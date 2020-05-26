Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D95CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6314A2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nVQ1QJpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgEZHDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbgEZHDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:03:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC662C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so807636pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fZ7IHiP/Z+5wqk/IVpAWK8RobZ149sWEYypNjSaWVHM=;
        b=nVQ1QJpS/aGTk0VchSb7wE/ai2hrbk48juRmxjQ984NV+mQnS3sJ6llsgYFEqa2Zad
         0RxjxfPXH9Oj4hW3khHPJYqo6utNQt8pj/DjTdFrezbdD5GR7S8ubJaCsGEr0AOa2TRH
         VGsNI1fFvfCnJMMpWTHIfKuGfl8NkV/FmjN8QZyEDCK6EUV3UwO13TAYTzKunoaNVsGh
         sHK3tnmrRHZytqL3oTtLK+cUCPEkEIfWZE+hDwZhZHCx0825xwNdGfm244W9vhoQG5Yt
         d9CNwEP8AmCnv93LtQUd6MmZU4PDvwcGlr+sYn9qmzCf5z6SEcnGT321cOB5OM4SfG1O
         4/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZ7IHiP/Z+5wqk/IVpAWK8RobZ149sWEYypNjSaWVHM=;
        b=f+6DUpZ2qWS9d/f6+MEcTs2kek7+vUF7U1O8c8gOsItymnP6x2Zfu+xxPu+NEQ5PKV
         OdFZA7vTVhFCCGRL4IMLN1JUHqBWd8Z58COBVsdEy9+7vaPCB9QdpvD5q8Em1RblYsVp
         Xp9W2gBFFhAzl5csT7G4evHndQHeM7VzE9Vbke9Nw5B3z35Q8qSKydX7TBp7JopYBkUt
         xMSktcdTryH/e8UYZ/JQN8V7qqouQmLOgTZfIiYONXmnUU78KoidLBr311PRH9CYU8rP
         Lx312TZjGGtasx/nCQEIV8R0yZv/agV6d7nvylQ+8ci8xRiZ7DIrCpATJ/8jwKLhxEx3
         io+Q==
X-Gm-Message-State: AOAM533IXs8Pcp5d92X9LMGjrJyay/aR08+XBcT4QJsRSMxGjoBe7szs
        9izh786gotr8tymFN7THTHJlSA==
X-Google-Smtp-Source: ABdhPJzMBT/HJSEdmH9HxTb2icg7SFzSF8ztRp2aI8PhCuNhNPDKgK1RJhnCJnQyUZXCBRvFyJOG8g==
X-Received: by 2002:a17:90b:4390:: with SMTP id in16mr25078324pjb.78.1590476586393;
        Tue, 26 May 2020 00:03:06 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:03:05 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 08/13] riscv: Reset vector register
Date:   Tue, 26 May 2020 15:02:37 +0800
Message-Id: <2424daf7c5b704b5c4ea2c317304d7fd0cf7ef2a.1590474856.git.greentime.hu@sifive.com>
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

