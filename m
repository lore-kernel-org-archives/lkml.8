Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C93EC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE97B20724
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587825127;
	bh=2Q/upiP+dr67u4tRq9PLOWQ4B95IDVSlUcu4hEkJpe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HNBX1CGx9XlQoX8JwBwrGrUS36AfpF58EZ9X5JB20iplPCxyfwcZwLwuSMmE7cV3H
	 3qeYwz5HcgF5eCZdrt1Kb354d8fZNyzl7XlYBoKmI8oLvIQXdRFlMknbWFfBUafdy7
	 b22A6CyVTZtdrzoN4g+iZ+2IW3zy2TBH4WQpSwCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDYOcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYOcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:32:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E2220714;
        Sat, 25 Apr 2020 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587825123;
        bh=2Q/upiP+dr67u4tRq9PLOWQ4B95IDVSlUcu4hEkJpe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pqJIWQw9M3rWg7TDjn7p8ySmB13X4El1kyX3qnH3LVPt7EWQldjodI8gIKPjOmFXc
         +F9pgnaMf8nMDBetjN8qhRuLlN42MkDOPh172YQrIGRlcVnQOH3DA3B9aa92uxas2e
         ny1OA5kT+BAn2KUT6jpCDd21GVXoGP3H1o56KKUs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jSLqb-006JQH-4x; Sat, 25 Apr 2020 15:32:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 25 Apr 2020 15:32:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     daniel.thompson@linaro.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        tglx@linutronix.de, will@kernel.org, julien.thierry.kdev@gmail.com
Subject: Re: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as
 pseudo NMI
In-Reply-To: <20200425112950.3a4815b6@why>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org>
 <20200425112950.3a4815b6@why>
Message-ID: <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, daniel.thompson@linaro.org, jason@lakedaemon.net, catalin.marinas@arm.com, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net, tglx@linutronix.de, will@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-25 11:29, Marc Zyngier wrote:
> On Fri, 24 Apr 2020 16:39:12 +0530
> Sumit Garg <sumit.garg@linaro.org> wrote:
> 
> Hi Sumit,
> 
>> With pseudo NMIs enabled, interrupt controller can be configured to
>> deliver SGI as a pseudo NMI. So add corresponding handling for SGIs.
>> 
>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 22 +++++++++++++++++-----
>>  1 file changed, 17 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3.c 
>> b/drivers/irqchip/irq-gic-v3.c
>> index d7006ef..be361bf 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -609,17 +609,29 @@ static inline void gic_handle_nmi(u32 irqnr, 
>> struct pt_regs *regs)
>>  	if (irqs_enabled)
>>  		nmi_enter();
>> 
>> -	if (static_branch_likely(&supports_deactivate_key))
>> -		gic_write_eoir(irqnr);
>>  	/*
>>  	 * Leave the PSR.I bit set to prevent other NMIs to be
>>  	 * received while handling this one.
>>  	 * PSR.I will be restored when we ERET to the
>>  	 * interrupted context.
>>  	 */
>> -	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
>> -	if (err)
>> -		gic_deactivate_unhandled(irqnr);
>> +	if (likely(irqnr > 15)) {
>> +		if (static_branch_likely(&supports_deactivate_key))
>> +			gic_write_eoir(irqnr);
>> +
>> +		err = handle_domain_nmi(gic_data.domain, irqnr, regs);
>> +		if (err)
>> +			gic_deactivate_unhandled(irqnr);
>> +	} else {
>> +		gic_write_eoir(irqnr);
>> +		if (static_branch_likely(&supports_deactivate_key))
>> +			gic_write_dir(irqnr);
>> +#ifdef CONFIG_SMP
>> +		handle_IPI(irqnr, regs);
>> +#else
>> +		WARN_ONCE(true, "Unexpected SGI received!\n");
>> +#endif
>> +	}
>> 
>>  	if (irqs_enabled)
>>  		nmi_exit();
> 
> If there is one thing I would like to avoid, it is to add more ugly
> hacks to the way we handle SGIs. There is very little reason why SGIs
> should be handled differently from all other interrupts. They have the
> same properties, and it is only because of the 32bit legacy that we 
> deal
> with them in such a cumbersome way. Nothing that we cannot fix though.
> 
> What I would really like to see is first a conversion of the SGIs to
> normal, full fat interrupts. These interrupts can then be configured as
> NMI using the normal API.
> 
> I think Julien had something along these lines (or was that limited to
> the PMU?). Otherwise, I'll happily help you with that.

OK, to give you an idea of what I am after, here's a small series[1] 
that
can be used as a base (it has been booted exactly *once* on a model, and
is thus absolutely perfect ;-).

There is still a bit of work to be able to actually request a SGI (they
are hard-wired as chained interrupts so far, as this otherwise changes
the output of /proc/interrupts, among other things), but you will
hopefully see what I'm aiming for.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gic-sgi
-- 
Jazz is not dead. It just smells funny...
