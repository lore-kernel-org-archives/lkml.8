Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1207C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8999C20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhaizvQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgHYJot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgHYJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:44:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA15C061574;
        Tue, 25 Aug 2020 02:44:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so15015631ejz.0;
        Tue, 25 Aug 2020 02:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bljd0yPvSj4Etp/mV+MrXhuFTS72Nc35Iw9MpmGupuc=;
        b=lhaizvQaToivtMGPmcZUwsjkzRNT6IOKm9HmLgMO2UBuZ570bHz9c9n1mKG4N6iz3S
         eClZ/hqmaAsHXGesSEIGdR5TGVvpi9nTqi6WRa2m6tIYJsyFIloGXuWmWWQt8C4gGcAu
         58jvOZTsjQ1C4KhnTjJPZXP5+Xb+1NK6UOJnJpjT90yV+OocQg/CH/3Vtm58hInXBjc/
         8SoI+1HwVcMQQjaRWGCLOoHXClZycFzWerrCuytFBZIods6pSOGJ/UuqM5IOyKBz9zCg
         6sFrmLL8z4jtpEn1zsol0XQuBSSE0V5GRAeTSjamW3KTIjxjIdFlubQoLZturucKwaAC
         qLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bljd0yPvSj4Etp/mV+MrXhuFTS72Nc35Iw9MpmGupuc=;
        b=uRhnmrwB2kV1AI4wFQ4JD/7Wk6pn2gG0OQDzYruax5+z0HQOPlUcQhaXTwBmD7OLgG
         MXTbs66s7TaXv3UVlO8pQI72t0V45owH9XuCFpwo0UY34C8Gjju7EAm7Om+WWH9pX4Kl
         FHgey/N3ILKoBU0XykycMlJ7Uxi53UF70HxAYC7Xd3GmLN09qm6Cj3r2I4plghUoz6wN
         zx+pHHwc6HIRSxKlIwaRiLJvui1Ko+k1Xe19bU3kb0+ocX0w1sJ9dAAYTyGvhOsQXEIA
         MXVZ6EgLzhjYc+BzjzzaI2fu4T0qH/zx67m7lsXdMJomqAH+SrQujXLz5XXbhmJ8pC9o
         Szgg==
X-Gm-Message-State: AOAM530SzrOt18OTWpZEjtfLMLh4+i6ZPi4yf1mVZkD+aN2n1vpJYos1
        Lu31iRcVQl62gWcPUWjPic8=
X-Google-Smtp-Source: ABdhPJwzE3plJD2kybLZ+eU7eXytGQkBOnRehNCxFVOi7Js+/GMh8zHfdXmTsjGkqaRtAd3c1F69Sw==
X-Received: by 2002:a17:906:52d9:: with SMTP id w25mr9345118ejn.491.1598348687207;
        Tue, 25 Aug 2020 02:44:47 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id gy26sm12944772ejb.71.2020.08.25.02.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 02:44:46 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:44:44 +0300
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
Message-ID: <20200825094444.GA2311453@BV030612LT>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <20200822131712.GB5954@Mani-XPS-13-9360>
 <20200822230513.GA2260050@BV030612LT>
 <48A6F999-D0A4-4E45-987F-0818E7FEA153@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48A6F999-D0A4-4E45-987F-0818E7FEA153@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 07:39:32AM +0530, Manivannan Sadhasivam wrote:
> 
> 
> On 23 August 2020 4:35:13 AM IST, Cristian Ciocaltea <cristian.ciocaltea@gmail.com> wrote:
> >Hi Mani,
> >
> >On Sat, Aug 22, 2020 at 06:47:12PM +0530, Manivannan Sadhasivam wrote:
> >> Hi Cristi,
> >> 
> >> On Wed, Aug 19, 2020 at 07:37:55PM +0300, Cristian Ciocaltea wrote:
> >> > This patch series adds support for the external interrupt
> >controller
> >> > (SIRQ) found in the Actions Semi Owl family of SoC's (S500, S700
> >and
> >> > S900). The controller handles up to 3 external interrupt lines
> >through
> >> > dedicated SIRQ pins.
> >> > 
> >> > This is a rework of the patch series submitted some time ago by 
> >> > Parthiban Nallathambi: 
> >> > https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> >> > 
> >> 
> >> You need to preserve the authorship while reposting the patches. If
> >you'd
> >> like to take the authorship intentionally then please explain the
> >reason in
> >> cover letter.
> >> 
> >> Thanks,
> >> Mani
> >
> >Thanks for pointing this out, I was not aware of the procedure - this
> >is
> >actually my very first repost. Could you please indicate how should I
> >proceed to fix this? I had absolutely no intention to take the
> >authorship..
> >
> 
> Below command would change the author of last commit:
> 
> git commit --amend --author="Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>"

