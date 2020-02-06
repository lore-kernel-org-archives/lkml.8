Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FBEC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE91217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580980161;
	bh=o5FYUNHWR4JnSDHrUMdC3nhqVzIDwQIn4yBc45ZxDb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DTKn/gIOeQW/C7q9yPWZqVTwe/8uftSPZ5IbCG8PhsWuDLh0UagXuOs6qGQvLYhnm
	 1AFrAR6lGVt0xe9pgXheWBI8apzst3IaHVID8EjDlvGFaXwvmD63KBIeetgURjTLdA
	 FiTpqbhx2ConGYvfllCX42lu2ftyAnXL6ccy4y90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgBFJJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgBFJJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:09:20 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFEE3206CC;
        Thu,  6 Feb 2020 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580980160;
        bh=o5FYUNHWR4JnSDHrUMdC3nhqVzIDwQIn4yBc45ZxDb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UiOq8E+c4EAjWNLFpgTWXyhiBSZdZcts6MCCsrMsOHNx0zxnY+i5a2rU4m1Yt0tVh
         ugtRjr4NWauEOYlDScswJ9301WdrLIOfFhE7o/8U/qR9lVBZFvm1MOjWcKsnBAyNFw
         cYK5TvfOmuO4drjALZ1HuwmwzYFKx7cCXtXGugFI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1izd9y-003HNt-2V; Thu, 06 Feb 2020 09:09:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 06 Feb 2020 09:09:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        siva.durga.paladugu@xilinx.com, anirudha.sarangi@xilinx.com
Subject: Re: [PATCH v2] irqchip: xilinx: Add support for multiple instances
In-Reply-To: <3d6077c1-2b13-acc6-e8f4-3d1ab23dc159@xilinx.com>
References: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
 <b8e7b9120bc6cd306bda3347cde117ff@kernel.org>
 <3d6077c1-2b13-acc6-e8f4-3d1ab23dc159@xilinx.com>
Message-ID: <8b5c5b5d601856ddc3f4388e267c4cd0@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: michal.simek@xilinx.com, mubin.usman.sayyed@xilinx.com, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, siva.durga.paladugu@xilinx.com, anirudha.sarangi@xilinx.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-06 07:06, Michal Simek wrote:
> On 05. 02. 20 17:53, Marc Zyngier wrote:
>> On 2020-02-05 14:05, Mubin Usman Sayyed wrote:

[...]

>>>  unsigned int xintc_get_irq(void)
>>>  {
>>> -       unsigned int hwirq, irq = -1;
>>> +       int hwirq, irq = -1;
>>> 
>>> -       hwirq = xintc_read(IVR);
>>> +       hwirq = xintc_read(primary_intc->base + IVR);
>>>         if (hwirq != -1U)
>>> -               irq = irq_find_mapping(xintc_irqc->root_domain, 
>>> hwirq);
>>> +               irq = irq_find_mapping(primary_intc->root_domain, 
>>> hwirq);
>>> 
>>>         pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>> 
>> I have the ugly feeling I'm reading the same code twice... Surely you 
>> can
>> make these two functions common code.
> 
> I have some questions regarding this.
> I have updated one patchset which is adding support for Microblaze SMP.
> And when I was looking at current wiring of this driver I have decided
> to change it.
> 
> I have enabled  GENERIC_IRQ_MULTI_HANDLER and HANDLE_DOMAIN_IRQ.
> This driver calls set_handle_irq(xil_intc_handle_irq)
> and MB do_IRQ() call handle_arch_irq()
> and IRQ routine here is using handle_domain_irq().
> 
> I would expect that this chained IRQ handler can also use
> handle_domain_irq().
> 
> Is that correct understanding?

handle_domain_irq() implies that you have a set of pt_regs, representing
the context you interrupted. You can't fake that up, so I can't see how
you use it in a chained context.

[...]

>>> +       intc_dev->name = intc->full_name;
>> 
>> No. The world doesn't need to see the OF path of your interrupt
>> controller in /proc/cpuinfo.
>> The name that was there before was perfectly descriptive, please stick
>> to it.
> 
> It should be showing name like interrupt-controller@41800000.
> Do you think that we really should stick with just fixed name?
> There could be multiple instances in the system and you will have no
> idea how they are connected.

What is that used for? Debugging. We have a whole infrastructure for 
that
(GENERIC_IRQ_DEBUGFS), which is the right tool for the job. If it needs
improvement, please let me know what is missing.

Also, anything in /proc is ABI, so we don't change it randomly.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
