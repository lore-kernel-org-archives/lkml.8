Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 13:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482182078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 13:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgEAJmXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHVNRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 09:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgHVNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 09:17:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EC1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 06:17:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g6so93909pjl.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uvSBHWeP6GEaswZL6yzDoYivAMYOOsA1ly+Tj65rYYY=;
        b=CgEAJmXJoAaa21ok3qK45ifn1N3OO5xyOxP8uOCth76qK95hh7O6T3U6NNt8sgRW/l
         y5O28MwukNJvBDEbfqHr+e4Y4b848of6dpD3g/SjED5ypsou4MsUfCyEEGJMSBiLGEvv
         P1qjWBylcXMNht1OYekpnKO2j3QrdmlZNqNfKCYeETelZohRERd9qy7qhHR4PieF7qm/
         UCABdjqWJ5P3EFtGl+auwiJTbuaLm3KkJzYA4bjUVpzDAxZYdx8FTWEBBNHPRm99ZOj9
         rhYPgebhNpPeoqVY8EVqG7iXvZO2Ug4sXx7ytxNMqC2WmEppeP++PggLcODkhl4KoF+j
         rm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uvSBHWeP6GEaswZL6yzDoYivAMYOOsA1ly+Tj65rYYY=;
        b=pYNx13iGVZ2bpLjYFiOP1KslOPVHmIq86cr1CGZchoCwweCN5qYunt024HVNJKCMF3
         320o3HPdO47lfRMTC3dkfLWFXyt+dpD+sZtQKE4upWThXF1z+csDRw4HwjzIUbUGfoki
         sVvcDOB43Xk/obuM/7BzNPo/0Sx2nH4xJeAh7KeXAuQ3hqa/3s5/EcmGumtxW5grKq8R
         oEDdlbzb1zjSIZffkjHB7Dczn7q/ASe7+Ea2nPLCaPRVEqEaC5+4X42a4dTxSgeEVTs3
         HmxnLq4U+3ryU6Q1Pb996mxgW8h85N5FCKCcYOBDkmDjY1ni7+mD/n/AFwRIK7T7JITk
         uyFA==
X-Gm-Message-State: AOAM531eZSHANxKuOVwX+Bui5lzrS+C/RKrIUgLTwE72CJgSEFfqhmd4
        xgDQp78xy3W5k+PhivBUeQt7
X-Google-Smtp-Source: ABdhPJwOsJeYk9LimzE2AZ60+CzIaTmvSKan9nOgwRtOiiLzpEkTuKvaoO/bku3P7PmyV3WaS5680w==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr2394152plt.163.1598102242150;
        Sat, 22 Aug 2020 06:17:22 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d94:5e90:8021:8773:d646:5b0b])
        by smtp.gmail.com with ESMTPSA id q6sm4482757pjr.20.2020.08.22.06.17.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 06:17:21 -0700 (PDT)
Date:   Sat, 22 Aug 2020 18:47:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 0/3] Add Actions Semi Owl family sirq support
Message-ID: <20200822131712.GB5954@Mani-XPS-13-9360>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristi,

On Wed, Aug 19, 2020 at 07:37:55PM +0300, Cristian Ciocaltea wrote:
> This patch series adds support for the external interrupt controller
> (SIRQ) found in the Actions Semi Owl family of SoC's (S500, S700 and
> S900). The controller handles up to 3 external interrupt lines through
> dedicated SIRQ pins.
> 
> This is a rework of the patch series submitted some time ago by 
> Parthiban Nallathambi: 
> https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> 

You need to preserve the authorship while reposting the patches. If you'd
like to take the authorship intentionally then please explain the reason in
cover letter.

Thanks,
Mani

> Please note I have dropped, for the moment, the S700 related patches 
> since I do not own a compatible hardware for testing. I'm using instead
> an S500 SoC based board for which I have already provided the initial
> support:
> https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/
> 
> The SIRQ controller support is a prerequisite of the soon to be submitted
> MFD driver for the Actions Semi ATC260x PMICs.
> 
> Thanks and regards,
> Cristi
> 
> Changes in v5:
> - Integrated Marc's review (more details in the driver patch changelog)
> - Rebased patch series on v5.9-rc1
> 
> Changes in v4:
> - Simplified the DTS structure:
>   * dropped 'actions,sirq-shared-reg' node, now the differentiation
>     between SoC variants is handled now via the compatible property
>   * dropped 'actions,sirq-reg-offset', now controller base address in
>     DTS points to SIRQ0 register, so no additional information is
>     required for S500 and S700, while for S900 SoC the offsets of SIRQ1
>     and SIRQ2 regs are provided by the driver
>   * 'actions,ext-irq-range' was replaced with 'actions,ext-interrupts',
>     an array of the GIC interrupts triggered by the controller
> - Fixed wrong INTC_EXTCTL_TYPE_MASK definition
> - Removed redundant irq_fwspec checks in owl_sirq_domain_alloc()
> - Improved error handling in owl_sirq_of_init()
> - Added yaml binding document
> - Dropped S700 related DTS patches for lack of testing hardware:
>   * arm64: dts: actions: Add sirq node for Actions Semi S700
>   * arm64: dts: actions: s700-cubieboard7: Enable SIRQ
> - Updated MAINTAINERS
> - Rebased patchset on kernel v5.8
> - Cosmetic changes
>  * Ordered include statements alphabetically
>  * Added comment to owl_sirq_set_type() describing conversion of falling
>    edge or active low signals
>  * Replaced IRQF_TRIGGER_* with corresponding IRQ_TYPE_* variants
>  * Ensured data types and function naming are consistent regarding the
>    'owl_sirq' prefix
> 
> Changes in v3 (Parthiban Nallathambi):
> - Set default operating frequency to 24MHz
> - Falling edge and Low Level interrupts translated to rising edge and high level
> - Introduced common function with lock handling for register read and write
> - Used direct GIC interrupt number for interrupt local hwirq and finding offset
> using DT entry (range) when registers are shared 
> - Changed irq_ack to irq_eoi
> - Added translation method for irq_domain_ops
> - Clearing interrupt pending based on bitmask for edge triggered
> - Added pinctrl definition for sirq for cubieboard7. This depends on,
> https://lore.kernel.org/patchwork/patch/1012859/
> 
> Changes in v2 (Parthiban Nallathambi):
> - Added SIRQ as hierarchical chip
>         GIC <----> SIRQ <----> External interrupt controller/Child devices
> - Device binding updates with vendor prefix
> - Register sharing handled globally and common init sequence/data for all
> actions SoC family
> 
> Cristian Ciocaltea (3):
>   dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
>   irqchip: Add Actions Semi Owl SIRQ controller
>   MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
> 
>  .../actions,owl-sirq.yaml                     |  68 ++++
>  MAINTAINERS                                   |   2 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-owl-sirq.c                | 347 ++++++++++++++++++
>  4 files changed, 418 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
>  create mode 100644 drivers/irqchip/irq-owl-sirq.c
> 
> -- 
> 2.28.0
> 
