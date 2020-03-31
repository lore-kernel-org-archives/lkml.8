Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDABC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8890020842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbgCaXBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:01:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33784 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgCaXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:01:54 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJPtG-00016q-8p; Wed, 01 Apr 2020 01:01:50 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BE3C5103A01; Wed,  1 Apr 2020 01:01:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Add debugfs support
In-Reply-To: <20200331222917.GG2954599@ulmo>
References: <20200331214045.2957710-1-thierry.reding@gmail.com> <87lfnguqky.fsf@nanos.tec.linutronix.de> <20200331222917.GG2954599@ulmo>
Date:   Wed, 01 Apr 2020 01:01:49 +0200
Message-ID: <87d08suo0y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:
> On Wed, Apr 01, 2020 at 12:06:37AM +0200, Thomas Gleixner wrote:
>> It does not provide any information about the clocksource, it provides
>> an interface to read the counter - nothing else.
>
> The counter is part of the information about a clocksource, isn't it?

Sorry to be pedantic, but no. Information about a clocksource is the
name, the type, the frequency, bitwidth etc.

The counter file is not providing information about the
clocksource. It's exposing an accessor to the clocksource itself.

> I can also add some information about what I intend to use this for,
> though it'll be a bit boring because I really only want this as a way
> of testing that I'm reading from the right registers and that these
> counters are running. A debugfs interface seemed like a better and more
> widely useful way to achieve that than implementing some one-off hack to
> poll those registers.

But how much value has this interface beyond the 'hack a driver for a
new clocksource' experience?

To me none, but that might be my personal skewed view.

Thanks,

        tglx
