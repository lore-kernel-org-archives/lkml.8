Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A004C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2684920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JRJeJlPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgDUIRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgDUIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:17:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so1058506pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1q1dIc4oOXMLuGJhmG405YIgkstM/KJ0hlFL0aEcs0=;
        b=JRJeJlPbvECowqMMqAqWbzZ8nqW0b1fVx207l4nQs0G9+u8AyrE8inMOe8Uu+Z6mGj
         oEOZzr8Klh+dWRbsfgOaINRJsKMd/aRX3NBYE5XqzRJkaxfMatym5xIbV3ooZL9jnaaM
         +HNfMZHP/TNdCf+PfqN1VPRK3J4JEGjE/ewraiaQV5Hg6+Ddm8v+G1yXlEhe/L1wUJsC
         baY1iJBav4DXjyhX63v9oHhvFi0vhSpYSODaovIkLUeCbp0OKzfU1xWU0XnbBOC1jzjx
         sc81wyIHXiBh5pXITuvhWZg3AI1x327mOGasYIohrkBPXI/7uBC/YKfXZ3fW0DizX8rC
         IIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1q1dIc4oOXMLuGJhmG405YIgkstM/KJ0hlFL0aEcs0=;
        b=K4MX782zVb52GpJnPylVnBJMXvomCP1DLQ52ppI7ZS51xHH1HD1GBiMMQoo06BCd9H
         GY5a06qPxlMkd3GSzc/T4NmEl+M+dB0UQFItJbkbqTeBY/uEYwlgwyQ6SLZIC1+JXgkw
         ed2RwQ+6dDnXinyPsIOiIRiXIEwxt6pCy2rJDK/ebp3Ey8WyMQHEU8hmDkE9CvMwUuNO
         Vyf5JrqddpMGOh0bFuEcyXD26HZwTx0/YblkdFfZlqKzscVEG7ijDbMtYmiFn3vjFnA4
         WDevGbf3wWoMuBK1olGOXHQ+Av2nnRDJsJxWgxPCZq7WycFOzvofj6bDpyLrjDox7Nmt
         cbeg==
X-Gm-Message-State: AGi0PuYYBinBIhY8234GLtr15NzOKPUKrPTRffjKzXOs4eK52DmN5Jw6
        jtD57yfTKIoWGdscvDTqyYCi3A==
X-Google-Smtp-Source: APiQypJ6TDv1BUeEjsdzkZkCUKbnTrPG7TD+P1kqLfxoAk/M5KRTxIjpkFX2KILsnIQRT2ae8Ou8Jw==
X-Received: by 2002:a17:90a:1da6:: with SMTP id v35mr4465596pjv.44.1587457051158;
        Tue, 21 Apr 2020 01:17:31 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id v9sm1610067pju.3.2020.04.21.01.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:17:30 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/4] riscv: support DEBUG_WX
Date:   Tue, 21 Apr 2020 16:17:13 +0800
Message-Id: <282e266311bced080bc6f7c255b92f87c1eb65d6.1587455584.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587455584.git.zong.li@sifive.com>
References: <cover.1587455584.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support DEBUG_WX to check whether there are mapping with write and
execute permission at the same time.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig              | 1 +
 arch/riscv/include/asm/ptdump.h | 6 ++++++
 arch/riscv/mm/init.c            | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62f7bfeb709e..612bf0a258d0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -68,6 +68,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select ARCH_HAS_DEBUG_WX
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
index e29af7191909..eb2a1cc5f22c 100644
--- a/arch/riscv/include/asm/ptdump.h
+++ b/arch/riscv/include/asm/ptdump.h
@@ -8,4 +8,10 @@
 
 void ptdump_check_wx(void);
 
+#ifdef CONFIG_DEBUG_WX
+#define debug_checkwx() ptdump_check_wx()
+#else
+#define debug_checkwx() do { } while (0)
+#endif
+
 #endif /* _ASM_RISCV_PTDUMP_H */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b55be44ff9bd..86606e4d1860 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -19,6 +19,7 @@
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/ptdump.h>
 
 #include "../kernel/head.h"
 
@@ -529,6 +530,8 @@ void mark_rodata_ro(void)
 	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
 	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
 	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
+
+	debug_checkwx();
 }
 #endif
 
-- 
2.26.1

