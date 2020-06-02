Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB9AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CC020734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h1ZqR31o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgFBR72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:59:27 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCBC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Y3HKI5svjaEX0i1wQ6y4ya6URar/l/ginxsdDN/q0M=; b=h1ZqR31owc5qrUxjp4IUDlH647
        pCZeh/SghJcpPNeBBd7iSBH7IwYPPt/ADioUIUzH3ci0IWOEzelsREAYWXoyKyhRmtl843ukQgliX
        CJQCO7zQwVJtZqUruWdsWVE2uBJ7fviK6f/D9PYqfKyi04hllBQc8nxxkdrTbjf6fywAS+j+iTEH1
        yo3ksjsqR2Ty2nOSK4Vnm6/FuVQZjAa5SiXoPE6bOKzh/xz8sFtN1FfPuyYF4U2+PBGbwMB9HZxhX
        l5rpVfDGN1LS5nbExEc0npnEaWQY0yAXeBrxO6niAYh4wPDQNOW+SBZEAKkZUf1bIZNkpVB4sjVYd
        JKSMtMwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgBBl-0000yt-5m; Tue, 02 Jun 2020 17:59:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3B9C3011B2;
        Tue,  2 Jun 2020 19:58:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DECFE202436F2; Tue,  2 Jun 2020 19:58:59 +0200 (CEST)
Date:   Tue, 2 Jun 2020 19:58:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: PANIC: double fault in fixup_bad_iret
Message-ID: <20200602175859.GC2604@hirez.programming.kicks-ass.net>
References: <000000000000d2474c05a6c938fe@google.com>
 <CACT4Y+ajjB8RmG3_H_9r-kaRAZ05ejW02-Py47o7wkkBjwup3Q@mail.gmail.com>
 <87o8q6n38p.fsf@nanos.tec.linutronix.de>
 <20200529160711.GC706460@hirez.programming.kicks-ass.net>
 <20200529171104.GD706518@hirez.programming.kicks-ass.net>
 <CACT4Y+YB=J0+w7+SHBC3KpKOzxh1Xaarj1cXOPOLKPKQwAW6nQ@mail.gmail.com>
 <CANpmjNP7mKDaXE1=5k+uPK15TDAX+PsV03F=iOR77Pnczkueyg@mail.gmail.com>
 <20200602094141.GR706495@hirez.programming.kicks-ass.net>
 <CANpmjNOqSQ38DZxunagMLdBi8gjRN=14+FFXPhc+9SsUk+FiXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOqSQ38DZxunagMLdBi8gjRN=14+FFXPhc+9SsUk+FiXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 07:51:40PM +0200, Marco Elver wrote:

> We have all attributes except __no_sanitize_coverage. GCC <= 7 has
> problems with __always_inline, so we may just have to bump the
> required compiler or emit a warning.

GCC <= 7 will hard fail the compile with those function attributes.
Bumping the min GCC version for KASAN/UBSAN to avoid that might be best.

> > > Not sure what the best strategy is to minimize patch conflicts. For
> > > now I could send just the patches to add missing definitions. If you'd
> > > like me to send all patches (including modifying 'noinstr'), let me
> > > know.
> >
> > If you're going to do patches anyway, might as well do that :-)
> 
> I was stuck on trying to find ways to emulate __no_sanitize_coverage
> (with no success), and then agonizing which patches to send in which
> sequence. ;-) You made that decision by sending the KCSAN noinstr
> series first, so let me respond to that with what I think we can add
> for KASAN and UBSAN at least.

Excellent, thanks!
