Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB8C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E669020658
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBZX1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:27:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZX1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:27:30 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7651-00008W-8B; Thu, 27 Feb 2020 00:27:03 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BB201100EA1; Thu, 27 Feb 2020 00:27:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Patrick Geary <patrickg@supermicro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Drake <drake@endlessm.com>,
        Michael Zhivich <mzhivich@akamai.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] x86/tsc: Add kernel options to disable CPUID and MSR calibrations
In-Reply-To: <20200226165407.GB18400@hirez.programming.kicks-ass.net>
References: <20200226164308.14468-1-prarit@redhat.com> <20200226165407.GB18400@hirez.programming.kicks-ass.net>
Date:   Thu, 27 Feb 2020 00:27:02 +0100
Message-ID: <87k149nd4p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Wed, Feb 26, 2020 at 11:43:08AM -0500, Prarit Bhargava wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index dbc22d684627..0316aadfff08 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4942,7 +4942,7 @@
>>  			See Documentation/admin-guide/mm/transhuge.rst
>>  			for more details.
>>  
>> -	tsc=		Disable clocksource stability checks for TSC.
>> +	tsc=option[,option...]	Various TSC options.
>>  			Format: <string>
>>  			[x86] reliable: mark tsc clocksource as reliable, this
>>  			disables clocksource verification at runtime, as well
>> @@ -4960,6 +4960,12 @@
>>  			in situations with strict latency requirements (where
>>  			interruptions from clocksource watchdog are not
>>  			acceptable).
>> +			[x86] no_cpuid_calibration: Disable the CPUID TSC
>> +			calibration.  Used in situations where the CPUID
>> +			TSC khz does not match the actual CPU TSC khz
>> +			[x86] no_msr_calibration: Disable the MSR TSC
>> +			calibration.  Used in situations where the MSR
>> +			TSC khz does not match the actual CPU TSC khz.
>
> Do we want to mention that these situations are mostly broken firmware?
> Also do mention that if you disable these you might not boot due to not
> having a PIT/HPET at all?

Right. Same discussion as before.

Also why do we want no_cpuid_calibration and no_msr_calibration? How
should Joe User figure out which one to use? This does not make
sense. The point is that the BIOS/Firmware supplied value in system
registers is bogus. So something like "skip_firmware_calibration" might
be better suitable.

Aside of that this really wants to be combined with the ability to
supply the actual frequency on the command line as I suggested in the
other thread to cope with machines which do not expose PIT/HPET or have
broken variants of them.

Thanks,

        tglx


