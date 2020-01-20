Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8143BC33CBA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B4D207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579510445;
	bh=7658EiAaUp7PZdEgintuX/ZlhBgoO6/vEgyIccALm9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ebj0vFU1hct03SEObBi1AB4bgxz++pCVxRGMdQtFHtzfs6uWJKoLzu5MVjv4szMnP
	 oK/QmT3v8OQb4e8f0y7PEBReVq8fctMUwUeium8Yasw/Coe5Qup1vWoa43Lv/PYMgH
	 RESEPaAOOVKHnFJAFmCVM0DStBQH+zlkurU0Pfqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATIyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgATIyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:54:04 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ADD22077C;
        Mon, 20 Jan 2020 08:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579510443;
        bh=7658EiAaUp7PZdEgintuX/ZlhBgoO6/vEgyIccALm9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iqssyyfSMZovWsn4zGGw2eWcWEy4oBVZI40yYEm6haUwX+7L+0ERyopt5aoWZjpiV
         aL2fAboolvdnOIv7YES1actzjAuNStq7dJxxynuGZJvYD5/gEhE/qIdeKCp5xi1KxL
         O3L4u76IVni+YXqLngVLArqY7RYXyTcqfQQ/OojY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1itSor-000DOa-Jh; Mon, 20 Jan 2020 08:54:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jan 2020 09:54:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        jason@lakedaemon.net, robh+dt@kernel.org, tglx@linutronix.de,
        joel@jms.id.au, andrew@aj.id.au
Subject: Re: [PATCH v6 00/12] aspeed: Add SCU interrupt controller and XDMA
 engine drivers
In-Reply-To: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1c0315d197ae5b8b01ea5beaaf32fa21@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eajames@linux.ibm.com, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, jason@lakedaemon.net, robh+dt@kernel.org, tglx@linutronix.de, joel@jms.id.au, andrew@aj.id.au
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-15 22:29, Eddie James wrote:
> This series first adds a driver to control the interrupt controller 
> provided by
> the System Control Unit (SCU) on the AST2500 and AST2600 SOCs. The 
> interrupts
> made available are necessary for the control of the XDMA engine 
> embedded in the
> same Aspeed SOCs.
> This series then adds a driver to control the XDMA engine. This driver 
> was
> previously sent to the list without support for the AST2600, and has 
> been
> refactored significantly to enable that support. The XDMA engine 
> performs
> automatic DMA operations between the Aspeed SOC (acting as a BMC) and a 
> host
> processor.
> 
> Changes since v5:
>  - Rework the XDMA locking completely; thanks Andrew Jeffrey for the 
> help.
> 
> Changes since v4:
>  - Fix dts documentation example for XDMA
>  - Add errno in warning for SCU failure in XDMA PCIe config
>  - Add a check for in_reset before proceeding in O_NONBLOCK case
>  - Add comments to memory sizes in the witherspoon/tacoma XDMA dts 
> entries
> 
> Changes since v3:
>  - See individual patches; just clean-up items
> 
> Changes since v2:
>  - See individual patches
>  - Drop rainier dts patch
>  - In summary, remove references to VGA memory as the XDMA driver 
> doesn't care
>    where it is. Remove SDRAM controller reference. Move user reset
>    functionality to a separate patch and make it an ioctl.
> 
> Changes since v1:
>  - See individual patches
>  - In summary, first the irqchip driver switched to use the parent SCU 
> regmap
>    rather than iomapping it's register. Secondly, the XDMA 
> initialization
>    switched to use properties from the device tree rather than 
> dynamically
>    calculate memory spaces, and system config.
> 
> Eddie James (12):
>   dt-bindings: interrupt-controller: Add Aspeed SCU interrupt 
> controller
>   irqchip: Add Aspeed SCU interrupt controller

I've now queued these two patches in the irqchip tree.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
