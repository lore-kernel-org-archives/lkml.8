Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF530C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 07:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B453B20739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 07:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFMH1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgFMH1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 03:27:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0526C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 00:27:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jk0Yr-0006Ly-GS; Sat, 13 Jun 2020 09:26:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C5C5E1013D0; Sat, 13 Jun 2020 09:26:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
In-Reply-To: <20200613024829.GA12958@paulmck-ThinkPad-P72>
References: <20200604225445.GA32319@paulmck-ThinkPad-P72> <20200605131451.GE2750@hirez.programming.kicks-ass.net> <20200605141607.GB4455@paulmck-ThinkPad-P72> <20200605184159.GA4062@paulmck-ThinkPad-P72> <20200606005126.GA21507@paulmck-ThinkPad-P72> <20200606172942.GA30594@paulmck-ThinkPad-P72> <20200607185732.GA18906@paulmck-ThinkPad-P72> <20200609154016.GA17196@paulmck-ThinkPad-P72> <20200613024829.GA12958@paulmck-ThinkPad-P72>
Date:   Sat, 13 Jun 2020 09:26:40 +0200
Message-ID: <87ftazctov.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> And an update based on your patch (https://paste.debian.net/1151802/)
> against 44ebe016df3a ("Merge branch 'proc-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace").

I'm running this patch since midnight on top of x86/entry. Still no NULL
pointer deref.

The cross-check with plain x86/entry has triggered it on all instances
by now.

So it looks your up to something here.

Thanks,

        Thomas
