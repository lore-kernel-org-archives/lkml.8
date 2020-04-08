Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B954C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B3720747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="M8FsO9ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgDHH5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40358 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgDHH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so2231500plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qkEQ73ghM61/BXRvlDJEs7SEg6hkPYIpkfLFdxJqkM=;
        b=M8FsO9urOLYfx+qNB72XqLl5IeK3k1rkWGB2QMaKDxaZ3GMZ9TkmwxK2X106mzWTZc
         h6SfGPemIf+TGa9RC0VllenRql97VDhVTSgiLjT7uRcU/sIo1L09xxkH4TJZbbTOdany
         KvIdpvhuZ7aZu4Hew/CRlD3Nu11OQ1e8+YCp1KVzmmD0In0eppM5yJwdWx6d1xyfhEF5
         F7/KOZyVklGrHaTKN3apLnV+MT57NiaA9GWFMExs7czk8HzYqQxKqRwOpymkHHiB4R0b
         e94SlP/mbS0WGfoYQTh6cOJPSe609uoPJPYWGWI5B03/10hz2Cwb363yMLe7BTSN9DRM
         yFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qkEQ73ghM61/BXRvlDJEs7SEg6hkPYIpkfLFdxJqkM=;
        b=l9toXUVKUwkArgkem4ZgEbEeAh3bY6eoe3KnxRbBD/a2xSQMuiqT3bq2IgS6Cj0byh
         t9T1wd9FQq7nQDZs9c+sn6XbPgrDPCMutVxoT3ECEg9DI/EpvKqem5VceF7P+QUFfnw1
         VISKNyZS3EmnOQ5C1FnE02TTq9s5CCumOGmKDCVEVciYL7KsXB+0SMxFUhpcGJ60+G67
         h542Y0euQ+OZYcT6ztFpBOVoE5HoYbAc9fME+7bk7Zq0xQu9Cnc6ElH2Yn6K4Xm+tezi
         RREKl8pjoIX3U4hQnPwHfxIaC1BBhGGChpa36/3AQ4QTHC/KBXNUi8Xpb1cVmGPuh64z
         HMgQ==
X-Gm-Message-State: AGi0PuaR+vCQd8x0usTyHazc5hFmMy9IHtW1vNqZVfP19gNNCi8yQx1V
        edfEfgpHWvaTEnECF+pgjc8PHA==
X-Google-Smtp-Source: APiQypIIXeNxjIMGSbVinBL4trNwBKG9qqUy1Cb/noizBIcTE9mvQcsmUXs8oVjWTimn72tJBLN8Cw==
X-Received: by 2002:a17:90a:33d1:: with SMTP id n75mr3776658pjb.167.1586332638821;
        Wed, 08 Apr 2020 00:57:18 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:18 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v5 5/9] riscv: add ARCH_HAS_SET_DIRECT_MAP support
Date:   Wed,  8 Apr 2020 15:57:00 +0800
Message-Id: <357ebe77f7f676dcc7e828436275ec096fd61a96.1586332296.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
References: <cover.1586332296.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add set_direct_map_*() functions for setting the direct map alias for
the page to its default permissions and to an invalid state that cannot
be cached in a TLB. (See d253ca0c ("x86/mm/cpa: Add set_direct_map_*()
functions")) Add a similar implementation for RISC-V.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/include/asm/set_memory.h |  3 +++
 arch/riscv/mm/pageattr.c            | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9044e0dd95ea..a94d0f064d9c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -59,6 +59,7 @@ config RISCV
 	select HAVE_EBPF_JIT if 64BIT
 	select EDAC_SUPPORT
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select SPARSEMEM_STATIC if 32BIT
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 79a810f0f38b..620d81c372d9 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -21,4 +21,7 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+int set_direct_map_invalid_noflush(struct page *page);
+int set_direct_map_default_noflush(struct page *page);
+
 #endif /* _ASM_RISCV_SET_MEMORY_H */
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index fcd59ef2835b..7be6cd67e2ef 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -148,3 +148,27 @@ int set_memory_nx(unsigned long addr, int numpages)
 {
 	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
 }
+
+int set_direct_map_invalid_noflush(struct page *page)
+{
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long end = start + PAGE_SIZE;
+	struct pageattr_masks masks = {
+		.set_mask = __pgprot(0),
+		.clear_mask = __pgprot(_PAGE_PRESENT)
+	};
+
+	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+}
+
+int set_direct_map_default_noflush(struct page *page)
+{
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long end = start + PAGE_SIZE;
+	struct pageattr_masks masks = {
+		.set_mask = PAGE_KERNEL,
+		.clear_mask = __pgprot(0)
+	};
+
+	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+}
-- 
2.26.0

