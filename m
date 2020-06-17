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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9CFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858B720663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec5rY47L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgFQCUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQCUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:20:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E3C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:20:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v24so232502plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6GXcf3wLRL4WRanPgpJHqRD9rkuU4zmnUhS9HuYjgvU=;
        b=ec5rY47LiFnF1A40ihlwiWqHCJ4QVCGRBA3rL4FWm15jfa45lCW3HgnoqTlvVjyay/
         mTe1k9ASc+V1FpGM+zOoylcnhy06bOIlJKrPCGcQvwW2EdKfABfzFam0qC5THsQkZhFT
         cXUU/Dx8JZSGEEKxoaJVCZVTVvi20PlQSgY76XV4elMp5WGo1EqrnKrAs17YFA8Lp4Zg
         TJR2MUJBkc3Pd4cwz9LfV6e0g+XmU0wPYuckgoxEgBOTmvBRNipaP2M4PPXCzLkrcqIs
         Z+67kLWzyvGj/HZdE6NHL3xMgfOrVgqX3FAD8tavx1O+K+glqIZW2xrBccFZLyiB6RmI
         xLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6GXcf3wLRL4WRanPgpJHqRD9rkuU4zmnUhS9HuYjgvU=;
        b=CU19Bpq2E5TMzHfYWdXkWfqhEm5gjJUB/4XEHdIhQP0uTrMqGCJ1G6LcSiL9rG9kKe
         DvUxPURMXIWtXB6vr3ECvTTgLQJnBOjFGqzy9p27LxJhMQRZrWcBre+zxYY8eiSwXvnD
         b7/LrVLhYbKwsQroNQ9795xBdPSkT8T/b+qnttxDnX70BPFotdMXWKk6hQ+JNMfnHhSq
         hzkiKilhqzFh3n2uw4eF2gCoF1CZFJ+AUO8G+C64DmYyKmSj83DIysJi+1CZQiDMpXHC
         CxgnjqUTXlAp2aV65cTHgrvivfj7J06E0tZwqDWS4/6LDun5anwS7ZN+53GtMvAep89+
         Fo4Q==
X-Gm-Message-State: AOAM530LWlrqrhXue/eCHWp3W1MbNuiW7hCzyfqdmNihAjhUWFZFmZm5
        1vYeKrMNPBjSuKBTlOUOzJgZphmuyIw=
X-Google-Smtp-Source: ABdhPJyxcB55i1YWFUpC1LmI+Jj2r/ji84B7Iib/mOmV5sk0BbnugKYyln1Tgs1UAFTAGymcXvOSbg==
X-Received: by 2002:a17:902:bf46:: with SMTP id u6mr4565386pls.302.1592360421139;
        Tue, 16 Jun 2020 19:20:21 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.213.184])
        by smtp.gmail.com with ESMTPSA id h9sm1203208pfe.32.2020.06.16.19.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 19:20:20 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com, pakki001@umn.edu,
        ldufour@linux.ibm.com, harshjain32@gmail.com, simon@nikanor.nu,
        walken@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH 2/4] staging: kpc2000: kpc_dma: Convert set_page_dirty() --> set_page_dirty_lock()
Date:   Wed, 17 Jun 2020 07:57:21 +0530
Message-Id: <1592360843-3440-3-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
References: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, convert set_page_dirty() to set_page_dirty_lock()

Second, there is an interval in there after set_page_dirty() and
before put_page(), in which the device could be running and setting
pages dirty. Moving set_page_dirty_lock() after dma_unmap_sg().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index b136353..bcce86c 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -214,13 +214,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 	BUG_ON(!acd->ldev);
 	BUG_ON(!acd->ldev->pldev);
 
+	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
+
 	for (i = 0 ; i < acd->page_count ; i++) {
 		if (!PageReserved(acd->user_pages[i]))
-			set_page_dirty(acd->user_pages[i]);
+			set_page_dirty_lock(acd->user_pages[i]);
 	}
 
-	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
-
 	for (i = 0 ; i < acd->page_count ; i++)
 		put_page(acd->user_pages[i]);
 
-- 
1.9.1

