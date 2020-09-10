Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D36C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41BB20708
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IzQaAMMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgIJIVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIJIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D7C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c3so540041plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7nwVvrjTBVRtHppJqQAkiSfbar3bHistj9A5OWSP/U=;
        b=IzQaAMMT2j0UvYxCP6rnBPqQiDH2qMqu/NIuRa+EjILwwb4WLiqn9RspVzMJEVmpqE
         KOvyjCo2zxHnSrmKFpvawqwa71LiLQTLSpWaDO2xTBod4XGLkf5vWpbPAaMNxKnf4q8l
         9rK8yOdPEF3V6yQRA8z+dzed8utlKxdCjPKpRwVdUYmePQdDWoUqWXzfklVial1oZGmN
         UhlIxxQUxSHiKXDf4uErygfu/LcnTm7X6CKHWpk2u7/PC97lfJQDPC1RE/gFHeb76eEU
         EVabX4/2FtFa/6GhAX62tqHrtef1/z2R9WGAm1UPUJMDU8k6eibMSg6aWEzc0X9Vmk0W
         OFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7nwVvrjTBVRtHppJqQAkiSfbar3bHistj9A5OWSP/U=;
        b=aZUQi2cjZij0ncYFP0sUCK8poHxZ5GFxJaVCWJ8+sMpKlhqVR8LzXz4uelv09bm7ru
         UdakGlPVOvE7LRXVXKtwBVT+zgzFo8nXZLWAvRLtYye6DrEcy4kzy70BNVNJwokwKDXr
         KXRcaVtg0Bj9bCfp6eyEesREYKLsDxlOdLbaXOKmfd2q0hfEtDYFhBkcLmgaeJkeJckI
         bmvta/Jml2rTazALMpLsx+hKUnzdg7LtG6R5D9FqADSqtamGlrEMtW4DkJwyqmG3qygc
         3LeyPhOn4gb74KhQF2s4zq5ipKgP/cAMob93decpXWuOQG+MQVecAmv5klP6GGTczuiI
         ONDw==
X-Gm-Message-State: AOAM532vSEuDi57LpQJaLc/OOb+DbS23uMWqPk8JcMjtYmfG6SvcTm/x
        f1ftBi1pugHIyH9VPgp2tEafYA==
X-Google-Smtp-Source: ABdhPJz+QyaGhkNP1HKU+VvxmMIedmnjMbRDvuvuw6dtRoI9tVnaL4pCHYxhOuf8CLM2YRRedhJvJA==
X-Received: by 2002:a17:902:eb0b:b029:d1:8c50:b1ed with SMTP id l11-20020a170902eb0bb02900d18c50b1edmr1614334plb.41.1599725573393;
        Thu, 10 Sep 2020 01:12:53 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:52 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v7 08/21] riscv: Add vector struct and assembler definitions
Date:   Thu, 10 Sep 2020 16:12:03 +0800
Message-Id: <4cb7ed8c6af8e1865ca817d590f06f4fb485230f.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
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
index bdddcd5c1b71..a66a5d4ee5ad 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -34,6 +34,7 @@ struct thread_struct {
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
index db203442c08f..f6fa65a6aaf0 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -67,6 +67,14 @@ void asm_offsets(void)
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
2.28.0

