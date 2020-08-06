Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A67C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B954D2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQ9MkvPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHFTmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:42:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCDEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:42:16 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so8488607eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTGXraRKF2Xnn2zuWAFO6+p95IAHDQSM01rMKogsvzs=;
        b=vQ9MkvPxcyEeIPqReTCgblByWgNh2RXqMOXfyQnzzV5pGUlbO1gNEi9Tuk2yXGAyvw
         Llp+YllnNF+/5YT35hIhLddUTJeCADRxco3W0o3sJc6USpPGiFgOPIyrTihBZOF3Ps3m
         b5ZWbutt/sHTifnimmHoLPTtNqysTQ9XTb7MzUOjCMNhbiT5DOvjHviINbVtIZmIxAqP
         S/sojwgCS0IH2KnB0TgYVG74FK3c4xzz0rriqrJAqHzc4Qk0guo0NNaJc+a+XXnz9Sog
         4j/RZfiLZqNe763mb3UC297NbxucK6AXP/cO9wRfGDEb577fsZw7XZ8d8qKe5ewyzyAP
         3TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTGXraRKF2Xnn2zuWAFO6+p95IAHDQSM01rMKogsvzs=;
        b=ARd6hJv+NXd5s/qk26WZ7kkcWSBTjLPdixyWyCeT14ytPbU9mAQ+bAhoOHD49OGyY7
         UTZccqO5mrhUazNsUP16X7B22Q+c+7bZqRwAjJA3eDPRJw2cP8dVoSR3Is5MqzS/TzLr
         DzjB0eg7eaodVtE2ee8SXwlDuOhycMAwg3gVuDDyBHRy+xaKQqUcdXrOadSaZSYu5Ny6
         3OXGv37E5GzrGflngMPnzTHSgT/iYGtFOpt/O5yL5vQhYjgHJhkA4G6ZSdLaOwdIeO1t
         fBQFKDWj3LztxGmpj3+sFfEa1J0m+ymCCvcQbHmuBg3hMRfblJFFtoGKnVjuRBh5VKWR
         9pGQ==
X-Gm-Message-State: AOAM530enUZJDyDc2oRKIEZC5zk15BFZZcxeUu1RMgiLIA2zs6VHnaRy
        KHdz0BuJ5ZIM467NwEwHw/o=
X-Google-Smtp-Source: ABdhPJwUSrOkit6R1m2RY1wbmUSTm5YwAHlyOTZHCmOcOrZQfPZ3BWq1IWCOT8TWScXfg7dJa2YeoA==
X-Received: by 2002:a17:906:2451:: with SMTP id a17mr5773388ejb.274.1596742935020;
        Thu, 06 Aug 2020 12:42:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id e13sm4016643eds.46.2020.08.06.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:42:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RESEND PATCH] sparse: use static inline for __chk_{user,io}_ptr()
Date:   Thu,  6 Aug 2020 21:42:06 +0200
Message-Id: <20200806194206.10338-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__chk_user_ptr() & __chk_io_ptr() are dummy extern functions which
only exist to enforce the typechecking of __user or __iomem pointers
in macros when using sparse.

This typechecking is done by inserting a call to these functions.
But the presence of these calls can inhibit some simplifications
and so influence the result of sparse's analysis of context/locking.

Fix this by changing these calls into static inline calls with
an empty body.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/compiler_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b67930216e45..a9b6699f3934 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -11,8 +11,8 @@
 # define __iomem	__attribute__((noderef, address_space(__iomem)))
 # define __percpu	__attribute__((noderef, address_space(__percpu)))
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
-extern void __chk_user_ptr(const volatile void __user *);
-extern void __chk_io_ptr(const volatile void __iomem *);
+static inline void __chk_user_ptr(const volatile void __user *ptr) { }
+static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 /* context/locking */
 # define __must_hold(x)	__attribute__((context(x,1,1)))
 # define __acquires(x)	__attribute__((context(x,0,1)))
-- 
2.28.0

