Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D0AC3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ADF24650
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581328804;
	bh=Dn46n2AYSU+Z2vVl+we06BNQDli46LIuwB29XqOrtZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=npABeT/Coa6CPAOgfBt2OtIeKXdjoGgx5Q9tIi6XsBlbJdJDCkWKxp83W8oZ6riCV
	 Bjw3oEAQ5/Ix1VYSfNPyahfAIcGJUe/NXA5SMtAHqsX7mpEouf5EhXbRD2Q+AuoVMk
	 4rtB0dNot1V2Fha8qxoWpX+TYuqR4+LBdnq4ejao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBJKAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgBJKAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:00:03 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 681D1208C4;
        Mon, 10 Feb 2020 10:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581328802;
        bh=Dn46n2AYSU+Z2vVl+we06BNQDli46LIuwB29XqOrtZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvupraef/J5VNBksDf2N2owNALT325yZj25BG93XIBMcTAKsB8SzyYZvunwJ6Wjrg
         eI8dvJJTfu7dNBhBuRYP4DjhoFvE41BYy/dRv9qxoB0tiHyBDW6X7z1xyswhZtoWw2
         wGvV7tOl3q7l1mwiZ2Zk6ZD1r/MiR7y62HKLUPGk=
Date:   Mon, 10 Feb 2020 09:59:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Message-ID: <20200210095956.GA15056@willie-the-truck>
References: <20200123153341.19947-1-will@kernel.org>
 <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
 <20200124083307.GA14914@hirez.programming.kicks-ass.net>
 <CAK7LNAS=er+Vkvx+vurYMCHS2u1_Vj0zV+tvUzDkSwop3XP1gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS=er+Vkvx+vurYMCHS2u1_Vj0zV+tvUzDkSwop3XP1gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 06:50:53PM +0900, Masahiro Yamada wrote:
> On Fri, Jan 24, 2020 at 5:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jan 23, 2020 at 09:59:03AM -0800, Linus Torvalds wrote:
> > > On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > This is version two of the patches I previously posted as an RFC here:
> > >
> > > Looks fine to me, as far as I can tell,
> >
> > Awesome, I've picked them up with a target for tip/locking/core.
> 
> Were they really picked up?
> 
> The MW is closed now, but I do not them in Linus' tree.
> I do not see them even in linux-next.

We ended up running into build issues with m68k which took quite a bit of
effort to fix, so that meant we missed the merge window. It also seems that
we've now run into similar looking issues for sparc32 :(

Will
