Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039BCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7DC2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrdRbuX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgF1HU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgF1HU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:20:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BF6C061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 00:20:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so10044433edr.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xub4a6AcFrTLJc1anaBxsk4voZXRWtmdI1iROOwnz10=;
        b=NrdRbuX3pVDMMvlHjYtKPK3ebtf11Bfb067WYZjUL0JCg1gU8YV71ZPjqpPGMxbtIL
         TTeKMKQodKiPmoyPBR/fS05/+fbVTfYX6Sr3dSHO53WfHJlaCykqvCU3r5AIouoQVx5P
         HExIIm65f2WA207uphRmhbFtblULmkx/AsXWDeay++HaC2pE8jp7ylkFZX3HaiUso7vP
         q39Ook5yFFWg9I2rhoLrf24lIA3anIjkOB4zaui+cx9NqiUvB0RdPmxtAhw649xsBIAb
         sRplVq8iqFWp0faFfduugEFAJZKVZaT/6tnY0dhjdmFqkdC1WhV5qNDdjUy8zRV0qK1R
         pX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xub4a6AcFrTLJc1anaBxsk4voZXRWtmdI1iROOwnz10=;
        b=NwmO++3p89hJqJNjKukVl6bvqj3hdZ7XkBfCwCj0IIeFFHAP7rQJX2ygELyF4d03YF
         Q5Y2Uxo/J8Hn7UsejvYrYtPC6O6ospVOkwd6wIdArNVex5RmxW1686Kh6ejvQNr071Wq
         ymbU1i4UM6rRWwJBtPG/DyyqqAdyRQVXuotjXBA2NS+RVyNzRx8/J1jFp/JiFDJ6BnUO
         wK8yv91RhSMV1XOCJeNtZSL0ApxVnY6XaUP5BpN3sU4CjawUG47avcHDGTldyzTUyJpp
         7Nfef19yknFxwTYK9T7P2ZLnzPaTjwfCX4ghnuW3aH6eUykMSk9wM/LcPEYdigY5y7rC
         BL7Q==
X-Gm-Message-State: AOAM531f4seBk8nV9lXFsiaD/TUzkxGi+4kq66U7RV4mpMkoJ2EJWynC
        xA3K9f4UKQHDcO+jCIxbjMui8Trh
X-Google-Smtp-Source: ABdhPJzRUEFCL7kjuJ+gQryw1pI1XNjsIh2B/grnj10uZB5jTkDZZQ99xa516hVMOK/iAC4skZ3xrg==
X-Received: by 2002:aa7:c15a:: with SMTP id r26mr11219231edp.21.1593328827189;
        Sun, 28 Jun 2020 00:20:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:f51f:7c31:2fc7:f95b])
        by smtp.gmail.com with ESMTPSA id o14sm11911857eja.121.2020.06.28.00.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 00:20:26 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
Date:   Sun, 28 Jun 2020 09:20:19 +0200
Message-Id: <20200628072019.67107-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
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
2.27.0

