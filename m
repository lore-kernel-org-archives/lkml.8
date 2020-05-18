Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012E5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7456207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589789673;
	bh=4y+hIz6o4EUtNGoTSAyYuxdvDt1kqgA448EFAYzZna4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wmjSQi6dQILzJ+T5cqKfejc7cDJMLqk34td3BtSZ5sq+4BVNMu99lsUGGl/sEA+l2
	 Qf6ehFKSy0cWlKygDfCqbNk2v1daDenyPdjUyWVHR0+CuPtcxB4JG9PYNwx7Um4GsI
	 oFh+SY4A/8TBWpv9yVAlxV+sia50N2JKCk0sk32g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgERIOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgERIOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:14:32 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009C3207D4;
        Mon, 18 May 2020 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589789672;
        bh=4y+hIz6o4EUtNGoTSAyYuxdvDt1kqgA448EFAYzZna4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aBMuriSVAZ0bZbk1IYqHHHogpilxZPDYvWC0Rm3Dqo0j85N+x0PMsiangyge0sgkO
         nkWBaObEGjIH1WkUYKFydpSgsjjDC2r24t04HnoMHhgcZxnHK9SgE0sDxw5yiMmj9E
         77ZDM7jwOq9U8AujvCgBtL3cgpBAbkvpqaozgOCQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jaaus-00DBaC-F0; Mon, 18 May 2020 09:14:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 May 2020 09:14:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] irqchip/sifive-plic: Separate irq_chip for muiltiple
 PLIC instances
In-Reply-To: <MN2PR04MB62078C2854FE33CE81186FA88DBA0@MN2PR04MB6207.namprd04.prod.outlook.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
 <20200516063901.18365-4-anup.patel@wdc.com>
 <577f9a16b3dddfadb7c5487ffaef31d8@kernel.org>
 <DM6PR04MB6201FD64C78C51A94C4776558DBA0@DM6PR04MB6201.namprd04.prod.outlook.com>
 <6fbfca8f084f6cd0dc6818c4bbf58843@kernel.org>
 <MN2PR04MB62078C2854FE33CE81186FA88DBA0@MN2PR04MB6207.namprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <5bc4010161af7bef8e3c30e08888ec82@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Anup.Patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, jason@lakedaemon.net, Atish.Patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-16 17:38, Anup Patel wrote:
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>

[...]

>> I *have* given you a way to implement that in a better way. But again, 
>> I'd
>> rather you *don't* do it for the reason I have outlined above.
> 
> I explored kernel/irq/proc.c and we can achieve what this patch does
> by implementing irq_print_chip() callback of "struct irq_chip" so we
> certainly don't need separate "struct irq_chip" for each PLIC instance.
> 
> I will implement irq_print_chip() callback in v2 series.

You still haven't explained *why* you need to have this change.
As it stands, I'm not prepared to take it.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
