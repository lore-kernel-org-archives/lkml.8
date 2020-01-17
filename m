Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D840C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C44F20730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAQJge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:36:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55155 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgAQJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:36:34 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isO3C-0004L3-Ff; Fri, 17 Jan 2020 10:36:22 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 90043100C19; Fri, 17 Jan 2020 10:36:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     vipul kumar <vipulk0511@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Vipul Kumar <vipul_kumar@mentor.com>, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] x86/tsc: Unset TSC_KNOWN_FREQ and TSC_RELIABLE flags on Intel Bay Trail SoC
In-Reply-To: <CADdC98RwESeK_nNXfiF00vdUdQSwN08sM+zt8-se6OdrhA_h2w@mail.gmail.com>
References: <1576683039-5311-1-git-send-email-vipulk0511@gmail.com> <87pnfjdpml.fsf@nanos.tec.linutronix.de> <CADdC98RwESeK_nNXfiF00vdUdQSwN08sM+zt8-se6OdrhA_h2w@mail.gmail.com>
Date:   Fri, 17 Jan 2020 10:36:21 +0100
Message-ID: <871rrye86i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vipul,

vipul kumar <vipulk0511@gmail.com> writes:
> On Fri, Jan 17, 2020 at 3:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Vipul Kumar <vipulk0511@gmail.com> writes:
>> Can you please provide detailed data about the problem you are trying to
>> solve? 'time drift' is pretty unspecific.
>
> After running board for some days without rebooting it, time drift is
> observed between system time and RTC time.
>
> SystemTime: 2019-11-08T15:48:46+00:00 RTC Time:   2019-11-08
> 15:44:35.976137+0000 Uptime: up 7 days 5 hours, 33 minutes
>
> This sample shows a difference of 4 minutes after 7 days.

Of course you fail to provide the data for the case where the frequency
is recalibrated, i.e. with your patch applied.

> To fix this drift issue, disable X86_FEATURE_TSC_KNOWN_FREQ flag for Soc's
> having  cpuid_level < 0x15.

Again, I explained you already that this does not work on SoCs which do
not expose HPET or PIT.

And again, it has absolutely nothing to do with the CPUID level because
these chips are not using CPUID to retrieve the frequency
information. They use cpu_khz_from_msr() which only depends on the CPU
model/family.

So if you want to enforce refined calibration on such systems, then you
need to do it in a way which does not break the world.

Thanks,

        tglx


