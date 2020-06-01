Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357BC20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590997264;
	bh=muwNuTxdUi/iY+cPf7GSvMRN5ZcCPlstCo2RAEIWx/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X+1x385udeRWgdUlyfqMz9UOuzEN1oZGS4wTqvcjmfaX9SG594FQhlkAPzuB+bDtU
	 o/66B1mTyrAVLabDmcBIKWp7RnrSFNykHcbJbIwRfQfjXGHKTIfsHFZ5OApCJwD9Xs
	 N1Sb1VrJu5JN3tnZ1BLm90bDQOrhiRJTT2vUeZCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgFAHlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgFAHlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:41:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD50206E2;
        Mon,  1 Jun 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590997262;
        bh=muwNuTxdUi/iY+cPf7GSvMRN5ZcCPlstCo2RAEIWx/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C3Cmo/KDRo0ldRsH20hoFndPfJGT2HEvTwUQN7sGNPGOWNVVIjIJPCn7XzcuuyaAv
         T6yrmzALIs6aQJLNOQfCULCaEMDrX3yxke1Zn3252Pkd4A15eqjX6CtJrIqp7CcTx9
         Xxj5i1SucUGT7bNsuUJW1BZ7TwvohZ4nR0kt2Fao=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jff48-00GqVu-Jo; Mon, 01 Jun 2020 08:41:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Jun 2020 08:41:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v6 3/6] irqchip: RISC-V per-HART local interrupt
 controller driver
In-Reply-To: <CAAhSdy3-dr1URn1mGu3n9D-h+wjsU18nbWPYMRNAtitMa58rwA@mail.gmail.com>
References: <20200530100725.265481-1-anup.patel@wdc.com>
 <20200530100725.265481-4-anup.patel@wdc.com>
 <cd4a5513197b73e3b8d335f09117bb8d@kernel.org>
 <CAAhSdy3cnZwnjpqWkixmZ5-fi=GK1cSUsjah=P3Yp5hjv382hg@mail.gmail.com>
 <a5f1346544aec6e6da69836b7a6e0a6e@kernel.org>
 <CAAhSdy2fJ1cd2OjAWODOmSbkWUBfvvr4rvsTqh4qNxZjTTKo5A@mail.gmail.com>
 <e315f76b06b7b0935ebee867c04f364e@kernel.org>
 <CAAhSdy3-dr1URn1mGu3n9D-h+wjsU18nbWPYMRNAtitMa58rwA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <ffeba9a68e72cf2cb97759c5fb496fac@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup@brainfault.org, anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, palmerdabbelt@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-01 05:09, Anup Patel wrote:
> On Sun, May 31, 2020 at 4:23 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-05-31 11:06, Anup Patel wrote:

[...]

> Also, the PLIC spec is now owned by RISC-V foundation (not SiFive) so
> we will have to rename the driver to "irq-riscv-plic" and will have a 
> new
> generic compatible string "riscv,plic-1.0.0". One of us (me or Palmer) 
> will
> send separate patches for this renaming. I hope you will be fine with 
> this??
> (Refer, https://github.com/riscv/riscv-plic-spec)

Do we really need the churn of a renaming? A new compatible, and maybe
a new config option should be enough, no? What does the renaming give 
us?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
