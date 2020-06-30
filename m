Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376E3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A3206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsDNRiEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgF3HoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgF3HoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:44:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26BBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so8144239plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oOqmjhvuPBAEiyHp7TL6kqUg9v7jBR3QwTJJwMLLxHI=;
        b=ZsDNRiEKrC4VHDYEKtee+J3noCJYUeVzePIO7GhImTxDvwPvsL291zvooNL/qm6jx7
         qnvsqFrrr0H9ihS1Is66bjEEHeG61sx8gZXf4AR63LdcMvlVMWz70K1HcmorWTDmY3pP
         TZhk1IU+7I3ifHtGRczUy13jzXO2ePWyUmxA5hMxDowgt3qR/Z4ORHblGjrLbrC5L5ee
         U+9wphIvfpa45jM7lc/FtHUy6WxuPiAeZE9+AxZdhLq9JI3WerBztmKQ1ZG3dycI5ezF
         v5Oo6JytqtOLuwLLnWK5+PDUVYoNkLTPb6z7rWPGFrWO7BAgOntchsftSa2mZkihgAwV
         zDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oOqmjhvuPBAEiyHp7TL6kqUg9v7jBR3QwTJJwMLLxHI=;
        b=szYu1BM+9l5L1LI76ut2yaFwtCfGh82M9uFtXoFMX+vf4KwoHrInXswCfjZkf/U/DP
         oPikKIFnf7K36xs+6Z+PfY167kN8frCC8QRDSbHANPHGZ04WR7EiO97tx9F5xNp/wTO2
         ZDO1vhLHFaO5bQZ8Ii9u5wDHNLD/YF1vL+qeMs7EQZH2KQsshfZ/HP5S++zAKwadzSVr
         hoLQ8yHxc9j6UippOjQqcLfi1FbvLoE/VQIih7UqxyshJYNjZGdT2/Han7i9rrwBB6gl
         7c+/kxFVqNY1Ff25KSoBxuDmqXKogyrU86qN2m4h333sZ+oDq/AHWBOCM5T6P4lswzCs
         ccCw==
X-Gm-Message-State: AOAM531BZpn2p4/6tFuiO31cD59DHzTRiyownTil28xO//9hYuGK/Q13
        2sFOnjMYO7qBndGLT8kZgWhT+Upm+Vk=
X-Google-Smtp-Source: ABdhPJx+RRpJReS8kxqO754KZ2IlBwIUOUaGkjouPlErmio0TT+zq3yenb0xAzezXeGRpVtKb+gcjQ==
X-Received: by 2002:a17:90b:1497:: with SMTP id js23mr21624060pjb.30.1593503059495;
        Tue, 30 Jun 2020 00:44:19 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.225.143])
        by smtp.gmail.com with ESMTPSA id w1sm1754276pfq.53.2020.06.30.00.44.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:44:18 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jane.pnx9@gmail.com, ldufour@linux.ibm.com,
        gregkh@linuxfoundation.org, harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH v2 1/4] staging: kpc2000: kpc_dma: Unpin partial pinned pages
Date:   Tue, 30 Jun 2020 13:22:16 +0530
Message-Id: <1593503539-18649-2-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
References: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
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

