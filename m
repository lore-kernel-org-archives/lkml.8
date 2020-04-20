Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBAAC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0BC208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/1dibae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgDTTRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDTTRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:17:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8924C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Bb37iSsZWAZLidveO3/hVGKaaLj1Eb4qOiowAVzP5U=; b=q/1dibaeYn0mAfwOgOwGZ+HeHC
        /3M+IolIlxc8tfGOLf9QttgC5UoYM2mNl+0BNO3yd6BdTomx3WZNKp6E0qQkUI+m3c/KKEQpYd8gD
        gKmNbHUxYNWkG3bGYKigIN5gPAq/FyCzzu3gargW27aGh+cxDOMrW6UVvOnIdZ8WAUWnL1J4n/wrw
        xCC5bmEBp1Jm05m9eXnJHHuRQ+ing09Tb5fXcxU7D6Vi98+mfyO74c1myEbjyfd6W9OqvCyGgNBh2
        qHVXcPalfNHKHr7J4qq/0uwaQMTJ8L1W3z1IvrCW4sfrkMzqEnSeG388A8YZNBld53b7vMIjzd1Rg
        cLLAEw7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQbv9-0007Wa-4z; Mon, 20 Apr 2020 19:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66B773010C4;
        Mon, 20 Apr 2020 21:17:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30B532BA17328; Mon, 20 Apr 2020 21:17:28 +0200 (CEST)
Date:   Mon, 20 Apr 2020 21:17:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200420191728.GN20730@hirez.programming.kicks-ass.net>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble>
 <20200420074845.GA72554@gmail.com>
 <CAHk-=wiG=Bz57AUmbTyZYMKU6C+nZpS8P2=vFf5xAAhBzrPuTQ@mail.gmail.com>
 <20200420174031.GM20730@hirez.programming.kicks-ass.net>
 <20200420181730.4bmggezf2zhu4ffb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420181730.4bmggezf2zhu4ffb@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 01:17:30PM -0500, Josh Poimboeuf wrote:
> On Mon, Apr 20, 2020 at 07:40:31PM +0200, Peter Zijlstra wrote:

> > So my pet peeve is that when objtool errors, or crashes, the .o file
> > gets deleted and it becomes really hard to debug the situation. I'm
> > thinking that your suggestion would actually help with that too.
> 
> I do have the same pet peeve and I'm thinking we should just revert
> 644592d32837 ("objtool: Fail the kernel build on fatal errors") which
> would ease most of the pain.  Those fatal errors don't really buy us
> much IMO.  Agree?

Well, I like that it stops the kernel build on an error; I hate that it
makes it so damn hard to then diagnose and fix the error :/

Also, it doesn't really help for crashes, luckily those are somewhat
rare -- except I had one today as a result of a mis-merge...

> > I just don't have enough Kbuild foo to even attempt this :/
> 
> It's an interesting idea, but it might have its own share of annoyances.
> 
> If you added something bad to a file, and just rebuilt that file, you
> wouldn't see the objtool warning until later when you build the entire
> kernel. 

Moo.. :/
