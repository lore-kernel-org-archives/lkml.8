Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E893C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC9020732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlhFXt6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBXSSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:18:17 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:32804 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:18:15 -0500
Received: by mail-yb1-f194.google.com with SMTP id w190so5102614ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACi0L9E8gh6Yib24xQrizNHwo9NMM5aW1BdPE5fFDt4=;
        b=KlhFXt6eLVbpn+FErpii8x78m31Z3Cb4EbsJnS/SNH1EU/KKrcT5Wfukkl71pQokIp
         /LtNWk0cuOxPMxUnusnJAneovgOTppyRuLCVkPwfrC4sTby+dIthQNrPmYqQYwkwVOP8
         cJpCraFKejP7rwym5OiVL5Y6axyedk0wZ+668kTQmHoMw2FR2rX0nuQAcNz8zp8U/j56
         luWcqkFpXDyIwWIdexkzKe9zK86/LERmYIIWyRe6nF5guuvd5lNU0lf2TclnVrUshGxy
         WQY2yLdtfPc6hMsYr/57PvQlOhCtYUiMSoMdLFZ/dbEN/1r0cSMouVgd8DogXvcKZuKb
         BPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACi0L9E8gh6Yib24xQrizNHwo9NMM5aW1BdPE5fFDt4=;
        b=dwHKYMuXskUiyuf/ozahW71wIKIs0fjrl+HBMju0kKpsWfFZSLxU8jz3S2Jq34aPKz
         ezqKY+taEivUo6W8JFqszVyWVd6eZpjle7soTYn2kNIRxRbPmRPFHjX31EPQr5+vri37
         ihqZFAD3f2Hj79oq3KsjeGayYI2IyMF88SByS7XUz4HKrC/hnXV4sMZ0fTlKKvKkV0wF
         IujwVrD2EZaJEqkA0jAiwa3cTGhjtEuddYeuzptRH3hqyACyeLcCbfDjvxe9Jj1iCw89
         cKMUU3Gc92upUsWzpKIifxvU0XLl6Vre12lFmrbZeoLR4f8PrGyezDemnH9l/dJtDDX3
         5E7Q==
X-Gm-Message-State: APjAAAXI2SyOtSIiPc+7YBIU1gK88u0M1qRLNLrzp6MhaOXXnesCPzG6
        gXe2JtVEso9/MVTEcu/xUa/5xzM=
X-Google-Smtp-Source: APXvYqzGAtxOLMmPu31hjYLzZ9L4NKIKDySFdiwYbQXxdmcwVPrMVmBW1zHHWomeAMOFTg6Jh0gj0w==
X-Received: by 2002:a25:fc27:: with SMTP id v39mr22017840ybd.473.1582568294370;
        Mon, 24 Feb 2020 10:18:14 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i66sm5632383ywa.74.2020.02.24.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:18:14 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 1/8] x86, syscalls: Refactor SYSCALL_DEFINEx macros
Date:   Mon, 24 Feb 2020 13:17:50 -0500
Message-Id: <20200224181757.724961-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224181757.724961-1-brgerst@gmail.com>
References: <20200224181757.724961-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull the common code out from the SYSCALL_DEFINEx macros into a new
__SYS_STUBx macro.  Also conditionalize the X64 version in preparation for
enabling syscall wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 86 ++++++++++++++------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e2389ce9bf58..44ed358a2e3c 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -21,6 +21,22 @@ struct pt_regs;
 	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
 	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
 
+#define __SYS_STUBx(abi, name, ...)					\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+	{								\
+		return __se_##name(__VA_ARGS__);			\
+	}
+
+#ifdef CONFIG_X86_64
+#define __X64_SYS_STUBx(x, sys_name, ...)				\
+	__SYS_STUBx(x64, sys_name,					\
+		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+#else /* CONFIG_X86_64 */
+#define __X64_SYS_STUBx(x, sys_name, ...)
+#endif /* CONFIG_X86_64 */
+
 #ifdef CONFIG_IA32_EMULATION
 /*
  * For IA32 emulation, we need to handle "compat" syscalls *and* create
@@ -38,21 +54,13 @@ struct pt_regs;
 		return __se_compat_sys_##name();			\
 	}
 
-#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
-	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
-	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+#define __IA32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)		\
+	__SYS_STUBx(ia32, compat_sys_name,				\
+		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
-#define __IA32_SYS_STUBx(x, name, ...)					\
-	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
-	ALLOW_ERROR_INJECTION(__ia32_sys##name, ERRNO);			\
-	asmlinkage long __ia32_sys##name(const struct pt_regs *regs)	\
-	{								\
-		return __se_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+#define __IA32_SYS_STUBx(x, sys_name, ...)				\
+	__SYS_STUBx(ia32, sys_name,					\
+		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
 /*
  * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
@@ -81,8 +89,8 @@ struct pt_regs;
 	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
-#define __IA32_COMPAT_SYS_STUBx(x, name, ...)
-#define __IA32_SYS_STUBx(x, fullname, name, ...)
+#define __IA32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)
+#define __IA32_SYS_STUBx(x, sys_name, ...)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -100,17 +108,13 @@ struct pt_regs;
 		return __se_compat_sys_##name();\
 	}
 
-#define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
-	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
-	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+#define __X32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)			\
+	__SYS_STUBx(x32, compat_sys_name,				\
+		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(x, name)
-#define __X32_COMPAT_SYS_STUBx(x, name, ...)
+#define __X32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -131,16 +135,21 @@ struct pt_regs;
 	}								\
 	static inline long __do_compat_sys_##name(void)
 
-#define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
-	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
-	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
-	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
-	{									\
-		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
-	}									\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
+	static long							\
+	__se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__));	\
+	static inline long						\
+	__do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__));	\
+	__IA32_COMPAT_SYS_STUBx(x, compat_sys##name, __VA_ARGS__)	\
+	__X32_COMPAT_SYS_STUBx(x, compat_sys##name, __VA_ARGS__)	\
+	static long							\
+	__se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__))		\
+	{								\
+		return __do_compat_sys##name(				\
+			__MAP(x, __SC_DELOUSE, __VA_ARGS__));		\
+	}								\
+	static inline long						\
+	__do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
@@ -192,15 +201,10 @@ struct pt_regs;
  * to the i386 calling convention (bx, cx, dx, si, di, bp).
  */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
-	asmlinkage long __x64_sys##name(const struct pt_regs *regs);	\
-	ALLOW_ERROR_INJECTION(__x64_sys##name, ERRNO);			\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	asmlinkage long __x64_sys##name(const struct pt_regs *regs)	\
-	{								\
-		return __se_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
-	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
+	__X64_SYS_STUBx(x, sys##name, __VA_ARGS__)			\
+	__IA32_SYS_STUBx(x, sys##name, __VA_ARGS__)			\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{								\
 		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
-- 
2.24.1

