Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F972078E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588428;
	bh=NP2yY3AUn0T++OVlmkGsswcYDbLSAlAf9pmk4epeYVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AOpQT59alNQCFcoAD/NUjKaJFhi8+6CZSFxBqXocF7JvQD1v+xAcLmXgx9g0FsOwc
	 AHWn1o39+2lQG9u+QLI4V9FVlcfQT2ANO98pEVu6MiAJJghXgUiGNZM1UZsEdpjkW2
	 qrWyP3SdNh8VYZo3N4rwx8NOPjdSfolqRiqVKa4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgIHSHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731507AbgIHQLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:11:55 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CBC2470E;
        Tue,  8 Sep 2020 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580233;
        bh=NP2yY3AUn0T++OVlmkGsswcYDbLSAlAf9pmk4epeYVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqNFZEIaa1zZDrtIZXH+5HOatxUmE6mzeHQRh3uWUyCwZMTQQEPsvO3W3TUgPNvmc
         190rAaJTMKveQm2luWeJ4R/tdtvUN50uu1VjsVkZMvq1u5HLpDCQirEZXIuQCJzsJL
         PcRVWoAR7+e2zYzQ7qLXgumWa2oEeGA7gUl49i8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 76/88] dm writecache: handle DAX to partitions on persistent memory correctly
Date:   Tue,  8 Sep 2020 17:26:17 +0200
Message-Id: <20200908152224.973045928@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit f9e040efcc28309e5c592f7e79085a9a52e31f58 upstream.

The function dax_direct_access doesn't take partitions into account,
it always maps pages from the beginning of the device. Therefore,
persistent_memory_claim() must get the partition offset using
get_start_sect() and add it to the page offsets passed to
dax_direct_access().

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 48debafe4f2f ("dm: add writecache target")
Cc: stable@vger.kernel.org # 4.18+
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-writecache.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -226,6 +226,7 @@ static int persistent_memory_claim(struc
 	pfn_t pfn;
 	int id;
 	struct page **pages;
+	sector_t offset;
 
 	wc->memory_vmapped = false;
 
@@ -244,9 +245,16 @@ static int persistent_memory_claim(struc
 		goto err1;
 	}
 
+	offset = get_start_sect(wc->ssd_dev->bdev);
+	if (offset & (PAGE_SIZE / 512 - 1)) {
+		r = -EINVAL;
+		goto err1;
+	}
+	offset >>= PAGE_SHIFT - 9;
+
 	id = dax_read_lock();
 
-	da = dax_direct_access(wc->ssd_dev->dax_dev, 0, p, &wc->memory_map, &pfn);
+	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
 	if (da < 0) {
 		wc->memory_map = NULL;
 		r = da;
@@ -268,7 +276,7 @@ static int persistent_memory_claim(struc
 		i = 0;
 		do {
 			long daa;
-			daa = dax_direct_access(wc->ssd_dev->dax_dev, i, p - i,
+			daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i, p - i,
 						NULL, &pfn);
 			if (daa <= 0) {
 				r = daa ? daa : -EINVAL;


