Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B341EC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC9E24673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgANLcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:32:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:32:14 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irKQQ-0002Kq-3S; Tue, 14 Jan 2020 12:31:58 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8410B101DEE; Tue, 14 Jan 2020 12:31:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, arnd@arndb.de,
        vincenzo.frascino@arm.com, luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH v3 06/12] lib: vdso: __iter_div_u64_rem() is suboptimal for 32 bit time
In-Reply-To: <5b38617a2ca4f719760aafbdb6115eaad28c0640.1578934751.git.christophe.leroy@c-s.fr>
References: <cover.1578934751.git.christophe.leroy@c-s.fr> <5b38617a2ca4f719760aafbdb6115eaad28c0640.1578934751.git.christophe.leroy@c-s.fr>
Date:   Tue, 14 Jan 2020 12:31:57 +0100
Message-ID: <875zheclzm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Using __iter_div_ulong_rem() is suboptimal on 32 bits.
> Nanoseconds are only 32 bits, and VDSO data is updated every 10ms
> so nsec will never overflow 32 bits.

That's theory and perhaps true for bare metal, but there is no guarantee
on VIRT that the CPU which has the timekeeping duty assigned is not
scheduled out for longer than 4 seconds.

Thanks,

        tglx
