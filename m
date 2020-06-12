Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C60C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99578207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lj5U69Ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFLHKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFLHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7466EC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so3478013pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQ9MqfWdvKY0A/nub4Fo1FL/E8bJu3O4TVW1RUvcWdg=;
        b=lj5U69Cksq6OCRUwr5FSFcfeGktJxkA9FTX+22+Wu+8dwxBHR77hXuHnIPRGOGie44
         ERN9/bY0xBVAOg9TX0F1fwANzNIdEZDZ8O4zqyQKeVct1npSg+vhxUXazCaPOanobztU
         9IPlSXq8y3X0DOryWc0JvgfCJkQrIvmRxtFpBJoIO0umdmsg88SzIQzbrWuSS5IaaqiC
         7jVNrkCGrcOhX9nUMKOmAks8AXBrZNwWlqrDsZmzAFXqqRLSuMEsdwLqtJCyTc7uVnbg
         trwbYhhJV97v47brW5F6K0w52j/zZa2BihQAIGVXfIz7oMjc6oE8qumbzxHB5NHRp0JI
         AMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQ9MqfWdvKY0A/nub4Fo1FL/E8bJu3O4TVW1RUvcWdg=;
        b=gINSqIBTfzmlxJbUH4cF8KHwyWOxF8BP/weoan9oX8DqRtgqjwhqBMoTlOt/7vvB1w
         nYik8SNnonD9G+/P/uvnlteWyErNnJ268l8NWHkUZN2CrSnp7U9YARVX2dhmt/yJrdfG
         UHbQ0kOgMcb2FGt4iOKEROEUnTfujMXrdUhreCCyA9bzZ/BeDtxGsoZGkpnxuT75cTyM
         DQdcKtHixueJjIqboExOGTt/t4Fl88W+CbXA2NOc8dtyUzrIOymosAN6ykGm/sywLp89
         c5yNjkgRRhr+XS+0yk7j5aSAKZP6JqiQMdyTrgTeTxiT0XKt7bgDyycb0DPT3gnEBYpi
         9bfQ==
X-Gm-Message-State: AOAM532K9+3gntywKbzTEa0CnpHCTKeMGrdqH2WydNbHTvDVx4DS+qY2
        tlx3p57rREAHwqcf/Lkv9cXyhg==
X-Google-Smtp-Source: ABdhPJwXTT29gm2ifat7CTG4weeyGOi00tGqBa0Ywljl2zNKwiR1hC9l0czmEkulm7P+V+zLBD+x/w==
X-Received: by 2002:a17:90a:3b09:: with SMTP id d9mr12421250pjc.225.1591945817016;
        Fri, 12 Jun 2020 00:10:17 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:16 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>
Subject: [PATCH 03/13] riscv: Rename __switch_to_aux -> fpu
Date:   Fri, 12 Jun 2020 15:09:52 +0800
Message-Id: <28ce87a2bf6b73b01faa33b35df440effaab9a8b.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

From: Guo Ren <ren_guo@c-sky.com>

The name of __switch_to_aux is not clear and rename it with the
determine function: __switch_to_fpu. Next we could add other regs'
switch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/switch_to.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 407bcc96a710..b9234e7178d0 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -44,7 +44,7 @@ static inline void fstate_restore(struct task_struct *task,
 	}
 }
 
-static inline void __switch_to_aux(struct task_struct *prev,
+static inline void __switch_to_fpu(struct task_struct *prev,
 				   struct task_struct *next)
 {
 	struct pt_regs *regs;
@@ -60,7 +60,7 @@ extern bool has_fpu;
 #define has_fpu false
 #define fstate_save(task, regs) do { } while (0)
 #define fstate_restore(task, regs) do { } while (0)
-#define __switch_to_aux(__prev, __next) do { } while (0)
+#define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
 extern struct task_struct *__switch_to(struct task_struct *,
@@ -71,7 +71,7 @@ do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
 	if (has_fpu)					\
-		__switch_to_aux(__prev, __next);	\
+		__switch_to_fpu(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
-- 
2.27.0

