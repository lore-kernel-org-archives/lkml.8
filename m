Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D173AC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A149921655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgCJVRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:17:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35222 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgCJVRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:17:16 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBmFE-0003vP-75; Tue, 10 Mar 2020 22:16:56 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1DCD7104099; Tue, 10 Mar 2020 22:16:55 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for __fpu__restore_sig()
In-Reply-To: <e62e968c0980b091d7b263401ddd10162773678f.camel@intel.com>
References: <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com> <20200228172202.GD25261@zn.tnic> <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com> <20200228183131.GE25261@zn.tnic> <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com> <20200228214742.GF25261@zn.tnic> <c8da950a64db495088f0abe3932a489a84e4da97.camel@intel.com> <20200229143644.GA1129@zn.tnic> <6778d141a3cdbbe51cdeb3a8efb9c34e0951f6c6.camel@intel.com> <53e795ffbc029de316985476fd61845b7a9e824f.camel@intel.com> <20200306205039.GA5337@cz.tnic> <e62e968c0980b091d7b263401ddd10162773678f.camel@intel.com>
Date:   Tue, 10 Mar 2020 22:16:55 +0100
Message-ID: <87a74n6hbs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu-cheng Yu <yu-cheng.yu@intel.com> writes:
> On Fri, 2020-03-06 at 21:50 +0100, Borislav Petkov wrote:
> Earlier you wrote:
>
>   53973 / (3*60 + 35) =~ 251 XSAVES invocations per second!
>
> I would argue that the kernel does much more than that for context
> switches.

And that argument is completly bogus. You deliberately ignored that
Boris said that this is just a boring kernel build which is definitely
not a signal heavy workload. And just if you look at what the build
does, it spends a huge amount if time in ld which is not using signals
at all.

> These are from:
>   perf record -a make -j32 bzImage

How useful: This is a systemwide record and not a recording of the
workload. Try again and try with and without your stuff.

Even if you do it proper, those numbers are uninteresting, really.

What do they tell? Nothing but a picture of a workload which is known to
be not signal heavy. You can also run while(1); for 20 seconds thats
equally useful.

Run a signal benchmark and then show the numbers before and after and
chose a benchmark which is not running on a single CPU, chose one which
is bouncing signals back and forth between two busy threads pinned on
different CPUs.

> Consider this and later maintenance, I think copy_xregs_to_kernel() is at
> least not worse than saving each state separately.

Please provide precise numbers taken with TSC for both variants just for
that particular code path.

And these numbers will only tell half of the story because they still do
not take the cache foot print into account. 1000 bytes just to throw
away 960 of them?

While I appreciate that you worry about maintenance I can assure you
that the code will be in a maintainable state at the point where it is
going to be merged.

Thanks,

        tglx


