Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47477C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221712088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593697718;
	bh=tMT/0/rWJ4mOlBloPAfcxWTRK0Bw2NaOowE/acDSAtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WBbvnU4pZC4svmLOLzfqlTv4c68ayKlKqQmCDN+hecsN7u+Cc5kd4i3X5utkJTRYf
	 w6C+xEIxCE9Ne/Q1XZ6zJHSD1umY3Hu9zbeL3h7y3LQeNP7xTbVvlK2kd++onCOFJI
	 mupFl3QxMIhkpwD08ggEFpb3xpzJ0OG6ijHcG2H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgGBNsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgGBNsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:48:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90487207D4;
        Thu,  2 Jul 2020 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593697715;
        bh=tMT/0/rWJ4mOlBloPAfcxWTRK0Bw2NaOowE/acDSAtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ay2vfvlwROBwHeQy4Mn+6qoiF4tF9B477V1+7ICkTcE41dA8y22/vIFebFAuJ1JsE
         aq/MC52NhMc0fcocodpQAqzef8EKOe7hIQFNdvUfXPNqHw+I5/KevedfJlGWps6FZd
         5vVID4duEyxGbCWCdjqh9y8FkabfAig4OEMN5DYk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqzZq-008Q8V-5U; Thu, 02 Jul 2020 14:48:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 14:48:34 +0100
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
Subject: Re: [PATCH v2 06/17] irqchip/gic-v3: Configure SGIs as standard
 interrupts
In-Reply-To: <jhjmu4i830n.mognet@arm.com>
References: <20200624195811.435857-1-maz@kernel.org>
 <20200624195811.435857-7-maz@kernel.org> <jhjimffgfyt.mognet@arm.com>
 <f9502c41d941e56ffcc30c51f2d23ab9@kernel.org> <jhjmu4i830n.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <1f3ac757acd15f6804917e222194c9cf@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02 14:23, Valentin Schneider wrote:
> On 30/06/20 11:15, Marc Zyngier wrote:
>> On 2020-06-25 19:25, Valentin Schneider wrote:
>>> Also, while staring at this it dawned on me that IPI's don't need the
>>> eoimode=0 isb(): due to how the IPI flow-handler is structured, we'll
>>> get a
>>> gic_eoi_irq() just before calling into the irqaction. Dunno how much 
>>> we
>>> care about it.
>> 
>> That's interesting. This ISB is a leftover from the loop we had before
>> the pseudo-NMI code, where we had to make sure the write to EOIR was
>> ordered with the read from IAR.
>> 
>> Given that we have an exception return right after the interrupt
>> handling, I *think* we could get rid of it (but that would need
>> mode checking on broken systems such as TX1...).  I don't think
>> this is specific to IPIs though.
>> 
> 
> If I got this one right:
> 
>   39a06b67c2c1 ("irqchip/gic: Ensure we have an ISB between ack and
> ->handle_irq")
> 
> you're describing case 2, which is indeed gone on gic-v3. However IIUC 
> we
> also want an ISB between poking IAR and calling into the irqaction 
> (case 1)
> - we get just that with IPIs due to the early gic_eoi_irq(), but we 
> don't
> for the other flows.

You just made me realise something amazing: I've started to forget about
all this crap. Which is wonderful! ;-)

More seriously, you are absolutely right. If we wanted to address this,
we'd probably have to give IPIs their own irqchip so that they get their
own eoi callback. Not sure that's worth it.

         M.
-- 
Jazz is not dead. It just smells funny...
