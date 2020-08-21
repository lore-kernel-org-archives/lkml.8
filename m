Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDBBC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1B520791
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NyTgbCze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHUTpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHUTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:44:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F95C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so1329383plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNMQ3F5q4g/Uk/+s5Q6WGurCwVwunmhXKYzGhkTYsIo=;
        b=NyTgbCzeEp1ym59DR/QNoKj0uG9hbvo/o+utcH9r4Kqq9qDleAjXl0OOU+wa72oid0
         FrDeaXspf6qhKYOuNZye4L/12pgzRr6iZoEOwV7U/CjWa9fCFKPcsbBgybjxujpqjzK7
         J1y+nrPz7erQ0BcWjuHUvdi/5/c1Bpagd89nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNMQ3F5q4g/Uk/+s5Q6WGurCwVwunmhXKYzGhkTYsIo=;
        b=rgn7rIPzV/4tvt2WTJBq4E2rAdddJGWgR4k9kY671r1MI9DmQhhOioTo/yBtfr6VF1
         +uGUc+F2ByK2cpsRHrZ05yTc/sMpnlYnShAAlr4yP2peFgyLiysC4P7j0MrbFmEAbMl0
         APxEUj78z8/s2JjO0MKCg180SVYrErI4iF4OsNop+tZuzcPDl5EdNkyqyA47+kNRr7xf
         bfjewq6Rqx1qnj22TWPalS1fokd8QL2npEJiXlwC8ol2dgdIknV44McJGQukC8n8GyXB
         j3Qm5h0uItDKzhfPbScEDh2ECTF5Tr1jlUbs+8yGFTAX7JU9SzWvKw4F8XNoMpAk0HV+
         9zSg==
X-Gm-Message-State: AOAM5315KbCuEcq2MQdy1JL44NyDFDl0ajMm334E3VjwvwB7x2R5HKVf
        XMsX4Wp9AnxyWed9aiJqyVb5QA==
X-Google-Smtp-Source: ABdhPJwx2k11/u4a4HxHG8VAxnrqER3e8md8d+tJb6KWY7SBST29tpxto+MAjoOMhPh2+M9prsPHmg==
X-Received: by 2002:a17:902:c181:: with SMTP id d1mr3416243pld.296.1598039070655;
        Fri, 21 Aug 2020 12:44:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u5sm3268710pfm.149.2020.08.21.12.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 15/29] arm/build: Refactor linker script headers
Date:   Fri, 21 Aug 2020 12:42:56 -0700
Message-Id: <20200821194310.3089815-16-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding --orphan-handling=warn, refactor the linker
script header includes, and extract common macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/{kernel => include/asm}/vmlinux.lds.h | 13 ++++++++-----
 arch/arm/kernel/vmlinux-xip.lds.S              |  4 +---
 arch/arm/kernel/vmlinux.lds.S                  |  4 +---
 3 files changed, 10 insertions(+), 11 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (96%)

diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
similarity index 96%
rename from arch/arm/kernel/vmlinux.lds.h
rename to arch/arm/include/asm/vmlinux.lds.h
index 381a8e105fa5..a08f4301b718 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
@@ -49,8 +50,12 @@
 		EXIT_CALL						\
 		ARM_MMU_DISCARD(*(.text.fixup))				\
 		ARM_MMU_DISCARD(*(__ex_table))				\
-		*(.discard)						\
-		*(.discard.*)
+		COMMON_DISCARDS
+
+#define ARM_STUBS_TEXT							\
+		*(.gnu.warning)						\
+		*(.glue_7)						\
+		*(.glue_7t)
 
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
@@ -64,9 +69,7 @@
 		CPUIDLE_TEXT						\
 		LOCK_TEXT						\
 		KPROBES_TEXT						\
-		*(.gnu.warning)						\
-		*(.glue_7)						\
-		*(.glue_7t)						\
+		ARM_STUBS_TEXT						\
 		. = ALIGN(4);						\
 		*(.got)			/* Global offset table */	\
 		ARM_CPU_KEEP(PROC_INFO)
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 3d4e88f08196..904c31fa20ed 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -9,15 +9,13 @@
 
 #include <linux/sizes.h>
 
-#include <asm-generic/vmlinux.lds.h>
+#include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/mpu.h>
 #include <asm/page.h>
 
-#include "vmlinux.lds.h"
-
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 5592f14b7e35..bb950c896a67 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -9,15 +9,13 @@
 #else
 
 #include <linux/pgtable.h>
-#include <asm-generic/vmlinux.lds.h>
+#include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/mpu.h>
 #include <asm/page.h>
 
-#include "vmlinux.lds.h"
-
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
-- 
2.25.1

