Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD73C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4776F207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eoNyYh4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgFPHp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:45:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36074C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:45:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so7999724pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+8GEwk8kcW25CIKv1LY5L5ZUakB4ZBGl9U9kcTV39M=;
        b=eoNyYh4J7k/8SYK2zXhF1YEKj9N0Afv3XXSYDDPaB9i+MQRoCZ9r3oIYXG/LPtrZj3
         wMZJUS90yAWZfZpwTvdnwjDV/e4fjPiX1UivN2O228mBCMQwJKA2PUaP650QN3WRY2rv
         mGKjNYRD+/+igGx0CeD1OcrdTxiTVHmK6lfKErkaQDGKEvqtH20AoVMmaGDk/xGsyTjs
         t6wuESKCPU8qJ6u90MJuTVgmQCU6TbGIBERMHPesvMdSti+XHf0YGd5QWqSgoHVUfpmt
         9N/jGpVSKM+DVSETlE5HT+BZeu1tOI9IPUB7P0lHj76oJJeeUrnxyRwKoVB4DojpK8k0
         TzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+8GEwk8kcW25CIKv1LY5L5ZUakB4ZBGl9U9kcTV39M=;
        b=DAr4cvDmNXE3HFaCwXViS0aSa3higrgrC9TjxmLCjdw/KBgrl4ArRETidThrBa33OY
         Hk3bKuHwCbH2i9qidBYTNGaWRRSUCWgNHtljrshTLwIOCMKYQ5+IVtfqG653YlShAlVS
         lew6ql81RDW88nXNcG4uFkEejJrFb3w/Z182mcKngipO5Qh6yc/jMxQQi3z3dw/Q/lg5
         zB9Db2SW5o2LM4G+w9YYKATjo9aXFOwA/9EO2sUO5QnVPeXd8UBB1ssPcNr1icbCsQMQ
         QAXWcj+C9/tg835+Tyx2VGnO1c6ON69MFINCzKg7KDob9/+rTJjSEDD1ieWR1Cm2eXT4
         uN6g==
X-Gm-Message-State: AOAM530vFZqFYi3CAxFwHWPd/5hXXXS+sqDJAJTUMRdzC34xtR4v3XQN
        /uoZ0Z5+LPw+6oAr0PGQ1mjH1w==
X-Google-Smtp-Source: ABdhPJxI/1algBV7u/BWaXijmfBCSe+WdnszWPet5V5GZKfuhZoCnZ1aSKcnGn0vS6U6eKautx/k0g==
X-Received: by 2002:a17:90a:fb94:: with SMTP id cp20mr1831844pjb.142.1592293553758;
        Tue, 16 Jun 2020 00:45:53 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id i22sm15948250pfo.92.2020.06.16.00.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:45:53 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/2] riscv: Register System RAM as iomem resources
Date:   Tue, 16 Jun 2020 15:45:46 +0800
Message-Id: <063fab26f4c15bf5b833b57fa818749afa7811d4.1592292685.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592292685.git.zong.li@sifive.com>
References: <cover.1592292685.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add System RAM to /proc/iomem, various tools expect it such as kdump.
It is also needed for page_is_ram API which checks the specified address
whether registered as System RAM in iomem_resource list.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/init.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f4adb3684f3d..bbe816e03b2f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -517,6 +517,27 @@ void mark_rodata_ro(void)
 }
 #endif
 
+void __init resource_init(void)
+{
+	struct memblock_region *region;
+
+	for_each_memblock(memory, region) {
+		struct resource *res;
+
+		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
+		if (!res)
+			panic("%s: Failed to allocate %zu bytes\n", __func__,
+			      sizeof(struct resource));
+
+		res->name = "System RAM";
+		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
+		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
+		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+		request_resource(&iomem_resource, res);
+	}
+}
+
 void __init paging_init(void)
 {
 	setup_vm_final();
@@ -524,6 +545,7 @@ void __init paging_init(void)
 	sparse_init();
 	setup_zero_page();
 	zone_sizes_init();
+	resource_init();
 }
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-- 
2.27.0

