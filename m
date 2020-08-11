Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496DBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0801C20774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597161703;
	bh=NL5JPcBD4J0heqlmpMus4+OlKKnHgMlLWggf1hazt1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YFRGycsHs1779aMulRkkg3oocWiU2F8KLBjzm5oFTwV9e/L/L91B5gHzPFVvwYkeS
	 n3EK5UIzPegsqKRS9eOjho2ENaYafn3QgajgMkPiQKKD+PDUwRwt414py6OdCtVSxk
	 Xm9LvnANI0RifDPVD9OPCE0dzfg1qyv7UsF7mCPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgHKQBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgHKQBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:01:40 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 172CF206B5;
        Tue, 11 Aug 2020 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597161699;
        bh=NL5JPcBD4J0heqlmpMus4+OlKKnHgMlLWggf1hazt1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvjZthd1QBr9r/BmnZaKjeFiPW/or+Xe6DbVIATO8yweiy5jb52nknbeorZqjq8J2
         2IM2FlZ9P/hLoipDyKJqg1yjMO+t1v6bfmPz5+sU+08+ydJR3qnFcWhlrt1gcKcmM6
         YO6d9HvlsAY7+2ap+v6ktLl6W4lOLYiPXfYK5ssY=
Date:   Tue, 11 Aug 2020 18:01:35 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200811160134.GA13652@linux-8ccs>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
 <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200811172738.2d632a09@coco.lan>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Mauro Carvalho Chehab [11/08/20 17:27 +0200]:
>Em Tue, 11 Aug 2020 16:55:24 +0200
>peterz@infradead.org escreveu:
>
>> On Tue, Aug 11, 2020 at 04:34:27PM +0200, Mauro Carvalho Chehab wrote:
>> >   [33] .plt              PROGBITS         0000000000000340  00035c80
>> >        0000000000000001  0000000000000000 WAX       0     0     1
>> >   [34] .init.plt         NOBITS           0000000000000341  00035c81
>> >        0000000000000001  0000000000000000  WA       0     0     1
>> >   [35] .text.ftrace[...] PROGBITS         0000000000000342  00035c81
>> >        0000000000000001  0000000000000000 WAX       0     0     1
>>
>> .plt and .text.ftrace_tramplines are buggered.
>>
>> arch/arm64/kernel/module.lds even marks then as NOLOAD.
>
>Hmm... Shouldn't the code at module_enforce_rwx_sections() or at
>load_module() ignore such sections instead of just rejecting probing
>all modules?
>
>I mean, if the existing toolchain is not capable of excluding
>those sections, either the STRICT_MODULE_RWX hardening should be
>disabled, if a broken toolchain is detected or some runtime code
>should handle such sections on a different way.

Hi Mauro, thanks for providing the readelf output. The sections marked 'WAX'
are indeed the reason why the module loader is rejecting them.

Interesting, my cross-compiled modules do not have the executable flag -

  [38] .plt              NOBITS           0000000000000340  00038fc0
       0000000000000001  0000000000000000  WA       0     0     1
  [39] .init.plt         NOBITS           0000000000000341  00038fc0
       0000000000000001  0000000000000000  WA       0     0     1
  [40] .text.ftrace_tram NOBITS           0000000000000342  00038fc0
       0000000000000001  0000000000000000  WA       0     0     1

ld version:

    GNU ld (GNU Binutils) 2.34
    Copyright (C) 2020 Free Software Foundation, Inc.
    This program is free software; you may redistribute it under the terms of
    the GNU General Public License version 3 or (at your option) a later version.

And gcc:

    aarch64-linux-gcc (GCC) 9.3.0
    Copyright (C) 2019 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

I'm a bit confused about what NOLOAD actually implies in this context. From the
ld documentation - "The `(NOLOAD)' directive will mark a section to not be
loaded at run time." But these sections are marked SHF_ALLOC and are referenced
to in the module plt code. Or does it just tell the linker to not initialize it?

Adding Ard to CC, I'm sure he'd know more about the section flag specifics.

Jessica
