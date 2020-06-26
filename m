Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D7EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B01220791
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593172721;
	bh=KrlcYvveojBvps7yT4BO9KVDnyR+GciP2qARbjklwKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uToCdoVVMetiQlG31Z46FaoIo1xscenTq0s3+uX1kNk2I9HXu3CAcq8BTeiVVi4Ic
	 o3w8imcnS1rcXlSWZIUFlMsPoEnKJ79K+fe47AonigwA8bzbRMVNTJcwV7IPASq7O6
	 Z/+/e9OXJ/from8y6EKFbLxfj9IZo+AHOUFXYz+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgFZL6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbgFZL6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:58:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57EF22078D;
        Fri, 26 Jun 2020 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593172718;
        bh=KrlcYvveojBvps7yT4BO9KVDnyR+GciP2qARbjklwKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mNpFLEY3w6NsKmmPOcBDruKtxGXFDfFlUKmD7vX2RiohVTGrHma+DBwVOe+3SGnkX
         kpJ6XoaJxdkxExT2ihoWt9fRmafyliiwDfNGBNWARic6KixqukgBZeCADkz9q0x3Bk
         y+aNeEc/EXvaUATbH7MkKyDESp80ZcHszLrE2BsA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jon08-006cq9-RX; Fri, 26 Jun 2020 12:58:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jun 2020 12:58:36 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: Re: [PATCH v2 15/17] arm64: Remove custom IRQ stat accounting
In-Reply-To: <jhjftajgfy6.mognet@arm.com>
References: <20200624195811.435857-1-maz@kernel.org>
 <20200624195811.435857-16-maz@kernel.org> <jhjftajgfy6.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <d1c0d35a38844ee3907571348f3bc1fd@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 19:26, Valentin Schneider wrote:
> On 24/06/20 20:58, Marc Zyngier wrote:
>> @@ -801,26 +802,15 @@ void show_ipi_list(struct seq_file *p, int prec)
>>       unsigned int cpu, i;
>> 
>>       for (i = 0; i < NR_IPI; i++) {
>> +		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
>>               seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
>>                          prec >= 4 ? " " : "");
>>               for_each_online_cpu(cpu)
>> -			seq_printf(p, "%10u ",
>> -				   __get_irq_stat(cpu, ipi_irqs[i]));
>> +			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
>>               seq_printf(p, "      %s\n", ipi_types[i]);
> 
> How attached are we to that custom IPI printout? AIUI we *could* give 
> them
> a "prettier" name in request_percpu_irq() and let the standard procfs
> printout take the wheel.

I wish. Unfortunately, /proc/interrupts is likely to be considered ABI,
and I'm really worried to change this (see what happened last time we
tried to update /proc/cpuinfo to be less braindead...).

         M.
-- 
Jazz is not dead. It just smells funny...
