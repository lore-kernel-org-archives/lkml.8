Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF5C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E2D20658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgBXJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:12:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48928 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgBXJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:12:29 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j69me-00068V-Qy; Mon, 24 Feb 2020 10:12:13 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A822F104083; Mon, 24 Feb 2020 10:12:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux@armlinux.org.uk, luto@kernel.org,
        m.szyprowski@samsung.com, Mark.Rutland@arm.com
Subject: Re: [PATCH v2 0/3] Fix arm_arch_timer clockmode when vDSO disabled
In-Reply-To: <20200222104005.6fc4019d@why>
References: <20200221181849.40351-1-vincenzo.frascino@arm.com> <20200222104005.6fc4019d@why>
Date:   Mon, 24 Feb 2020 10:12:11 +0100
Message-ID: <87h7zg4adw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:
> On Fri, 21 Feb 2020 18:18:46 +0000
> Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
>> 
>> This patch series addresses the issue defining a default arch clockmode
>> for arm and arm64 and using it to initialize the arm_arch_timer.
>
> arm only. arm64 is just fine.

Right. ARM64 unconditionaly enables VDSO

>
> This doesn't apply to -rc2, and is rather against next.

More precise it's against tip timers/core which has the VDSO changes
which caused this fallout.

>> Vincenzo Frascino (3):
>>   arm: clocksource: Add VDSO default clockmode
>>   arm64: clocksource: Add VDSO default clockmode
>>   clocksource: Fix arm_arch_timer clockmode when vDSO disabled
>
> Please squash the three patches into a single one. There is zero point
> in having 3 patches for something that small.

I really don't see why we need all this redefine foo. What's wrong with
the obvious?

--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,7 +69,12 @@ static enum arch_timer_ppi_nr arch_timer
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
+
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
+#else
+static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
+#endif
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
