Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB68EC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ABD2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XoVHwOun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCXHbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:31:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38922 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgCXHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:31:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so8849952pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eR+uDkZlwayIbsgbPeyhEUp7doO9+jBvD/Fsht7osWo=;
        b=XoVHwOunlnnbXskW9yEXFl7rJ9ssINpRGhRVPBNdeKX2ubyzIqYnH7eOAuSMPP47WM
         vpKFBPcMqG36hjx5V9ijQ5XnCZZkQIWI1tZjd3oRZHyBNBWUi8pl2Gt2hBTYwifQ6ftG
         GYYAaKaGAfU6znHtAwVS6nk59jizZ8IkH8NR3GC2jDw2RAP+PoQIb66l7GXWxPSDOk6X
         t86QXLZ+el4hQ8fIoCNxLsTKPO8lBNpFPmrg8J/tRYBogRjl6D83lkUa6ICTHiT9t0Pp
         Qnpj/UoH5ouKUI08kBZfOPHpXugMxTI5KFE/nG2KOA+7/RRz8rf7p8QYWs/H0b7RkqFM
         J+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eR+uDkZlwayIbsgbPeyhEUp7doO9+jBvD/Fsht7osWo=;
        b=uoFBK+GmTzp2xkgycA/Q4W4bdYtmnmmt9PUDcBrkhghAiW0OFNpioLAvh2bNGPPPnt
         hO7q1aUDYomkRQE6OqGMrT6+WbWOTXAJlgp/W/l+V649ro/YO5sz+/ViHWLrx7dlexQx
         JN5knCdnsggnObxKLHL3VGOjqpSixyIyyoHDgUWjG99THg2fptqweq2IBZiVQd8GFXEN
         vai3RqgxZ5ujZutD0iaB1w0lHwbZdI5nirgtpzVYex2wUG46CKvVIDZKjFODUqz62DJB
         R/iYP33VK1vsKypwwL8G4fANcDzCR4Wj6rRt7ddtqsA8/xkeVoJqfqRpJpr4zxvAYUfX
         u2Bw==
X-Gm-Message-State: ANhLgQ2Gwk0jBderftUNGfyFPChZzaLZ3i+8CizZwVpuyrfGq6kESQBR
        xKLTS1eyJ6Fwtknsq64Eg2rGEA==
X-Google-Smtp-Source: ADFU+vtQyavi3WiglYVqrQnZDp3eiLFu1j+s5c3PNQLghbIos9mzlMX/psPU7J6BV8na+AKAN5ODnQ==
X-Received: by 2002:a63:ff4e:: with SMTP id s14mr26364986pgk.269.1585035069344;
        Tue, 24 Mar 2020 00:31:09 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:31:09 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 7/8] riscv/kaslr: add cmdline support to disable KASLR
Date:   Tue, 24 Mar 2020 15:30:52 +0800
Message-Id: <292e5511fff99d564c947c9ee71be367be947f55.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1584352425.git.zong.li@sifive.com>
References: <cover.1584352425.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a cmdline parameter 'nokaslr' to disable KASLR.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/kaslr.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/riscv/kernel/kaslr.c b/arch/riscv/kernel/kaslr.c
index 0bd30831c455..6920727e4b4a 100644
--- a/arch/riscv/kernel/kaslr.c
+++ b/arch/riscv/kernel/kaslr.c
@@ -156,6 +156,36 @@ static __init u64 kaslr_get_seed(void)
 	return ret;
 }
 
+static __init const u8 *kaslr_get_cmdline(void)
+{
+	static const u8 default_cmdline[] __initconst = CONFIG_CMDLINE;
+
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		int node;
+		const u8 *prop;
+
+		node = fdt_path_offset(dtb_early_va, "/chosen");
+		if (node < 0)
+			goto out;
+
+		prop = fdt_getprop(dtb_early_va, node, "bootargs", NULL);
+		if (!prop)
+			goto out;
+
+		return prop;
+	}
+
+out:
+	return default_cmdline;
+}
+
+static __init bool kaslr_is_disabled(void)
+{
+	const u8 *cmdline = kaslr_get_cmdline();
+
+	return strstr(cmdline, "nokaslr") != NULL;
+}
+
 static __init bool is_overlap(uintptr_t s1, uintptr_t e1, uintptr_t s2,
 			      uintptr_t e2)
 {
@@ -379,6 +409,10 @@ uintptr_t __init kaslr_early_init(void)
 	if (!seed)
 		return 0;
 
+	/* Check whether disable kaslr by cmdline. */
+	if (kaslr_is_disabled())
+		return 0;
+
 	/* Get the random number for kaslr offset. */
 	kaslr_offset = get_random_offset(seed, kernel_size);
 
-- 
2.25.1

