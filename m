Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA63207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f1wSpJy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgE1GlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgE1GlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9324C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so9951261pgg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxFPfi7yVRboC8Xk/rNGKghJD7hDxFD+xwshE+PjzTI=;
        b=f1wSpJy/h2YUOcYWweQ/5X7Ou0bveOnO17Q3bv+RfqWbcLVhuosNfiYkXyuWn4kCUh
         EFbRsaCd2Yd6UiPlY2gewRV8InaM/ZosRiefglxbygWm60zJW03L8sTYQrKoo4ZPivqT
         6R/QDNspd9OLCpij2aDfBgktPHtwYgGuOzeWyGmxxnj3ZRi91EwVgMzAz6CXaDHj1aPT
         K04jf1kKyMLF/IEx7ZmNBEXHMCMrWMxutkBhJKNXmqBXecLxKZEg7SvDgWpFDX4ld4ji
         bETxb8MIJSKwTle4Jg7p157eqUF2AmxC4q+JY1sBX3laaT/xuLK7x4om+96aBTWw2UU+
         BeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxFPfi7yVRboC8Xk/rNGKghJD7hDxFD+xwshE+PjzTI=;
        b=s/ZcPObuLb45Y3Fv5J5Oxr/sQdJzP0ikBYJw5oFDNoNs9y3TbudL3+27AzkqX2WxZF
         egZ+xOqF8uHVp9+1GGSwWOcq9O1/Grjm3NXI1JUY0o81tFdMrEENPKqYfmSyG96KZYGI
         MYPagJeb3obsaEG0sRpEhVLx2fxb4XAe61KaAXlXyn+8wQ5eqNdglF9M00aKiB2GJiTg
         4FviYokO5lWRNU8QSeMzWojzGT6BfLSolvah88XaNB/dIXZIJLGSQHsVAt5J4uDET2kr
         trHYg1ggT4044/rs7OKDNPzZLlOzND+RrHh4VFYDGTN7TOIqXTQj+UD9V6FPXnUfj1pS
         j8EA==
X-Gm-Message-State: AOAM531AB/FBo4uD5FXLvtcfxoz6XrCgrVi95sgD17YKmSkuusoPpqB1
        PgzVEkE2COzjgVBQvxq87zjmTvi3Tr6seA==
X-Google-Smtp-Source: ABdhPJyzX13f5/QnB6M+TjYVmvxYFhQiZ+I+UK+08JJLyHFvv82ppMdeWwzu3tFliPawqU1SBMxRFA==
X-Received: by 2002:a62:30c7:: with SMTP id w190mr1563681pfw.302.1590648073195;
        Wed, 27 May 2020 23:41:13 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:12 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     Anup Patel <anup@brainfault.org>
Subject: [RFC PATCH v5 03/13] riscv: Rename __switch_to_aux -> fpu
Date:   Thu, 28 May 2020 14:40:51 +0800
Message-Id: <690bd2391cf1a44e23d1e6e4df58c1083a71c7af.1590646208.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590646208.git.greentime.hu@sifive.com>
References: <cover.1590646208.git.greentime.hu@sifive.com>
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
2.26.2

