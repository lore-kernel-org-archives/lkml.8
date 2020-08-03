Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F92B22BF3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUzpeCBE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leD5YLtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHCTW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:22:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHCTW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:22:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596482574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fnh19shj45XwVSRJ/AsU92QxNDDk6Jg7+Bn6+Y9OBbc=;
        b=rUzpeCBEfAgw3bwmckKW5o5Lg46V6f6rMapfuMyZ3rikpOPw5fC9DLXpAoas5c1yYEm5oD
        3KxxuE24rejUH8jFJ+SvhJ2m6ervnaNyfxbXM7tJubxjNzBjG0s0JjXKZ/KPZGT7s2Yfxj
        AEzac5sJua/pFnjUH/pP8u6hGrgB5Z5c9gIMp5xtVbV8ztGNGDQkOQ+M54m8pdUpvq6kOy
        oXkaoCGuRPsd3QGCX9v6ThiXXvy9PIwZwrNRo8LAlmuSnyr8aHZEwbVKw5MH2NeIMfxIps
        NokiXzj0njkNosO6DU3BBpR+L0cPCKCWvhHE9xi55YfiIg9r45Ry0FBGfGzGYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596482574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fnh19shj45XwVSRJ/AsU92QxNDDk6Jg7+Bn6+Y9OBbc=;
        b=leD5YLtY+Wa4TNm5tSNxVe1HLJg5bjMMOIlBeWeaR5cABf1s2j5aO6i4agBKOqWNhw/0F/
        uErwH/5+UXd98XCw==
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <jhjh7tjivew.mognet@arm.com>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf> <87d047n4oh.fsf@nanos.tec.linutronix.de> <jhjh7tjivew.mognet@arm.com>
Date:   Mon, 03 Aug 2020 21:22:53 +0200
Message-ID: <875z9zmt4i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin,

Valentin Schneider <valentin.schneider@arm.com> writes:
> On 03/08/20 16:13, Thomas Gleixner wrote:
>> Vladimir Oltean <olteanv@gmail.com> writes:
>>>>  1) When irq accounting is disabled, RT throttling kicks in as
>>>>     expected.
>>>> 
>>>>  2) With irq accounting the RT throttler does not kick in and the RCU
>>>>     stall/lockups happen.
>>> What is this telling us?
>>
>> It seems that the fine grained irq time accounting affects the runtime
>> accounting in some way which I haven't figured out yet.
>>
>
> With IRQ_TIME_ACCOUNTING, rq_clock_task() will always be incremented by a
> lesser-or-equal value than when not having the option; you start with the
> same delta_exec but slice some for the IRQ accounting, and leave the rest
> for the rq_clock_task() (+paravirt).
>
> IIUC this means that if you spend e.g. 10% of the time in IRQ and 90% of
> the time running the stress-ng RT tasks, despite having RT tasks hogging
> the entirety of the "available time" it is still only 90% runtime, which is
> below the 95% default and the throttling doesn't happen.

   totaltime = irqtime + tasktime

Ignoring irqtime and pretending that totaltime is what the scheduler
can control and deal with is naive at best.

Thanks,

        tglx

