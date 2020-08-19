Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9195207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH7adRKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHSTjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHSTjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:39:43 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00539C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:39:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so19087792eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yd7EYvVEuvXaQQnlQebjKHZTDtyygSQlPm6fYa8dX0c=;
        b=NH7adRKAPFPqZPXCowY/ar3Ei1f5iH0HB+od9dTrfZ2Q2zUAIfVlraBF/Fxwux/zc7
         Qesy8hn2qkE3lri4hKI8j3wtgYeFKwxVac52bl2h2WmvlLmA74QcWLk1orOx4vde9Tn2
         0IPJN7vNLSBr2JIbZ40KjUcC8mErBK/GR13YjOlhouPHETMFWv/cniY/UWH1St5nVFrw
         YVFgyD0G4Kwdpdje0udHuHg043j6p3aVp+WSUnL9erAxPMF+C3LByIAooTqKVFX4UFuL
         SiojRV6UrVcFkdC3LxawWpCpkiijD6Ej5VBcYpJjIgCt8UXcGZZzmTxm5KXQ3c95LNCU
         563Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yd7EYvVEuvXaQQnlQebjKHZTDtyygSQlPm6fYa8dX0c=;
        b=gFPa27wrqysze93nKzScAyvI2R+nPfBHQRfukq6NFCzkor4nBFAX4QTF0tkmyo4p5E
         /g/YlXJT3RTrRHUChL+5ZnRYiHwtMTcQM+O4DJOzUXXh54SEXNkXytL6W9BP8RQRHezi
         euB7iRlNZ1FEevDhTKAGlLq7EkVP4aXzopg7lyCojSfN19/J4CzXF0vP3XzIC/KIsJ/r
         8QF/XLr9dtiIm1ATkeyyIk6qbBHiu31sBh/J8GboOWKqSwY0xv7zkXHFdTDTcSrK65St
         Ex6WHt7JrcNu1HnvVxjAXlGkyT06vOU4m3McKU2TgYTp/xSs3/EZUiQEwgRR2j18ARMJ
         44OA==
X-Gm-Message-State: AOAM5315UodZ/XVp1k6X9AE6TecibTJg6OtPG7mgt0cVs2yiud97Ylvh
        hS3qYv3eblYYgl/uicmSrns=
X-Google-Smtp-Source: ABdhPJzRnOQW8YcxGuz4rNEnMK/i4+CphrpkfHFQ/9AogKnkfRQdSdNfeYjk6Gsj1pC+dzZxDPkFaw==
X-Received: by 2002:a05:6402:1443:: with SMTP id d3mr27266551edx.40.1597865981745;
        Wed, 19 Aug 2020 12:39:41 -0700 (PDT)
Received: from tsnow (IGLD-83-130-68-114.inter.net.il. [83.130.68.114])
        by smtp.gmail.com with ESMTPSA id a19sm18231355edv.49.2020.08.19.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:39:41 -0700 (PDT)
Date:   Wed, 19 Aug 2020 22:39:34 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] staging: android: Remove BUG from ion_system_heap.c
Message-ID: <39222c3a041708c41ab3bc1be855ac83912ee07b.1597865771.git.tomersamara98@gmail.com>
References: <cover.1597865771.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597865771.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove BUG()  at ion_sytem_heap.c and error handling to:
 - free_buffer_page
 - alloc_buffer_page
this fix the following checkpatch issue:
Avoid crashing the kernel - try using WARN_ON &
recovery code ratherthan BUG() or BUG_ON().

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index eac0632ab4e8..56d53268b82c 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -30,7 +30,7 @@ static int order_to_index(unsigned int order)
 	for (i = 0; i < NUM_ORDERS; i++)
 		if (order == orders[i])
 			return i;
-	BUG();
+
 	return -1;
 }
 
@@ -48,8 +48,13 @@ static struct page *alloc_buffer_page(struct ion_system_heap *heap,
 				      struct ion_buffer *buffer,
 				      unsigned long order)
 {
-	struct ion_page_pool *pool = heap->pools[order_to_index(order)];
+	struct ion_page_pool *pool;
+	int index = order_to_index(order);
 
+	if (index < 0)
+		return NULL;
+
+	pool = heap->pools[index];
 	return ion_page_pool_alloc(pool);
 }
 
@@ -58,6 +63,7 @@ static void free_buffer_page(struct ion_system_heap *heap,
 {
 	struct ion_page_pool *pool;
 	unsigned int order = compound_order(page);
+	int index;
 
 	/* go to system */
 	if (buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE) {
@@ -65,8 +71,11 @@ static void free_buffer_page(struct ion_system_heap *heap,
 		return;
 	}
 
-	pool = heap->pools[order_to_index(order)];
+	index = order_to_index(order);
+	if (index < 0)
+		return;
 
+	pool = heap->pools[index];
 	ion_page_pool_free(pool, page);
 }
 
-- 
2.25.1

