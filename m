Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028E9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6DDF206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXSfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXSfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:35:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5C8206F0;
        Fri, 24 Jul 2020 18:34:58 +0000 (UTC)
Date:   Fri, 24 Jul 2020 14:34:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200724143457.27755412@oasis.local.home>
In-Reply-To: <20200724175500.GD3123@ubuntu>
References: <20200719155033.24201-1-oscar.carter@gmx.com>
        <20200719155033.24201-3-oscar.carter@gmx.com>
        <20200721140545.445f0258@oasis.local.home>
        <20200724161921.GA3123@ubuntu>
        <20200724123528.36ea9c9e@oasis.local.home>
        <20200724171418.GB3123@ubuntu>
        <20200724133656.76c75629@oasis.local.home>
        <20200724134020.3160dc7c@oasis.local.home>
        <20200724175500.GD3123@ubuntu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 19:55:00 +0200
Oscar Carter <oscar.carter@gmx.com> wrote:

> > Which one of the above is this patch set for?  
> 
> This patch is the result of a warning obtained with the following:
> 
> make allmodconfig ARCH=powerpc
> make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -j4
> 
> And with the -Wcast-function-type enabled in the top level makefile.

Looking into powerpc I found this:

arch/powerpc/include/asm/ftrace.h:

  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
  #define ARCH_SUPPORTS_FTRACE_OPS 1
  #endif


arch/powerpc/Kconfig:

	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if MPROFILE_KERNEL
[..]

  config MPROFILE_KERNEL
	depends on PPC64 && CPU_LITTLE_ENDIAN && FUNCTION_TRACER
	def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__)

So, it looks like you need to be 64bit PowerPC, Little Endian, and gcc
needs to support -mprofile.

Otherwise, it falls back to the old way that does the type casting.

If you are really concerned about this, I would recommend adding
support to the architecture you care about, and then this will no
longer be an issue.

The funny part is, you can still add support for ftrace_ops, without
adding support for DYNAMIC_FTRACE_WITH_REGS, if you only care about not
having to do that typecast.

My NAK still stands. I wont let an intrusive patch be added to the
ftrace core code to deal with an unsupported feature in an architecture.

I would be will to add that linker trick to remove the warning. Or we
just use that warning as incentive to get architecture developers to
implement this feature ;-)

-- Steve
