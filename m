Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E5DC433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0769922BED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752781;
	bh=U/vZ+MZGMwLJ1UVqqK6/GQHXcdv5AyPJlaIEplnEad8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V0mv3WT74uGm0zIYhSj/L9iYiN0ibcIYwrlPs22n9oLdP6E59/bPNzhjEIcRoDfB1
	 Apkp7wru2UwtI5ih/RC0248ApGBnFYpYFcIpAXg0UAOJGBbIefie58yg0KpjmdxfCE
	 q+ABiHTY7nPlcCr21Cubl2qEA+w77HpuB/fzAK+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgGNSw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbgGNSwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:52:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D476722B42;
        Tue, 14 Jul 2020 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752773;
        bh=U/vZ+MZGMwLJ1UVqqK6/GQHXcdv5AyPJlaIEplnEad8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Q94SjXQSfp8a8Vbf2MQPmV1tEV7vpYDJ8pm/WbrjOCG9cT2iQX8LSdjcHHQYj/wr
         S40hkxsibWP0aAI2ZOW77LAT64d0YiUqOGeIR4yuW0B/sIOdo2BWS0BvCllMsFrUdL
         /tauod/KoCtS/H74UmtA1Ug9Q01QM3VLQg7bwWN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 104/109] dm writecache: reject asynchronous pmem devices
Date:   Tue, 14 Jul 2020 20:44:47 +0200
Message-Id: <20200714184110.545942232@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

commit a46624580376a3a0beb218d94cbc7f258696e29f upstream.

DM writecache does not handle asynchronous pmem. Reject it when
supplied as cache.

Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.com/
Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org # 5.3+
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-writecache.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2104,6 +2104,12 @@ invalid_optional:
 	}
 
 	if (WC_MODE_PMEM(wc)) {
+		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
+			r = -EOPNOTSUPP;
+			ti->error = "Asynchronous persistent memory not supported as pmem cache";
+			goto bad;
+		}
+
 		r = persistent_memory_claim(wc);
 		if (r) {
 			ti->error = "Unable to map persistent memory for cache";


