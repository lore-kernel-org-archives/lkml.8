Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F83C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE652084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ecQPNOMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgE1Gl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgE1GlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE558C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a45so390132pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fZ7IHiP/Z+5wqk/IVpAWK8RobZ149sWEYypNjSaWVHM=;
        b=ecQPNOMWFN6b2YfFKWU4oMbBXZ+R0nS95qowGUZRFJ8FR+jJ7V6ZZMjcGMycCdSp6K
         RZzhokLmqgenfcN/CVF3q4sB0jkEMC2u8zlKZ9CimbxwZEcxhq2ScZyZUDp8IN1KE9W3
         RutucfxXJfkOdN5AbC3JH+bnjMv3hUaS3FRg3Q9a8/a+lL/WarkjHby75BKsKFBZwpeC
         HNjN4MSf72hxEDQTVjgmYeq1JnuBB/yGKzyX8p1J8F96SfOD4IFAErwFD67szd5Ezhmc
         bczR/BFO+Do8oY9P5CP5m0q6mcVasEj+enLPT9jCgihkchgNIWvRNZB00MnXXdKbxI5f
         tQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZ7IHiP/Z+5wqk/IVpAWK8RobZ149sWEYypNjSaWVHM=;
        b=cYjNvkVqySTqbsNo0v0UoOkKHFkrYfw62bzCETdokSEDlD6fqmofc41basz8eAH1ai
         AkVf9LkeUmyE8/lZfjYsN3DizVhzgiUND1TC86BWfZV31gBFhMPndATZZm1MUqR1o6FE
         PcP77pNRDjHiZ8NFxlrE8XH4vfUuJdAxOW8E0AJdghNKl3fxFtbxlQc0uqALigaU/vBm
         iaKn+ewaoha8AuqdMNuBcTokUNIx/M2gPsmDRSzfbOCIWzDa9IWl55wakq2AL2XKiMzU
         lzCx14rxFFYpe+H4GoXciyeGLSEr0uPbFXFDm3KvHRatfC1LdQ06XOBE5yXdOTFAc5Wj
         Xi6w==
X-Gm-Message-State: AOAM533ldtxU3W0/+iP7O4IKL/VWSjkEqHIYgG/V9qf1aOQFzRJSjNAg
        8dJyf1vUo//wvUs7Nfyyhd3yWzOQfU7Xow==
X-Google-Smtp-Source: ABdhPJwhfcmrOPMwrpz4PykSjHmxMC3nkDqYlb8LUtRLCgjH3EzBt8/MUUH6wHiw9NbacmbWQ9k2uQ==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr2089961pls.102.1590648084303;
        Wed, 27 May 2020 23:41:24 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:23 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v5 08/13] riscv: Reset vector register
Date:   Thu, 28 May 2020 14:40:56 +0800
Message-Id: <d7914022dc9d2d1827d67fb4415919398b339619.1590646208.git.greentime.hu@sifive.com>
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

Reset vector registers at boot-time and disable vector instructions
execution for kernel mode.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/entry.S |  2 +-
 arch/riscv/kernel/head.S  | 49 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 56d071b2c0a1..4e32770c19c8 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -70,7 +70,7 @@ _save_context:
 	 * Disable the FPU to detect illegal usage of floating point in kernel
 	 * space.
 	 */
-	li t0, SR_SUM | SR_FS
+	li t0, SR_SUM | SR_FS | SR_VS
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 98a406474e7d..1290ef680125 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -181,10 +181,10 @@ ENTRY(_start_kernel)
 .option pop
 
 	/*
-	 * Disable FPU to detect illegal usage of
+	 * Disable FPU & VECTOR to detect illegal usage of
 	 * floating point in kernel space
 	 */
-	li t0, SR_FS
+	li t0, SR_FS | SR_VS
 	csrc CSR_STATUS, t0
 
 #ifdef CONFIG_SMP
@@ -341,6 +341,51 @@ ENTRY(reset_regs)
 	csrw	fcsr, 0
 	/* note that the caller must clear SR_FS */
 #endif /* CONFIG_FPU */
+
+#ifdef CONFIG_VECTOR
+	csrr	t0, CSR_MISA
+	li	t1, (COMPAT_HWCAP_ISA_V >> 16)
+	slli	t1, t1, 16
+	and	t0, t0, t1
+	beqz	t0, .Lreset_regs_done
+
+	li	t1, SR_VS
+	csrs	CSR_STATUS, t1
+	vmv.v.i v0, 0
+	vmv.v.i v1, 0
+	vmv.v.i v2, 0
+	vmv.v.i v3, 0
+	vmv.v.i v4, 0
+	vmv.v.i v5, 0
+	vmv.v.i v6, 0
+	vmv.v.i v7, 0
+	vmv.v.i v8, 0
+	vmv.v.i v9, 0
+	vmv.v.i v10, 0
+	vmv.v.i v11, 0
+	vmv.v.i v12, 0
+	vmv.v.i v13, 0
+	vmv.v.i v14, 0
+	vmv.v.i v15, 0
+	vmv.v.i v16, 0
+	vmv.v.i v17, 0
+	vmv.v.i v18, 0
+	vmv.v.i v19, 0
+	vmv.v.i v20, 0
+	vmv.v.i v21, 0
+	vmv.v.i v22, 0
+	vmv.v.i v23, 0
+	vmv.v.i v24, 0
+	vmv.v.i v25, 0
+	vmv.v.i v26, 0
+	vmv.v.i v27, 0
+	vmv.v.i v28, 0
+	vmv.v.i v29, 0
+	vmv.v.i v30, 0
+	vmv.v.i v31, 0
+	/* note that the caller must clear SR_VS */
+#endif /* CONFIG_VECTOR */
+
 .Lreset_regs_done:
 	ret
 END(reset_regs)
-- 
2.26.2

