Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E8520776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590494573;
	bh=WcHaLBfV+u85yPM/yBzsl+UKP18EOXaGG8MIp0mxU9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kpVzDtQnw7VSqyUid2nxaZee+OzrGVkPIPofEXY75HcFjJQ+ShuoTHF5dAiNqcEOU
	 YXQoURMQ0yndqFmSy5XBVrTlBEK20uu/ln+RDAgn5t4DkJ+JI0YvAB7SRQA8AuLbIJ
	 sLX8kkqaNiXMl2VZ+QkKASSP+cVQD3g0Xw9+q0pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgEZMCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgEZMCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:02:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5AD62073B;
        Tue, 26 May 2020 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590494572;
        bh=WcHaLBfV+u85yPM/yBzsl+UKP18EOXaGG8MIp0mxU9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwvigOdeh53MruG9iZWYt3ga4Q2t47Jgi/T9Hyy+IqKns1AAYvAa8Zmi/nl3m5qBp
         VnCEh9vtQdjyZMp2XgOmnnmqesi9BiwmPQsIB9bEfK1TPry2gCmFF8IrmLkATrVEs7
         leP5KjAKCH1ngNeUOcjm1ZGRPo2Ljc/2lO9d0WaM=
Date:   Tue, 26 May 2020 13:02:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement
 expression
Message-ID: <20200526120245.GB27166@willie-the-truck>
References: <20200521142047.169334-1-elver@google.com>
 <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 12:42:16PM +0200, Arnd Bergmann wrote:
> On Thu, May 21, 2020 at 10:21 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Thu, May 21, 2020 at 7:22 AM 'Marco Elver' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> > >
> > > It appears that compilers have trouble with nested statement
> > > expressions. Therefore remove one level of statement expression nesting
> > > from the data_race() macro. This will help us avoid potential problems
> > > in future as its usage increases.
> > >
> > > Link: https://lkml.kernel.org/r/20200520221712.GA21166@zn.tnic
> > > Acked-by: Will Deacon <will@kernel.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Thanks Marco, I can confirm this series fixes the significant build
> > time regressions.
> >
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > More measurements in: https://github.com/ClangBuiltLinux/linux/issues/1032
> >
> > Might want:
> > Reported-by: Borislav Petkov <bp@suse.de>
> > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > too.
> 
> I find this patch only solves half the problem: it's much faster than
> without the
> patch, but still much slower than the current mainline version. As far as I'm
> concerned, I think the build speed regression compared to mainline is not yet
> acceptable, and we should try harder.
> 
> I have not looked too deeply at it yet, but this is what I found from looking
> at a file in a randconfig build:
> 
> Configuration: see https://pastebin.com/raw/R9erCwNj

So this .config actually has KCSAN enabled. Do you still see the slowdown
with that disabled? Although not ideal, having a longer compiler time when
the compiler is being asked to perform instrumentation doesn't seem like a
show-stopper to me.

Will
