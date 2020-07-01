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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0A20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHVAS6YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGAGJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGAGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:09:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F79C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:09:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so11184789pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xo4kx1NAZFSrQlqrR4fKrSHkld4dOPpLGIHAf+LkV2I=;
        b=tHVAS6YA5XDLIVdffU924/kQYhbNx0e+NPD1VKUWOt2+bCxjYGRlTrt2H3OFxUmTZu
         ek3swGqtZUoFwUO4HjMxAIzdoXwYhCOv+EG+NCGO7Xy/QuposvsMJ176j3WwIu6G/LzF
         ysDs6e8FQkDo0Hvji4QAnJDDQdfyvmIRqJzVg1AEt63gnQW157fpJrPNWn0D9SNQMP7K
         eBNk6uwhIWn+4KaClmwSNyKcF0wDF1X/j7ibvThLoyjcLfHPPtFyvIf0bg6vpZuf78qL
         HBvwGs3TK43oyHSXDa/n4kla1vPE6a2kFx3wwY8bE1yTJJKaQjXIeYzgkGWUIgeOc9cN
         xttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xo4kx1NAZFSrQlqrR4fKrSHkld4dOPpLGIHAf+LkV2I=;
        b=kL4Obe4YwvAuVfSFTzQVz9YufkUeMAzfRPcyljqCKfE4gr21Ufpd+WSq5qmk4XnDX+
         H+Z2/LUfuaVRi3GorWFQrkf/vdSZlToMa3UI+ZktQLKeVUr7XtkHE8HJ9v77a52KHr9N
         a4PLBQh3e7BaWEjyy2yhfSAwQjr1FEvOqMXTVFLarh8K9vJdOHytuNh2Gi3SGQnwYp/p
         b4/kVaWYzcYC+0ghk52hX4gj1u3u+2ecZLNvJNO2AXU4IxYi0RAE/XyuXYr2xcGcpTS5
         hFfZxZNtMwXgzMravdxuJj28lW8vIxWsvU4mZHO4Amv88eZUo4YwawF1qZx6u/1errqZ
         Ebhw==
X-Gm-Message-State: AOAM531GTwBqPGdjxBduAyLXLfSqgqjswJGU6tclQJu/dosUXYOTXWhb
        yj/Xf5M0RIqdH+5hQzh40y0=
X-Google-Smtp-Source: ABdhPJzkKFMl5l3MTjtmmjB/I87a8WxbDI0qFkgqt2jrF81H3n99Hikz+/xQ+XVI8San/xdxbliuTw==
X-Received: by 2002:a63:34c3:: with SMTP id b186mr18323931pga.173.1593583789643;
        Tue, 30 Jun 2020 23:09:49 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.42.200])
        by smtp.gmail.com with ESMTPSA id 127sm4694073pgf.5.2020.06.30.23.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:09:48 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com,
        daniel.m.jordan@oracle.com, simon@nikanor.nu,
        harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 2/4] staging: kpc2000: kpc_dma: Convert set_page_dirty() -->  set_page_dirty_lock()
Date:   Wed,  1 Jul 2020 11:47:42 +0530
Message-Id: <1593584264-16982-3-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
References: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
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
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index becdb41..08d90a6 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -215,13 +215,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
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

