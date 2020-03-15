Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9231CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7341B20739
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgCOKDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 06:03:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgCOKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 06:03:04 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDQ6Y-0007T9-0n; Sun, 15 Mar 2020 11:02:46 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 09DCD101305; Sun, 15 Mar 2020 11:02:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v3 00/26] Introduce common headers for vDSO
In-Reply-To: <693b6a61-b5f6-2744-1579-b356e6510547@gmail.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com> <693b6a61-b5f6-2744-1579-b356e6510547@gmail.com>
Date:   Sun, 15 Mar 2020 11:02:45 +0100
Message-ID: <87fteadjga.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Safonov <0x7f454c46@gmail.com> writes:
> I like the idea, but I'm wondering if we could have less-grained
> headers? Like, AFAICS the patches create headers < 10 lines and even
> mostly < 5 lines.. I like that header's names perfectly describe what's
> inside, but I'm not sure how effective to have a lot of extra-small
> includes.

If that goes all into a big header then the headers from where the bits and
pieces are split out would have all to include this big header which
might result in other include dependency nightmares.

>>  create mode 100644 include/vdso/time.h
>>  create mode 100644 include/vdso/time32.h
>>  create mode 100644 include/vdso/time64.h
>
> Maybe we could made them less-grained?
>
> I.e, time32 + time64 + time.h => time.h?

Then you end up with ifdeffery. I like the clear separation.

Thanks,

        tglx
