Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D10C47258
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECE6207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NviJUGL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgD3Tql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:46:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26954 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbgD3Tqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588275996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7tVzOz674GCv08lehU/753YbxFNL2OpNE+v8cho6GHc=;
        b=NviJUGL9co2O4xQwPSBoduvcXrHDZUlWKYJ1karGyI7iikGLnedOCm9w3/2RC9RUDlxkpI
        g7t8gYhQc1oQaXYY+blfiBeQln3v3UoQyWhwHfyiGcP3l8QMiG5sqjC6HKsUwRikQ/w7rS
        XOzmXywEkE28EZEjAowC0ZjBBKwTZ0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-ODtBXb3pONeHTeiLx_7oMg-1; Thu, 30 Apr 2020 15:46:34 -0400
X-MC-Unique: ODtBXb3pONeHTeiLx_7oMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75CEE102C84B;
        Thu, 30 Apr 2020 19:46:33 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B1EB68403;
        Thu, 30 Apr 2020 19:46:32 +0000 (UTC)
Date:   Thu, 30 Apr 2020 14:46:30 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200430194630.jkwysx6eftkaf6bu@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
 <20200429231115.z2mo5bsmrmj4oark@treble>
 <20200429232835.yw6ajtjyleob3lmz@treble>
 <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
 <20200430143350.qezebqmx2xwdxqxq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430143350.qezebqmx2xwdxqxq@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 09:33:50AM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 30, 2020 at 03:41:56PM +0200, Arnd Bergmann wrote:
> > On Thu, Apr 30, 2020 at 1:28 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Wed, Apr 29, 2020 at 06:11:15PM -0500, Josh Poimboeuf wrote:
> > > > > We can probably move those SYS_NI() instances to kernel/sys_ni.c,
> > > > > which does not include the header, but it's still a bit ugly. I'll try
> > > > > that tomorrow
> > > > > unless you come up with a better suggestion first.
> > > >
> > > > Oh I guess arm32 doesn't have SYS_NI defined.  All this syscall aliasing
> > > > stuff is a total mystery to me.
> > >
> > > Another idea would be to split up syscalls.h into two files: one for
> > > SYSCALL_* macros and one for sys_*() function prototypes.  It sounds
> > > like the latter aren't needed by most header files anyway.
> > >
> > >  * Please note that these prototypes here are only provided for information
> > >  * purposes, for static analysis, and for linking from the syscall table.
> > >  * These functions should not be called elsewhere from kernel code.
> > 
> > To me the main purpose of the header is to ensure the calling conventions
> > are sane, so I'd definitely want to see the declarations included whenever
> > a syscall is defined. I would also expect to see a warnig from sparse, or
> > from gcc with "make W=1" when an extern function is defined with no
> > prior declaration.
> 
> Yup, makes sense.  I think I've been getting confused by the syscall
> wrappers.
> 
> > How hard would it be to change objtool instead of changing the sources?
> 
> It might be a little tricky, but I can look into it.

So there's an easy fix below, just define an x86-specific SYSCALL_ALIAS.
It also requries moving the syscall alias macros to syscalls.h, but
that's probably where they belong anyway.

But the objtool .cold parent alias function detection is a little
smelly, so I might end up cleaning that up instead if I can figure out a
good way to do it.

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a84333adeef2..abe6e633f8dc 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -79,6 +79,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		return __se_##name(__VA_ARGS__);			\
 	}
 
+#define SYSCALL_ALIAS(alias, name) __alias(name) typeof(name) alias
+
 #define __COND_SYSCALL(abi, name)					\
 	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
 	{								\
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index d796ec20d114..369c65d4386c 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -22,20 +22,6 @@
 #define asmlinkage CPP_ASMLINKAGE
 #endif
 
-#ifndef cond_syscall
-#define cond_syscall(x)	asm(				\
-	".weak " __stringify(x) "\n\t"			\
-	".set  " __stringify(x) ","			\
-		 __stringify(sys_ni_syscall))
-#endif
-
-#ifndef SYSCALL_ALIAS
-#define SYSCALL_ALIAS(alias, name) asm(			\
-	".globl " __stringify(alias) "\n\t"		\
-	".set   " __stringify(alias) ","		\
-		  __stringify(name))
-#endif
-
 #define __page_aligned_data	__section(.data..page_aligned) __aligned(PAGE_SIZE)
 #define __page_aligned_bss	__section(.bss..page_aligned) __aligned(PAGE_SIZE)
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..dc93d7e595af 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -252,6 +252,20 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* __SYSCALL_DEFINEx */
 
+#ifndef SYSCALL_ALIAS
+#define SYSCALL_ALIAS(alias, name) asm(			\
+	".globl " __stringify(alias) "\n\t"		\
+	".set   " __stringify(alias) ","		\
+		  __stringify(name))
+#endif
+
+#ifndef cond_syscall
+#define cond_syscall(x)	asm(				\
+	".weak " __stringify(x) "\n\t"			\
+	".set  " __stringify(x) ","			\
+		 __stringify(sys_ni_syscall))
+#endif
+
 /*
  * Called before coming back to user-mode. Returning to user-mode with an
  * address limit different than USER_DS can allow to overwrite kernel memory.

