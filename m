Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61929C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270F122B45
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597159665;
	bh=F5Au2QencG0Uq++GUgB+02riOEgxtOOIblwGIT8wvLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1sUep3jw/42etnp7rAi46BTehP59lUmHofQrUY2wp1R6LpvWLvrHBh1cnO4/o+7B9
	 ckx87OciIja6dNSCuiwSQYLhuPmBGAWtW7kdN1Jof+8n21nsRR3DR1KUrkRZglzpfr
	 Nrw4jCqFoae379z2NJzOY1Kq54zfweMvrF/crWJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgHKP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgHKP1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:27:43 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C1F2078E;
        Tue, 11 Aug 2020 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597159663;
        bh=F5Au2QencG0Uq++GUgB+02riOEgxtOOIblwGIT8wvLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VxS0aKjCXSiP7qflto20mBRjPz47NV/sdbDFuxnl6vEsEPgSRcHVKGIAwz1xESNrX
         IftH9QhriPOjJq7XLqo3P0Asme+gtXExwDwdPpfHbRlntfDWuc/tSXUd2l1opGORGU
         pzY5h48v6Pfm6abiD+lVDUJcBdEdYOdkk9AvLkns=
Date:   Tue, 11 Aug 2020 17:27:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     peterz@infradead.org
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200811172738.2d632a09@coco.lan>
In-Reply-To: <20200811145524.GE2674@hirez.programming.kicks-ass.net>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
        <20200808101222.5103093e@coco.lan>
        <20200810092523.GA8612@linux-8ccs>
        <20200810150647.GB8612@linux-8ccs>
        <20200811163427.6edbf343@coco.lan>
        <20200811145524.GE2674@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 11 Aug 2020 16:55:24 +0200
peterz@infradead.org escreveu:

> On Tue, Aug 11, 2020 at 04:34:27PM +0200, Mauro Carvalho Chehab wrote:
> >   [33] .plt              PROGBITS         0000000000000340  00035c80
> >        0000000000000001  0000000000000000 WAX       0     0     1
> >   [34] .init.plt         NOBITS           0000000000000341  00035c81
> >        0000000000000001  0000000000000000  WA       0     0     1
> >   [35] .text.ftrace[...] PROGBITS         0000000000000342  00035c81
> >        0000000000000001  0000000000000000 WAX       0     0     1  
> 
> .plt and .text.ftrace_tramplines are buggered.
> 
> arch/arm64/kernel/module.lds even marks then as NOLOAD.

Hmm... Shouldn't the code at module_enforce_rwx_sections() or at
load_module() ignore such sections instead of just rejecting probing
all modules?

I mean, if the existing toolchain is not capable of excluding
those sections, either the STRICT_MODULE_RWX hardening should be
disabled, if a broken toolchain is detected or some runtime code 
should handle such sections on a different way.

Thanks,
Mauro
