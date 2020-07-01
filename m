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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C512074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEMG27Aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGAGJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGAGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:09:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94226C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:09:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h4so3398843plt.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQZ0v72A1nwBi+dtLOqVNnehvx96WQ1i1bGMN4I9JcY=;
        b=fEMG27AaP4D1S5jOvjynRjeoBbG2VgmoGI730zMRIrw1+HkS58v9w30oP7UilSnewg
         oKQNATB+wQgbVTx8D7tnAPjdAZDf+JzA/4xdQND3VoHGU8TgkHq9yjui97ZdfEcNdMX0
         3e7enLsMr7aebrSojaXXGtMM6mLD3/B6nfWZYysIPGKJJ9Ujn7NFRDnuxR1TZy/q0xfg
         BwRVLHtlS0AbY4OYfGdIfHp9Pylcp8LHxaCE5DssIYioiy/0QIt+wve9CtOVb0wmZaAj
         BkvlclyArnBVreDZIf/R6lVV6mPCvKry3rxKOC/aTxS3jLL+kyBVseBPcTU8jJPlrKGf
         Y6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQZ0v72A1nwBi+dtLOqVNnehvx96WQ1i1bGMN4I9JcY=;
        b=S8AwrFvPbHr4igSvR4DR0jKNjEhF3KqksjDzXZahSZA1BU5O6piWtQrLV5axP+AOnh
         B0BwRbl350/NmHUbV5BuTeHWZOSn4+D1votPJrTkWDMQv07u7Ykm8kxkRTEoeEMX9i4E
         /dEpABQ2nakylpwNFVCfLNhmHQNnyqixgXBDK/ujlQoxf05Y/7M8ngfUYgu3NcGn9nu0
         j2Bx47JJGDGJjZipXQU4WZTFEXGabO7/iFNGGuFL3QVp2E6oCHaHvLWCd6U/7zkIt9sj
         rvlbBLqaevejl0MhwPNJVpY4qG3P7+SwrVgGKghDdBDV6eTH8qfIMClIdq3ovo+wqLiJ
         ss3w==
X-Gm-Message-State: AOAM531rrOnn4HUYpx8psvUWZ5N7A28ttIAA/Q8qiRcXQYcG49Y33X3S
        BBcQAsQzG3KkkNR1hS67K28=
X-Google-Smtp-Source: ABdhPJzdWt0P0vdHU5UkKk0ojQQvk2chmuuO83+DtWzjWv+mlETXduJDn7sK7pokb1sAEpwQqOsdxw==
X-Received: by 2002:a17:90b:a0d:: with SMTP id gg13mr5172637pjb.203.1593583795168;
        Tue, 30 Jun 2020 23:09:55 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.42.200])
        by smtp.gmail.com with ESMTPSA id 127sm4694073pgf.5.2020.06.30.23.09.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:09:54 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com,
        daniel.m.jordan@oracle.com, simon@nikanor.nu,
        harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 3/4] staging: kpc2000: kpc_dma: Convert get_user_pages() -->  pin_user_pages()
Date:   Wed,  1 Jul 2020 11:47:43 +0530
Message-Id: <1593584264-16982-4-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
References: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
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

