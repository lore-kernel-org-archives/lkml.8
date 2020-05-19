Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094DFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AB4206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgESWFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESWFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:05:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F100C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 15:05:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbAMH-0003FU-EL; Wed, 20 May 2020 00:05:09 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B6FD5100606; Wed, 20 May 2020 00:05:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>, Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE variants
In-Reply-To: <CAG=TAF7zVCMLj5US0uw-piwBUSmWpmPSPV3Thjbh7_kGsO88hQ@mail.gmail.com>
References: <20200512183839.2373-1-elver@google.com> <20200512190910.GM2957@hirez.programming.kicks-ass.net> <CAG=TAF5S+n_W4KM9F8QuCisyV+s6_QA_gO70y6ckt=V7SS2BXw@mail.gmail.com> <CANpmjNMxvMpr=KaJEoEeRMuS3PGZEyi-VkeSmNywpQTAzFMSVA@mail.gmail.com> <CAG=TAF7zVCMLj5US0uw-piwBUSmWpmPSPV3Thjbh7_kGsO88hQ@mail.gmail.com>
Date:   Wed, 20 May 2020 00:05:08 +0200
Message-ID: <87y2pn60ob.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> On Tue, May 19, 2020 at 5:26 PM Marco Elver <elver@google.com> wrote:
>> The new solution is here:
>>     https://lkml.kernel.org/r/20200515150338.190344-1-elver@google.com
>> While it's a little inconvenient that we'll require Clang 11
>> (currently available by building yourself from LLVM repo), but until
>> we get GCC fixed (my patch there still pending :-/), this is probably
>> the right solution going forward.   If possible, please do test!
>
> That would be quite unfortunate. The version here is still gcc-8.3.1
> and clang-9.0.1 on RHEL 8.2 here. It will probably need many years to
> be able to get the fixed compilers having versions that high. Sigh...
> Also, I want to avoid compiling compilers on my own.

Yes, it's unfortunate, but we have to stop making major concessions just
because tools are not up to the task.

We've done that way too much in the past and this particular problem
clearly demonstrates that there are limits.

Making brand new technology depend on sane tools is not asked too
much. And yes, it's inconvenient, but all of us have to build tools
every now and then to get our job done. It's not the end of the world.

Building clang is trivial enough and pointing the make to the right
compiler is not rocket science either.

Thanks,

        tglx
