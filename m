Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12EEC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D0C206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KZyNHydN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgEENvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:51:16 -0400
Received: from ozlabs.org ([203.11.71.1]:53215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgEENvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:51:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Gh2m6PfNz9sP7;
        Tue,  5 May 2020 23:51:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588686673;
        bh=5CkKOVUVokCv024MIkwREMwys8odQ5q3YBvid1ysFyA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KZyNHydNPFL4k4SUu0Q55R5VfRyP86hefH3T8UE+z5+SeGJhfmewbmNqkE/wNDyg7
         gbW0tCAdH0C0/9v8azV+BbS5YmAZZxINF60wEBHFlBS9TPTRqInTG8d6kGaqMLoSr5
         QdjGlboAaG/Hbh/QfAv2xttdOptlaW1gX8ZFadoZoKM1+az+qq6J+CuVQXPQWpyE8O
         9Ud4pUqqy25KoLk+FV7qOf7OOqqwlZG2jvhaF8mRT8f7m/DDlLrTlbjkkxCC52pNHn
         0NxuegEpzmcy8DlKsPPpBkgjL45lUsxrDPfhla86drNkelndsz/apV+gOQPjR3YvV+
         DbzrKtO5YXSLQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] init/kconfig: Add LD_VERSION Kconfig
In-Reply-To: <20200504080651.GA2621@willie-the-truck>
References: <1585568499-21585-1-git-send-email-amit.kachhap@arm.com> <CAMuHMdWxTtFxgpabeK3L4Ev4zgZ6r=_c+5MBVYd7ZAHbNYxm=Q@mail.gmail.com> <20200504080651.GA2621@willie-the-truck>
Date:   Tue, 05 May 2020 23:51:27 +1000
Message-ID: <87v9lacwww.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> writes:
> On Mon, May 04, 2020 at 09:11:12AM +0200, Geert Uytterhoeven wrote:
>> On Mon, Mar 30, 2020 at 1:42 PM Amit Daniel Kachhap
>> <amit.kachhap@arm.com> wrote:
>> > This option can be used in Kconfig files to compare the ld version
>> > and enable/disable incompatible config options if required.
>> >
>> > This option is used in the subsequent patch along with GCC_VERSION to
>> > filter out an incompatible feature.
>> >
>> > Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> 
>> > --- a/init/Kconfig
>> > +++ b/init/Kconfig
>> > @@ -17,6 +17,10 @@ config GCC_VERSION
>> >         default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
>> >         default 0
>> >
>> > +config LD_VERSION
>> > +       int
>> > +       default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh)
>> > +
>> >  config CC_IS_CLANG
>> >         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
>> 
>> .config: warning: symbol value '2.01827e+11' invalid for LD_VERSION
>> 
>> Seen with the or32 compiler on kisskb, e.g.
>> http://kisskb.ellerman.id.au/kisskb/buildresult/14226173/
>
> Hmm. The binutils version there is '2.26.20160125', but I think
> scripts/ld-version.sh is expecting that to be '2.26.0.20160125' as it would
> then ignore the date suffix as of commit 0d61ed17dd30 ("ld-version: Drop
> the 4th and 5th version components").

I updated the or32 compiler on kisskb to gcc 9.3.0, thanks to Arnd for
building it.

It has binutils 2.34.

cheers
