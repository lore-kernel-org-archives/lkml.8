Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B3CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531E320719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFnUe2iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgHaWII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgHaWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:08:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7435CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:08:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so633200pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U4+uhTBpQ4TnYUC3EzzBpVleBFNuIQlKM1znnPHB1ac=;
        b=pFnUe2iZ3ov4n6I4Jfr63UCW7Vt5Hu/bWRsHROs5W7Ba6/+8R2TaKQ0Ij7+5z0TvDB
         FJk88pG+iRs9LDOyxoh1ycpMKmobBTn6W646xKcpVACyv247icoEiIzzWqD97vvbqYlB
         0BJR3ko28RdwulkwQDmpdbfwys9NOOOgSzDex8bmKSoY2bdauLzaJPBpqmhyqs0ytQR+
         5//3v7/Ol7Lwv6gYZz9nJx5qFMjL+A9RZqMe45sLAPbYUg4JOG7/UCcC2EoNv8cXefE7
         wHvhVIagg6mSAVN8X6xvZoAdYESL2F/MIIupn4S2m65CnlHXGS3tq6b/aSsG+dBeKmGt
         1nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U4+uhTBpQ4TnYUC3EzzBpVleBFNuIQlKM1znnPHB1ac=;
        b=U0JPb0mmDOkkLz5c7jy/AamO5fPHf/apvasQvXW+jd63qn5f7BDuJh0C6MyNGmydyV
         jly+pP85kmXaAZ1+yt8ks8Erph267AY+cocSXxYoF3xnTEDV3v3GEGg0JN7G+NXCdZWD
         lv3cqlEVCI5rwM2HfVJtldTy7WBkOLu7XwLaAtnC4trvLRaohyaOjtdLuXVCXtCH8jy/
         +06XTmh9WpsDcDo5gMJBy3jcr6ews2j5z1+zao5wFE4o35EfA5eMW0VCNmd9ehu6DgP+
         xH0XCXlwiP0DOnoyljQmYrxI/tCKvikhcRrc8chH8ifWUuPj2V/F0x7+kWJeY2A2nxME
         OFiw==
X-Gm-Message-State: AOAM531oYMZS+b0EzBQZUEWfHwJY+XJhqf6C9hoqma9PUSvNBTJdTT6/
        GPSs+29KiX3HXceYmuO4e42/W/avpawP8g==
X-Google-Smtp-Source: ABdhPJzByXePJdtVOTodzmZQ6Zxp98z1V0gvKmoHZGQPzP0LKaaLv4KXbF9MwtFl+nb5KWGhON6iwQ==
X-Received: by 2002:a17:90b:3284:: with SMTP id ks4mr1195295pjb.116.1598911685771;
        Mon, 31 Aug 2020 15:08:05 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.39.120])
        by smtp.gmail.com with ESMTPSA id i20sm9150452pfq.204.2020.08.31.15.08.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 15:08:04 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, jhubbard@nvidia.com
Cc:     jgg@ziepe.ca, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, timur@freescale.com, galak@kernel.crashing.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [linux-next PATCH v3] drivers/virt/fsl_hypervisor: Fix error handling path
Date:   Tue,  1 Sep 2020 03:37:47 +0530
Message-Id: <1598911668-6178-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, when memory allocation for sg_list_unaligned failed, there
is a bug of calling put_pages() as we haven't pinned any pages.

Second, if get_user_pages_fast() failed we should unpinned num_pinned
pages instead of checking till num_pages.

This will address both.

As part of these changes, minor update in documentation.

Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor
management driver")
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
v2:
   Added review tag.

v3:
   Address review comment on v2 from John.
   Added review tag.

 drivers/virt/fsl_hypervisor.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 1b0b11b..efb4e7f 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 
 	unsigned int i;
 	long ret = 0;
-	int num_pinned; /* return value from get_user_pages() */
+	int num_pinned = 0; /* return value from get_user_pages_fast() */
 	phys_addr_t remote_paddr; /* The next address in the remote buffer */
 	uint32_t count; /* The number of bytes left to copy */
 
@@ -174,7 +174,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 		return -EINVAL;
 
 	/*
-	 * The array of pages returned by get_user_pages() covers only
+	 * The array of pages returned by get_user_pages_fast() covers only
 	 * page-aligned memory.  Since the user buffer is probably not
 	 * page-aligned, we need to handle the discrepancy.
 	 *
@@ -224,7 +224,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 
 	/*
 	 * 'pages' is an array of struct page pointers that's initialized by
-	 * get_user_pages().
+	 * get_user_pages_fast().
 	 */
 	pages = kcalloc(num_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages) {
@@ -241,7 +241,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 	if (!sg_list_unaligned) {
 		pr_debug("fsl-hv: could not allocate S/G list\n");
 		ret = -ENOMEM;
-		goto exit;
+		goto free_pages;
 	}
 	sg_list = PTR_ALIGN(sg_list_unaligned, sizeof(struct fh_sg_list));
 
@@ -250,7 +250,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 		num_pages, param.source != -1 ? FOLL_WRITE : 0, pages);
 
 	if (num_pinned != num_pages) {
-		/* get_user_pages() failed */
+		/* get_user_pages_fast() failed */
 		pr_debug("fsl-hv: could not lock source buffer\n");
 		ret = (num_pinned < 0) ? num_pinned : -EFAULT;
 		goto exit;
@@ -293,12 +293,12 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 
 exit:
 	if (pages) {
-		for (i = 0; i < num_pages; i++)
-			if (pages[i])
-				put_page(pages[i]);
+		for (i = 0; i < num_pinned; i++)
+			put_page(pages[i]);
 	}
 
 	kfree(sg_list_unaligned);
+free_pages:
 	kfree(pages);
 
 	if (!ret)
-- 
1.9.1

