Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37714C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121E820735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgEFSKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:10:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:37800 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgEFSKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:10:22 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 046I9r6r015436;
        Wed, 6 May 2020 13:09:53 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 046I9rPL015416;
        Wed, 6 May 2020 13:09:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 6 May 2020 13:09:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-ID: <20200506180952.GU31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr> <87sggecv81.fsf@mpe.ellerman.id.au> <1c6379b2-7e0a-91fe-34f0-51f5adca7929@csgroup.eu> <20200505155944.GO31009@gate.crashing.org> <87lfm5dev3.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfm5dev3.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:36:00AM +1000, Michael Ellerman wrote:
> >> As far as I understood that's mandatory on recent gcc to get the 
> >> pre-update form of the instruction. With older versions "m" was doing 
> >> the same, but not anymore.
> >
> > Yes.  How much that matters depends on the asm.  On older CPUs (6xx/7xx,
> > say) the update form was just as fast as the non-update form.  On newer
> > or bigger CPUs it is usually executed just the same as an add followed
> > by the memory access, so it just saves a bit of code size.
> 
> The update-forms are stdux, sthux etc. right?

And stdu, sthu, etc.  "x" is "indexed form" (reg+reg addressing).

> I don't see any change in the number of those with or without the
> constraint. That's using GCC 9.3.0.

It's most useful in loops (and happens more often there).  You probably
do not have many loops that allow update form insns.

> >> Should we ifdef the "m<>" or "m" based on GCC 
> >> version ?
> >
> > That will be a lot of churn.  Just make 4.8 minimum?
> 
> As I said in my other mail that's not really up to us. We could mandate
> a higher minimum for powerpc, but I'd rather not.

Yeah, I quite understand that.

> I think for now I'm inclined to just drop the "<>", and we can revisit
> in a release or two when hopefully GCC 4.8 has become the minimum.

An unhappy resolution, but it leaves a light on the horizon :-)

In that case, leave the "%Un", if you will but the "<>" back soonish?
Not much point removing it and putting it back later (it is harmless,
there are more instances of it in the kernel as well, since many years).

Thanks!


Segher
