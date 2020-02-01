Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01C2C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46B52063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBAUxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 15:53:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57531 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBAUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 15:53:21 -0500
Received: from [31.149.229.2] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixzl5-0002NH-TV; Sat, 01 Feb 2020 21:52:52 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D4273103088; Sat,  1 Feb 2020 21:52:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Krzysztof Piecuch <piecuch@protonmail.com>,
        "linux-kernel\\\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "mingo\\\@redhat.com" <mingo@redhat.com>,
        "bp\\\@alien8.de" <bp@alien8.de>,
        "hpa\\\@zytor.com" <hpa@zytor.com>,
        "x86\\\@kernel.org" <x86@kernel.org>,
        "rafael.j.wysocki\\\@intel.com" <rafael.j.wysocki@intel.com>,
        "drake\\\@endlessm.com" <drake@endlessm.com>,
        "viresh.kumar\\\@linaro.org" <viresh.kumar@linaro.org>,
        "juri.lelli\\\@redhat.com" <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich\\\@akamai.com" <mzhivich@akamai.com>,
        "malat\\\@debian.org" <malat@debian.org>,
        "piecuch\@protonmail.com" <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_early_khz command line parameter overriding early TSC calibration
In-Reply-To: <WIxfn1FPETITrmzdhnFHwujR0uEbHZ44PWZgmtRAzmj4rJ4wfzQUbcSWMtneOk0p7HkbJubs0z1BSLaBY3IXJarup8Ukw7Kv0WWYNgPk5bo=@protonmail.com>
References: <O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com> <WIxfn1FPETITrmzdhnFHwujR0uEbHZ44PWZgmtRAzmj4rJ4wfzQUbcSWMtneOk0p7HkbJubs0z1BSLaBY3IXJarup8Ukw7Kv0WWYNgPk5bo=@protonmail.com>
Date:   Sat, 01 Feb 2020 21:52:50 +0100
Message-ID: <87h80at4gt.fsf@nanos.tec.linutronix.de>
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

> Can I please have some feedback on this patch?

It's in my backlog and todo list
