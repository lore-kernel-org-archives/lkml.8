Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29ABC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE32220724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A0w/fOVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDUVX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDUVX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:23:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597EBC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LyNj4SiL/2kh6dALWu6QVaROE8w7N0gkcmTuKp8uqPc=; b=A0w/fOVbmXTqlRPw0gYzdH3btq
        YIuDXFJUyL+lLIsnyIYBiKnPBjoqscUWLkkBNANMU5SCWlzC/Oe9zqpQXbg4ERaDu8wwJw9o1rHbQ
        GvsHK9jBtBCQWvPfO2WAp6myl42kUdLpkhDdzYYRXhcmU6WQUO2TBsIVID7JgpT0zkZRe1qwHKiGR
        qK9lhDzp4+Lb16ZriVYxXN4dOMLAKuPUfo7FOE6NFVGc0mrxqcEX3Drk2UadMoZMQHQUzyYYWItQm
        gYbwAqLwDiMPGYNUiVYyefxoDewFld7Pi9rAcHcos1xpotK+rISVqWPfT3bjQ8CtGVyRi/ifZXOgx
        Ehwb2ygA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR0Mw-0003TB-9i; Tue, 21 Apr 2020 21:23:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2AA4983ABB; Tue, 21 Apr 2020 23:23:47 +0200 (CEST)
Date:   Tue, 21 Apr 2020 23:23:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Harald Arnesen <harald@skogtun.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
Message-ID: <20200421212347.GV2483@worktop.programming.kicks-ass.net>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
 <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:03:10PM -0700, Linus Torvalds wrote:
> On Mon, Apr 20, 2020 at 1:52 AM Harald Arnesen <harald@skogtun.org> wrote:
> >
> > Neither rc1 nor rc2 will boot on my laptop. The attached picture is all
> > I have been able to capture.
> 
> I know you saw the reply about this probably being fixed by
> 
>   https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/
> 
> but it would be lovely if you could actually verify that that series
> of four patches does indeed fix it for you.

(not seeing the original report in the archives or my list copy)

I'm assuming it's some sort of dodgy virt setup, actual real proper
hardware should never get here like that.

> Your oops is on that divide instruction:
> 
>         freq_scale = div64_u64(acnt, mcnt);
> 
> and while we had a check for mcnt not being zero earlier, we did
> 
>         mcnt *= arch_max_freq_ratio;
> 
> after that check. I could see it becoming zero either due to an
> overflow, or due to arch_max_freq_ratio being 0.

Right, so that's not supposed to happen, as you say, we should not
enable this code if the ratio is 0, and we should not overflow mcnt due
to reading that reg once per tick.

But yeha, virt, anything can happen :/

> I think the first commit in that series is supposed to fix that
> arch_max_freq_ratio being 0 case, but it still feels like the code
> that does the divide is checking for zero in the wrong place...

Yeah, we can certainly modify that. As is, real actual hardware should
never even hit that case either. So we might as well move that check and
then also make it disable all this frequency scaling stuff if we ever do
hit it.
