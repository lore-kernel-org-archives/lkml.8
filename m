Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4FAC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B5C20736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584951083;
	bh=dWOOiVZtGZ96dq5jw1pcpJBKWTobiKVkk1kTGU/Kux0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aYQ5ca8jdy6JDrhXOCjGHbbtWJr+ImGKPQgm46Y6OX5HmJzSgvZfwxBKLMWV+Wnsc
	 C1aBXGTiciDR1e00rBbrZzzQFDPRVgSv63fIxyHCWyoZ81pNmNsaYm27hG/LUrnYUJ
	 4l5g+/E9ajckXDhmYGNr1rQIvqyXoBLexlL3IfvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgCWILW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:11:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36297 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgCWILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:11:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so9687523wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHIW+QVtzE1xcLJp+3O/as7HmyD4LesHaV7anw/Educ=;
        b=m3oUZGC9q7A+ysv0gd2/sfYMwLniBPqKUtSy7BD+cR4lGMmdt6P6G3K9m/ZpH1Nndn
         Mn1VcOYgWZ2mhxevDXBJtDx+ooigKyUDnbV+Wwv9OOmo9mV6Tmi/4Pqr3F2bZ7uWvgYo
         lrC3+7kbRPgq5sF8RdE6VRBRYnyHsoHon15lvaHHeASxdx5ZimuAZZ/scPaDpuqnhP0C
         0m01wnnN+NSY5n652EXucbm8lxviLV04gJXHkhUgEtTCjvjyCQuP9tHOAhce6LW1Fn06
         aD8F8cX3tuWQJ21kV3/4MB1edFrqE7vuLjkmspBMQU9MfSLwHftuBugtzBVeWjo+w1If
         EyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHIW+QVtzE1xcLJp+3O/as7HmyD4LesHaV7anw/Educ=;
        b=om/CPY8/3jFnSIdJKtQ0WzxI+b4nYM6+YJSiwub0VuqA9vT7DCwC0eUP3giZV9eNPM
         o7tmzAJ3DYun4sbF5qUxP7R9fsD5M41rLAWVxJ2cLkKXKU0yVOLNkm5w/mVoAK/PxCEU
         yNOs8esuz9Hfo8NUSqtTkwdAOyzGmqW+st/YMBpQWy9wcWwXbgZCtTIjpEd3oyCgGZRs
         QclquRe04VMS4JZ0Args6JfLC2xypP4fRmPvJasEv2EtNXY2uCpju940isVD3OsVOlsy
         pI9lwGXK4+FcLYoUz/+67gC3N8wCSzV6NMQaYhVQIZGs0fzPnG6FuI/IZ9pERRPdiJ5X
         ue4Q==
X-Gm-Message-State: ANhLgQ1N7bIvmwYkBMc2EjxmnGSCzS/pvju7SbpTipWGH6EffK5Fczi0
        uWSFikJcCwzJKzdTl+04VKs=
X-Google-Smtp-Source: ADFU+vsw8k7f1Tlx4jRdx1UhV7xBebSKrI5+IoBzB1vw38QH3193rvLJSRVMegUm4Y1HWnEqGhs4RQ==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr8017841wrp.23.1584951078153;
        Mon, 23 Mar 2020 01:11:18 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i19sm11493967wmb.44.2020.03.23.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 01:11:17 -0700 (PDT)
Date:   Mon, 23 Mar 2020 09:11:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] x86/entry: Fix SYS_NI() build failure
Message-ID: <20200323081114.GA10796@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
 <20200313195144.164260-5-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313195144.164260-5-brgerst@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Brian Gerst <brgerst@gmail.com> wrote:

> Pull the common code out from the SYS_NI macros into a new __SYS_NI macro.
> Also conditionalize the X64 version in preparation for enabling syscall
> wrappers on 32-bit native kernels.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>

>  #define COMPAT_SYS_NI(name)						\
> -	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
> -	SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
> +	__IA32_COMPAT_SYS_NI(name)					\
> +	__X32_COMPAT_SYS_NI(name)
>  
>  #endif /* CONFIG_COMPAT */
>  
> @@ -231,9 +245,9 @@ struct pt_regs;
>  	__X64_COND_SYSCALL(name)					\
>  	__IA32_COND_SYSCALL(name)
>  
> -#ifndef SYS_NI
> -#define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
> -#endif
> +#define SYS_NI(name)							\
> +	__X64_SYS_NI(name)						\
> +	__IA32_SYS_NI(name)

This breaks the x86-64 build on !CONFIG_POSIX_TIMERS (and probably also 
with some x32 build variants), because of a missing ';' between 
__X64_SYS_NI() and __IA32_SYS_NI().

I suspect testing didn't catch this because SYS_NI() is rarely used in 
our x86-64 Kconfig space.

Very lightly tested fix attached.

I didn't see the COND_SYSCALL_COMPAT() build failure, but seems to have a 
similar bug.

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>

---
 arch/x86/include/asm/syscall_wrapper.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e10efa1454bc..8929419b9783 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -214,12 +214,12 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
  * kernel/time/posix-stubs.c to cover this case as well.
  */
-#define COND_SYSCALL_COMPAT(name) 					\
-	__IA32_COMPAT_COND_SYSCALL(name)				\
+#define COND_SYSCALL_COMPAT(name)					\
+	__IA32_COMPAT_COND_SYSCALL(name);				\
 	__X32_COMPAT_COND_SYSCALL(name)
 
 #define COMPAT_SYS_NI(name)						\
-	__IA32_COMPAT_SYS_NI(name)					\
+	__IA32_COMPAT_SYS_NI(name);					\
 	__X32_COMPAT_SYS_NI(name)
 
 #endif /* CONFIG_COMPAT */
@@ -257,7 +257,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	__IA32_COND_SYSCALL(name)
 
 #define SYS_NI(name)							\
-	__X64_SYS_NI(name)						\
+	__X64_SYS_NI(name);						\
 	__IA32_SYS_NI(name)
 
 
