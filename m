Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E06C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0320F207D0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590922401;
	bh=cDOXdwIRPzfH77hpV1aQ9G8n49HhGcsjIyovyaKeb+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ER2Ch90b7BOLrdM5CerMGBinTPL73iZUnooT0D78js31Q7292Ykw6zcwDyJcQFvI8
	 LHhdheyn/rTgyfj9oU7FOcJbkCQRtHE9NeeRvBp02zaSiLiRe/LA2QjGUzw4LanehA
	 uyWG+fkYEEx6ixt2cTEejQxo/eVkYj5fKkdruIZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgEaKxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 06:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgEaKxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 06:53:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F7B2077D;
        Sun, 31 May 2020 10:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590922399;
        bh=cDOXdwIRPzfH77hpV1aQ9G8n49HhGcsjIyovyaKeb+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WtBH4tp1jQ3zoPFoW5sVLnr5DlAebaJW1Jqvqx9RZleEKQqYO59S9Iw56TfIRvmHk
         syWHSxJjmb2nhRRmMa7RRkKG8UfncPQPV4eUS/b3MBdd05qCcYe3BXcyVA2giihB5R
         kXhpyuHSiWdmTrp8g/OBOdv9aZatKNa7amVlz228=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jfLaf-00GfrJ-IT; Sun, 31 May 2020 11:53:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 31 May 2020 11:53:17 +0100
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
In-Reply-To: <CAAhSdy2fJ1cd2OjAWODOmSbkWUBfvvr4rvsTqh4qNxZjTTKo5A@mail.gmail.com>
References: <20200530100725.265481-1-anup.patel@wdc.com>
 <20200530100725.265481-4-anup.patel@wdc.com>
 <cd4a5513197b73e3b8d335f09117bb8d@kernel.org>
 <CAAhSdy3cnZwnjpqWkixmZ5-fi=GK1cSUsjah=P3Yp5hjv382hg@mail.gmail.com>
 <a5f1346544aec6e6da69836b7a6e0a6e@kernel.org>
 <CAAhSdy2fJ1cd2OjAWODOmSbkWUBfvvr4rvsTqh4qNxZjTTKo5A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <e315f76b06b7b0935ebee867c04f364e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup@brainfault.org, anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, palmerdabbelt@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-31 11:06, Anup Patel wrote:
> On Sun, May 31, 2020 at 3:03 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-05-31 06:36, Anup Patel wrote:
>> > On Sat, May 30, 2020 at 5:31 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> [...]
>> 
>> >> >       plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
>> >>
>> >> Why do you need to both disable the interrupt *and* change the
>> >> priority
>> >> threshold? It seems to be that one of them should be enough, but my
>> >> kno9wledge of the PLIC is limited. In any case, this would deserve a
>> >> comment.
>> >
>> > Okay, I will test and remove "disable the interrupt" part from
>> > plic_dying_cpu().
>> 
>> Be careful, as interrupt enabling/disabling is refcounted in order
>> to allow nesting. If you only enable on CPU_ON and not disable
>> on CPU_OFF, you will end-up with a depth that only increases,
>> up to the point where you hit the roof (it will take a while though).
>> 
>> I would keep the enable/disable as is, and drop the priority
>> setting from the CPU_OFF path.
> 
> The PLIC threshold is like GICv2 CPU interface enable/disable.

Looking at the documentation[1], that's not really a correct analogy:

- The PLIC is far removed from the CPU, and is more akin a GICv3
   distributor. The INTC itself is more like a GICv3 redistributor,
   as it deals with local interrupts only. I don't see anything
   in the RISC-V architecture that actually behaves like a GIC
   CPU interface (not necessarily a bad thing...).

- The threshold register is not an ON/OFF, but a priority mask,
   similar to the GIC PMR (except that the PMR lives in the CPU
   interface and affects all interrupts targetting this CPU while
   this only seem to affect PLIC interrupts and not the INTC interrupts).
   You may be using it as an ON/OFF for now as you don't support
   multiple priorities yet, but that's just a SW thing.

> Based on your comment, we should only program the PLIC threshold
> in CPU_ON and don't touch the PLIC threshold in CPU_OFF. Right??

This seems like the correct thing to do.

         M.

[1] 
https://sifive.cdn.prismic.io/sifive%2Fdc4980ff-17db-448b-b521-4c7ab26b7488_sifive+u54-mc+manual+v19.08.pdf
-- 
Jazz is not dead. It just smells funny...
