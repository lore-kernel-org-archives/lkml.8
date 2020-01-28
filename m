Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A75C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE49224683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgA1PMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:12:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49191 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgA1PMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:12:09 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwSWt-0000xt-UP; Tue, 28 Jan 2020 16:11:52 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 491F1101227; Tue, 28 Jan 2020 16:11:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     vipul kumar <vipulk0511@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Stable <stable@vger.kernel.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        x86@kernel.org, Len Brown <len.brown@intel.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [v3] x86/tsc: Unset TSC_KNOWN_FREQ and TSC_RELIABLE flags on Intel Bay Trail SoC
In-Reply-To: <CADdC98To8VKOUWnR+8zAJ04vgdc4vJoh2h96588+5XFer9YTJw@mail.gmail.com>
References: <1579617717-4098-1-git-send-email-vipulk0511@gmail.com> <87eevs7lfd.fsf@nanos.tec.linutronix.de> <CADdC98RJpsvu_zWehNGDDN=W11rD11NSPaodg-zuaXsHuOJYTQ@mail.gmail.com> <878slzeeim.fsf@nanos.tec.linutronix.de> <CADdC98TE4oNWZyEsqXzr+zJtfdTTOyeeuHqu1u04X_ktLHo-Hg@mail.gmail.com> <20200123144108.GU32742@smile.fi.intel.com> <df04f43d-8c6d-7602-cb50-535b85cf2aaa@redhat.com> <87iml11ccf.fsf@nanos.tec.linutronix.de> <c06260e3-bd19-bf3c-89f7-d36bdb9a5b20@redhat.com> <87ftg5131x.fsf@nanos.tec.linutronix.de> <37321319-e110-81f5-2488-cedf000da04d@redhat.com> <CADdC98To8VKOUWnR+8zAJ04vgdc4vJoh2h96588+5XFer9YTJw@mail.gmail.com>
Date:   Tue, 28 Jan 2020 16:11:51 +0100
Message-ID: <87ftfz62fc.fsf@nanos.tec.linutronix.de>
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

Please see https://people.kernel.org/tglx/notes-about-netiquette
and search for Top-posting.

> Please find attached logs with mainline kernel version 5.4.15 with
> patch.

Which patch? I'm not seing any of the debug prints from my patch in that
dmesg.

I assume it's your patch, right?

> [    5.736689] tsc: Refined TSC clocksource calibration: 1833.333 MHz

Otherwise this would not show up.

Try again please with your patch removed an my debug patch applied.

Thanks,

        tglx
