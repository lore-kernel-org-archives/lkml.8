Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E9DC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6E720719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbgCPSzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:55:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52686 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgCPSzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:55:43 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDutk-0003lS-No; Mon, 16 Mar 2020 19:55:36 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 242F21013B2; Mon, 16 Mar 2020 19:55:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/9] completion: Use simple wait queues
In-Reply-To: <CAHk-=wgO1Fn88+1K9V7=mfBNOttkGkFakGxp_QEsokZU2ywUvg@mail.gmail.com>
References: <20200313174701.148376-1-bigeasy@linutronix.de> <20200313174701.148376-6-bigeasy@linutronix.de> <CAHk-=wgO1Fn88+1K9V7=mfBNOttkGkFakGxp_QEsokZU2ywUvg@mail.gmail.com>
Date:   Mon, 16 Mar 2020 19:55:36 +0100
Message-ID: <87y2s0ceon.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, Mar 13, 2020 at 10:47 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> and before you do a conversion, you need to spend a _lot_ of time
> thinking about why that is the case.
>
> And _after_ you do the conversion, you damn well need to explain why
> it's safe. Not just state that it's a good idea.
>
> For example, this patch just randomly changes wait events to the swait
> event _exclusive_ waits. With not a single explanation of why that
> would be ok.
>
> I want an explanation for EVERY SINGLE CASE. Because people have done
> this kind of conversion before, and it's been buggy garbage before. I
> want to see that people actually thought about what the semantic
> differences were, and _documented_ that thinking process.

My bad. I'll rework the changelog so it contains the proof that the
result is semantical and functional equivalent.

Thanks,

        tglx
