Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D74C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850D72077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579511150;
	bh=hOGKfcLdv9OKkNbqFbJrj6fJFh85PVPo/RJsKujWiAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lQ/0Ic18O23Xa5743JehEBfjieHFb3mUBflX2V+phh/py9rRIPrc9HCMADXSkzHb5
	 JwAlhPyCYQrWUB2pNcTe8PaTZoOZRD1RSZmCPXMPSxwboPxO03TSBMFDYkRqrsV4M4
	 DdJ2K8uZP8WDHehSccsAUmP0zZIDMEy3Dy8Eyaqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgATJFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgATJFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:05:49 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E862073D;
        Mon, 20 Jan 2020 09:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579511148;
        bh=hOGKfcLdv9OKkNbqFbJrj6fJFh85PVPo/RJsKujWiAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KbYBd1i7M1f6Yi0KbjFcHi7YS7/6lzCyR+2JxRRHfgmnMVia5eOQJ2GGnK/JBx0LP
         3gAE456ROqcf1XhKUVbR3cd/UJCKZIDyOj8x5UaTUH1Kpmdulkkbwe6veIF9ydwboF
         S+sYd70GT8p0L9wX4178FSqtf7Fn62N4DhyxDuRc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1itT0E-000DbN-Tx; Mon, 20 Jan 2020 09:05:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jan 2020 10:05:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/4] irqchip/meson-gpio: Add support for Meson-A1 SoC
In-Reply-To: <20191216123645.10099-1-qianggui.song@amlogic.com>
References: <20191216123645.10099-1-qianggui.song@amlogic.com>
Message-ID: <8e78c2728bec3601cb9a6615a7f5b103@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qianggui.song@amlogic.com, tglx@linutronix.de, jason@lakedaemon.net, khilman@baylibre.com, narmstrong@baylibre.com, jbrunet@baylibre.com, jianxin.pan@amlogic.com, xingyu.chen@amlogic.com, hanjie.lin@amlogic.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 13:36, Qianggui Song wrote:
> This patchset adds support for GPIO interrupt controller of Meson-A1 
> SoC
> which use new register layout, two main things are done in the patchset
> 1. rework current driver
> 2. add a1 support
> 
> changes since v1 at [0]
>  - place initial macro after the definition of param structure
>  - make common data as parameter of initial macro
>  - add dummy init function for previous chips
> 
> [0]https://lore.kernel.org/linux-amlogic/20191206121714.14579-1-qianggui.song@amlogic.com
> 
> Qianggui Song (4):
>   dt-bindings: interrupt-controller: New binding for Meson-A1 SoCs
>   irqchip/meson-gpio: rework meson irqchip driver to support meson-A1
>     SoCs
>   irqchip/meson-gpio: Add support for meson a1 SoCs
>   arm64: dts: meson: a1: add gpio interrupt controller support
> 
>  .../amlogic,meson-gpio-intc.txt               |   1 +
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   9 ++
>  drivers/irqchip/irq-meson-gpio.c              | 137 ++++++++++++++----
>  3 files changed, 122 insertions(+), 25 deletions(-)

I've queued the first 3 patches. The last one can go taken via arm-soc.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
