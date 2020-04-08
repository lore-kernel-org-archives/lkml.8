Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FBBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FE620769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U7G20s6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgDHH5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:23 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34241 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgDHH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:22 -0400
Received: by mail-pj1-f68.google.com with SMTP id q16so1953379pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9zl9wdVM8GEYtYil3Mhwjs87sA3d02fBbOSD/V/2Io=;
        b=U7G20s6LmTf2LuYfnrXDNYEjXHb9WEsy956inSxRQMo/VA6l9qWdgAo0dEbehYjLYD
         f5E2WmGKWxTZ/YFKy5cJ2nJCMcOHestOXgrl8JHnYc6uOLdJMD66pzAkhMoz0lXMJa1a
         q6Sd93eJ5SmSFiJQR2GnbVljhf0cUURmRBg2OIVfpRGKqhHY6oA0yOci57cIypYhU94D
         KQViqVTTVemVaSYG2zoGoljdEnt4pnHr8w+Avu8mP8JIeNAYm12aAVJ+P5t/mLZGbxTk
         ky/UBHaVirsmaCNTa+FVw3OV3jfW5Xa2HRerKbZmZibpXXzOtY/bXT0OyuTQyV6liYO2
         rGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9zl9wdVM8GEYtYil3Mhwjs87sA3d02fBbOSD/V/2Io=;
        b=pGqDQnhxiJIG5j/+SUxfhpKLMU2RB30W8aMRITBFbC1HKHLM6pDAjPC/KJcb+ry/0B
         2JlIvN8SUoNBQ7nkSSEfLTCS42pvThDQLmcKHwEXQciZsUxX3Spaig01frbs1Q2gn/lh
         XrrcPpy28YqQJAruqyuVEpv+bx8brUL51rTpSXvOyNwVPLr3d5jkGwEeiSjQZH4iwtNR
         m8hjtr2aoqmIWSasK3dSsU7IVv3xy/x09qZ+rFwusZhfUmzPcVnE9nXLVnkJcRbbKnMe
         ih3XpJXf7fFFWuv5MPih2a+kAeLi0Zc9EDhbcxYdBna8mBdR/pFk772CZDa7PBKxlGMC
         aAkA==
X-Gm-Message-State: AGi0Pub9V1EsI7Bht+VwlW/LFCPNlZVrtAHB6vXO7k/pHH7GeZBEOXlH
        MaDeglFlR47JLMC527Rm/a2+XA==
X-Google-Smtp-Source: APiQypLxV8BTgShiG5s/VFnuxWwrOSXsD17o88Vs6ZV9ud2Hzidb8dVTOvmyVJfp26rP9LzGVWdm7w==
X-Received: by 2002:a17:90a:db54:: with SMTP id u20mr3902925pjx.140.1586332640815;
        Wed, 08 Apr 2020 00:57:20 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:20 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v5 6/9] riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
Date:   Wed,  8 Apr 2020 15:57:01 +0800
Message-Id: <15fce3374de4978c4541beaab8216bf0f84ca72d.1586332296.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
References: <cover.1586332296.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
pages for debugging purposes. Implement the __kernel_map_pages
functions to fill the poison pattern.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig       |  3 +++
 arch/riscv/mm/pageattr.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a94d0f064d9c..1e1efc998baf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -132,6 +132,9 @@ config ARCH_SELECT_MEMORY_MODEL
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
+config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	def_bool y
+
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y
 
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 7be6cd67e2ef..728759eb530a 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -172,3 +172,16 @@ int set_direct_map_default_noflush(struct page *page)
 
 	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
 }
+
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	if (!debug_pagealloc_enabled())
+		return;
+
+	if (enable)
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(_PAGE_PRESENT), __pgprot(0));
+	else
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(0), __pgprot(_PAGE_PRESENT));
+}
-- 
2.26.0

