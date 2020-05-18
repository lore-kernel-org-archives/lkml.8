Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A996C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5679320709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgERL0R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgERL0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:26:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:26:17 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaduR-0008K2-H1; Mon, 18 May 2020 13:26:15 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 03E0E100606; Mon, 18 May 2020 13:26:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
In-Reply-To: <20200518111103.sj73h5j3r75zv2wp@pali>
References: <20200508213122.f7srcd2gnduamtvs@pali> <87zhah4evs.fsf@nanos.tec.linutronix.de> <20200518111103.sj73h5j3r75zv2wp@pali>
Date:   Mon, 18 May 2020 13:26:14 +0200
Message-ID: <87ftbxxz55.fsf@nanos.tec.linutronix.de>
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
> On Saturday 09 May 2020 11:49:27 Thomas Gleixner wrote:
>> Sure, but what's the problem? The adjustemt is done to make the observed
>> time as correct as possible.
>
> Yes. But correction may take lot of time, e.g. also more then one day.
>
> So during this period when correction is in progress, measuring time
> difference via CLOCK_MONITONIC will have incorrect results.
>
> It already happened for me, system clock was shifted by one hour and
> chronyd started adjustment, it slow down system clock. 6 real hours
> passed and via system clock was measured time difference only about
> 5 hours and 20 minutes (correction was still in progress as system
> clock at that time was still shifted by about 20 minutes).

System clock shifted by one hour? You mean DST change? If chronyd
adjusts that by smoothing the frequency, that's just broken and really
not the kernel's problem.

Thanks,

        tglx
