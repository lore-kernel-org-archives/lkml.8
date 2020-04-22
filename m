Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB53C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205EE2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587578523;
	bh=FzQTGQ2Ix7C7yR7IfBH/DXbB5Ch65ICfo4tHoOW7nnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OxV7Xk8y+G6zLJRiYGCozCGY6DPRBGgw8aIlloulHf2Sq35NmnvSh0H4SkT2J84oF
	 k8b03vtnDQ9ZyneXQzi7/JwLtafFX+tMWd9LCLC3w5637S1bRS2p8cqRNQ0aFlvjuF
	 hM79iOlloaRGIh45WghJ2OKHMt211w0b0aFd5Mgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgDVSCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgDVSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:02:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824A1214AF;
        Wed, 22 Apr 2020 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587578520;
        bh=FzQTGQ2Ix7C7yR7IfBH/DXbB5Ch65ICfo4tHoOW7nnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0A/YQX2JzsYbuIiD4/c6g+qjcG+aB9pdJitG9h83SJHB7+jTxNwY5IDmnL47zNJ6V
         qkPfXvBBgDtNOmFzFEVREiwbBFjVhVldeCzCnsxfJ4wJIjmCpYs/DAm781XyRGitZZ
         7lfgUik1elBgd5oRg2rtr0BDR5SgI2rZBf6TZ7fc=
Date:   Wed, 22 Apr 2020 19:01:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20200422180153.GD3121@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck>
 <20200420211830.GA5081@google.com>
 <20200422173938.GA3069@willie-the-truck>
 <202004221047.3AEAECC1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004221047.3AEAECC1@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:51:02AM -0700, Kees Cook wrote:
> On Wed, Apr 22, 2020 at 06:39:47PM +0100, Will Deacon wrote:
> > On Mon, Apr 20, 2020 at 02:18:30PM -0700, Sami Tolvanen wrote:
> > > On Mon, Apr 20, 2020 at 06:17:28PM +0100, Will Deacon wrote:
> > > > > +	 * The shadow call stack is aligned to SCS_SIZE, and grows
> > > > > +	 * upwards, so we can mask out the low bits to extract the base
> > > > > +	 * when the task is not running.
> > > > > +	 */
> > > > > +	return (void *)((unsigned long)task_scs(tsk) & ~(SCS_SIZE - 1));
> > > > 
> > > > Could we avoid forcing this alignment it we stored the SCS pointer as a
> > > > (base,offset) pair instead? That might be friendlier on the allocations
> > > > later on.
> > > 
> > > The idea is to avoid storing the current task's shadow stack address in
> > > memory, which is why I would rather not store the base address either.
> > 
> > What I mean is that, instead of storing the current shadow stack pointer,
> > we instead store a base and an offset. We can still clear the base, as you
> > do with the pointer today, and I don't see that the offset is useful to
> > an attacker on its own.
> > 
> > But more generally, is it really worthwhile to do this clearing at all? Can
> > you (or Kees?) provide some justification for it, please? We don't do it
> > for anything else, e.g. the pointer authentication keys, so something
> > feels amiss here.
> 
> It's a hardening step to just reduce the lifetime of a valid address
> exposed in memory. In fact, since there is a cache, I think it should be
> wiped even in scs_release().

But we don't do this for /anything/ else and it forces alignment
restrictions on the SCS allocation. Please either do it consistently, or
not at all.

Will
