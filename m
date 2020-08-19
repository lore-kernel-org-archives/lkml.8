Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F651C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A3E2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVFkn7Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHSDFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgHSDFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:05:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79DC061389;
        Tue, 18 Aug 2020 20:05:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 77so20400651qkm.5;
        Tue, 18 Aug 2020 20:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuU80Z7VtjiOx9KYQrgsSGrMxc3EizeZUZWTydpUAn4=;
        b=bVFkn7Jpptl33UIirsnQkeycmvNl+gvNzoYFkghC8+6LGL5udoY37qDPQN2nCnq1Q8
         T58YXrbN4JyvG+RZkoxxlSeoX2I/CI19QvzMqFadCN7TYhE1y1N+nbG/bGDZ4vP/Kr6q
         E2Ow4NFC9C923Y1Qai+wqjaZ5/kB5iFLLMgeXX6Z2MvyC4l/XVLo71WW2Od7wscGRqNP
         jHq+bVWN5DXVgb+L0bk/aUCIoOM9k09jd8sLwDunWR1LD5d+i6BgZDUG158hj+Y4e8ZQ
         PCnOeM7iPGTvFRvi3sZmvKShkK7JyBe2rnJdRHK4kkVA7pdCWJSQ0Ug5s9lpQu+CxzpA
         nZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuU80Z7VtjiOx9KYQrgsSGrMxc3EizeZUZWTydpUAn4=;
        b=MkX5yD9TaqIF4cdx4VbxfpnIpkPvBbXbigSuo4dW3hlarSk75Ouv5cpTPAfIaml1D6
         7J1hFTjzVLX8V9oum+FOh2AETZ9XHwyGdEsJ3jcwFvtfgHFN5y3rBnkfcF8v4du3nlHi
         VfY1WtYu8fFWgxugpghHnC3RY+Sq+BZOjUgNemfZR+oeuLg7XL9/5DgLdsJ/weUn4d6e
         +lNgiiXLjDoG0F9JBza6SPMHKkNECxsecI6AjfMdiFZztiZiO9iupO8rAiYEkUid+I9k
         aAe3w1XLdK+AMOBB1pVxxDH/4mZUW6U+FcrQbExm5OZ/GTpuAql6BXhvho99Yg8Qjl3l
         J6Ng==
X-Gm-Message-State: AOAM531vczUeqEQYR5feT7Y8CCY0j79SSqKq4Q0jMq+8XS6Mu4eYusQu
        4+ODvU1updFrcabXRUXKBAk=
X-Google-Smtp-Source: ABdhPJyuIl56o6bND7x75nor1iLa463PwWDbzhtM4fKJhOAT35dMU0ViE0ppxcixJye0CgD7MqivPA==
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr20332775qkv.490.1597806353035;
        Tue, 18 Aug 2020 20:05:53 -0700 (PDT)
Received: from atris.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id m30sm27724520qtm.46.2020.08.18.20.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:05:52 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] sh: add support for cmpxchg on u8 and u16 pointers
Date:   Tue, 18 Aug 2020 23:05:11 -0400
Message-Id: <20200819030511.1114-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test bot reported[1] that using set_mask_bits on a u8 causes
the following issue on SuperH:

    >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/phy/ti/phy-tusb1210.ko] undefined!

Add support for cmpxchg on u8 and u16 pointers.

[1] https://lore.kernel.org/patchwork/patch/1288894/#1485536

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---

Hi,

This was reported by the kernel test bot on an architecture I can't
really test on. I was only able to make sure the build succeeds, but
nothing more.
This patch is based on the __cmpxchg_u32 impletmentation and seems
incomplete based on the different cmpxchg headers I can find.

Do these function need to be impletmented in each header
simulataneously?

Thanks,
Liam

 arch/sh/include/asm/cmpxchg-irq.h | 27 +++++++++++++++++++++++++++
 arch/sh/include/asm/cmpxchg.h     |  5 +++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/cmpxchg-irq.h b/arch/sh/include/asm/cmpxchg-irq.h
index 07d3e7f08389..918c4153a930 100644
--- a/arch/sh/include/asm/cmpxchg-irq.h
+++ b/arch/sh/include/asm/cmpxchg-irq.h
@@ -51,4 +51,31 @@ static inline unsigned long __cmpxchg_u32(volatile int *m, unsigned long old,
 	return retval;
 }
 
+static inline unsigned long __cmpxchg_u16(volatile u16 *m, unsigned long old,
+	unsigned long new)
+{
+	u16 retval;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	retval = *m;
+	if (retval == old)
+		*m = new;
+	local_irq_restore(flags);
+	return (unsigned long)retval;
+}
+
+static inline unsigned long __cmpxchg_u8(volatile u8 *m, unsigned long old,
+	unsigned long new)
+{
+	u8 retval;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	retval = *m;
+	if (retval == old)
+		*m = new;
+	local_irq_restore(flags);
+	return (unsigned long)retval;
+}
 #endif /* __ASM_SH_CMPXCHG_IRQ_H */
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index e9501d85c278..7d65d0fd1665 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -56,8 +56,9 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 		unsigned long new, int size)
 {
 	switch (size) {
-	case 4:
-		return __cmpxchg_u32(ptr, old, new);
+	case 4: return __cmpxchg_u32((int *)ptr, old, new);
+	case 2: return __cmpxchg_u16((u16 *)ptr, old, new);
+	case 1: return __cmpxchg_u8((u8 *)ptr, old, new);
 	}
 	__cmpxchg_called_with_bad_pointer();
 	return old;
-- 
2.27.0

