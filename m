Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741AC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 10:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740D9222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 10:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgALKc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 05:32:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35372 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbgALKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 05:32:28 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iqaXV-00084R-AG; Sun, 12 Jan 2020 11:32:13 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 188DC100C2F; Sun, 12 Jan 2020 11:32:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCHv8 20/34] lib/vdso: Prepare for time namespace support
In-Reply-To: <20191112012724.250792-21-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com> <20191112012724.250792-21-dima@arista.com>
Date:   Sun, 12 Jan 2020 11:32:12 +0100
Message-ID: <8736clrmmr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Safonov <dima@arista.com> writes:
> From: Thomas Gleixner <tglx@linutronix.de>
> +#ifdef CONFIG_TIME_NS
> +static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
> +		      struct __kernel_timespec *ts)
> +{
> +	const struct vdso_data *vd = __arch_get_timens_vdso_data();
> +	const struct vdso_timestamp *vdso_ts;
> +	const struct timens_offset *offs = &vdns->offset[clk];
> +	u64 cycles, last, ns;
> +	u32 seq, msk;
> +	s64 sec;
> +
> +	msk = 1U << clk;
> +	if (msk & VDSO_HRES)
> +		vd = &vd[CS_HRES_COARSE];
> +	else if (msk & VDSO_RAW)
> +		vd = &vd[CS_RAW];
> +	else
> +		return -1;

This part is redundant. The initial call site already made sure that
this is only called for clocks matching VDSO_HRES or VDSO_RAW. I just
drop it.

Thanks,

        tglx
