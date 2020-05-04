Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF10C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278F020746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588579618;
	bh=KgviiHqJtQABngYsmhCiq91FZpqHvsAXcKF9Kb/EwCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bUF/FmQ+oB4CeoBqAHLoo+RZe8+ajjniNbzTA3ZtTYTATjofrh1SlkU6aSQ9i55Z6
	 aCDU922ek1r7iZ2zFgAGyzXNcHC8EmhvgKMEQiujRaoH7cVs0VoULkmP6ainO7/Qbc
	 9/+hfq2Vlg3M8LQAYfhXn4/Lc6Ci7JZv1VpVZSy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgEDIG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgEDIG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:06:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D2C820643;
        Mon,  4 May 2020 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588579616;
        bh=KgviiHqJtQABngYsmhCiq91FZpqHvsAXcKF9Kb/EwCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jb1at5d1Qv8MMYWePegEsCXL7rZtgdRj05fhGJtZaZmRZYIIspbjIMPHtedVpdygU
         HQQ1kD02SGdgoVMXAEmzPqc7U07gVYZs+t7JIYVm8iQmz9kD7yUwn+cSfFRCcKR8at
         JkElzRrlbPloa/HIxhpbkzKevFMpvXXi3UNuVsX4=
Date:   Mon, 4 May 2020 09:06:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] init/kconfig: Add LD_VERSION Kconfig
Message-ID: <20200504080651.GA2621@willie-the-truck>
References: <1585568499-21585-1-git-send-email-amit.kachhap@arm.com>
 <CAMuHMdWxTtFxgpabeK3L4Ev4zgZ6r=_c+5MBVYd7ZAHbNYxm=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWxTtFxgpabeK3L4Ev4zgZ6r=_c+5MBVYd7ZAHbNYxm=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 09:11:12AM +0200, Geert Uytterhoeven wrote:
> On Mon, Mar 30, 2020 at 1:42 PM Amit Daniel Kachhap
> <amit.kachhap@arm.com> wrote:
> > This option can be used in Kconfig files to compare the ld version
> > and enable/disable incompatible config options if required.
> >
> > This option is used in the subsequent patch along with GCC_VERSION to
> > filter out an incompatible feature.
> >
> > Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> 
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -17,6 +17,10 @@ config GCC_VERSION
> >         default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
> >         default 0
> >
> > +config LD_VERSION
> > +       int
> > +       default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh)
> > +
> >  config CC_IS_CLANG
> >         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
> 
> .config: warning: symbol value '2.01827e+11' invalid for LD_VERSION
> 
> Seen with the or32 compiler on kisskb, e.g.
> http://kisskb.ellerman.id.au/kisskb/buildresult/14226173/

Hmm. The binutils version there is '2.26.20160125', but I think
scripts/ld-version.sh is expecting that to be '2.26.0.20160125' as it would
then ignore the date suffix as of commit 0d61ed17dd30 ("ld-version: Drop
the 4th and 5th version components"). On a 32-bit host architecture, the
awk expression ends up printing the version using exponential notation,
but even on a 64-bit arch the number would still be bogus.

Will
