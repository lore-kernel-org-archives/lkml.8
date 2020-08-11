Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4AF2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597165053;
	bh=WJZo5EU9j4S+7O6zVjIVT+WIEt8Kt1kO2zE3O8kuxyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=prgzIUTFQhoFDgY30727qzpQRcp8svYUSFkK/WH2thaRK3fYxESAudQG9RIrMyDv2
	 f2sTpjmsENLJ99U3BnxQMUEjliZjq4lJqXJ0/LXVOKj3gzokM483bVFqmeGBPWzZGU
	 a+TzIszxdm8LB7dyfdv8QWL22rJiPYOphrq/fRfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgHKQ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbgHKQ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:57:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 314042076B;
        Tue, 11 Aug 2020 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597165048;
        bh=WJZo5EU9j4S+7O6zVjIVT+WIEt8Kt1kO2zE3O8kuxyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/CzefHiBZl/ao7CDnuh6eYoCS7WJa4vMB2nzNhxZ6Z8+CbaDzljseo5Ro6JIRUPY
         swaQty6afb9AaTgMk1j7yd4tgGMFks8WoU8G1xiRHUP/jUGkfuetmy2weiaeooEiv2
         QEYXadJDAjrlkOa+DuuypzfvJsjscZI2haPoXrb0=
Date:   Tue, 11 Aug 2020 17:57:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200811165722.GA7716@willie-the-truck>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
 <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811160134.GA13652@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 06:01:35PM +0200, Jessica Yu wrote:
> +++ Mauro Carvalho Chehab [11/08/20 17:27 +0200]:
> > Em Tue, 11 Aug 2020 16:55:24 +0200
> > peterz@infradead.org escreveu:
> > 
> > > On Tue, Aug 11, 2020 at 04:34:27PM +0200, Mauro Carvalho Chehab wrote:
> > > >   [33] .plt              PROGBITS         0000000000000340  00035c80
> > > >        0000000000000001  0000000000000000 WAX       0     0     1
> > > >   [34] .init.plt         NOBITS           0000000000000341  00035c81
> > > >        0000000000000001  0000000000000000  WA       0     0     1
> > > >   [35] .text.ftrace[...] PROGBITS         0000000000000342  00035c81
> > > >        0000000000000001  0000000000000000 WAX       0     0     1
> > > 
> > > .plt and .text.ftrace_tramplines are buggered.
> > > 
> > > arch/arm64/kernel/module.lds even marks then as NOLOAD.
> > 
> > Hmm... Shouldn't the code at module_enforce_rwx_sections() or at
> > load_module() ignore such sections instead of just rejecting probing
> > all modules?
> > 
> > I mean, if the existing toolchain is not capable of excluding
> > those sections, either the STRICT_MODULE_RWX hardening should be
> > disabled, if a broken toolchain is detected or some runtime code
> > should handle such sections on a different way.
> 
> Hi Mauro, thanks for providing the readelf output. The sections marked 'WAX'
> are indeed the reason why the module loader is rejecting them.
> 
> Interesting, my cross-compiled modules do not have the executable flag -
> 
>  [38] .plt              NOBITS           0000000000000340  00038fc0
>       0000000000000001  0000000000000000  WA       0     0     1
>  [39] .init.plt         NOBITS           0000000000000341  00038fc0
>       0000000000000001  0000000000000000  WA       0     0     1
>  [40] .text.ftrace_tram NOBITS           0000000000000342  00038fc0
>       0000000000000001  0000000000000000  WA       0     0     1

FWIW, I also see the same output as you for both of the GCC 9 and Clang 11
builds I have kicking around, and there are no WAX sections in sight.

Will
