Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F81D20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpuuQUH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgFQCUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgFQCUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:20:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:20:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ne5so275108pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RU7+sTzElvyavGrWR8T0S7aCMXu0KpU3ibcKQwydBt8=;
        b=fpuuQUH3hWdUn+U7INlHJcayaHQPXBGXinKmcYF/y1ILtPdYRYdIzzata24fOY6gIB
         p4sFbwmfuveqQ2rrvIo8ezp5x6tNqLtdU0uciIhyoUVUygQJZyONvWDLMtiG5uAeCiTg
         zpsIhV5qKbSUdW/fODn7VPZ3J/UYfr0Mj0khQ2LkL5CrYOehrnx+47+bnqWDMDiejRod
         tJNWkL6D0YkSzS3dNQhTOQIkKOogW1EJ7JIbuC6HMecWyj/hob7mPiRJPdidmUu7ZoZu
         B4qXKMbTZdUysI4e5IousnwlSmkJogzWExcQRr6bzCzRBWvL+hIItMt8sOz1JAkEfUT2
         XlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RU7+sTzElvyavGrWR8T0S7aCMXu0KpU3ibcKQwydBt8=;
        b=MMIF8sXHcwFK42GGEc1aq4KZ4SthddeDeXrWBBvCkjIAbBcd63kl+NG/I7kLd5Xo8+
         G2EAChFx5kPOlTCKeVNEmf1v2dmMsgpL3jz8d+RyTnk+b71WMTVP8S0lROhSzX1587l4
         OpIzf2eYQ3TlGTyEX+KIEHmzO1fNFZroZSN4mS/CR2y0zWfyXzJvPNjLNN7zJh9pdNih
         Nam0vlbf8A+qvNBUULq8u6lVtc93L7MbFBCOsb6/w7dshI6T9uwKR2nqHx71lXORXfot
         wlSeQfD7WG9JWV/8rC/u5GO6LD4klubrjteUCptW2IwsV+2+mAYD0C0nYbiTyRb7SFAy
         ovLw==
X-Gm-Message-State: AOAM530lPPjygN6b+LSS1c5jZsp7Xe+TdsmKB/s32xzWqvTZp8Dify1D
        xPMWuFHKp/AKZtcngyegVdo=
X-Google-Smtp-Source: ABdhPJzg6h+CLn2Va7ZN3PG5ayxoM0H2rr+xluUcuM0/FATKGVhrM+pDRBO9X6IfhMJ46f4WIcBLWQ==
X-Received: by 2002:a17:90a:fa8f:: with SMTP id cu15mr5967338pjb.9.1592360434786;
        Tue, 16 Jun 2020 19:20:34 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.213.184])
        by smtp.gmail.com with ESMTPSA id h9sm1203208pfe.32.2020.06.16.19.20.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 19:20:34 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com, pakki001@umn.edu,
        ldufour@linux.ibm.com, harshjain32@gmail.com, simon@nikanor.nu,
        walken@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 3/4] staging: kpc2000: kpc_dma: Convert get_user_pages() --> pin_user_pages()
Date:   Wed, 17 Jun 2020 07:57:22 +0530
Message-Id: <1592360843-3440-4-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
References: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index bcce86c..1f5ab81 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -76,10 +76,10 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 
 	// Lock the user buffer pages in memory, and hold on to the page pointers (for the sglist)
 	mmap_read_lock(current->mm);      /*  get memory map semaphore */
-	rv = get_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages, NULL);
+	rv = pin_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE, acd->user_pages, NULL);
 	mmap_read_unlock(current->mm);        /*  release the semaphore */
 	if (rv != acd->page_count) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't get_user_pages (%ld)\n", rv);
+		dev_err(&priv->ldev->pldev->dev, "Couldn't pin_user_pages (%ld)\n", rv);
 		goto err_get_user_pages;
 	}
 
@@ -189,14 +189,11 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	sg_free_table(&acd->sgt);
  err_dma_map_sg:
  err_alloc_sg_table:
-	for (i = 0 ; i < acd->page_count ; i++)
-		put_page(acd->user_pages[i]);
+	unpin_user_pages(acd->user_pages, acd->page_count);
 
  err_get_user_pages:
-	if (rv > 0) {
-		for (i = 0; i < rv; i++)
-			put_pages(acd->user_pages[i])
-	}
+	if (rv > 0)
+		unpin_user_pages(acd->user_pages, rv);
 	kfree(acd->user_pages);
  err_alloc_userpages:
 	kfree(acd);
@@ -221,8 +218,7 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 			set_page_dirty_lock(acd->user_pages[i]);
 	}
 
-	for (i = 0 ; i < acd->page_count ; i++)
-		put_page(acd->user_pages[i]);
+	unpin_user_pages(acd->user_pages, acd->page_count);
 
 	sg_free_table(&acd->sgt);
 
-- 
1.9.1

