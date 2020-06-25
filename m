Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73DFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BBA2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az91tkeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbgFYCy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 22:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389357AbgFYCy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 22:54:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607EFC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:54:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f3so2613693pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zp4npQcgeZMS0pGjybddj8LwS3fxPZyTX8wZXmAxxq8=;
        b=Az91tkePwm/xh44txinQdcyBs/2AMx7g4pZmjPtGWK2i06v/4LoR+m3rR1QuJD/JYK
         Y07aw6vQOY6UupyMDXeuqqdgCerrwRSuFxZtNWPAPsSK2Y15Evu3u62oyDGJ1KInb3el
         y5pMfE7BF0nslx1d99ZO6inoSdV3sUcwB6LgDAXB1/vu8DHwlQRoJ97hfxqp2p6jflU5
         /jWTggLrwFX55TkRA9aPLeK2NvVdv2e/C/QwsxlOdQfBx43RxEDhMzgLpySzJZSu9EBS
         SbwThB3OXl8kBaxZVNhPp/UoUv1pyGsWBPayAXzR89WKZBIvUPbBq8KY7bFm22h8giPj
         NNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zp4npQcgeZMS0pGjybddj8LwS3fxPZyTX8wZXmAxxq8=;
        b=ae3kyCCQLbN/OL96wv9L49TGPM6I+csNadMWd9mS8iM/juhWJHBBl07MH0B9kvBHn7
         Hj7Eo6e999KPRm69PVAzIZGtDnwLZbS4X4omiTWaJSFNhufIC5VoiggY+vxPstjn7icW
         kuXWnIizSwZt0X0SSJhD5VMYPRW5rL+Y05Y4W1HdQO95UIq3Ck+14MDRRpRGeaUO2kgs
         MST/4ZQEN0sJwgivoJt3zUtVvTnJXWmDVypBnsx7auZ0dLhlMEHF6wU0/FV3pgaqWTBA
         fgPWHPAOUgzuIpgX1nMsbDIsgTAr+KUYev1exZhQLwDjNrsdskA8VJ5EOPmvBOHVOVKu
         HlMg==
X-Gm-Message-State: AOAM530iNYV8a9iw8hz1LVILSOJuwQrrZfafHqO3NYrBCEfgFUCFNDQP
        n95eVGFo7GjRz5A1yyw33LPnE6N2EAo=
X-Google-Smtp-Source: ABdhPJxabE67+Alwujp7u9O15q0niQ7itBEEzErE0Ls5oHuYwsqVsBmpiuxlji26MFkmaJ/GNds1hA==
X-Received: by 2002:a62:60c7:: with SMTP id u190mr30255128pfb.240.1593053695830;
        Wed, 24 Jun 2020 19:54:55 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.254.114])
        by smtp.gmail.com with ESMTPSA id y10sm18593000pgi.54.2020.06.24.19.54.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2020 19:54:55 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH 2/2] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
Date:   Thu, 25 Jun 2020 08:32:40 +0530
Message-Id: <1593054160-12628-2-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593054160-12628-1-git-send-email-jrdr.linux@gmail.com>
References: <1593054160-12628-1-git-send-email-jrdr.linux@gmail.com>
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
Cc: Paul Durrant <xadimgnik@gmail.com>
---
Hi,

I'm compile tested this, but unable to run-time test, so any testing
help is much appriciated.

 drivers/xen/privcmd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 0da417c..eb05254 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -595,7 +595,7 @@ static int lock_pages(
 		if (requested > nr_pages)
 			return -ENOSPC;
 
-		page_count = get_user_pages_fast(
+		page_count = pin_user_pages_fast(
 			(unsigned long) kbufs[i].uptr,
 			requested, FOLL_WRITE, pages);
 		if (page_count < 0) {
@@ -612,13 +612,7 @@ static int lock_pages(
 
 static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 {
-	unsigned int i;
-
-	for (i = 0; i < nr_pages; i++) {
-		if (!PageDirty(page))
-			set_page_dirty_lock(page);
-		put_page(pages[i]);
-	}
+	unpin_user_pages_dirty_lock(pages, nr_pages, 1);
 }
 
 static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
-- 
1.9.1

