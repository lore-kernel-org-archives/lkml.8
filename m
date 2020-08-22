Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC81C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 23:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C1F206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 23:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY/TWFNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgHVXFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgHVXFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 19:05:19 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15AC061573;
        Sat, 22 Aug 2020 16:05:17 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so4975928eds.2;
        Sat, 22 Aug 2020 16:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Fpwogtsb8NGet/9oeWKnkv+ON3vD5cWlFlPhK4b0pk=;
        b=VY/TWFNJYwEBGSFmB855o1i9sz1IzgZKm3lUxnLXUie8J/srUwF+A0uaE3cPaylP+2
         qJ5XB6qMdiGbkgiapFi1+HzxVhrz8noLOVTykooRgf/xsUrvbAIoXLyeb759/eNmJgci
         agVVK1j5RR/60xocQJyUU+m/RqtlI+cCUz1e7R2Z1No0lHA/HKLxr/Y4/nlQ6+snV0T8
         FMer8eq3bYpIr0eQEgL97J/bswbGK4HUvf03Z31PomdqKBLlYU0f3OJ42mA2g7HQ8xX9
         DlS0AYYGQGDHRy7ageKAbX1+o3Wk7iGHnsmYjjAbqOPQsMU0jnO8/aOf+ptmgeN50nlJ
         Vxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Fpwogtsb8NGet/9oeWKnkv+ON3vD5cWlFlPhK4b0pk=;
        b=hkig9ci8OfTs9eaKLN1sfPUK52acDol85JW5Y9DNolqBhvd5KbtKzR6ivIr4RVq3kd
         FQ3EbPGnfBUW9XiCIIb/QRryzlmMjRhxtXtpFioV5b06awpkaaNNJMjaq8zLX/yOYDoe
         sNPQ2Dp37qI8GRLpWMt/MsR/RV0ryaYb8vT/umVYSu3BXPTxDz9q/aWptHsv6K76ZjyG
         8+mxMwLvT5zceZNkXCsVkpM33UXdHkeNwtSvKhOTR8AfmVi7u6or9RdjAJVsRt2C25Dx
         RWssz8QQLU3xYLhjWXsOv0P/90YJwMMuBStgGSdgEkilfwKDD8723VS+IqXlRuJr9Q1J
         LAtg==
X-Gm-Message-State: AOAM531YWv8kplfSX5zAG8IsAceB15dBdESSt/UfPbUrz0TGVwqAoGSI
        riWZdbc8gzBuwyRI/8PFmoc=
X-Google-Smtp-Source: ABdhPJzjZpBkLXFOtvZZoBfrQJVlw0sie6RZD0ECwJErzc05Hv0HcFVAw0DamE6gu+iZizm2xo0GAg==
X-Received: by 2002:a05:6402:168c:: with SMTP id a12mr3199388edv.275.1598137516401;
        Sat, 22 Aug 2020 16:05:16 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id z10sm4195099eje.122.2020.08.22.16.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 16:05:15 -0700 (PDT)
Date:   Sun, 23 Aug 2020 02:05:13 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 0/3] Add Actions Semi Owl family sirq support
Message-ID: <20200822230513.GA2260050@BV030612LT>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <20200822131712.GB5954@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822131712.GB5954@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On Sat, Aug 22, 2020 at 06:47:12PM +0530, Manivannan Sadhasivam wrote:
> Hi Cristi,
> 
> On Wed, Aug 19, 2020 at 07:37:55PM +0300, Cristian Ciocaltea wrote:
> > This patch series adds support for the external interrupt controller
> > (SIRQ) found in the Actions Semi Owl family of SoC's (S500, S700 and
> > S900). The controller handles up to 3 external interrupt lines through
> > dedicated SIRQ pins.
> > 
> > This is a rework of the patch series submitted some time ago by 
> > Parthiban Nallathambi: 
> > https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> > 
> 
> You need to preserve the authorship while reposting the patches. If you'd
> like to take the authorship intentionally then please explain the reason in
> cover letter.
> 
> Thanks,
> Mani

