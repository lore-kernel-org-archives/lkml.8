Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C73C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2081120782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfAZokO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGCRVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGCRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:21:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB13BC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:21:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so32705677wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8ete6I4ixSjbonl8sGfOuxL0bZF6e3pE/Fs8ioQCGKQ=;
        b=mfAZokO+WjGIsaCnXXptSbe05uvi4l7PSLIxYAaKNw444xSdOO4zv8QucMewmHfitM
         5wtOXBgXg8fP6E3JyQpl0HAr/fpB4sDFRKlFPefdk9+fczavZ4UjuXpLp/YicK4Rcr3U
         TFqIhhRhx4yRK5PU6DBK9SZSfTLEwLBDt7i/4T0rHDzniT/pmRbJoTmH0njqmkoF/1fg
         1PEyklputJfe5lw27QjiN7iIRVBhd1t6HO1xZxtMWugVAXqAALUNQIZZjwVkSVpE9TtJ
         w9UwaCMAYOd4oQR6x2l5T+DQqjUMgOCxsBSLifHex5Lfl2Tpa9vLAtwfG7WYAS8/yBuf
         3OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8ete6I4ixSjbonl8sGfOuxL0bZF6e3pE/Fs8ioQCGKQ=;
        b=k2Ze/FyU2hZjYkBUp7AC46hWwKBc2gGGtH7TmMrKzOVz/nsSCnMVrtlCmR98RCb37I
         BP62TKbRg69jzMekCG1zZ6vj6M2LCpUj8vg+XEMsB0uRMlrNAORfinO62Q6qofXrkbQe
         05MOr/6Emjlt9Yn4vnliVLCxErO4y2clGlfwh8epuuaJkRnfdEKqrUfVA+BCxvTJGGV6
         2m1mX15anCjbm00BNTq1qqXOJ02W8MmS2wAGveFMNQZQ12wGujssrnjMqRZOtOaB/fCD
         xOckasRV/260ktyOhuvrdZB9B+sSMyTDKLJon8Qc36aT3MhBQHXG2Zb3typnI6XiGmX9
         dHng==
X-Gm-Message-State: AOAM531EeNpdrvTjT9sOVaWcUk3QzIT6eOnG4s0Vkk62UZ1k5Kmi5fTM
        A9zF4dzpdMqA/HcMVH1ArZDstw==
X-Google-Smtp-Source: ABdhPJwgqFiZK7yvPBmX2Ha7Poc2II8t97vwg4ExlUBs3GokKuV9Cz8COt1NQZk47tn4YMKaSWa/0A==
X-Received: by 2002:a1c:80c8:: with SMTP id b191mr35735658wmd.37.1593796911630;
        Fri, 03 Jul 2020 10:21:51 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm14464840wrq.13.2020.07.03.10.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:21:50 -0700 (PDT)
Date:   Fri, 3 Jul 2020 18:21:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 00/30] Fix a bunch of W=1 issues in USB
Message-ID: <20200703172148.GD2743379@dell>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200703073725.GA2370189@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200703073725.GA2370189@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020, Greg KH wrote:

> On Thu, Jul 02, 2020 at 03:45:55PM +0100, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > Lee Jones (30):
> >   usb: phy: phy: Fix-up a whole bunch of formatting issues
> >   usb: host: pci-quirks: Demote function header from kerneldoc to
> >     comment block
> >   usb: common: debug: Demote comment blocks which are obviously not
> >     kerneldoc
> >   usb: common: usb-conn-gpio: Demote comment block which is clearly not
> >     kerneldoc
> >   usb: dwc3: drd: File headers are not doc headers
> >   usb: dwc3: ulpi: File headers are not doc headers
> >   usb: common: ulpi: Fix a few kerneldoc related issues
> >   usb: dwc3: dwc3-omap: Do not read DMA status
> >   usb: dwc2: gadget: Do not read GINTMSK2
> >   usb: dwc2: gadget: Remove assigned but never used 'maxsize'
> >   usb: dwc2: gadget: Avoid pointless read of EP control register
> >   usb: host: ehci-omap: Provide documentation for
> >     ehci_hcd_omap_probe()'s arg 'pdev'
> >   usb: cdns3: core: Fix incorrect formatting and misspelled function arg
> >     docs
> >   usb: cdns3: ep0: Fix a bunch of kerneldoc issues
> >   usb: dwc3: dwc3-haps: Function headers are not suitable for kerneldoc
> >   usb: mtu3: mtu3_trace: Function headers are not suitable for kerneldoc
> >   usb: cdns3: gadget: Fix a bunch of kernel doc issues
> >   usb: dwc3: dwc3-of-simple: Function headers are not good candidates
> >     for kerneldoc
> >   usb: host: isp1362: Mark the many unused ISP1362_REG entries as
> >     __maybe_unused
> >   usb: host: ohci-at91: Demote kerneldoc headers down to basic comment
> >     blocks
> >   usb: host: ohci: Mark cc_to_error as __maybe_unused
> >   usb: cdns3: ep0: Move 'zlp' description to appropriate function header
> >   usb: host: oxu210hp-hcd: Move declaration of 'qtd' into 'ifdef
> >     OXU_URB_TRACE'
> >   usb: mtu3: mtu3_trace: Supply missing mtu3_debug.h include file
> >   usb: mtu3: mtu3_core: Demote obvious misuse of kerneldoc to standard
> >     comment block
> >   usb: c67x00: c67x00-ll-hpi: Demote obvious misuse of kerneldoc to
> >     standard comment blocks
> >   usb: class: cdc-wdm: Provide description for usb_cdc_wdm_register()'s
> >     manage_power arg
> >   usb: c67x00: c67x00-hcd: Demote obvious misuse of kerneldoc to
> >     standard comment blocks
> >   usb: class: usbtmc: File headers are not good candidates for kerneldoc
> >   usb: c67x00: c67x00-sched: Demote obvious misuse of kerneldoc to
> >     standard comment blocks
> 
> I've applied 25 of these, if you could rebase and resend the remaining
> ones, after fixing up the review comments made on them, that would be
> wonderful.

Will do.  Thanks Greg.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
