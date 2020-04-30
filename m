Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBCAC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BDF20873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G97l20gH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgD3XDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 19:03:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727074AbgD3XDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 19:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588287781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KNGqGSLo9W3HxJTip6pskQH3gV/RNz99fZv+UYVpfmI=;
        b=G97l20gHIUSnXodpuakfA9hwNHSq7/CMAzobdQkiutc86s1k2QfMtGbSv2apyAk8ZkiiPA
        0UsOk5kWr4WEJGUkQx17nOz0ylGOdgCF+5IXrNQyzXYnepXfJipJJ0zxBjFyvExYBDl5CE
        b1ZVijMs1VunCKOrzFFvDtmYel/F9WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-GpjACr3wN6ewcLHUzq41Sw-1; Thu, 30 Apr 2020 19:02:57 -0400
X-MC-Unique: GpjACr3wN6ewcLHUzq41Sw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49E6C800D24;
        Thu, 30 Apr 2020 23:02:56 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12CF339E;
        Thu, 30 Apr 2020 23:02:54 +0000 (UTC)
Date:   Thu, 30 Apr 2020 18:02:52 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200430230252.2wlfroq74syupkkd@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
 <20200429231115.z2mo5bsmrmj4oark@treble>
 <20200429232835.yw6ajtjyleob3lmz@treble>
 <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
 <20200430143350.qezebqmx2xwdxqxq@treble>
 <20200430194630.jkwysx6eftkaf6bu@treble>
 <20200430210805.67h5la6m7rtygeq5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430210805.67h5la6m7rtygeq5@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:08:05PM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 30, 2020 at 02:46:30PM -0500, Josh Poimboeuf wrote:
> > > Yup, makes sense.  I think I've been getting confused by the syscall
> > > wrappers.
> > > 
> > > > How hard would it be to change objtool instead of changing the sources?
> 
> So I just realized this is an objtool bug after all.  Or at least a new
> GCC quirk.  The quick fix is:
> 
>   sed -si 's/cold./cold/' tools/objtool/check.c
> 
> However... after studying how all this works, I'm actually thinking that
> it makes sense to move the SYS_NI usage into kernel/sys_ni.c, like you
> originally suggested.  That seems cleaner to me: all the syscall
> aliasing code together in one file.  SYS_NI is similar to COND_SYSCALL,
> except it has a custom ENOSYS handler.  Having "NI" in the name is
> another clue it belongs in sys_ni.c.
> 
> Alternatively, I could do the x86-specific SYSCALL_ALIAS, which is easy
> enough, but I really prefer the sys_ni.c approach.
> 
> Either of those would allow the removal of some hacky objtool code,
> which only ever existed in the first place because of posix-stubs.c and
> that inline asm SYSCALL_ALIAS macro.
> 
> One of objtool's goals is to standardize ELF data, and it seems
> reasonable to require the use of C-based aliases.  And I think it would
> be a nice cleanup anyway.

It's a really nice diffstat.  The only "downside" I can tell is that now
there's no printk when calling one of the undefined timer syscalls with
CONFIG_POSIX_TIMERS=n.

Thoughts?

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 94e4cde8071a..a28ed880790e 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1013,8 +1013,6 @@ SYSCALL_DEFINE2(osf_settimeofday, struct timeval32 __user *, tv,
 	return do_sys_settimeofday64(tv ? &kts : NULL, tz ? &ktz : NULL);
 }
 
-asmlinkage long sys_ni_posix_timers(void);
-
 SYSCALL_DEFINE2(osf_utimes, const char __user *, filename,
 		struct timeval32 __user *, tvs)
 {
diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index b383b4802a7b..44226f09e398 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -43,9 +43,6 @@ struct pt_regs;
 		return sys_ni_syscall();						\
 	}
 
-#define COMPAT_SYS_NI(name) \
-	SYSCALL_ALIAS(__arm64_compat_sys_##name, sys_ni_posix_timers);
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)						\
@@ -78,6 +75,4 @@ struct pt_regs;
 		return sys_ni_syscall();					\
 	}
 
-#define SYS_NI(name) SYSCALL_ALIAS(__arm64_sys_##name, sys_ni_posix_timers);
-
 #endif /* __ASM_SYSCALL_WRAPPER_H */
diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index 3c3d6fe8e2f0..16f52683fa98 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -61,10 +61,6 @@
 	cond_syscall(__s390x_sys_##name);				\
 	cond_syscall(__s390_sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);		\
-	SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers)
-
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	__diag_push();								\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
@@ -86,15 +82,11 @@
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
- * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
- * kernel/time/posix-stubs.c to cover this case as well.
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name)					\
 	cond_syscall(__s390_compat_sys_##name)
 
-#define COMPAT_SYS_NI(name)						\
-	SYSCALL_ALIAS(__s390_compat_sys_##name, sys_ni_posix_timers)
-
 #else /* CONFIG_COMPAT */
 
 #define __S390_SYS_STUBx(x, fullname, name, ...)
@@ -108,9 +100,6 @@
 #define COND_SYSCALL(name)						\
 	cond_syscall(__s390x_sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)						\
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a84333adeef2..655e7832fc29 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -85,9 +85,6 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		return sys_ni_syscall();				\
 	}
 
-#define __SYS_NI(abi, name)						\
-	SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers);
-
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)						\
 	__SYS_STUB0(x64, sys_##name)
@@ -99,13 +96,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __X64_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x64, sys_##name)
 
-#define __X64_SYS_NI(name)						\
-	__SYS_NI(x64, sys_##name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
 #define __X64_COND_SYSCALL(name)
-#define __X64_SYS_NI(name)
 #endif /* CONFIG_X86_64 */
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
@@ -119,13 +113,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __IA32_COND_SYSCALL(name)					\
 	__COND_SYSCALL(ia32, sys_##name)
 
-#define __IA32_SYS_NI(name)						\
-	__SYS_NI(ia32, sys_##name)
 #else /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
 #define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
 #define __IA32_COND_SYSCALL(name)
-#define __IA32_SYS_NI(name)
 #endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -134,8 +125,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * additional wrappers (aptly named __ia32_sys_xyzzy) which decode the
  * ia32 regs in the proper order for shared or "common" syscalls. As some
  * syscalls may not be implemented, we need to expand COND_SYSCALL in
- * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
- * case as well.
+ * kernel/sys_ni.c to cover this case as well.
  */
 #define __IA32_COMPAT_SYS_STUB0(name)					\
 	__SYS_STUB0(ia32, compat_sys_##name)
@@ -147,14 +137,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __IA32_COMPAT_COND_SYSCALL(name)				\
 	__COND_SYSCALL(ia32, compat_sys_##name)
 
-#define __IA32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(ia32, compat_sys_##name)
-
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
 #define __IA32_COMPAT_COND_SYSCALL(name)
-#define __IA32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -174,13 +160,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __X32_COMPAT_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x32, compat_sys_##name)
 
-#define __X32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(x32, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
-#define __X32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -211,17 +194,12 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
- * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
- * kernel/time/posix-stubs.c to cover this case as well.
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name) 					\
 	__IA32_COMPAT_COND_SYSCALL(name)				\
 	__X32_COMPAT_COND_SYSCALL(name)
 
-#define COMPAT_SYS_NI(name)						\
-	__IA32_COMPAT_SYS_NI(name)					\
-	__X32_COMPAT_SYS_NI(name)
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)					\
@@ -242,8 +220,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
  * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
  * hurt, we only need to re-define it here to keep the naming congruent to
- * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
- * macros to work correctly.
+ * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() macro to
+ * work correctly.
  */
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
@@ -256,11 +234,6 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	__X64_COND_SYSCALL(name)					\
 	__IA32_COND_SYSCALL(name)
 
-#define SYS_NI(name)							\
-	__X64_SYS_NI(name)						\
-	__IA32_SYS_NI(name)
-
-
 /*
  * For VSYSCALLS, we need to declare these three syscalls with the new
  * pt_regs-based calling convention for in-kernel use.
diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..6a24a6d8f906 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2286,8 +2286,7 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # SYSCALL_DEFINE() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>
 # and the COMPAT_ variants in <linux/compat.h>, in particular to use a
 # different calling convention for syscalls. They can also override the
-# macros for not-implemented syscalls in kernel/sys_ni.c and
-# kernel/time/posix-stubs.c. All these overrides need to be available in
-# <asm/syscall_wrapper.h>.
+# macros for not-implemented syscalls in kernel/sys_ni.c.  All these
+# overrides need to be available in <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..8b3fc3a5d4df 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -151,6 +151,10 @@ COND_SYSCALL_COMPAT(get_robust_list);
 /* kernel/hrtimer.c */
 
 /* kernel/itimer.c */
+COND_SYSCALL(getitimer);
+COND_SYSCALL_COMPAT(getitimer);
+COND_SYSCALL(setitimer);
+COND_SYSCALL_COMPAT(setitimer);
 
 /* kernel/kexec.c */
 COND_SYSCALL(kexec_load);
@@ -161,6 +165,12 @@ COND_SYSCALL(init_module);
 COND_SYSCALL(delete_module);
 
 /* kernel/posix-timers.c */
+COND_SYSCALL(timer_create);
+COND_SYSCALL_COMPAT(timer_create);
+COND_SYSCALL(timer_gettime);
+COND_SYSCALL(timer_getoverrun);
+COND_SYSCALL(timer_settime);
+COND_SYSCALL(timer_delete);
 
 /* kernel/printk.c */
 COND_SYSCALL(syslog);
@@ -312,6 +322,8 @@ COND_SYSCALL(name_to_handle_at);
 COND_SYSCALL(open_by_handle_at);
 COND_SYSCALL_COMPAT(open_by_handle_at);
 
+COND_SYSCALL(clock_adjtime);
+
 COND_SYSCALL(sendmmsg);
 COND_SYSCALL_COMPAT(sendmmsg);
 COND_SYSCALL(process_vm_readv);
@@ -349,7 +361,6 @@ COND_SYSCALL(pkey_mprotect);
 COND_SYSCALL(pkey_alloc);
 COND_SYSCALL(pkey_free);
 
-
 /*
  * Architecture specific weak syscall entries.
  */
@@ -449,6 +460,9 @@ COND_SYSCALL(sysfs);
 COND_SYSCALL(ipc);
 COND_SYSCALL_COMPAT(ipc);
 
+/* obsolete: __ARCH_WANT_SYS_ALARM */
+COND_SYSCALL(alarm);
+
 /* obsolete: UID16 */
 COND_SYSCALL(chown16);
 COND_SYSCALL(fchown16);
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index fcb3b21d8bdc..e6f6f29e0c4f 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -17,40 +17,6 @@
 #include <linux/time_namespace.h>
 #include <linux/compat.h>
 
-#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
-/* Architectures may override SYS_NI and COMPAT_SYS_NI */
-#include <asm/syscall_wrapper.h>
-#endif
-
-asmlinkage long sys_ni_posix_timers(void)
-{
-	pr_err_once("process %d (%s) attempted a POSIX timer syscall "
-		    "while CONFIG_POSIX_TIMERS is not set\n",
-		    current->pid, current->comm);
-	return -ENOSYS;
-}
-
-#ifndef SYS_NI
-#define SYS_NI(name)  SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers)
-#endif
-
-#ifndef COMPAT_SYS_NI
-#define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
-#endif
-
-SYS_NI(timer_create);
-SYS_NI(timer_gettime);
-SYS_NI(timer_getoverrun);
-SYS_NI(timer_settime);
-SYS_NI(timer_delete);
-SYS_NI(clock_adjtime);
-SYS_NI(getitimer);
-SYS_NI(setitimer);
-SYS_NI(clock_adjtime32);
-#ifdef __ARCH_WANT_SYS_ALARM
-SYS_NI(alarm);
-#endif
-
 /*
  * We preserve minimal support for CLOCK_REALTIME and CLOCK_MONOTONIC
  * as it is easy to remain compatible with little code. CLOCK_BOOTTIME
@@ -156,18 +122,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 				 which_clock);
 }
 
-#ifdef CONFIG_COMPAT
-COMPAT_SYS_NI(timer_create);
-#endif
-
-#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
-COMPAT_SYS_NI(getitimer);
-COMPAT_SYS_NI(setitimer);
-#endif
-
 #ifdef CONFIG_COMPAT_32BIT_TIME
-SYS_NI(timer_settime32);
-SYS_NI(timer_gettime32);
 
 SYSCALL_DEFINE2(clock_settime32, const clockid_t, which_clock,
 		struct old_timespec32 __user *, tp)
@@ -248,4 +203,5 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
-#endif
+
+#endif /* CONFIG_COMPAT_32BIT_TIME */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fec890547e04..d3f5efee9f4d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -655,38 +655,12 @@ static int add_jump_destinations(struct objtool_file *file)
 			return -1;
 		}
 
-		/*
-		 * Cross-function jump.
-		 */
 		if (insn->func && insn->jump_dest->func &&
-		    insn->func != insn->jump_dest->func) {
+		    insn->func->pfunc != insn->jump_dest->func->pfunc &&
+		    insn->jump_dest->offset == insn->jump_dest->func->offset) {
 
-			/*
-			 * For GCC 8+, create parent/child links for any cold
-			 * subfunctions.  This is _mostly_ redundant with a
-			 * similar initialization in read_symbols().
-			 *
-			 * If a function has aliases, we want the *first* such
-			 * function in the symbol table to be the subfunction's
-			 * parent.  In that case we overwrite the
-			 * initialization done in read_symbols().
-			 *
-			 * However this code can't completely replace the
-			 * read_symbols() code because this doesn't detect the
-			 * case where the parent function's only reference to a
-			 * subfunction is through a jump table.
-			 */
-			if (!strstr(insn->func->name, ".cold.") &&
-			    strstr(insn->jump_dest->func->name, ".cold.")) {
-				insn->func->cfunc = insn->jump_dest->func;
-				insn->jump_dest->func->pfunc = insn->func;
-
-			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
-				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
-
-				/* internal sibling call */
-				insn->call_dest = insn->jump_dest->func;
-			}
+			/* internal sibling call */
+			insn->call_dest = insn->jump_dest->func;
 		}
 	}
 

