Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB6C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9CE24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAOH7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 02:59:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46361 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOH7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:59:48 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irdaQ-0006J7-HF; Wed, 15 Jan 2020 08:59:34 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9147A101225; Wed, 15 Jan 2020 08:59:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [patch 09/15] clocksource: Add common vdso clock mode storage
In-Reply-To: <f6c5ce65-be49-add3-5959-85fa9cdc75a2@c-s.fr>
References: <20200114185237.273005683@linutronix.de> <20200114185947.500141436@linutronix.de> <f6c5ce65-be49-add3-5959-85fa9cdc75a2@c-s.fr>
Date:   Wed, 15 Jan 2020 08:59:33 +0100
Message-ID: <874kwxb15m.fsf@nanos.tec.linutronix.de>
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
>> --- a/kernel/time/vsyscall.c
>> +++ b/kernel/time/vsyscall.c
>> @@ -72,12 +72,19 @@ void update_vsyscall(struct timekeeper *
>>   	struct vdso_data *vdata = __arch_get_k_vdso_data();
>>   	struct vdso_timestamp *vdso_ts;
>>   	u64 nsec;
>> +	s32 mode;
>
> gcc will claim 'mode' is unused when CONFIG_GENERIC_VDSO_CLOCK_MODE is 
> not defined.

I know. It's intermediate and goes away a few patches later, but yes I
can fix it up.

Thanks,

        tglx
