Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596DAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9862078D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M35WWEAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgHPTba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgHPTb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:31:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC95FC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:31:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so11932882wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=riVeaXVjuZmcehfNxxO8lj1kUtlDfTSeuBv9qK6ixUA=;
        b=M35WWEAt9qJsNNvKpcIIpZDd4UCS92+EA1NKQ1mjYL7EO+BCytO5qucyp5SJ5ycDBW
         ok6UZvtncPj9Z2neCyQSNZF5vSNZkEwxhdJt5BCBMUbXd4yrGHw7qkcIzGC5oFi5Usn9
         WQNJXubTHLsJ00fSyWsZcgu/UMYdPTXN0Q6V7/d//ppdwwFoIW4GnLT9KXU/3advb3zz
         1UtIGTD9LHNCptcgSJL8oEA7rFk/LIsevxHRWlWzc4oMXZ+k8NWd9nKi1zu0Z8ECfg7p
         dg9RzfTXM9NoJGKySUUqFARfqIiR6X8xAk4CbHAvRE4W8631hQsy4Sv1NPKyzp5D798y
         Y8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=riVeaXVjuZmcehfNxxO8lj1kUtlDfTSeuBv9qK6ixUA=;
        b=IgMrV/bBjWsajnxx2VEGZVToXHXnzFmwLcTMJ3sJY47OUU/kzcgPI+hB7ehomfmTvM
         tt2IAsH7qMxbJIktLCmXbVdS65CxOyZ0ha6H1AV5DY4hkFCdnSGfBLVOO+Fy1pTJMN6J
         8uzKhWvdTPX8SJnOf61gpbh9wFBk8QyZf/VuaGmUaRAuo+hxIYkjaSMQfochoN5a7enx
         Ae6liFHrJwpEgH2Avib60SlRiQHxcTFXns7u+1KYDUC0pk0xdn7hapjzkeO7UKvKo3vj
         IjG8+7ji7DpqoLioXoRaQ264/oCvaaOpzQs/gEbNVxA+5jHs0G6tysasKK/vnyoM9jQY
         Q2dg==
X-Gm-Message-State: AOAM531RFpMt3bJD9lXiy5acnStltZS8f2yT5vZo19Tr7Qpp+4aFiz8j
        Wj4y5+5qma6ZQy0r7kgcziXLQb+Ya0Q=
X-Google-Smtp-Source: ABdhPJyi4UbmT00nTsoSw/OuAaaFid8FGig1pZoNI7QyAgobSL5JM93sWI/I2tZYZtmJy2gncMhaeQ==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr11556318wmh.168.1597606285796;
        Sun, 16 Aug 2020 12:31:25 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id u66sm27717981wmu.37.2020.08.16.12.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 12:31:25 -0700 (PDT)
Date:   Sun, 16 Aug 2020 22:31:22 +0300
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
Subject: [PATCH v2 4/4] staging: android: Add error handling to
 order_to_index callers
Message-ID: <c653c468e0c3044b10df375e8245e5d50634a7fa.1597602783.git.tomersamara98@gmail.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597602783.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error check to:
- free_buffer_page
- alloc_buffer_page
after calling order_to_index, due to converting BUG to WARN at
order_to_index.

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 37065a59ca69..1e73bfc88884 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -49,8 +49,13 @@ static struct page *alloc_buffer_page(struct ion_system_heap *heap,
 				      struct ion_buffer *buffer,
 				      unsigned long order)
 {
-	struct ion_page_pool *pool = heap->pools[order_to_index(order)];
+	struct ion_page_pool *pool;
+	int index = order_to_index(order);
+
+	if (index < 0)
+		return NULL;
 
+	pool = heap->pools[index];
 	return ion_page_pool_alloc(pool);
 }
 
@@ -59,6 +64,7 @@ static void free_buffer_page(struct ion_system_heap *heap,
 {
 	struct ion_page_pool *pool;
 	unsigned int order = compound_order(page);
+	int index;
 
 	/* go to system */
 	if (buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE) {
@@ -66,8 +72,11 @@ static void free_buffer_page(struct ion_system_heap *heap,
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