Got it now, for some reason I have lost original author information in
my local repository - I'll pay more attention to this next time.
I will submit the fix after receiving Rob's review for the binding doc,
if that would be ok.

Thanks,
Cristi

> >Sorry for the mistake,
> 
> No issues! 
> 
> Thanks, 
> Mani
> 
> >Cristi
> >
> >> > Please note I have dropped, for the moment, the S700 related
> >patches 
> >> > since I do not own a compatible hardware for testing. I'm using
> >instead
> >> > an S500 SoC based board for which I have already provided the
> >initial
> >> > support:
> >> >
> >https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/
> >> > 
> >> > The SIRQ controller support is a prerequisite of the soon to be
> >submitted
> >> > MFD driver for the Actions Semi ATC260x PMICs.
> >> > 
> >> > Thanks and regards,
> >> > Cristi
> >> > 
> >> > Changes in v5:
> >> > - Integrated Marc's review (more details in the driver patch
> >changelog)
> >> > - Rebased patch series on v5.9-rc1
> >> > 
> >> > Changes in v4:
> >> > - Simplified the DTS structure:
> >> >   * dropped 'actions,sirq-shared-reg' node, now the differentiation
> >> >     between SoC variants is handled now via the compatible property
> >> >   * dropped 'actions,sirq-reg-offset', now controller base address
> >in
> >> >     DTS points to SIRQ0 register, so no additional information is
> >> >     required for S500 and S700, while for S900 SoC the offsets of
> >SIRQ1
> >> >     and SIRQ2 regs are provided by the driver
> >> >   * 'actions,ext-irq-range' was replaced with
> >'actions,ext-interrupts',
> >> >     an array of the GIC interrupts triggered by the controller
> >> > - Fixed wrong INTC_EXTCTL_TYPE_MASK definition
> >> > - Removed redundant irq_fwspec checks in owl_sirq_domain_alloc()
> >> > - Improved error handling in owl_sirq_of_init()
> >> > - Added yaml binding document
> >> > - Dropped S700 related DTS patches for lack of testing hardware:
> >> >   * arm64: dts: actions: Add sirq node for Actions Semi S700
> >> >   * arm64: dts: actions: s700-cubieboard7: Enable SIRQ
> >> > - Updated MAINTAINERS
> >> > - Rebased patchset on kernel v5.8
> >> > - Cosmetic changes
> >> >  * Ordered include statements alphabetically
> >> >  * Added comment to owl_sirq_set_type() describing conversion of
> >falling
> >> >    edge or active low signals
> >> >  * Replaced IRQF_TRIGGER_* with corresponding IRQ_TYPE_* variants
> >> >  * Ensured data types and function naming are consistent regarding
> >the
> >> >    'owl_sirq' prefix
> >> > 
> >> > Changes in v3 (Parthiban Nallathambi):
> >> > - Set default operating frequency to 24MHz
> >> > - Falling edge and Low Level interrupts translated to rising edge
> >and high level
> >> > - Introduced common function with lock handling for register read
> >and write
> >> > - Used direct GIC interrupt number for interrupt local hwirq and
> >finding offset
> >> > using DT entry (range) when registers are shared 
> >> > - Changed irq_ack to irq_eoi
> >> > - Added translation method for irq_domain_ops
> >> > - Clearing interrupt pending based on bitmask for edge triggered
> >> > - Added pinctrl definition for sirq for cubieboard7. This depends
> >on,
> >> > https://lore.kernel.org/patchwork/patch/1012859/
> >> > 
> >> > Changes in v2 (Parthiban Nallathambi):
> >> > - Added SIRQ as hierarchical chip
> >> >         GIC <----> SIRQ <----> External interrupt controller/Child
> >devices
> >> > - Device binding updates with vendor prefix
> >> > - Register sharing handled globally and common init sequence/data
> >for all
> >> > actions SoC family
> >> > 
> >> > Cristian Ciocaltea (3):
> >> >   dt-bindings: interrupt-controller: Add Actions SIRQ controller
> >binding
> >> >   irqchip: Add Actions Semi Owl SIRQ controller
> >> >   MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
> >> > 
> >> >  .../actions,owl-sirq.yaml                     |  68 ++++
> >> >  MAINTAINERS                                   |   2 +
> >> >  drivers/irqchip/Makefile                      |   1 +
> >> >  drivers/irqchip/irq-owl-sirq.c                | 347
> >++++++++++++++++++
> >> >  4 files changed, 418 insertions(+)
> >> >  create mode 100644
> >Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> >> >  create mode 100644 drivers/irqchip/irq-owl-sirq.c
> >> > 
> >> > -- 
> >> > 2.28.0
> >> > 
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
