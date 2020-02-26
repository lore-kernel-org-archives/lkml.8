Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63825C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E48520801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBZXoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:44:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgBZXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:44:05 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j76LK-0000RN-A5; Thu, 27 Feb 2020 00:43:54 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C9F5F100EA1; Thu, 27 Feb 2020 00:43:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <CAMzpN2j7EHZ2bKg9SZ2Ri-qsmEoknAAJO6O5yoLn-fY8_h1B2A@mail.gmail.com>
References: <20200225224719.950376311@linutronix.de> <20200225231609.000955823@linutronix.de> <CAMzpN2ij8ReOXZH00puhzraCGRdKY8qt+TMipd_14_XWTu8xtg@mail.gmail.com> <87k149p0na.fsf@nanos.tec.linutronix.de> <CAMzpN2j7EHZ2bKg9SZ2Ri-qsmEoknAAJO6O5yoLn-fY8_h1B2A@mail.gmail.com>
Date:   Thu, 27 Feb 2020 00:43:53 +0100
Message-ID: <87eeugoqx2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <brgerst@gmail.com> writes:
> On Wed, Feb 26, 2020 at 3:13 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Brian Gerst <brgerst@gmail.com> writes:
>> Now the question is whether we care about the packed stubs or just make
>> them larger by using alignment to get rid of this silly +0x80 and
>> ~vector fixup later on. The straight forward thing clearly has its charm
>> and I doubt it matters in measurable ways.
>
> I think we can get rid of the inversion.  That was done so orig_ax had
> a negative number (signifying it's not a syscall), but if you replace
> it with -1 that isn't necessary.  A simple -0x80 offset should be
> sufficient.
>
> I think it's a worthy optimization to keep.  There are 240 of these
> stubs, so increasing the allocation to 16 bytes would add 1920 bytes
> to the kernel text.

I rather pay the 2k text size for readable and straight forward
code. Can you remind me why we are actually worrying at that level about
32bit x86 instead of making it depend on CONFIG_OBSCURE?

Thanks,

        tglx
