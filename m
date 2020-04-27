Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211BCC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5D320656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgD0PfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0PfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:35:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5AAC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:35:22 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT5mw-0006ze-LA; Mon, 27 Apr 2020 17:35:18 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 12C9A100606; Mon, 27 Apr 2020 17:35:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Leon Romanovsky <leon@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between console and hrtimer locks
In-Reply-To: <20200414070502.GR334007@unreal>
References: <20200407170925.1775019-1-leon@kernel.org> <20200414054836.GA956407@unreal> <20200414062454.GA84326@gmail.com> <20200414070502.GR334007@unreal>
Date:   Mon, 27 Apr 2020 17:35:18 +0200
Message-ID: <87v9llosax.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Romanovsky <leon@kernel.org> writes:
> But if we are talking about other weirdnesses, I have another splat in my
> QEMU machine, which is different, but from the same code area.

It's a completely different code area, really. This triggers in
deactivate_slab().

> [    1.383968] ACPI: Added _OSI(Module Device)
> [    1.385684] ACPI: Added _OSI(Processor Device)
> [    1.389345] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    1.389345] ACPI: Added _OSI(Processor Aggregator Device)
> [    1.393454] ACPI: Added _OSI(Linux-Dell-Video)
> [    1.394920] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    1.396481] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    1.793418] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    1.845452]
> [    1.846768] =============================
> [    1.849293] [ BUG: Invalid wait context ]

Do you have CONFIG_PROVE_RAW_LOCK_NESTING enabled? If yes, please
disable it. The Kconfig option explains that this will trigger
splats.

If not, then this is mysterious but has absolutely nothing to do with
the other thing. It's also completely unrelated to ACPI ...

Thanks,

        tglx
