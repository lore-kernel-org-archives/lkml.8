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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B363C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D6C206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNNzML7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgF3Hob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgF3Hob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:44:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h4so2058758plt.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQZ0v72A1nwBi+dtLOqVNnehvx96WQ1i1bGMN4I9JcY=;
        b=XNNzML7QP2g/BVO/rIU4GyM6fsPoLTPI3AXcvi1lDz0mbGoN+RGl2UN/NG1OpPSj4a
         YRyC7PGhI7hRLHH5QxueLZFEDB6q5h5T1fkAKVpOLzZaFZJq0Hjvhv7OEtAee00ez2LE
         ILGfM0Zv94QEbVIay4Sw7q5XvxZ9zon0Gp0IHV8aQ/FdL5Th37skTepdeNHqF7SMELbF
         Zpc/uVrF9ZO6jCKdHelDQ+utsogwZeEr+EZPiEW5qnwwluGVCHd9iA4WGgCL9+/6uva1
         Sk/BAJVG+Q5FAMhR8oTPtFyKT9h++sYkWjmwXeFYzKXD/ZidmtzSl0F2huDeaLvvlSl0
         xUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQZ0v72A1nwBi+dtLOqVNnehvx96WQ1i1bGMN4I9JcY=;
        b=tvb6bMR2OhwlVcjCCo1GTjDwiweof4RIKZ3Es+pNuWkNxlB9VKbbZvJNy6ph2ZbDNu
         kb5zXUGHOEzbVC92DOh+Fk0CqZVtdbBRX7CCpRUV0rqj6ny5cGMsFLC0rS8VJWV/XGn6
         sxHXl0bTLClra3Wv7E5xbhT8/nizXwkoAQNUdqpOgXhu+F+tJDYbZq96C0SfljEJZJBI
         iBV3v+WwsIhr3jl3Avr2ZDV7s4kvDQ/PyWZyUf1FBwCeS6naL9CWsdGBd2S8VOFb1kt3
         +aLpe7v/7ByLlH1EVBPeCjM2w7+93HL2I9y3cMyQEeaX4zREZDgOgUkDTR914Z9hYJun
         kPiQ==
X-Gm-Message-State: AOAM531Wp2swJXOKAVXPZFDPdf7Ezhaf3CT0/eVKJkBN04G/a7+iqgFO
        SuazBEqQtIambFr8dyGp0+g=
X-Google-Smtp-Source: ABdhPJyM3PhIfiACdVMemPHU1vHfpeVF0l5A+OnyqiMT0sDXntN3OJFcG2Ucdk77Mh5UV3QYsy69iQ==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2mr16846646plb.2.1593503070423;
        Tue, 30 Jun 2020 00:44:30 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.225.143])
        by smtp.gmail.com with ESMTPSA id w1sm1754276pfq.53.2020.06.30.00.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:44:29 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jane.pnx9@gmail.com, ldufour@linux.ibm.com,
        gregkh@linuxfoundation.org, harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 3/4] staging: kpc2000: kpc_dma: Convert get_user_pages() -->  pin_user_pages()
Date:   Tue, 30 Jun 2020 13:22:18 +0530
Message-Id: <1593503539-18649-4-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
References: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information. This is case 2 as per document [1].

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 08d90a6..8cd20ad 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -76,10 +76,10 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 
 	// Lock the user buffer pages in memory, and hold on to the page pointers (for the sglist)
 	mmap_read_lock(current->mm);      /*  get memory map semaphore */
-	rv = get_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages, NULL);
+	rv = pin_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE, acd->user_pages, NULL);
 	mmap_read_unlock(current->mm);        /*  release the semaphore */
 	if (rv != acd->page_count) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't get_user_pages (%d)\n", rv);
+		dev_err(&priv->ldev->pldev->dev, "Couldn't pin_user_pages (%d)\n", rv);
 		goto err_get_user_pages;
 	}
 
@@ -189,13 +189,11 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	sg_free_table(&acd->sgt);
  err_dma_map_sg:
  err_alloc_sg_table:
-	for (i = 0 ; i < acd->page_count ; i++)
-		put_page(acd->user_pages[i]);
+	unpin_user_pages(acd->user_pages, acd->page_count);
 
  err_get_user_pages:
 	if (rv > 0) {
-		for (i = 0; i < rv; i++)
-			put_pages(acd->user_pages[i]);
+		unpin_user_pages(acd->user_pages, rv);
 		rv = -EFAULT;
 	}
 	kfree(acd->user_pages);
@@ -222,8 +220,7 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 			set_page_dirty_lock(acd->user_pages[i]);
 	}
 
-	for (i = 0 ; i < acd->page_count ; i++)
-		put_page(acd->user_pages[i]);
+	unpin_user_pages(acd->user_pages, acd->page_count);
 
 	sg_free_table(&acd->sgt);
 
-- 
1.9.1