Thanks for pointing this out, I was not aware of the procedure - this is
actually my very first repost. Could you please indicate how should I
proceed to fix this? I had absolutely no intention to take the authorship..

Sorry for the mistake,
Cristi

> > Please note I have dropped, for the moment, the S700 related patches 
> > since I do not own a compatible hardware for testing. I'm using instead
> > an S500 SoC based board for which I have already provided the initial
> > support:
> > https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/
> > 
> > The SIRQ controller support is a prerequisite of the soon to be submitted
> > MFD driver for the Actions Semi ATC260x PMICs.
> > 
> > Thanks and regards,
> > Cristi
> > 
> > Changes in v5:
> > - Integrated Marc's review (more details in the driver patch changelog)
> > - Rebased patch series on v5.9-rc1
> > 
> > Changes in v4:
> > - Simplified the DTS structure:
> >   * dropped 'actions,sirq-shared-reg' node, now the differentiation
> >     between SoC variants is handled now via the compatible property
> >   * dropped 'actions,sirq-reg-offset', now controller base address in
> >     DTS points to SIRQ0 register, so no additional information is
> >     required for S500 and S700, while for S900 SoC the offsets of SIRQ1
> >     and SIRQ2 regs are provided by the driver
> >   * 'actions,ext-irq-range' was replaced with 'actions,ext-interrupts',
> >     an array of the GIC interrupts triggered by the controller
> > - Fixed wrong INTC_EXTCTL_TYPE_MASK definition
> > - Removed redundant irq_fwspec checks in owl_sirq_domain_alloc()
> > - Improved error handling in owl_sirq_of_init()
> > - Added yaml binding document
> > - Dropped S700 related DTS patches for lack of testing hardware:
> >   * arm64: dts: actions: Add sirq node for Actions Semi S700
> >   * arm64: dts: actions: s700-cubieboard7: Enable SIRQ
> > - Updated MAINTAINERS
> > - Rebased patchset on kernel v5.8
> > - Cosmetic changes
> >  * Ordered include statements alphabetically
> >  * Added comment to owl_sirq_set_type() describing conversion of falling
> >    edge or active low signals
> >  * Replaced IRQF_TRIGGER_* with corresponding IRQ_TYPE_* variants
> >  * Ensured data types and function naming are consistent regarding the
> >    'owl_sirq' prefix
> > 
> > Changes in v3 (Parthiban Nallathambi):
> > - Set default operating frequency to 24MHz
> > - Falling edge and Low Level interrupts translated to rising edge and high level
> > - Introduced common function with lock handling for register read and write
> > - Used direct GIC interrupt number for interrupt local hwirq and finding offset
> > using DT entry (range) when registers are shared 
> > - Changed irq_ack to irq_eoi
> > - Added translation method for irq_domain_ops
> > - Clearing interrupt pending based on bitmask for edge triggered
> > - Added pinctrl definition for sirq for cubieboard7. This depends on,
> > https://lore.kernel.org/patchwork/patch/1012859/
> > 
> > Changes in v2 (Parthiban Nallathambi):
> > - Added SIRQ as hierarchical chip
> >         GIC <----> SIRQ <----> External interrupt controller/Child devices
> > - Device binding updates with vendor prefix
> > - Register sharing handled globally and common init sequence/data for all
> > actions SoC family
> > 
> > Cristian Ciocaltea (3):
> >   dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
> >   irqchip: Add Actions Semi Owl SIRQ controller
> >   MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
> > 
> >  .../actions,owl-sirq.yaml                     |  68 ++++
> >  MAINTAINERS                                   |   2 +
> >  drivers/irqchip/Makefile                      |   1 +
> >  drivers/irqchip/irq-owl-sirq.c                | 347 ++++++++++++++++++
> >  4 files changed, 418 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> >  create mode 100644 drivers/irqchip/irq-owl-sirq.c
> > 
> > -- 
> > 2.28.0
> > 
