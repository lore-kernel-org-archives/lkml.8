Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E2C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213F120578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgBUQ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:27:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46250 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:27:32 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j5B9B-00069p-JK; Fri, 21 Feb 2020 17:27:25 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E5D2D100EA2; Fri, 21 Feb 2020 17:27:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de
Subject: Re: kernel BUG at arch/x86/kernel/apic/apic.c with Dell server with x2APIC enabled and unset X2APIC
In-Reply-To: <d573ba1c-0dc4-3016-712a-cc23a8a33d42@molgen.mpg.de>
References: <d573ba1c-0dc4-3016-712a-cc23a8a33d42@molgen.mpg.de>
Date:   Fri, 21 Feb 2020 17:27:24 +0100
Message-ID: <87imjzoqhf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

Paul Menzel <pmenzel@molgen.mpg.de> writes:
>
> On the Dell PowerEdge T640/04WYPY, BIOS 2.4.8 11/27/2019, Linux 5.4.14 (and 4.19.57) with
> unset `IRQ_REMAP` and `X86_X2APIC` crashes on start-up, when x2APIC is enabled in the
> firmware.

>     [    3.883893] Switched APIC routing to physical flat.
>     [    3.888904] ------------[ cut here ]------------
>     [    3.893641] kernel BUG at arch/x86/kernel/apic/apic.c:1616!

So the APIC is not registered.
>
> `noapic` and `acpi=off` separately did not work, but `noapic acpi=off` hit the other
> panic.

I have no idea what you are talking about.

Which command line options are set to reproduce the above?

Also please test the latest stable kernels not some random ones.

Thanks,

        tglx
