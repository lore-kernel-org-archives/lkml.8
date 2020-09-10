Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3404A2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q2cGez+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIJISM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgIJIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCFFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so4165537pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ommHQQSpigOoxveeOFgXjiVdJvwUb8j2DzRPHrvB8ew=;
        b=Q2cGez+F8URgAoZvPAYByAl6wQOxX86fqXQguCLGEvBvEVALos9gy+uGgwCfIaqzx4
         tQAN+B8kOPNupoqb1AZETPXjyLVaqWO0hRhl3MbUE2G4YQstbdgBJvkVE3jMsPzY9JGq
         duU4NTbnVx7Bp3jjv+xrBpjQXRX7KXD7xZlO1c9y5iLb/siA0xBPxtbN8vIvYBmqI0bW
         47Swj8CvaqU/+YSM++ibx1DXz4ja3Gotg2Q7Gdcq1b+giT78Y60o6Ca8ZWg6RCUS4VX9
         IyUfwSLcj0qa1AAxEK7saXRh6+Yw+v5qLo/zkdyEOxLScRUgFTr+PwnfhaBRt/Z3hasj
         Y9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ommHQQSpigOoxveeOFgXjiVdJvwUb8j2DzRPHrvB8ew=;
        b=Wehm6x0wTyIQ6U+iSYDz7WyA/0A7A871dtMRUZ6ueD+2oRWVcV3PuBOxTQZ387yK9c
         SjL4D6BzYWGSUyedFdMy2L4ewRXRA6EiDYnSuK8HW/f/nksLFGzIODfEbA7hzf6U62yz
         uITKsUFOEYL+VE59DyPK0IFipPlN+M4Ztt2fKpqxKvRCsLdXoCxTxQooi3PsWpF2HWS8
         Et71+YQ31P7NPEgYZBy11HfkN+kbQI92RPowXn6SWLsHp4rBuv33Lqrn2IaNlXc/ljG2
         IxemeevjQ2Qo8OCsKE9uSkb7xmrXZ5maFhL7S3WpcDyLtE+GZJFmZ2OYnmpi9IgkzrCs
         5jwg==
X-Gm-Message-State: AOAM533ak0R/YFId2ag0U0dmN4yhNTjBW2yUgd0ZOx9b+Ysk6PxSIubg
        H3hgzOpYjzh2/K9Wh9tZRtjRBA==
X-Google-Smtp-Source: ABdhPJw4mbqJR11v7mgubz1trEb59ezNxgb6EoFi6G+IlzBsjor6vQFM5ZmYEz/7BxSXw5fxGISSFw==
X-Received: by 2002:a63:fd51:: with SMTP id m17mr3785010pgj.210.1599725571382;
        Thu, 10 Sep 2020 01:12:51 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:50 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v7 07/21] riscv: Reset vector register
Date:   Thu, 10 Sep 2020 16:12:02 +0800
Message-Id: <9ea7cdc5f290d33f52643ec00830362723b71ec4.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
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
index 524d918f3601..c905efb6c998 100644
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
index 0a4e81b8dc79..e97c7915ae27 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -204,10 +204,10 @@ pmp_done:
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
@@ -365,6 +365,51 @@ ENTRY(reset_regs)
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
2.28.0

