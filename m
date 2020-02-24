Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E4C38BFF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838F320732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgBXXVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:21:35 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44430 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgBXXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:21:33 -0500
Received: by mail-qt1-f196.google.com with SMTP id j23so7786716qtr.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dV6KOm+5xGU5Fmvg1Yr6S6y1zc/vzXFOAFt08+WthgA=;
        b=m0bXc9iU3025kiRW/zZjI4AHtpGqnPDVrvT76l6lBRbXl611pzzso6MtT2rLsBKo3A
         yfMAPOQHSbyjrSnuB5wPnLOrtgxnHj6BmR2cNb2bOcA8jMjhLkrenCizh75wFuQVjjzv
         RxRmFpkXA8iPedJ8Rs1mFLYr5/6uplx4qkfwU/CV4gqooY8vjip0ufMx8ZpWJcYZsguw
         VgFgun9fIko2IvS9gfEBR+0657gCXh73rlFuwdQE6ODg5NuaHaTnvXYXdIVkfJcbNP0u
         20ceS+QFzd3EDy+rW6E3YNZb/xoIWJSWUW5UTrw8YfpY5Y0J8puA/+09CAxAEOUi7PgM
         0zCg==
X-Gm-Message-State: APjAAAWEpI9CNupr53QLV0phrP2uQOxwSEiYEADDLzbMcKKFk6GZS+Dx
        uiy6kZoIbLVLMK30tkZqXFo=
X-Google-Smtp-Source: APXvYqwzjiEdJSCtQN0uWeuS+nLM4wOfpUHiwi8ohS+H86cVpr85z8lnfiQC7w8HvqxzlhbpVk8FgA==
X-Received: by 2002:ac8:2784:: with SMTP id w4mr195974qtw.218.1582586492814;
        Mon, 24 Feb 2020 15:21:32 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 202sm3757849qkg.132.2020.02.24.15.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:21:32 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/2] arch/x86: Drop unneeded linker script discard of .eh_frame
Date:   Mon, 24 Feb 2020 18:21:29 -0500
Message-Id: <20200224232129.597160-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't generate .eh_frame sections for the files in setup.elf
and realmode.elf, the linker scripts don't need the /DISCARD/ any more.

Remove the one in the main kernel linker script as well, since there are
no .eh_frame sections already, and fix up a comment referencing .eh_frame.

Update the comment in asm/dwarf2.h referring to .eh_frame so it continues
to make sense, as well as being more specific.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 5 -----
 arch/x86/boot/setup.ld                 | 1 -
 arch/x86/include/asm/dwarf2.h          | 4 ++--
 arch/x86/kernel/vmlinux.lds.S          | 7 ++-----
 arch/x86/realmode/rm/realmode.lds.S    | 1 -
 5 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 469dcf800a2c..508cfa6828c5 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -73,9 +73,4 @@ SECTIONS
 #endif
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
-
-	/* Discard .eh_frame to save some space */
-	/DISCARD/ : {
-		*(.eh_frame)
-	}
 }
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 3da1c37c6dd5..24c95522f231 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -52,7 +52,6 @@ SECTIONS
 	_end = .;
 
 	/DISCARD/	: {
-		*(.eh_frame)
 		*(.note*)
 	}
 
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index ae391f609840..f71a0cce9373 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -42,8 +42,8 @@
 	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
 	 * The latter we currently just discard since we don't do DWARF
 	 * unwinding at runtime.  So only the offline DWARF information is
-	 * useful to anyone.  Note we should not use this directive if
-	 * vmlinux.lds.S gets changed so it doesn't discard .eh_frame.
+	 * useful to anyone.  Note we should not use this directive if we
+	 * ever decide to enable DWARF unwinding at runtime.
 	 */
 	.cfi_sections .debug_frame
 #else
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e3296aa028fe..5cab3a29adcb 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -313,8 +313,8 @@ SECTIONS
 
 	. = ALIGN(8);
 	/*
-	 * .exit.text is discard at runtime, not link time, to deal with
-	 *  references from .altinstructions and .eh_frame
+	 * .exit.text is discarded at runtime, not link time, to deal with
+	 *  references from .altinstructions
 	 */
 	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
 		EXIT_TEXT
@@ -412,9 +412,6 @@ SECTIONS
 	DWARF_DEBUG
 
 	DISCARDS
-	/DISCARD/ : {
-		*(.eh_frame)
-	}
 }
 
 
diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
index 64d135d1ee63..63aa51875ba0 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -71,7 +71,6 @@ SECTIONS
 	/DISCARD/ : {
 		*(.note*)
 		*(.debug*)
-		*(.eh_frame*)
 	}
 
 #include "pasyms.h"
-- 
2.24.1

