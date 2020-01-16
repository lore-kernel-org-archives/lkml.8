Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F5C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23C620728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbgAPWE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:04:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgAPWE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:04:57 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isDFy-00029r-RE; Thu, 16 Jan 2020 23:04:50 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4D96A101226; Thu, 16 Jan 2020 23:04:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vipul Kumar <vipulk0511@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Vipul Kumar <vipul_kumar@mentor.com>, x86@kernel.org,
        Bin Gao <bin.gao@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] x86/tsc: Unset TSC_KNOWN_FREQ and TSC_RELIABLE flags on Intel Bay Trail SoC
In-Reply-To: <1576683039-5311-1-git-send-email-vipulk0511@gmail.com>
References: <1576683039-5311-1-git-send-email-vipulk0511@gmail.com>
Date:   Thu, 16 Jan 2020 23:04:50 +0100
Message-ID: <87pnfjdpml.fsf@nanos.tec.linutronix.de>
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

please always CC the relevant maintainers. Aside of that it's good
practice to CC the author of a particular commit you identified.

Vipul Kumar <vipulk0511@gmail.com> writes:

> From: Vipul Kumar <vipul_kumar@mentor.com>
>
> 'commit f3a02ecebed7 ("x86/tsc: Set TSC_KNOWN_FREQ and TSC_RELIABLE
> flags on Intel Atom SoCs")', causing time drift for Bay trail SoC.
> These flags are set for SoCs having cpuid_level 0x15 or more.
> Bay trail is having cpuid_level 0xb.

Which is completely irrelevant. These CPUs read their frequency from
MSRs not from CPUID.

> So, unset both flags to make sure the clocksource calibration can
> be done.

That's going to break tons of ATOM SoC based systems which have neither
HPET not PIT.

Aside of that on some systems HPET/PIT based calibration is not really
more accurate than the MSR based frequency, quite the contrary.

Can you please provide detailed data about the problem you are trying to
solve? 'time drift' is pretty unspecific.

Thanks,

        tglx
