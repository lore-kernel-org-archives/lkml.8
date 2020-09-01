Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D76C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2168C207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loa9Ih3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgIAVVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIAVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:21:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36857C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 14:21:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so1384227pgd.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HEDnL2gB4v6pMF7uVRx3U5IzQZ6Y49b2H7FAFdGpYKY=;
        b=loa9Ih3ZUYZG0+IPorkIL+QInYuFys8rYkr7cJaFbqs88myy0BMWJwd/5cLxBw0ho4
         ozsZjx70t3OgavK3OyJGOCI+I1q0xQKfzYqcIi8VjfBPLEo5RnCvknLhhL8tgBGn9uSy
         rg6cbrpbwnZ/dY31DorgJSJNnCqSjOIF6jVRnxxcYKDZdLTha9Sv475DnJnmEOGikYCe
         n821g1WKyOxR+/yJ0/TKeHgHyZcaMh8hCv5ZUHV+ngTz+ApGj2XV4TtbNI1ta+qyMY3F
         e866e3u5qe/niuBnU417jH6ZPOVlHYXWPv+ADjfTHq/iois5gTjQg6ZWOtjUWVke9kWp
         heDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HEDnL2gB4v6pMF7uVRx3U5IzQZ6Y49b2H7FAFdGpYKY=;
        b=jG3pDBuKXWuxLSxc0RPKi39iZmMJRWiwcymIF/DU+5352Ac/vdwAvB5NC9H6qNJPb3
         idDofyRwfO8N0TaLizmf8peGBiPXbZ+H+JkQUX2tyfvJBy3jsdeXEsAljeVvaiDcvoEu
         LkNOzFJ7oaUbvz3Tazjyw0M6FRE8PMu/2itWKoXuX6yZZbOlUyukICTVbQyPHsIK4LXe
         uaOwoZqZF2Ol5nPuXx6y4NkiRiyYl7yVD0h5+PoTn/lf4zBmvMvaorL6uCbD41Zl6yaM
         f6L39BQxREjzbJt0+ioCfzopX4dIqL1eNnQFZzAyxLYdOuQeV7maDeC0xoGbyA7USKCN
         85iQ==
X-Gm-Message-State: AOAM533CDE4Sprpry4I26AQkjlC+Ww8VsvKEZ0++lSzWHacwLBUKJ3Vm
        WuEa2BsSAQ6m2R7qeYtWIIa0Yvi5Jst3qw==
X-Google-Smtp-Source: ABdhPJw9XhAEuAtuTVV9ArllLE8tLOovUc9N/ZKIgsqNHmW0LQhG5uzhG9gbpy4u5RbJWOHkKckHUQ==
X-Received: by 2002:aa7:9556:: with SMTP id w22mr93551pfq.245.1598995287662;
        Tue, 01 Sep 2020 14:21:27 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.71.13])
        by smtp.gmail.com with ESMTPSA id w82sm2791634pfc.183.2020.09.01.14.21.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 14:21:26 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, jhubbard@nvidia.com
Cc:     jgg@ziepe.ca, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        timur@freescale.com, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Souptick Joarder <jrdr.linux@gmail.com>
Subject: [linux-next PATCH v4] drivers/virt/fsl_hypervisor: Fix error handling path
Date:   Wed,  2 Sep 2020 02:51:11 +0530
Message-Id: <1598995271-6755-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, when memory allocation for sg_list_unaligned failed, there
is a bug of calling put_pages() as we haven't pinned any pages.

Second, if get_user_pages_fast() failed we should unpin num_pinned
pages.

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

v4:
  Address another set of review comments from John.

 drivers/virt/fsl_hypervisor.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 1b0b11b..46ee0a0 100644
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
 
@@ -250,7 +250,6 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 		num_pages, param.source != -1 ? FOLL_WRITE : 0, pages);
 
 	if (num_pinned != num_pages) {
-		/* get_user_pages() failed */
 		pr_debug("fsl-hv: could not lock source buffer\n");
 		ret = (num_pinned < 0) ? num_pinned : -EFAULT;
 		goto exit;
@@ -292,13 +291,13 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 		virt_to_phys(sg_list), num_pages);
 
 exit:
-	if (pages) {
-		for (i = 0; i < num_pages; i++)
-			if (pages[i])
-				put_page(pages[i]);
+	if (pages && (num_pinned > 0)) {
+		for (i = 0; i < num_pinned; i++)
+			put_page(pages[i]);
 	}
 
 	kfree(sg_list_unaligned);
+free_pages:
 	kfree(pages);
 
 	if (!ret)
-- 
1.9.1

