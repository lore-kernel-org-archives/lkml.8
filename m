Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D56C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3A6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuks+c+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCMTxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:53:21 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43872 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:11 -0400
Received: by mail-qv1-f68.google.com with SMTP id c28so5274913qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G29QVsSkkUqrG7r9BJsozRWYfilk+qJH9OFfvcUGx+c=;
        b=uuks+c+iko6sK8gAZ8x2eh2lvkTkLwTmS9U3SJvMU6EAK1/al8QkfMh5M6EZY/7IOg
         32r+IVU18h2vtfcYUrccGZXE89MYw7xaKPvkeY/91K1hALW5NCQFsREAhXfAdo4jPubo
         aM9TPm1SRF4Qv0ropbwj5wZQg3sxtVYqxj8NX0HHxdD5V/SRD/gyF4HPA8OGYTfD7eWo
         K71/aq5FwQxXme3d9n3Ql0EdYetIGPdAztXuouU+YOKAaUE9ORDALGJ5wuFCw5dtdNnQ
         kLB67HRgj2bRpKNW8iq96W35UGZU0tdBEB0v+vWu5y5LuYPZ2q6fhhfwvSZfs3yKWDAN
         rDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G29QVsSkkUqrG7r9BJsozRWYfilk+qJH9OFfvcUGx+c=;
        b=dIldqxqhrbkP7S/83p6nIXmwgg/abnXjcSEyHhFHCYU9Xg8FOA5QxDlyMjY92AJn+0
         gwKDjVRl8JijoKl2bDJZDGdcO6yc7BnmCd1Bkn0Xg1uV/CwdTjZujsoYH6MBro5MG8av
         F4buXNf1yHRpgd+f6r7Zcb9GQjXApwuCKOhdf3b7mkn8Mwlmi2qU3M6YxCl+sd1OdXjD
         y7lr9JECqcFLZ6sggneyKBPi8wLsh5Gofx7rjqtp1oOBMY2KzfgFoG6/RR43n7jWTMQ/
         xH6ZL7JtyILTJEvhM/Rk8gyN6/0mMo44Jb9J7ZI3dz0R26gDVc+qTOnwzd5wUN96is/2
         eSzA==
X-Gm-Message-State: ANhLgQ031UpjnnFwrQvzwtZOTjMvUrHqxs2p3CnIFx/bmhByzVRNjRGV
        8wj2ktO/70Gfbzd4ymeNitJa6KY=
X-Google-Smtp-Source: ADFU+vutB/qVW46p09l9In1lmXWrLGMlHhmPnpUlZm4qltUKIcDb0z77ElLGOIKW/nqsOnQJKieRNQ==
X-Received: by 2002:a05:6214:10c1:: with SMTP id r1mr14164281qvs.70.1584129130249;
        Fri, 13 Mar 2020 12:52:10 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:09 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 01/18] x86, syscalls: Refactor SYSCALL_DEFINEx macros
Date:   Fri, 13 Mar 2020 15:51:27 -0400
Message-Id: <20200313195144.164260-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
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
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/syscall_wrapper.h | 49 +++++++++++++-------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e2389ce9bf58..a1c090bde063 100644
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
+#define __X64_SYS_STUBx(x, name, ...)					\
+	__SYS_STUBx(x64, sys##name,					\
+		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+#else /* CONFIG_X86_64 */
+#define __X64_SYS_STUBx(x, name, ...)
+#endif /* CONFIG_X86_64 */
+
 #ifdef CONFIG_IA32_EMULATION
 /*
  * For IA32 emulation, we need to handle "compat" syscalls *and* create
@@ -39,20 +55,12 @@ struct pt_regs;
 	}
 
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
-	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
-	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+	__SYS_STUBx(ia32, compat_sys##name,				\
+		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #define __IA32_SYS_STUBx(x, name, ...)					\
-	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
-	ALLOW_ERROR_INJECTION(__ia32_sys##name, ERRNO);			\
-	asmlinkage long __ia32_sys##name(const struct pt_regs *regs)	\
-	{								\
-		return __se_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+	__SYS_STUBx(ia32, sys##name,					\
+		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
 /*
  * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
@@ -82,7 +90,7 @@ struct pt_regs;
 
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
-#define __IA32_SYS_STUBx(x, fullname, name, ...)
+#define __IA32_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -101,12 +109,8 @@ struct pt_regs;
 	}
 
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
-	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
-	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+	__SYS_STUBx(x32, compat_sys##name,				\
+		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(x, name)
@@ -192,14 +196,9 @@ struct pt_regs;
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
+	__X64_SYS_STUBx(x, name, __VA_ARGS__)				\
 	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{								\
-- 
2.24.1

