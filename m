Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7592C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF2F20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592901473;
	bh=yuB+KVGGndng6N/bVAKpdP7MFMnd4b/Kd5HAj2ZqLtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZYBlVNkydqISEnblbvHswvTGARiYH+y4Fi8tYjEnceJPAV7PVApLplBu6ShmY4nK5
	 lpg4dBLgA+BViOIYxU9XRQ2capY1qbMuSKaRo34Mt5A2KLIM9VRFuGEzw3qzCLioHt
	 yP4MCSKnnH0pI1TWwqSlm4JWdjfP2vo20174ucTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgFWIhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731691AbgFWIhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:37:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36EE20707;
        Tue, 23 Jun 2020 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592901470;
        bh=yuB+KVGGndng6N/bVAKpdP7MFMnd4b/Kd5HAj2ZqLtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CegwgC/kWMW0h1xezI5IE4V1Iu37kgjI+vIsOiT347zB55uxZ6WNajUgpriNlS+96
         6Ozyv0/o+qEbu4PZ7+YKyhe4fHrMmq8WBdkzemn5ac+LTBxoyVNVMi+4Wfrzgy5z72
         hbY7hDA12+aPoiz3IsC5dpgjhb4yAB9fxb3GT4dw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jneRB-005clT-5m; Tue, 23 Jun 2020 09:37:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Jun 2020 09:37:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     CC Hwang <cc.hwang@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>, wsd_upstream@mediatek.com,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, saravanak@google.com
Subject: Re: [PATCH 1/1] irqchip: Add config MTK_SYSIRQ and MTK_CIRQ
In-Reply-To: <1592894173.10773.42.camel@mtkswgap22>
References: <1592483471-14806-1-git-send-email-hanks.chen@mediatek.com>
 <f47e8a1e70c982ecf6245db573630f51@kernel.org>
 <1592490123.10773.16.camel@mtkswgap22>
 <1592894173.10773.42.camel@mtkswgap22>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <3dc953265ed4cd4300bd9600bf7e33d6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: hanks.chen@mediatek.com, cc.hwang@mediatek.com, jason@lakedaemon.net, wsd_upstream@mediatek.com, loda.chou@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, saravanak@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Saravana

On 2020-06-23 07:36, Hanks Chen wrote:

[...]

> Hi Marc,
> 
> I want to break the dependency between ARCH_MEDIATEK and CIRQ/SYSIRQ,
> because we need to follow the GKI.

This isn't what GKI mandates. GKI requires that the SoC code is compiled
as modules, not that it is dissociated from its platform (which would
be completely pointless).

> Could I add the MTK_CIRQ and MTK_SYSIRQ into defconfig?
> (arch/arm64/config/defconfig)

I don't deal with defconfig at all. That's a patch for the arm-soc 
people.

> 
> It would ensures all platform are executable.
> 
> e.g.
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> 
>  CONFIG_QCOM_PDC=y
> +CONFIG_MTK_SYSIRQ=m
> +CONFIG_MTK_CIRQ=y
>  CONFIG_RESET_QCOM_AOSS=y
> 
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -572,4 +572,18 @@ config LOONGSON_PCH_MSI
>         help
>           Support for the Loongson PCH MSI Controller.
> 
> +config MTK_SYSIRQ
> +       tristate "Mediatek interrupt polarity controller"
> +       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       help
> +         Interrupt polarity controller driver to swap polarity for
> +         interrupts for Mediatek mobile chips.
> +
> +config MTK_CIRQ
> +       bool "Mediatek low-power interrupt controller"
> +       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       help
> +         Low-power interrupt controller driver to monitor IRQS
> +         in the sleep mode for Mediatek mobile chips.
> +
> 
> 
> P.S I'll make the irq-mtk-sysirq driver as a loadable kernel module for
> GKI

You might as well turn both drivers into modules. Saravana was working
on a set of patches to ease this transition.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
