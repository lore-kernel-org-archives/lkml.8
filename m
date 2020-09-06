Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A9C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 06:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD5A2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 06:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MszkEUa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIFGwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 02:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIFGwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 02:52:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77862C061573
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 23:52:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u13so6500070pgh.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Db0fgXXbzH2p2U25JJ6scSTK1v1Ti17DDq8xS5lR3/w=;
        b=MszkEUa5ryYy30yaiYP8RoyZtu6DMbERcUxtpSd18pBj6WexOGEKKL7JkkCjeVUYa4
         CLPoxhkxomeYAPBFdTEqbgyEnE9h08KH9vh/2zYii0811dV9ABqMr9Y+OOGDR4GbOKWQ
         DTwpEZ4rNvQ47beCtgBw67QI3/z/j2BUult3VlMTBvtL7D8gc932t9nL1RVNBW0Q2Xql
         EOvSDVqH3rJH+AbCcVBG9XpMu4jVYzF9TmggKmsf6S17fC4F3G27oREvQ7LQPIXCtV4U
         8VXHh/QZPE+IAXJLXGU2l8GBimNhAKcGwVpsPC1+d9MH2dSd3obODmPQiNoIKRnUkMfy
         Fgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Db0fgXXbzH2p2U25JJ6scSTK1v1Ti17DDq8xS5lR3/w=;
        b=kRKOBXXhFS+Yh/4toScLVJbEaZ8PMzDcE8HDKkYRKAIR6GU/rBHPu3r3h205F+Yehc
         LK8bNsSXNeId47KhhMjQLqEsDaEHSzUL215iT3RLdQUmf+IPNrKtbT0DbPPqkB166RVz
         fVU2A5aWe3O0D9wfvBM0u4rJuaohxyAEEzqxNP7+/k0QcMuGs0l4tSkjPD8+ropn++kf
         VXcnyZepy5jbodo6FLg4PxH1Z6yICOruGdgn7wEH2/8bTr2QVXRweoqGFeWlHACguTQz
         eVZPmsKB5Zr8LxGNRuP22mZIGEkRszcTHJE6RuHPMpXkIkf/DTfgEIq1iuyVZ0BYzBXm
         SGsg==
X-Gm-Message-State: AOAM5335kbstXAa5u0JZYoEQZ6QadnU7dNItQFSHKbvJ5Zqqlo+gpNca
        6zbeV9FZNS++K7gnej8RjbM=
X-Google-Smtp-Source: ABdhPJxQeP2UYdkYbiXq2FOVaFF2XXnDUgZOTqlJ7qMyx28A9j6QYQ0Cphyslfl3lZuG6wql4/ZCpQ==
X-Received: by 2002:aa7:941a:: with SMTP id x26mr11701444pfo.177.1599375168362;
        Sat, 05 Sep 2020 23:52:48 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.54.54])
        by smtp.gmail.com with ESMTPSA id n128sm9199947pga.5.2020.09.05.23.52.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2020 23:52:47 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, david.vrabel@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] xen/gntdev.c: Convert get_user_pages*() to pin_user_pages*()
Date:   Sun,  6 Sep 2020 12:21:54 +0530
Message-Id: <1599375114-32360-2-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1599375114-32360-1-git-send-email-jrdr.linux@gmail.com>
References: <1599375114-32360-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information. This is case 5 as per document [1].

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
 drivers/xen/gntdev.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5e1411b..a36b712 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -731,7 +731,7 @@ static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
 	unsigned long xen_pfn;
 	int ret;
 
-	ret = get_user_pages_fast(addr, 1, batch->writeable ? FOLL_WRITE : 0, &page);
+	ret = pin_user_pages_fast(addr, 1, batch->writeable ? FOLL_WRITE : 0, &page);
 	if (ret < 0)
 		return ret;
 
@@ -745,13 +745,7 @@ static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
 
 static void gntdev_put_pages(struct gntdev_copy_batch *batch)
 {
-	unsigned int i;
-
-	for (i = 0; i < batch->nr_pages; i++) {
-		if(batch->writeable && !PageDirty(batch->pages[i]))
-			set_page_dirty_lock(batch->pages[i]);
-		put_page(batch->pages[i]);
-	}
+	unpin_user_pages_dirty_lock(batch->pages, batch->nr_pages, batch->writeable);
 	batch->nr_pages = 0;
 	batch->writeable = false;
 }
-- 
1.9.1

