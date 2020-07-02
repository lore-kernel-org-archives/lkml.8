Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67722C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354052088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593697080;
	bh=hduG8RcoB6Y0lE+3g7jHFto84R1rHz9MylAR+LshBOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YZR1cj5GmszcP/8t8n4kQlenPHJLDamtxD6Wmvi944AO2zKsL95VnLztALrw8EpYM
	 5bGOcsig20463WMYgp08Zu68yijt+2LSnrU/bF9r9Gobdh/OxHdqyU+ImlWwIYX3mP
	 PuZPJWnfWV2oknDzRkYXsrm2NJ04CFmFxFEKWclc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgGBNh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgGBNh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:37:58 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241AB207CD;
        Thu,  2 Jul 2020 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593697078;
        bh=hduG8RcoB6Y0lE+3g7jHFto84R1rHz9MylAR+LshBOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zgOjKcUtHepkmiGPnnMypO3ZHYmIPQwOSjfm2PlTGeeBxzYdF06w0SutUeXmu87aB
         LNh8CcC9Yy/K94gU0rOqthG9sGlweSt6OvULqUmhJXQMYow3JnlkPcSiYTjgrTOUTC
         engaWLbImiQRSPFea/6wJBYoWUqhREYrcQpe3ryY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqzPY-008Px1-NH; Thu, 02 Jul 2020 14:37:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 14:37:56 +0100
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
Subject: Re: [PATCH v2 14/17] arm64: Kill __smp_cross_call and co
In-Reply-To: <jhjh7uzgfyj.mognet@arm.com>
References: <20200624195811.435857-1-maz@kernel.org>
 <20200624195811.435857-15-maz@kernel.org> <jhjh7uzgfyj.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <b43910de5fa3bedbea69e1ca9a682a15@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 19:25, Valentin Schneider wrote:
> On 24/06/20 20:58, Marc Zyngier wrote:
>> @@ -852,8 +841,7 @@ void arch_send_wakeup_ipi_mask(const struct 
>> cpumask *mask)
>>  #ifdef CONFIG_IRQ_WORK
>>  void arch_irq_work_raise(void)
>>  {
>> -	if (__smp_cross_call)
>> -		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
>> +	smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
> 
> AIU the following commit:
> 
>   eb631bb5bf5b ("arm64: Support arch_irq_work_raise() via self IPIs")
> 
> It seems arm64 hasn't needed that check since
> 
>   4b3dc9679cf7 ("arm64: force CONFIG_SMP=y and remove redundant 
> #ifdefs")
> 
> Did I get that right?

Indeed. SMP implies being able to IPI, and thus the check has been
irrelevant for some time now.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
