Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C01AC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533272084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="D7E7YCQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDUHaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUHaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:30:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245FDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:30:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so2593989pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4WDP1SMH7S0gCqpLudhaUhXZhK0yEhskeGa9kdwQxh4=;
        b=D7E7YCQkPau74cH6jcUzcy5Yz55VXMbppI8DPPkOwo4imWbzJ01JFL5vyQn3xfm4SG
         SEKdbZBdqa+Qjv4s7fIY9hSNLLfGK97lhTksdkGtOZDfoBnq18rM7U8HD9FPq6GavRxT
         oPQIa6bv2VkOAMLxnWkoS12OHcWmyrC5JI/vom9Ksyj3Oq81VPD0YOILAI4bq+ktQJ/M
         EHiZH8ZxhGeUe0WKAEtIl/Nu81moyISZ6Tb50hF04itJbfncIt5UXOkJCxPU5rZ0gxky
         wNJcnGXKSnplkL4rDvMyCMw6q/jy7N/Ni67Z0ggJEsbcehYGEDze3nSBSKMj5WLiBYIT
         ZhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WDP1SMH7S0gCqpLudhaUhXZhK0yEhskeGa9kdwQxh4=;
        b=TfGFCLhScG92J+lUk2mYl8u2QG/pM11UmN4/OLmiTPTy99sxSXKBP32xBS2w7jyf8X
         at0jeAvnxEG8MwSeEXzKzPAAtMCNMYAvRH9WGb4F/z/EILrVViBmttBKlF/Hk3wOV2cm
         /CpAmRV92wYrD6vgklEId9KZQ0GPzPfTva9lJO3ChnfNy5TkllUNSPd2KNYAmTjBs8AJ
         Az0kVNTwTfOxt4YJEuBCdKtV8axcaPxTicN3dTKmYlM/+HBqEKvCtAXhD7ayhlvqDSj8
         k/XTeTPJlbdFJMx10arSAgR9InU1c4qPxZgVYiM0OMUWdPim5Kyp8m57l2zhVPV16pvC
         T0iA==
X-Gm-Message-State: AGi0PuZ+sAja82DZZARUwFRHRkNx0wRXkE5N6/2pioOH2O0y1P4P2W3J
        IR1qJJEUUWjfmUkuuep0J8srdQ==
X-Google-Smtp-Source: APiQypLh/ynGfDBOcHwhG6BfHszacpO3EvqFZChIUyhgkVVVqIUwEdQMhJVZDDjeY5DtQCaFIjqXQA==
X-Received: by 2002:a63:4d4f:: with SMTP id n15mr19479072pgl.399.1587454211726;
        Tue, 21 Apr 2020 00:30:11 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t7sm1535200pfh.143.2020.04.21.00.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:30:11 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 2/3] riscv: Use NOKPROBE_SYMBOL() instead of __krpobes annotation
Date:   Tue, 21 Apr 2020 15:30:00 +0800
Message-Id: <79fd8bc7c1d80c35124ab542cb3306a7209e08e7.1587453338.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587453338.git.zong.li@sifive.com>
References: <cover.1587453338.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __kprobes annotation is old style, so change it to NOKPROBE_SYMBOL().

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/patch.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index de28f23f65cb..8acb9ae2da08 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -20,7 +20,7 @@ struct patch_insn {
 #ifdef CONFIG_MMU
 static DEFINE_RAW_SPINLOCK(patch_lock);
 
-static void __kprobes *patch_map(void *addr, int fixmap)
+static void *patch_map(void *addr, int fixmap)
 {
 	uintptr_t uintaddr = (uintptr_t) addr;
 	struct page *page;
@@ -37,13 +37,15 @@ static void __kprobes *patch_map(void *addr, int fixmap)
 	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
 					 (uintaddr & ~PAGE_MASK));
 }
+NOKPROBE_SYMBOL(patch_map);
 
-static void __kprobes patch_unmap(int fixmap)
+static void patch_unmap(int fixmap)
 {
 	clear_fixmap(fixmap);
 }
+NOKPROBE_SYMBOL(patch_unmap);
 
-static int __kprobes patch_insn_write(void *addr, const void *insn, size_t len)
+static int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
@@ -68,14 +70,16 @@ static int __kprobes patch_insn_write(void *addr, const void *insn, size_t len)
 
 	return ret;
 }
+NOKPROBE_SYMBOL(patch_insn_write);
 #else
-static int __kprobes patch_insn_write(void *addr, const void *insn, size_t len)
+static int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	return probe_kernel_write(addr, insn, len);
 }
+NOKPROBE_SYMBOL(patch_insn_write);
 #endif /* CONFIG_MMU */
 
-int __kprobes patch_text_nosync(void *addr, const void *insns, size_t len)
+int patch_text_nosync(void *addr, const void *insns, size_t len)
 {
 	u32 *tp = addr;
 	int ret;
@@ -87,8 +91,9 @@ int __kprobes patch_text_nosync(void *addr, const void *insns, size_t len)
 
 	return ret;
 }
+NOKPROBE_SYMBOL(patch_text_nosync);
 
-static int __kprobes patch_text_cb(void *data)
+static int patch_text_cb(void *data)
 {
 	struct patch_insn *patch = data;
 	int ret = 0;
@@ -106,8 +111,9 @@ static int __kprobes patch_text_cb(void *data)
 
 	return ret;
 }
+NOKPROBE_SYMBOL(patch_text_cb);
 
-int __kprobes patch_text(void *addr, u32 insn)
+int patch_text(void *addr, u32 insn)
 {
 	struct patch_insn patch = {
 		.addr = addr,
@@ -118,3 +124,4 @@ int __kprobes patch_text(void *addr, u32 insn)
 	return stop_machine_cpuslocked(patch_text_cb,
 				       &patch, cpu_online_mask);
 }
+NOKPROBE_SYMBOL(patch_text);
-- 
2.26.1

