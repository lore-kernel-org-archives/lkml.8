Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C20AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C37F2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afpLZoVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgHVToI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgHVToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 15:44:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC8C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 12:44:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o4so908964wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+y66MqggCakjVuRG4cFz30VjWieYM9CuDcuOFxkR0Z0=;
        b=afpLZoVb9S8UX5sZ9/41+hXwLGbgiEtiHOm6f0p2P8Oh3Af7Yx/no4zrBKzKnt0F0f
         PPIT2K/9GZAWs+wbhuu+TJwBZ6LEfRYnHvZkTfv64n7pZrcffX0YS/x5cTaijqlkLzZP
         mKJR9PFZG+yGLfMKAMdJc1mackvLjGEjbz/zDBoz0qUeFGlQwPfhnSoiwq8//Z9UlFNn
         O/MvoekqmF7B2xPoXRW2cYPtM3YApr7keQHyrArRZHDI2VQmH060XReevrwNCxSlfr9i
         GY9+091wIX9sfA+wZSOhUMdgB7fs5OKUTLNqWZBlqnGeandc5Snv8rrJU3MZk9+ODRaa
         qQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+y66MqggCakjVuRG4cFz30VjWieYM9CuDcuOFxkR0Z0=;
        b=HDH9C8f8Y1roMO98y/GtnDxjGSC0KJoSKGJTDED1asN3wQBg/7x61WmFXiAcEbGPvT
         47vYexDlUfeYPRk61V32AJc6U1SB5ngNSfD+UvGHISjXnqUCn+tByP42LJaaqDAIMmGw
         1OX0hogFiTNZ5Mqlwv56VJ9s4fqfnVMnzeXNYB12eiR4NEBgVxlwwoP4Z2aI0LGrp/Hk
         IHGFRiAOfJJismyDxJxhJhhf4pRnP0mQHxFG+LHjU9ebYn+QIIN3bvHitmx7DMrSYIxp
         HZQ9quTSqpUOvYClyf5iqgZ1F5qSLQzEn9Fa69KnqT/b56nloQ7VuU6XKsI6UdAsDFeL
         lvRA==
X-Gm-Message-State: AOAM531tBBHtWPwUWPI80cvqbPS3LWYKW2zqN9RD4ZyOIJzw/n5DpmXB
        ccAzj8XXLSrsRgAAMPdvxvY=
X-Google-Smtp-Source: ABdhPJwt5n+lLcPAY7wmuVOEPNfgK98a5ZJcSYZj6v5ca19sNHLgGR7JEhitIeLWdduX+y2ESbJtEg==
X-Received: by 2002:a5d:5485:: with SMTP id h5mr3181435wrv.247.1598125442919;
        Sat, 22 Aug 2020 12:44:02 -0700 (PDT)
Received: from tsnow (IGLD-83-130-62-237.inter.net.il. [83.130.62.237])
        by smtp.gmail.com with ESMTPSA id k7sm3692908wrv.72.2020.08.22.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 12:44:02 -0700 (PDT)
Date:   Sat, 22 Aug 2020 22:43:50 +0300
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
Subject: [PATCH v5 2/2] staging: android: Remove BUG from ion_system_heap.c
Message-ID: <f554a891fb433e830403091e21fe288924c5c74d.1598125227.git.tomersamara98@gmail.com>
References: <cover.1598125227.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598125227.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove BUG() from ion_sytem_heap.c

this fix the following checkpatch issue:
Avoid crashing the kernel - try using WARN_ON &
recovery code ratherthan BUG() or BUG_ON().

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index eac0632ab4e8..00d6154aec34 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -30,7 +30,7 @@ static int order_to_index(unsigned int order)
 	for (i = 0; i < NUM_ORDERS; i++)
 		if (order == orders[i])
 			return i;
-	BUG();
+	/* This is impossible. */
 	return -1;
 }
 
-- 
2.25.1

