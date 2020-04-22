Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A42C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6192098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587558396;
	bh=WoG2dRF24011ASSJYkMybNHc6GOGg8Zw81SdJa7uWmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jeLKy8E5R+cQQ/irX6+tsJ5yfTuzLAjQVlxSrO28pqbp6lld4mM459HonMbVFmXmM
	 WaLA/UAVfvrayUUPv/FZ6ff00CJUDzOOtOv7VCaNZOIO9wsdptQwre3SgxZ0EPzh6U
	 5KLbfkFIpxu0SFe2DwiUslpmwduanT9gr5DtwE2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgDVM0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVM0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:26:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D498620882;
        Wed, 22 Apr 2020 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587558394;
        bh=WoG2dRF24011ASSJYkMybNHc6GOGg8Zw81SdJa7uWmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JL01+7NyGCwL4SlN73HMZYvZs4+e0Kpgw5i4ViVCGIdgw9rRAAkJE1o9XG9xEXdzs
         bmrk6baGNDggzYYVj4vUQIpIcMlF4kuKxlK/2MGRUlIeJLKFvmKPfouVDoupzAal9P
         UJoM+AYccAuas6549mdjRFCs08BhdDEiaOjCYUxY=
Date:   Wed, 22 Apr 2020 13:26:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Message-ID: <20200422122626.GA676@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
 <20200422081838.GA29541@willie-the-truck>
 <20200422113721.GA20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422113721.GA20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:37:21PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 22, 2020 at 09:18:39AM +0100, Will Deacon wrote:
> > On Tue, Apr 21, 2020 at 11:42:56AM -0700, Linus Torvalds wrote:
> > > On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > It's me again. This is version four of the READ_ONCE() codegen improvement
> > > > patches [...]
> > > 
> > > Let's just plan on biting the bullet and do this for 5.8. I'm assuming
> > > that I'll juet get a pull request from you?
> > 
> > Sure thing, thanks. I'll get it into -next along with the arm64 bits for
> > 5.8, but I'll send it as a separate pull when the time comes. I'll also
> > include the sparc32 changes because otherwise the build falls apart and
> > we'll get an army of angry robots yelling at us (they seem to form the
> > majority of the active sparc32 user base afaict).
> 
> So I'm obviously all for these patches; do note however that it collides
> most mighty with the KCSAN stuff, which I believe is still pending.

That stuff has been pending for the last two releases afaict :/

Anyway, I'm happy to either provide a branch with this series on, or do
the merge myself, or send this again based on something else. What works
best for you? The only thing I'd obviously like to avoid is tightly
coupling this to KCSAN if there's a chance of it missing the merge window
again.

Cheers,

Will
