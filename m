Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C254FC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AF62072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584607502;
	bh=nsLp4Rn/WbNgg5c0efrndSO2d36JwaT+wQJoqmu5/SA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AJC6pvNy5vPOPU+JxebyF6AGVc97tAb6eGAQUmRkayrBRtE4O7iNg8FCAlB7/RZJS
	 iGQUQbRRqaKzyujsgnhe+sRUsJZS1ZlSfETH2ofzDa2Z0jwYcToqwMvXHSD8SQpfod
	 QR8Alr+LMgyCg2D985xDFYH/V7SNnB4uStpaZDTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCSIpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgCSIpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:45:01 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F9120724;
        Thu, 19 Mar 2020 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584607500;
        bh=nsLp4Rn/WbNgg5c0efrndSO2d36JwaT+wQJoqmu5/SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rf6u2PFmQqWvwY1WKpZe255t6/NQBguN0WrcCWUMycs3Keq2eiQSpMPlRJ9m4wGPW
         D9gF1iZzqBJ9KxJhaOg3VrMZxn58ybEA/Cq8b+OX/He/2rZLpAfZrQWm+Co8RbTj+6
         QHy5OK5sHF9g1b0Fp66Nsw3p+Qi+iWNLXSMYaxO8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jEqnS-00Dsyj-Cb; Thu, 19 Mar 2020 08:44:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Mar 2020 08:44:58 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-oxnas@groups.io, Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] irqchip/versatile-fpga: Handle chained IRQs properly
In-Reply-To: <20200319023448.1479701-1-mans0n@gorani.run>
References: <002b72cab9896fa5ac76a52e0cb503ff@kernel.org>
 <20200319023448.1479701-1-mans0n@gorani.run>
Message-ID: <f0a4acfaf5da72cbfc2670fcb5b71fc6@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mans0n@gorani.run, linus.walleij@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, narmstrong@baylibre.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-19 02:34, Sungbo Eo wrote:
> Enclose the chained handler with chained_irq_{enter,exit}(), so that 
> the
> muxed interrupts get properly acked.
> 
> This patch also fixes a reboot bug on OX820 SoC, where the jiffies 
> timer
> interrupt is never acked. The kernel waits a clock tick forever in
> calibrate_delay_converge(), which leads to a boot hang.
> 
> Fixes: c41b16f8c9d9 ("ARM: integrator/versatile: consolidate FPGA IRQ
> handling code")
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> ---
> v2: moved readl below chained_irq_enter()
>     added Fixes tag
> 
>  drivers/irqchip/irq-versatile-fpga.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Queued for 5.7.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
