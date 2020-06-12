Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ED3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A021D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Fc/RmOfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgFLHKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFLHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD16C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z63so2953643pfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bt52k9Bvf6mwoBH8BO99Cl1SZAUWj8JPjBOKu49Dflg=;
        b=Fc/RmOfgUenC1huViLl/zLKhIYopdecJLV5VD2dJhaN267VO6VkoMGplqRcZ7bos2+
         Wb+yl4Cd5cB8HwFCeCFWz42VYHvuzOcw8O3LW7JJ5vvZndUYNM/B8JOs2x9JBEheZQmR
         R94SW60bIr/7HaO6oNg1yMXH1Htlxkwt36l/C3KR+1kfnJhgMbydFY96Vp7NIHRXxxLm
         fzs/HMyxeNFHl1wdrdNPMaL06WQMM+GHIcSK/JL7Y+VYwaHPqiNQOxxcP5OGSEpa59rA
         uT3nUgYAtPpwmiipEPCZk0Aqjs6puRTNijHtj+C13r6ciR7iu4xkPSz4R1ta6nyv2RuS
         Fjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bt52k9Bvf6mwoBH8BO99Cl1SZAUWj8JPjBOKu49Dflg=;
        b=HifEqyxUvRGAt0CZm3/K9smhcKJ21UCBkD95AjKg5n5j66aG73EOcuEPLNxNa+VSJt
         y68K94XT+KgW6uQsxMWl8BkDr+ehiVKLPJf+MmWpbRMLYBmOw8ZtUgBl99hT/9XUR8ui
         iSzzD6h+VzqpvdugJma58l4Fi05sB44LDLXSrVwdnCqMwcP4MyasLwgX01gnJ8YPa9x7
         ETPKMffp5r5uVCvhpi2W9/Qz8srJkFEaRegxvV3O4IFZJSXlSIpYIKGsCdcXrFgacnWH
         xxgNqILBFgwO43iPB1KWj4juNOVJkOs9JVAcTbkKsEetYUFSF8M48RnC0ucvajdJZ3aN
         ++gQ==
X-Gm-Message-State: AOAM531DeCdB6aHBeAjM9hCRGnpvUBHBPKOKTcC0SMnFAT/S+0OhtaYF
        31Q7g022fQvYvdnrsdz/Px1TYg==
X-Google-Smtp-Source: ABdhPJzcGkM7/3ILCBONGZKG4PpCtorJ3xtsrdL+K4vr+cBUu+pfS0s625IeEIqoX+ldCpeFmfNF/A==
X-Received: by 2002:a63:7f5d:: with SMTP id p29mr9628085pgn.337.1591945828140;
        Fri, 12 Jun 2020 00:10:28 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:27 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] riscv: Reset vector register
Date:   Fri, 12 Jun 2020 15:09:57 +0800
Message-Id: <63ca68cb344d18fdae0036e1b66770f1f9a90fbc.1591344965.git.greentime.hu@sifive.com>
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

Reset vector registers at boot-time and disable vector instructions
execution for kernel mode.

[greentime.hu@sifive.com: add comments]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/entry.S |  6 ++---
 arch/riscv/kernel/head.S  | 49 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 56d071b2c0a1..2184153836ca 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -67,10 +67,10 @@ _save_context:
 	 * Disable user-mode memory access as it should only be set in the
 	 * actual user copy routines.
 	 *
-	 * Disable the FPU to detect illegal usage of floating point in kernel
-	 * space.
+	 * Disable the FPU/Vector to detect illegal usage of floating point
+	 * or vector in kernel space.
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
2.27.0

