Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE22C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D306D2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgC0RNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:13:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:39589 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0RNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:13:42 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 02RHCc49019619;
        Fri, 27 Mar 2020 12:12:38 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 02RHCZQx019618;
        Fri, 27 Mar 2020 12:12:35 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 27 Mar 2020 12:12:35 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH]     x86: Alias memset to __builtin_memset.
Message-ID: <20200327171235.GI22482@gate.crashing.org>
References: <20200323114207.222412-1-courbet@google.com> <20200326123841.134068-1-courbet@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326123841.134068-1-courbet@google.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Mar 26, 2020 at 01:38:39PM +0100, Clement Courbet wrote:
> --- a/arch/powerpc/include/asm/setjmp.h
> +++ b/arch/powerpc/include/asm/setjmp.h
> @@ -12,7 +12,9 @@
> 
>  #define JMP_BUF_LEN    23
> -extern long setjmp(long *);
> -extern void longjmp(long *, long);
> +typedef long * jmp_buf;
> +
> +extern int setjmp(jmp_buf);
> +extern void longjmp(jmp_buf, int);
> 
> I'm happy to send a patch for this, and get rid of more -ffreestanding.
> Opinions ?

Pedantically, jmp_buf should be an array type.  But, this will probably
work fine, and it certainly is better than what we had before.

You could do
  typedef long jmp_buf[JMP_BUF_LEN];
perhaps?

Thanks,


Segher
