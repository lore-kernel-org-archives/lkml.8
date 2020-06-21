Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC999C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C2B2343B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJkKcGn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgFUOhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgFUOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:37:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1EC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 07:37:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so1690680ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/EhCjhGUaHKEZmLZB2/jWP0BJA/JoCVKoRNRHhGW8k=;
        b=VJkKcGn+8xXDYqo1P2AvHoeILHB4XYGDpdIXSV2YiUnvECfKere6WIEpqozLuO7czh
         2kyHkpZ+8qS9xuagwGQYuHuk6bR0izlB7eKTEMFOUPn+T49OzkgA268AJVjSMir+Y0tR
         uvCbvuG7TyE8g68GPOHJZlGnOVwJTTxoGxnX4NkiZvl6AVU6QijIJkys5hNcCu9Owisv
         wFq75EFSmUWhUZH+nq1zKF7bNS7BbAio2oCWTWhMahhZXVrVWCcv3qmF2k0g1JJflk7P
         DF+yWzFppjwD7kBiaCOHJb43fzQs4O7HdpxhX0fJ3/YAglaba83Qhz5uCIiJIsgPocsn
         FVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/EhCjhGUaHKEZmLZB2/jWP0BJA/JoCVKoRNRHhGW8k=;
        b=AuIgtmOWgWpE7lSmk4ku1o7AYL7CLF970vPjVgeyeS3ezw+ts3lmWV8PN4FM9SwJLg
         vDNoiTL9B4El5t3p4lGgGaj+oza83NVGZ136mR0SK51yqWed9ThsEYFvQRvS5nC2jOfr
         y8do3JQLoVgYQ6fP3NTD+5yH3lIQl8ApJ51Njmc3ah6L9QyD4IyruK8cYsLbZFK0dmr6
         zJd8tDvv3XETA/b8bAFGPfaNGeo9RTQPO3I6mumIOMwsiSvdVQVntlPGt9dQ4nxNNri/
         1azNRsip5Ohw8bXGwQOzCxTJV5csuc8x1cP3oLeV4TjbfdEggKprWZEHuWPTAs+ErNaK
         EFhA==
X-Gm-Message-State: AOAM53266MLplqF1DcRVEiCXWn51gXdGfF6g76FTPoOoxARYO7MP9Bug
        993UIc+aS7v1NYFKe+piAc3Tasp9
X-Google-Smtp-Source: ABdhPJwj9c/EO+Zhw80kTn9UCHHA2oKXODD5UYSBLhH/iiBUz2PgQ3Wv6GEmTtPaI3aC2UCcMQW/3A==
X-Received: by 2002:a17:906:1d5b:: with SMTP id o27mr11826764ejh.344.1592750220092;
        Sun, 21 Jun 2020 07:37:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:5fe:4ba0:7ffd:29fd])
        by smtp.gmail.com with ESMTPSA id p25sm9513864ejf.79.2020.06.21.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 07:36:59 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH] sparse: group the defines by functionality
Date:   Sun, 21 Jun 2020 16:36:52 +0200
Message-Id: <20200621143652.53798-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By popular demand, reorder the defines for sparse annotations
and group them by functionality.

Link: lore.kernel.org/r/CAMuHMdWQsirja-h3wBcZezk+H2Q_HShhAks8Hc8ps5fTAp=ObQ@mail.gmail.com
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/compiler_types.h | 44 +++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e368384445b6..b67930216e45 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -5,48 +5,54 @@
 #ifndef __ASSEMBLY__
 
 #ifdef __CHECKER__
+/* address spaces */
 # define __kernel	__attribute__((address_space(0)))
 # define __user		__attribute__((noderef, address_space(__user)))
-# define __safe		__attribute__((safe))
-# define __force	__attribute__((force))
-# define __nocast	__attribute__((nocast))
 # define __iomem	__attribute__((noderef, address_space(__iomem)))
+# define __percpu	__attribute__((noderef, address_space(__percpu)))
+# define __rcu		__attribute__((noderef, address_space(__rcu)))
+extern void __chk_user_ptr(const volatile void __user *);
+extern void __chk_io_ptr(const volatile void __iomem *);
+/* context/locking */
 # define __must_hold(x)	__attribute__((context(x,1,1)))
 # define __acquires(x)	__attribute__((context(x,0,1)))
 # define __releases(x)	__attribute__((context(x,1,0)))
 # define __acquire(x)	__context__(x,1)
 # define __release(x)	__context__(x,-1)
 # define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
-# define __percpu	__attribute__((noderef, address_space(__percpu)))
-# define __rcu		__attribute__((noderef, address_space(__rcu)))
+/* other */
+# define __force	__attribute__((force))
+# define __nocast	__attribute__((nocast))
+# define __safe		__attribute__((safe))
 # define __private	__attribute__((noderef))
-extern void __chk_user_ptr(const volatile void __user *);
-extern void __chk_io_ptr(const volatile void __iomem *);
 # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
 #else /* __CHECKER__ */
+/* address spaces */
+# define __kernel
 # ifdef STRUCTLEAK_PLUGIN
-#  define __user __attribute__((user))
+#  define __user	__attribute__((user))
 # else
 #  define __user
 # endif
-# define __kernel
-# define __safe
-# define __force
-# define __nocast
 # define __iomem
-# define __chk_user_ptr(x) (void)0
-# define __chk_io_ptr(x) (void)0
-# define __builtin_warning(x, y...) (1)
+# define __percpu
+# define __rcu
+# define __chk_user_ptr(x)	(void)0
+# define __chk_io_ptr(x)	(void)0
+/* context/locking */
 # define __must_hold(x)
 # define __acquires(x)
 # define __releases(x)
-# define __acquire(x) (void)0
-# define __release(x) (void)0
+# define __acquire(x)	(void)0
+# define __release(x)	(void)0
 # define __cond_lock(x,c) (c)
-# define __percpu
-# define __rcu
+/* other */
+# define __force
+# define __nocast
+# define __safe
 # define __private
 # define ACCESS_PRIVATE(p, member) ((p)->member)
+# define __builtin_warning(x, y...) (1)
 #endif /* __CHECKER__ */
 
 /* Indirect macros required for expanded argument pasting, eg. __LINE__. */
-- 
2.27.0

