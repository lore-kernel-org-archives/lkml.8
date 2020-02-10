Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F119C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1463520714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341655;
	bh=r58XpYdCqHCenSwSfWv3N/7s2FTO0pSHgf2V6VzPpkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvXX8AHV2nijCaHlp6IvvwaHKA7L1Z+72gqNf6WpbnFl28XAzOL3B+vAu/isfcyKy
	 PmjZbQhw6copnYlNLLNc2IA8zSWVcq/oTEzzQR3DaokUy0PoEUZkk6YcYF4Vg8q0HA
	 JB62ggo0nYbt2mBA7pOSmyJ4wcIutxIUY7A8gx80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgBJNeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbgBJMfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:30 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38BB02085B;
        Mon, 10 Feb 2020 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338129;
        bh=r58XpYdCqHCenSwSfWv3N/7s2FTO0pSHgf2V6VzPpkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRaojfDbtp2BrbaL00rkpcB/SR68TRnwlG7nlolaWItrfADtXsD2j7LjVA6p+De66
         bdAwaIw6guCqMKzBhzOpB4N0Sf8f27ukAM3ddEqGNjzAcIbYFNscfuZYmSRroJo5ZY
         F0d7D7SIE5wLjzwHLQ+wTdbHRVE1p0m+QTGKX2vE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/195] hv_balloon: Balloon up according to request page number
Date:   Mon, 10 Feb 2020 04:32:09 -0800
Message-Id: <20200210122312.757697386@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

commit d33c240d47dab4fd15123d9e73fc8810cbc6ed6a upstream.

Current code has assumption that balloon request memory size aligns
with 2MB. But actually Hyper-V doesn't guarantee such alignment. When
balloon driver receives non-aligned balloon request, it produces warning
and balloon up more memory than requested in order to keep 2MB alignment.
Remove the warning and balloon up memory according to actual requested
memory size.

Fixes: f6712238471a ("hv: hv_balloon: avoid memory leak on alloc_error of 2MB memory block")
Cc: stable@vger.kernel.org
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/hv_balloon.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1215,10 +1215,7 @@ static unsigned int alloc_balloon_pages(
 	unsigned int i = 0;
 	struct page *pg;
 
-	if (num_pages < alloc_unit)
-		return 0;
-
-	for (i = 0; (i * alloc_unit) < num_pages; i++) {
+	for (i = 0; i < num_pages / alloc_unit; i++) {
 		if (bl_resp->hdr.size + sizeof(union dm_mem_page_range) >
 			PAGE_SIZE)
 			return i * alloc_unit;
@@ -1252,7 +1249,7 @@ static unsigned int alloc_balloon_pages(
 
 	}
 
-	return num_pages;
+	return i * alloc_unit;
 }
 
 static void balloon_up(struct work_struct *dummy)
@@ -1267,9 +1264,6 @@ static void balloon_up(struct work_struc
 	long avail_pages;
 	unsigned long floor;
 
-	/* The host balloons pages in 2M granularity. */
-	WARN_ON_ONCE(num_pages % PAGES_IN_2M != 0);
-
 	/*
 	 * We will attempt 2M allocations. However, if we fail to
 	 * allocate 2M chunks, we will go back to 4k allocations.
@@ -1279,14 +1273,13 @@ static void balloon_up(struct work_struc
 	avail_pages = si_mem_available();
 	floor = compute_balloon_floor();
 
-	/* Refuse to balloon below the floor, keep the 2M granularity. */
+	/* Refuse to balloon below the floor. */
 	if (avail_pages < num_pages || avail_pages - num_pages < floor) {
 		pr_warn("Balloon request will be partially fulfilled. %s\n",
 			avail_pages < num_pages ? "Not enough memory." :
 			"Balloon floor reached.");
 
 		num_pages = avail_pages > floor ? (avail_pages - floor) : 0;
-		num_pages -= num_pages % PAGES_IN_2M;
 	}
 
 	while (!done) {


