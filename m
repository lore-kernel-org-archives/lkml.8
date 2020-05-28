Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561D4207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l0IXQ9IT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgE1Gla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgE1Gl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCB0C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k2so1582869pjs.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d8KymXTIzfL2DSySO92h+GogegkiWUPCyUDxjM568ZM=;
        b=l0IXQ9IT4LdA3rLadoIdH9UelbiHhQV84fFynRfNHzaMjFEcrpSF2VyoPXOhGh1XuL
         7Iqy5V7K9+IAZLgesWIE8fNfyZS1EAerGxaUpwZ2ulgYEk3IUt2DgcePMttQnojk0MRi
         HZs369OGr2etAt2cMVXDftcW7uEmtg9q8m+Alc7vMk+pZRsK++JuOrnU1oIOIbOKrZwU
         xShKBiXHDvQzaFEyH1lHIkDx8NffqWZxNbKyOUdX8zT8ug17t26YaKz1ry8gTN8FJu3O
         uc/LRB/9F/HbvAirL9qOajUhLP6KGl9HK6/jpQRDnq7GNh9P+38ai4G+edTRRzdel9Ew
         CVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8KymXTIzfL2DSySO92h+GogegkiWUPCyUDxjM568ZM=;
        b=hR+DVXNVV4whRwWmynHEhjdyhVDPOQAZc+FjK74zUXkqA5EAdZh9xH2lyCqxiGr7xg
         xrd2EnIiieqOaOr2xA6MWTMtzhjEBZjHU8E2nPUK93/gR+mKK0+Ewp1mrK0lOabyYE+r
         pLK7jOP321o+zjwdrcpxofSMQfa61vRYOcAbiMfgz8B9rE4xdQ+T1HrDRnIzLLD7/9mT
         6Reklp5RALGZOuMRLcSQjmGqpKR+hHfPpiC9jRT3wEMlMswQzAzfr1He0MNcgW45jLzf
         cJLLh3OI+qQ4XW+V8YpdI6ki6zQFqDUjEM65sgmg1K8DcufSXg9e7bD09Fb3h84Lm4OB
         KyLw==
X-Gm-Message-State: AOAM532pQjRtf0PIdLkB/usDQNt+pOXniVQqAc2j4i4mcNAlH9Z0iiUW
        oR8zkq3UqAm3wE/ziHUL06uhKQ==
X-Google-Smtp-Source: ABdhPJwgtTfk52tXURdZI/TCSJ5EOlNZ9ysXJLsJmuH/davCMw5nigpJWr/X8sVEp0/IhknMp2jcbA==
X-Received: by 2002:a17:902:cb03:: with SMTP id c3mr2126242ply.307.1590648086332;
        Wed, 27 May 2020 23:41:26 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:25 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v5 09/13] riscv: Add vector struct and assembler definitions
Date:   Thu, 28 May 2020 14:40:57 +0800
Message-Id: <d6b4a7c8f8e6ae95994888c0aabdbfd46360ab63.1590646208.git.greentime.hu@sifive.com>
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

Add vector state context struct in struct thread and asm-offsets.c
definitions.

The vector registers will be saved in datap pointer of __riscv_v_state. It
will be dynamically allocated in kernel space. It will be put right after
the __riscv_v_state data structure in user space.

[greentime.hu@sifive.com: add support for dynamic vlen, add vcsr and remove
vxsat, vxrm because these data can be get in vcsr, add new macros for
_riscv_v_state elements offset and remove unused ones]
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
2.26.2

