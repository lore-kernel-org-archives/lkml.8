Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF9BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A1F2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbgEMQci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgEMQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:32:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F507C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:32:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYuJ6-0000T1-Nj; Wed, 13 May 2020 18:32:32 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0D399100605; Wed, 13 May 2020 18:32:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Will Deacon' <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: RE: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
In-Reply-To: <9ba9552bd68a4461bb346dc3bae71d7a@AcuMS.aculab.com>
References: <20200511204150.27858-1-will@kernel.org> <20200512081826.GE2978@hirez.programming.kicks-ass.net> <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com> <20200512190755.GL2957@hirez.programming.kicks-ass.net> <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com> <20200513111057.GN2957@hirez.programming.kicks-ass.net> <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com> <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck> <9ba9552bd68a4461bb346dc3bae71d7a@AcuMS.aculab.com>
Date:   Wed, 13 May 2020 18:32:32 +0200
Message-ID: <87wo5f23tr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:
> From: Will Deacon
>> Sent: 13 May 2020 13:40
>> On Wed, May 13, 2020 at 02:32:43PM +0200, Peter Zijlstra wrote:
>> > On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:
>> >
>> > > Disabling most instrumentation for arch/x86 is reasonable. Also fine
>> > > with the __READ_ONCE/__WRITE_ONCE changes (your improved
>> > > compiler-friendlier version).
>> > >
>> > > We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
>> > > (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
>> > > If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
>> > > data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
>> > > now.
>> 
>> I agree that Peter's patch is the right thing to do for now. I was hoping we
>> could instrument __{READ,WRITE}_ONCE(), but that we before I realised that
>> __no_sanitize_or_inline doesn't seem to do anything.
>
> Could something be done that put the addresses of the instructions
> into a separate segment and have KASAN check that table before
> reporting an actual error?

That still does not solve the problem that the compiler adds calls into
k*san which we need to prevent in the first place.

Thanks,

        tglx
