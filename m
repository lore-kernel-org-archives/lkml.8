Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B25AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CB02087D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A8Ba9LiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgEZHDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731428AbgEZHC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:02:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BA8C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 131so1333514pfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxFPfi7yVRboC8Xk/rNGKghJD7hDxFD+xwshE+PjzTI=;
        b=A8Ba9LiM4FXDBMj3/JoAULUfqoADa0ZJ7s+8l4NrIqTU+KQ3a2+it1Iuet3PTrxIrw
         UI9B9o/y6gawWY0sVVNMAM3kWP/6zmTAW+IoiZaj/BlaaX+NSpsOM/7dsmGJPlBQyyZq
         p4ZyeoTqSv8K005XX52f3ZutijPMkUro18w60KwVEKZ1NOUoDytlpMveWxBqpX1R7xNE
         Rm9HDAUm7uG1VjgESdC1YsOP2VVZ0PrhU+EUUn4MiNn8GkLKYbZgjDtze0YB1FVUniXz
         Rg34XS7vZ7eHXgHwn73i+6UTkMwQGXoHriLC3zNe3abjzAfK13tMGnh6LAWfdWriwPoz
         PxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxFPfi7yVRboC8Xk/rNGKghJD7hDxFD+xwshE+PjzTI=;
        b=ovDhP+uaCubtC5yjWKGsA0WH3sLWEGXV7o+0FU8kciQbjFvKI70anFERlTUuXkGIo4
         P64PkNOuDv4u+b5SS+RCJTjWMYHPqj5uk5BDkyCIT5ESWJuZDppvdDai6lb4tzhbPd5e
         cPEInYtmagWQBpzdBMpO8BV8sru8VmfhKhyWNUhGqLXYVUbk+Z2MlMClpn+apNzbRvN3
         G4VZaf6dhWP1RndJSby5fvEXt3bc1E1B/PwS/YgmZdjDNjd5ej/kYUtz3c9C/ZrAGXJI
         B9vPOerITfo00N/jYCf60SowrUv3FMhLZlujthAy+NHdmXWU5BEVC4CXrzjgxedtEHgT
         o0bw==
X-Gm-Message-State: AOAM533wWH3lScc1tSrXqE3JC2npIi2Ywjgm1E8QrDcAAYAPLTJctJIc
        G5ElnqI2fDr+fzPDZgEVHT60ZA==
X-Google-Smtp-Source: ABdhPJxjtjxmQcZuhl0Aa/0AtC4qperp3MlGwBWJTMwMxNvqgsI/B5oMXqtXmEL5m4hT9DUTckKPUQ==
X-Received: by 2002:a63:f64d:: with SMTP id u13mr29609458pgj.151.1590476576166;
        Tue, 26 May 2020 00:02:56 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:02:55 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     Anup Patel <anup@brainfault.org>
Subject: [RFC PATCH v4 03/13] riscv: Rename __switch_to_aux -> fpu
Date:   Tue, 26 May 2020 15:02:32 +0800
Message-Id: <dd4b4959a413b9f9304caf593cea056c121dcefb.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590474856.git.greentime.hu@sifive.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
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

