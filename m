Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDBC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180E62086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581415210;
	bh=Rf1cVsXYoyZPTMZMbH8vZlwFAWASWhkCsYObkjMQ9Ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QScFHSRZZjyHyTSlYIN1vaZGXQuPN+19SQSnBH+6336C8Gd7DQkusQz4WdOBn5TOj
	 f+PAhxn307lYiADWcll2Js6U5nf+6kJ2pBt3kRuIiZ8bv+PmURQhhgeNDECO70fSGz
	 W4ykYls7ExTWwrIkWYKZzVrKqru4ZrppjEXnmZjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgBKKAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgBKKAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:00:08 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5851D20714;
        Tue, 11 Feb 2020 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581415207;
        bh=Rf1cVsXYoyZPTMZMbH8vZlwFAWASWhkCsYObkjMQ9Ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZjYMZLNqPENaRh+mcuqb7UfkV1Eo12AXIsjC468Zej2Z0m3Xd4BRmSMg9JSvvGj5H
         d9HH7b+bMenMTDHwqZ70TklYjBBZWv2Wy0UHKUXpqRyPPMqRkx8b8FAYDwNKRYW4Ui
         v81OVzKUWodAvvqpc8bQnpxEao6X/kS36AWJyp8o=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j1SKn-004I7J-J6; Tue, 11 Feb 2020 10:00:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Feb 2020 10:00:01 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/11] arm64: disable SCS for hypervisor code
In-Reply-To: <20200211095519.GB8560@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-10-samitolvanen@google.com>
 <6f62b3c0-e796-e91c-f53b-23bd80fcb065@arm.com>
 <20200210175214.GA23318@willie-the-truck>
 <20200210180327.GB20840@lakrids.cambridge.arm.com>
 <20200210180740.GA24354@willie-the-truck>
 <43839239237869598b79cab90e100127@kernel.org>
 <20200211095519.GB8560@willie-the-truck>
Message-ID: <fed83df0e9140b9655b00f315814fab8@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, mark.rutland@arm.com, james.morse@arm.com, samitolvanen@google.com, catalin.marinas@arm.com, rostedt@goodmis.org, mhiramat@kernel.org, ard.biesheuvel@linaro.org, Dave.Martin@arm.com, keescook@chromium.org, labbott@redhat.com, ndesaulniers@google.com, jannh@google.com, miguel.ojeda.sandonis@gmail.com, yamada.masahiro@socionext.com, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-11 09:55, Will Deacon wrote:
> On Tue, Feb 11, 2020 at 09:14:52AM +0000, Marc Zyngier wrote:
>> On 2020-02-10 18:07, Will Deacon wrote:
>> > On Mon, Feb 10, 2020 at 06:03:28PM +0000, Mark Rutland wrote:
>> > > On Mon, Feb 10, 2020 at 05:52:15PM +0000, Will Deacon wrote:
>> > > > On Mon, Feb 10, 2020 at 05:18:58PM +0000, James Morse wrote:
>> > > > > On 28/01/2020 18:49, Sami Tolvanen wrote:
>> > > > > > Filter out CC_FLAGS_SCS and -ffixed-x18 for code that runs at a
>> > > > > > different exception level.
>> > > > >
>> > > > > Hmmm, there are two things being disabled here.
>> > > > >
>> > > > > Stashing the lr in memory pointed to by VA won't work transparently at EL2 ... but
>> > > > > shouldn't KVM's C code still treat x18 as a fixed register?
>> > > >
>> > > > My review of v6 suggested dropping the -ffixed-x18 as well, since it's only
>> > > > introduced by SCS (in patch 5) and so isn't required by anything else. Why
>> > > > do you think it's needed?
>> > >
>> > > When EL1 code calls up to hyp, it expects x18 to be preserved across
>> > > the
>> > > call, so hyp needs to either preserve it explicitly across a
>> > > transitions
>> > > from/to EL1 or always preserve it.
>> >
>> > I thought we explicitly saved/restored it across the call after
>> > af12376814a5 ("arm64: kvm: stop treating register x18 as caller save").
>> > Is
>> > that not sufficient?
>> >
>> > > The latter is easiest since any code used by VHE hyp code will need
>> > > x18
>> > > saved anyway (ans so any common hyp code needs to).
>> >
>> > I would personally prefer to split the VHE and non-VHE code so they can
>> > be
>> > compiled with separate options.
>> 
>> This is going to generate a lot of code duplication (or at least 
>> object
>> duplication),
>> as the two code paths are intricately linked and splitting them to 
>> support
>> different
>> compilation options and/or calling conventions.
>> 
>> I'm not fundamentally opposed to that, but it should come with ways to 
>> still
>> manage it as a unified code base as much as possible, as ways to 
>> discard the
>> unused part at runtime (which should become easy to do once we have 
>> two
>> distinct sets of objects).
> 
> Agreed, and I don't want to hold up the SCS patches because of this. 
> I'm
> just nervous about the function attribute because I've only ever had
> terrible experiences with them. Maybe it will work this time (!)

I have the same experience chasing missing __hyp_text attributes. Until 
we
have tooling that picks on this *at compile time*, we'll have to play
wack-a-mole with them...

         M.
-- 
Jazz is not dead. It just smells funny...
