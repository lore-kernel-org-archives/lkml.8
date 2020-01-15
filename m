Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36905C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DD42467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgAOVre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:47:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgAOVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:47:33 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irqVO-0001fH-05; Wed, 15 Jan 2020 22:47:14 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 74BEA101228; Wed, 15 Jan 2020 22:47:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Krzysztof Piecuch <piecuch@protonmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "juri.lelli\@redhat.com" <juri.lelli@redhat.com>,
        "malat\@debian.org" <malat@debian.org>,
        "piecuch\@protonmail.com" <piecuch@protonmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich\@akamai.com" <mzhivich@akamai.com>,
        "viresh.kumar\@linaro.org" <viresh.kumar@linaro.org>,
        "drake\@endlessm.com" <drake@endlessm.com>,
        "rafael.j.wysocki\@intel.com" <rafael.j.wysocki@intel.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "hpa\@zytor.com" <hpa@zytor.com>, "bp\@alien8.de" <bp@alien8.de>,
        "mingo\@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_guess flag disabling CPUID.16h use for tsc calibration
In-Reply-To: <03j72W25Dne_HDSwI8Y7xiXPzvEBX5Ezw_xw8ed8DC83bpdMxoPcjhbinNcDD0yeoX9GGN691f3kqqtGLztTnW8Pay3FrbO5sTlj3vjnh-Y=@protonmail.com>
References: <03j72W25Dne_HDSwI8Y7xiXPzvEBX5Ezw_xw8ed8DC83bpdMxoPcjhbinNcDD0yeoX9GGN691f3kqqtGLztTnW8Pay3FrbO5sTlj3vjnh-Y=@protonmail.com>
Date:   Wed, 15 Jan 2020 22:47:13 +0100
Message-ID: <87pnfkxuhq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Piecuch <piecuch@protonmail.com> writes:

> Changing base clock frequency directly impacts tsc hz but not CPUID.16h
> values. An overclocked CPU supporting CPUID.16h and partial CPUID.15h
> support will set tsc hz according to "best guess" given by CPUID.16h
> relying on tsc_refine_calibration_work to give better numbers later.
> tsc_refine_calibration_work will refuse to do its work when the outcome is
> off the early tsc hz value by more than 1% which is certain to happen on an
> overclocked system.

The above sets the context which is great, but it does not explain what the
solution is.

> +	tsc_guess=	[X86,INTEL] Don't use data provided by CPUID.16h during
> +			early tsc calibration. Disabling this may be useful for
> +			CPUs with altered base clocks.
> +			Format: <bool> (1/Y/y=enable, 0/N/n=disable)
> +			default: enabled

That's really a misnomer. CPUID.16h is way more than a guess. It's
pretty accurate except for the case you describe. This command line
option should clearly tell what it is about, i.e. overclocking.

Aside of that we have to be careful because on quite some modern systems
CPUID 16h is the only way to calibrate TSC and local APIC because PIT
and HPET are either not exposed or disfunct. So disabling CPUID.16h
should be prominently noted in dmesg.

Thanks,

       tglx
