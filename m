Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA972C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9AD2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVjQoM5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbgDBVB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:01:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730837AbgDBVB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585861286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=acHm6n7jFULVWslWW8a+LQ1s2fp8Pdj9KK30dT5DLGE=;
        b=EVjQoM5M/sRF6HSCR/OUBP11iSqx98paiAZSfAlQCXMBsaesU0xBNPWRDubnFJFlwx9ztf
        fpNX0zqzHmu2OI8zYlLLQ+K5NMH0ph1R2FL9XabrORHNH/xOdKnL6J9iUKc7IuCfAnkn+/
        /71iahOMZwc1vRcTvhtpGifAohoQYUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-UUn-k57dPK65zGuJ8LZvQw-1; Thu, 02 Apr 2020 17:01:25 -0400
X-MC-Unique: UUn-k57dPK65zGuJ8LZvQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E0E4107ACC4;
        Thu,  2 Apr 2020 21:01:20 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8374560BF3;
        Thu,  2 Apr 2020 21:01:17 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:01:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [RESEND][patch V3 06/23] bug: Annotate WARN/BUG/stackfail as
 noinstr safe
Message-ID: <20200402210115.zpk52dyc6ofg2bve@treble>
References: <20200320175956.033706968@linutronix.de>
 <20200320180032.994128577@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320180032.994128577@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:00:02PM +0100, Thomas Gleixner wrote:
> Warnings, bugs and stack protection fails from noinstr sections, e.g. low
> level and early entry code, are likely to be fatal.
> 
> Mark them as "safe" to be invoked from noinstr protected code to avoid
> annotating all usage sites. Getting the information out is important.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/bug.h |    3 +++
>  include/asm-generic/bug.h  |    9 +++++++--
>  kernel/panic.c             |    4 +++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -70,13 +70,16 @@ do {									\
>  #define HAVE_ARCH_BUG
>  #define BUG()							\
>  do {								\
> +	instr_begin();						\
>  	_BUG_FLAGS(ASM_UD2, 0);					\
>  	unreachable();						\
>  } while (0)

For visual symmetry at least, it seems like this wants an instr_end()
before the unreachable().  Does objtool not like that?

> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -83,14 +83,19 @@ extern __printf(4, 5)
>  void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
>  		       const char *fmt, ...);
>  #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
> -#define __WARN_printf(taint, arg...)					\
> -	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
> +#define __WARN_printf(taint, arg...) do {				\
> +	instr_begin();							\
> +	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);		\
> +	instr_end();							\
> +	while (0)

Missing a '}' before the 'while'?

-- 
Josh

