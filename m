Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25F0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4A021775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgBGUdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:33:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41555 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:33:46 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j0AJp-0002AT-F8; Fri, 07 Feb 2020 21:33:41 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B9334100F58; Fri,  7 Feb 2020 20:33:40 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Doug Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v2] genirq: Clarify that irq wake state is orthogonal to enable/disable
In-Reply-To: <CAD=FV=VX1Kh0UhJBX2JcSjSo7KaSQggicnVFYV8M31ocx3PYpg@mail.gmail.com>
References: <20200206191521.94559-1-swboyd@chromium.org> <20200206195752.GA8107@codeaurora.org> <CAD=FV=VX1Kh0UhJBX2JcSjSo7KaSQggicnVFYV8M31ocx3PYpg@mail.gmail.com>
Date:   Fri, 07 Feb 2020 21:33:40 +0100
Message-ID: <87lfpe87dn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:
>> Thomas also mentioned that hardware could work either way and probably
>> should not be assumed to work one way or the other.
>
> Right...
>
> ...and then (paraphrasing) Stephen pointed out that policy makes it
> really hard for clients of the API to work properly.
>
> ...and then (paraphrasing) Thomas said "Good point.  As long as you
> document that not all drivers _actually_ behave the way you describe,
> it's fine to add a comment saying that drivers _should_ behave the way
> you describe".
>
> Or, said another way: if a driver doesn't behave the way Stephen
> describes then it should be fixed unless there is some reason why
> there is no possible way to make it happen.

Yes, that's right.

Thanks,

        tglx

