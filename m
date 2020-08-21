Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED86C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4429207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrqNGUmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHUP2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgHUP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:28:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2ECC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:28:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so2304720wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+y66MqggCakjVuRG4cFz30VjWieYM9CuDcuOFxkR0Z0=;
        b=XrqNGUmj2d6Xu6Kb6GMB3M6jmXO1rzxI9r2vGH/mlHjReZ/EU9RkaCjmwICLzWY4Gn
         TGX8IBv6+v8eYu5rSay0806nirzMq65EzeJd6NOkbwQbwSEiQFJy8wdhquSBc4YOfmUG
         p5s1Bzs56kl0dmEPlRi1W31V8SFMxK3pzTUz2D6boIA6gDo8i1/ZZgcjkvirtaMc+lJ5
         UDWeWSgwgYyOdUACy2ozcc/Iz83Ln4ITtmcCsk/xqOjAcwFXWIiCIgjVAxfygoZs1p0z
         gKl3GsxfxpaqAYLtGx3HWCsRKVXuJHaNRjzlKM+z/lvf1aseKPg6eUs2uPFuZ5fcGSSB
         4/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+y66MqggCakjVuRG4cFz30VjWieYM9CuDcuOFxkR0Z0=;
        b=o74IrWaPBbrw3+0Meu2vWN4Hd1/8+rpF5RT94sQAu33LEoNTodQMn253cZocT/ew4j
         zsJWswN6FsLCqAD+0iR92EPY6ZGKsPPCLSjYNWn65HCVjqkUT0RSwXdDWMmCGOaldibj
         ssR8wqoQyaVmekklyXGLBls+bKQQCf4AL+/ioK32fItSCWsqK8pqwig7mFec5hbcTca+
         eC5gshaEjnVANAA7b+XY14ByUmNDx3Vpw2Z8SXIG/Fn5HVR/CkbH2cjv9RkH4BDI4dAU
         0D2h1ID+FZFxmSRb3f1oDPnILNK5XpoP4fmci2GaXg9XgwbKJia0Xb9x7Y6nDGibNXTm
         oqlQ==
X-Gm-Message-State: AOAM531gKUHxbd1xeNlcU3XWfQm/flJZdrSO+o5WENongJkl5ETWPBmR
        2oxf55/de1fefw1cxXsk0NU=
X-Google-Smtp-Source: ABdhPJzsj3Ldq5q3T34rHmzgtlQJTbTH7AApriawiIsBCRv3S499thDPeosIx/PU22cuIXSKmQim4Q==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr4278996wmb.63.1598023697023;
        Fri, 21 Aug 2020 08:28:17 -0700 (PDT)
Received: from tsnow (IGLD-83-130-85-196.inter.net.il. [83.130.85.196])
        by smtp.gmail.com with ESMTPSA id w132sm6418009wma.32.2020.08.21.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:28:16 -0700 (PDT)
Date:   Fri, 21 Aug 2020 18:28:10 +0300
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
Subject: [PATCH v4 2/2] staging: android: Remove BUG from ion_system_heap.c
Message-ID: <a39407f84031eaeed5e65a7aab515a079edf5fcc.1598023524.git.tomersamara98@gmail.com>
References: <cover.1598023523.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598023523.git.tomersamara98@gmail.com>
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

