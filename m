Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B20C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F99D20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgAaTre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:47:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgAaTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:47:34 -0500
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixcGH-0004bP-D1; Fri, 31 Jan 2020 20:47:29 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5171C105BDC; Fri, 31 Jan 2020 20:47:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eric Dumazet <edumazet@google.com>, Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Confused about hlist_unhashed_lockless()
In-Reply-To: <CANn89iJNgPOzCdc-7QoC+dawJVn7tLQxmrx58GL8PT9rDVT2hA@mail.gmail.com>
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com> <20200131165718.GA5517@willie-the-truck> <CANn89iKmSBPKJGw--WaJJhCdu2wz2aq-ve+E8z=gfsYj6Zom_A@mail.gmail.com> <20200131172058.GB5517@willie-the-truck> <CANn89iJNgPOzCdc-7QoC+dawJVn7tLQxmrx58GL8PT9rDVT2hA@mail.gmail.com>
Date:   Fri, 31 Jan 2020 20:47:23 +0100
Message-ID: <87blqj4ddg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <edumazet@google.com> writes:
> On Fri, Jan 31, 2020 at 9:21 AM Will Deacon <will@kernel.org> wrote:
>> Without serialisation, timer_pending() as currently implemented does
>> not reliably tell you whether the timer is in the hlist. Is that not a
>> problem?
>
> No it is not a problem.

Even if we would take the base lock then this is just a snapshot, which
can be wrong at the moment the lock is dropped. So why bother?

Thanks,

        tglx
