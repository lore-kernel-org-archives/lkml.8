Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D44C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BDD208FE
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590917626;
	bh=pqk91tWWobV97/8S9ckQJG1Cg14LQlrVuVJgBaWOX0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iC+g0DcWcdGVVEtyb6LFP6r99VO7xzpEeVOv0ZG5YcI/+7AGAkJsM2K/lDIup12n6
	 cc5iJRmycbpQfJCmf5KJ6J0LWgg7nBnGRDQSl4PGfCGTbUI5phVpFOAHSlq/6MJ214
	 jvx1xYCudVhS+8tE8U5LlmwI/zHGqPvYwsz+pBkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgEaJdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 05:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgEaJdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:33:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E750620707;
        Sun, 31 May 2020 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590917621;
        bh=pqk91tWWobV97/8S9ckQJG1Cg14LQlrVuVJgBaWOX0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rHKbpyM8DCm+F6y4UHz94TueNXZnKFZThsc0jU4dE+Fse6tt7Ib7kq1pQLQPlLMJd
         I7MtLh+XIk4Q5fzxbq2KPVjrNh4riurdDBqlfVgt9sMR6nJP+ZG9Ct65GrgQkg5HZy
         lFuSC79X6S37a0iZDzVTpVGKxRcPUqZU5ZZlsR1c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jfKLb-00GfAi-HI; Sun, 31 May 2020 10:33:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 31 May 2020 10:33:39 +0100
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
In-Reply-To: <CAAhSdy3cnZwnjpqWkixmZ5-fi=GK1cSUsjah=P3Yp5hjv382hg@mail.gmail.com>
References: <20200530100725.265481-1-anup.patel@wdc.com>
 <20200530100725.265481-4-anup.patel@wdc.com>
 <cd4a5513197b73e3b8d335f09117bb8d@kernel.org>
 <CAAhSdy3cnZwnjpqWkixmZ5-fi=GK1cSUsjah=P3Yp5hjv382hg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <a5f1346544aec6e6da69836b7a6e0a6e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup@brainfault.org, anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, palmerdabbelt@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-31 06:36, Anup Patel wrote:
> On Sat, May 30, 2020 at 5:31 PM Marc Zyngier <maz@kernel.org> wrote:

[...]

>> >       plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
>> 
>> Why do you need to both disable the interrupt *and* change the 
>> priority
>> threshold? It seems to be that one of them should be enough, but my
>> kno9wledge of the PLIC is limited. In any case, this would deserve a
>> comment.
> 
> Okay, I will test and remove "disable the interrupt" part from 
> plic_dying_cpu().

Be careful, as interrupt enabling/disabling is refcounted in order
to allow nesting. If you only enable on CPU_ON and not disable
on CPU_OFF, you will end-up with a depth that only increases,
up to the point where you hit the roof (it will take a while though).

I would keep the enable/disable as is, and drop the priority
setting from the CPU_OFF path.

>> >       return 0;
>> > @@ -260,7 +266,11 @@ static int plic_starting_cpu(unsigned int cpu)
>> >  {
>> >       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>> >
>> > -     csr_set(CSR_IE, IE_EIE);
>> > +     if (plic_parent_irq)
>> > +             enable_percpu_irq(plic_parent_irq,
>> > +                               irq_get_trigger_type(plic_parent_irq));
>> > +     else
>> > +             pr_warn("cpu%d: parent irq not available\n");
>> 
>> What does it mean to carry on if the interrupt cannot be signaled?
>> Shouldn't you error out instead, and leave the CPU dead?
> 
> The CPU is not dead if we cannot enable RISC-V INTC external
> interrupt because the Timer and IPIs interrupts are always through
> RISC-V INTC. The PLIC external interrupt not present for a CPU
> only means that that CPU cannot receive peripherial interrupts.
> 
> On a sane RISC-V system, if PLIC is present then all CPUs should
> be able to get RISC-V INTC external interrupt. Base on this rationale,
> I have put a warning for plic_parent_irq == 0.

Fair enough.

         M.
-- 
Jazz is not dead. It just smells funny...
