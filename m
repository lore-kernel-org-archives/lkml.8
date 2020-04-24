Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81BEC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A40620706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgDXO70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:59:26 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58885 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbgDXO7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:59:25 -0400
Received: from [192.168.0.5] (ip5f5af075.dynamic.kabel-deutschland.de [95.90.240.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 782FD2002EE1D;
        Fri, 24 Apr 2020 16:59:22 +0200 (CEST)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: `calibrate_APIC_clock()` takes 100 ms on AMD systems
Message-ID: <d6d50a65-59bc-aaa0-3f15-01d71496ef89@molgen.mpg.de>
Date:   Fri, 24 Apr 2020 16:59:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Trying to decrease the boot time, I noticed on AMD systems 
`calibrate_APIC_clock()` takes around 100 ms.

     [    0.004764] Freeing SMP alternatives memory: 32K
     [    0.107676] smpboot: CPU0: AMD Ryzen 3 2200G with Radeon Vega 
Graphics (family: 0x17, model: 0x11, stepping: 0x0)

On a different system with `apic=verbose`:

     [    0.209161] Freeing SMP alternatives memory: 28K
     [    0.212830] Using local APIC timer interrupts.
            calibrating APIC timer ...
     [    0.320928] ... lapic delta = 625044
     [    0.320928] ... PM-Timer delta = 357959
     [    0.320928] ... PM-Timer result ok
     [    0.320929] ..... delta 625044
     [    0.320930] ..... mult: 26844619
     [    0.320930] ..... calibration result: 400028
     [    0.320931] ..... CPU clock speed is 4400.1228 MHz.
     [    0.320931] ..... host bus clock speed is 100.0028 MHz.
     [    0.320936] smpboot: CPU0: AMD A6-6400K APU with Radeon(tm) HD 
Graphics (family: 0x15, model: 0x13, stepping: 0x1)

On Intel systems TSC deadline is used, and the function returns right away.

         if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
                 return 0;

     [    0.078373] Freeing SMP alternatives memory: 32K
     [    0.080373] TSC deadline timer enabled
     [    0.080375] smpboot: CPU0: Intel(R) Core(TM) i7-5600U CPU @ 
2.60GHz (family: 0x6, model: 0x3d, stepping: 0x4)

100 ms is almost 10 % percent of the total one second the Linux kernel 
takes here on the AMD systems, so I wonder if there are ways to reduce that.

     #define LAPIC_CAL_LOOPS         (HZ/10)

is 100 on my system, so the while loop below runs 100 times.

         while (lapic_cal_loops <= LAPIC_CAL_LOOPS) {
                 /* Wait for a tick to elapse */
                 while (1) {
                         if (tsc_khz) {
                                 u64 tsc_now = rdtsc();
                                 if ((tsc_now - tsc_start) >= tsc_perj) {
                                         tsc_start += tsc_perj;
                                         break;
                                 }
                         } else {
                                 unsigned long jif_now = READ_ONCE(jiffies);

                                 if (time_after(jif_now, jif_start)) {
                                         jif_start = jif_now;
                                         break;
                                 }
                         }
                         cpu_relax();
                 }

                 /* Invoke the calibration routine */
                 local_irq_disable();
                 lapic_cal_handler(NULL);
                 local_irq_enable();
         }

Can you give more information, why HZ/10 is chosen? Is there a way to 
break out earlier?

Do AMD devices feature an alternatives like for Intel? What other 
possibilities are there? (Please excuse my ignorance.) For example, 
taking the calibration values from the firmware, or could they be passed 
on the command line, if the user knows, the system has not changed?


Kind regards,

Paul
