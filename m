Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF86C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9331207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgERNB1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:01:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73116C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:01:27 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jafOY-0001kn-0i; Mon, 18 May 2020 15:01:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5897E100606; Mon, 18 May 2020 15:01:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
In-Reply-To: <20200518124902.yuw2rtmjndi7nbd2@pali>
References: <20200508213122.f7srcd2gnduamtvs@pali> <87zhah4evs.fsf@nanos.tec.linutronix.de> <20200518111103.sj73h5j3r75zv2wp@pali> <87ftbxxz55.fsf@nanos.tec.linutronix.de> <20200518113522.y6sj7ypunsu6pi3s@pali> <87d071xwxv.fsf@nanos.tec.linutronix.de> <20200518124902.yuw2rtmjndi7nbd2@pali>
Date:   Mon, 18 May 2020 15:01:25 +0200
Message-ID: <87a725xuqi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:
> On Monday 18 May 2020 14:13:48 Thomas Gleixner wrote:
>> Of course not, but the kernel relies on that application behaving
>> sanely. If it does not then the time stamps you are complaining about
>> are the least of your worries.
>
> I do not thing it is too bad... When I needed to deal in userspace with
> time/date/clock I just needed either "current time in UTC" to show it to
> user (possible in different timezone and pretty formatted) or I needed
> "timestamp since some epoch" suitable for measuring time differences.
>
> For first case I used CLOCK_REALTIME and for second case I used
> CLOCK_MONOTONIC_RAW (as it was not affected by adjtime()).
>
> And I would like to know, it is correct to use these two clocks in those
> situations?

It's your choice to do so. I prefer CLOCK_MONOTONIC simply because it's
in human understandable units and not some assumed frequency.

> Anyway, what would happen with CLOCK_BOOTTIME when during suspend is
> that external RTC source shifted back? Is kernel guarantee that
> CLOCK_BOOTTIME is always monotonic even in this case?

If the RTC delta is negative, then it's ignored, i.e. 0 sleep time
injected.

Thanks,

        tglx
