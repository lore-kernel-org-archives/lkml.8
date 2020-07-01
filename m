Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D119AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57F22074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh5p+IYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgGAGJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGAGJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:09:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E01C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:09:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so4993968pfo.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oOqmjhvuPBAEiyHp7TL6kqUg9v7jBR3QwTJJwMLLxHI=;
        b=fh5p+IYS+GyBqIiPYiQP24tODpgeKqroVm6a2zrENVblNOD8iBrV8BN+RCPNGHy68C
         Lt8w4b0LTxLZw0rPUQTpTVnZdmRpeYi5imXEbl8pJ7Rq4tU6sbQZa/QAWS4CM3UTo4rm
         ZmIKjKSar68blxT+9dP7OWlIHEuF6ZOLoCDA3sdXa1yPIG+o0DQcP1IBir+XsHDyasvp
         qtzKAVSbOVltdJVBfcb3zcA7vlWNV6a0JcwE+NpTQyuEO0OZMghtjd8V0+y8vsvW0K55
         yZ0sVgpAUwhvemWivxqdmXA09LMYrU20n5tgRX3Wxed8biyPXp/EjFATiHx1dtcFICUt
         JzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oOqmjhvuPBAEiyHp7TL6kqUg9v7jBR3QwTJJwMLLxHI=;
        b=cW66sV6mH+KJgaZkDDFOVFymKiDT6Nri/onv5wxOO5S99J0iLqxpkqxS1KNAPyRcBp
         zzJD0YDwNpVsXZPCeg3L96UKSZdnfXe9a/bI6+yd0g3G0jKG26CKy8SprrxYceZqQ97B
         H42KeIei6FZ8Zae3LUE8BALz26SE2wUB4zB7yChn1z967qrn6MdJ+RT3FknBoxqNCDfm
         UuyXNhSvn/whcXBaALIdj5tdvN2nC9gBNBlFfda/uKk4HgGZmHXi2+u/Rc2dKuwmXz2r
         ulfim+QGnJt9z03Y9IaTdNdq+9g1bpnTgVuNbT3wiPNRWkn8vJReqZPV/dgu0Ovtmt9I
         0NLA==
X-Gm-Message-State: AOAM530npmiWEroqY+ECPTMfukO2BLSZ4LtQCpH2apYgEYLh0jFM/AP/
        X4dlxw/bvexuxoYbXhc7InE=
X-Google-Smtp-Source: ABdhPJzueLqkfiCNtpCLQlwKNIabeqN8iu4TFi2dAorZGc5LHYRftUrU9e3dZI4fpq25onFK7iplnA==
X-Received: by 2002:a63:eb54:: with SMTP id b20mr18415447pgk.380.1593583784355;
        Tue, 30 Jun 2020 23:09:44 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.42.200])
        by smtp.gmail.com with ESMTPSA id 127sm4694073pgf.5.2020.06.30.23.09.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:09:43 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com,
        daniel.m.jordan@oracle.com, simon@nikanor.nu,
        harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH v3 1/4] staging: kpc2000: kpc_dma: Unpin partial pinned pages
Date:   Wed,  1 Jul 2020 11:47:41 +0530
Message-Id: <1593584264-16982-2-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
References: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug, when get_user_pages() failed but partially pinned
pages are not unpinned and positive numbers are returned instead of
-ERRNO. Fixed it.

Also, int is more appropriate type for rv. Changed it.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 8975346..becdb41 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -35,7 +35,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 			    unsigned long iov_base, size_t iov_len)
 {
 	unsigned int i = 0;
-	long rv = 0;
+	int rv = 0;
 	struct kpc_dma_device *ldev;
 	struct aio_cb_data *acd;
 	DECLARE_COMPLETION_ONSTACK(done);
@@ -79,14 +79,14 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	rv = get_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages, NULL);
 	mmap_read_unlock(current->mm);        /*  release the semaphore */
 	if (rv != acd->page_count) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't get_user_pages (%ld)\n", rv);
+		dev_err(&priv->ldev->pldev->dev, "Couldn't get_user_pages (%d)\n", rv);
 		goto err_get_user_pages;
 	}
 
 	// Allocate and setup the sg_table (scatterlist entries)
 	rv = sg_alloc_table_from_pages(&acd->sgt, acd->user_pages, acd->page_count, iov_base & (PAGE_SIZE - 1), iov_len, GFP_KERNEL);
 	if (rv) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't alloc sg_table (%ld)\n", rv);
+		dev_err(&priv->ldev->pldev->dev, "Couldn't alloc sg_table (%d)\n", rv);
 		goto err_alloc_sg_table;
 	}
 
@@ -193,10 +193,15 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 		put_page(acd->user_pages[i]);
 
  err_get_user_pages:
+	if (rv > 0) {
+		for (i = 0; i < rv; i++)
+			put_pages(acd->user_pages[i]);
+		rv = -EFAULT;
+	}
 	kfree(acd->user_pages);
  err_alloc_userpages:
 	kfree(acd);
-	dev_dbg(&priv->ldev->pldev->dev, "%s returning with error %ld\n", __func__, rv);
+	dev_dbg(&priv->ldev->pldev->dev, "%s returning with error %d\n", __func__, rv);
 	return rv;
 }
 
-- 
1.9.1

