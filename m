Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F787C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1E22084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j34D/ROQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgFLHKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgFLHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37808C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so3704254pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hj2dPYxf9ChP39UbQUHFbp9CrwoiANKLX5kN73nw2wo=;
        b=j34D/ROQjnhONX4zQlk9GKNvkSsVJAjFQ5qEvF4lY3wxw8UUtWollpSadUBzL2YJhg
         R03cWdRvP2V8n2uD0EJgysBgnDW1YP4h4QuIy5QhUmezjvvVIE/9OBfz757j6vaf7WzZ
         5A2T5z0iTYn1t3Bdlb5aEQ3yIUf8S7jVMP2jOuyRC6HmbWJIGiItS98O1eqwUVX3KjfT
         4hbPlGd5HumJ+uYiiI6t1m1uvmlnYxtX7KEfyk840xrff2G0I73+qQTxJ0r1FAbLFISu
         Tz09DL1YGzTf14uBNYzY5760j/Xw5mwwO4y8o40BgXE9/zzKV/jKXrM3pSCmlBGnFi3J
         UTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hj2dPYxf9ChP39UbQUHFbp9CrwoiANKLX5kN73nw2wo=;
        b=YOlaBh5TnWNHgO2MkZFLfpEgXWHqZQnerfz/uLbr+0W3Zjy7YL/LGubqK5Cr0kE3NL
         raQiMFJkkVnY5LRrTyWblBqHeFmxufocas+MiczvT5BCCPW8K+BRIEY21M/Y960Kfr+C
         rHlLW2BmkI5Djv7l88GNt9Ih9AQps10tYpXniwG1FZXbh0Wzkq61z4BzX0Ti1dlifwiD
         /kedIHdcRXBTd74MrtjZyAiSCzWl67dWDMRWdw9E1mGn3jthb9W7eCIu76AiyN0izKzp
         kDqDMP6Kvh/zVeUz1ZIEfu81aX7E9K8U5L4/KbNI+LVzWpQTFmOnjr3xCqCow+r3XO2f
         CtUw==
X-Gm-Message-State: AOAM5316OYKTMVkPnowVmJvZE7h+0iw31obDbkkm9PRgA60L0rGz8RWL
        i077CJLdfVz6DKeGM61jzxpCQjHJN2kocw==
X-Google-Smtp-Source: ABdhPJzSQsT2X/6m8pvPFSpq5aCtQwFbocucHDtZ7VPPrFY8MzbWGMx0sQXNb2xDQ+3qFy+gaPtJNw==
X-Received: by 2002:a63:7c51:: with SMTP id l17mr9664899pgn.303.1591945830320;
        Fri, 12 Jun 2020 00:10:30 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:29 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] riscv: Add vector struct and assembler definitions
Date:   Fri, 12 Jun 2020 15:09:58 +0800
Message-Id: <ccfa1f8a945100d93f88a0a8c369917931855d0f.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vector state context struct in struct thread and asm-offsets.c
definitions.

The vector registers will be saved in datap pointer of __riscv_v_state. It
will be dynamically allocated in kernel space. It will be put right after
the __riscv_v_state data structure in user space.

[guoren@linux.alibaba.com: first version vector porting]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/uapi/asm/ptrace.h | 13 +++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  8 ++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3ddb798264f1..217273375cfb 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -32,6 +32,7 @@ struct thread_struct {
 	unsigned long sp;	/* Kernel mode stack */
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
+	struct __riscv_v_state vstate;
 };
 
 #define INIT_THREAD {					\
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 882547f6bd5c..661b0466b850 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -77,6 +77,19 @@ union __riscv_fp_state {
 	struct __riscv_q_ext_state q;
 };
 
+struct __riscv_v_state {
+	__u32 magic;
+	__u32 size;
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	void *datap;
+#if __riscv_xlen == 32
+	__u32 __padding;
+#endif
+} __attribute__((aligned(16)));
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 07cb9c10de4e..6627fde230b2 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -70,6 +70,14 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_F31, task_struct, thread.fstate.f[31]);
 	OFFSET(TASK_THREAD_FCSR, task_struct, thread.fstate.fcsr);
 
+	OFFSET(RISCV_V_STATE_MAGIC, __riscv_v_state, magic);
+	OFFSET(RISCV_V_STATE_SIZE, __riscv_v_state, size);
+	OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
+	OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
+	OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
+	OFFSET(RISCV_V_STATE_VCSR, __riscv_v_state, vcsr);
+	OFFSET(RISCV_V_STATE_DATAP, __riscv_v_state, datap);
+
 	DEFINE(PT_SIZE, sizeof(struct pt_regs));
 	OFFSET(PT_EPC, pt_regs, epc);
 	OFFSET(PT_RA, pt_regs, ra);
-- 
2.27.0

