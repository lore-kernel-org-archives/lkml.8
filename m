Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E278EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF2920714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgBKK2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:28:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45600 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgBKK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:28:53 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j1Smb-00059T-Sk; Tue, 11 Feb 2020 11:28:46 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 18414101115; Tue, 11 Feb 2020 11:28:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/2] sched: Add sched_clock_register_new()
In-Reply-To: <20200210134213.8324-1-paul@crapouillou.net>
Date:   Tue, 11 Feb 2020 11:28:45 +0100
Message-ID: <87lfp94duq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

Paul Cercueil <paul@crapouillou.net> writes:

> The sched_clock_register_new() behaves like sched_clock_register() but

This function name does not make any sense. Two years from now you are
going to provide sched_clock_register_new_2_dot_0() ?

> takes an extra parameter which is passed to the read callback.

This lacks any form of justification why this function and the data
pointer is required.

>   * @sched_clock_mask:   Bitmask for two's complement subtraction of non 64bit
>   *			clocks.
>   * @read_sched_clock:	Current clock source (or dummy source when suspended).
> + * @data:		Callback data for the current clock source.
>   * @mult:		Multipler for scaled math conversion.
>   * @shift:		Shift value for scaled math conversion.
>   *
> @@ -39,7 +40,8 @@ struct clock_read_data {
>  	u64 epoch_ns;
>  	u64 epoch_cyc;
>  	u64 sched_clock_mask;
> -	u64 (*read_sched_clock)(void);
> +	u64 (*read_sched_clock)(void *);

How is that supposed to work without fixing up _all_ sched clock
instances? So the below typecast

> +void __init
> +sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
> +{
> +	sched_clock_register_new((u64 (*)(void *))read, bits, rate, NULL);

makes it compile.

By pure luck this does not explode in your face at runtime when the
existing read(void) functions are called with an argument. Any stack
based argument passing calling convention would fall flat on it's nose.

While clever this is really an ugly hack.

As the clocksource for which you are doing this is a single instance,
what's wrong with having some static storage for the information you
need as any other driver which has the same problem does as well?

If there is really a point in avoiding a few bytes of static storage,
then this needs to be cleaned up treewide and not hacked around.

Thanks,

        tglx



