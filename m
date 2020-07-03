Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F90206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593761843;
	bh=3hXzjoxayCwIlMyaIVk4q1EyS1f0Z06EJ0cKKjqyt8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=psIDq5LpDjSljw8YVGYojdGPY1nbU8PzRrpPjxAOXF5TupdVZE6PNITZzVRqoabh9
	 kr456k0gquJlA5FU2F3QP4PMzyZQgJW+6znoeKwZKQ/Vjfdwz1mQaFG4TpQv1DCvV/
	 +8p2rnurGhpVvEcv6S3lBDLYue/KigsKYPZ6xGC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgGCHhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCHhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:37:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680E6206DF;
        Fri,  3 Jul 2020 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593761841;
        bh=3hXzjoxayCwIlMyaIVk4q1EyS1f0Z06EJ0cKKjqyt8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzrdJFEh0vrcKI86nCxCh++RcbHDCzwbiU4e55HeK+TI72KS4sd7/fIXjUnp+cPaS
         zE6JPTVO7fNm5DMx9ZvqmKLPyiOklTmkTpMmTH/LTr+uliOl6DETVwTsxz24ds1miT
         ckY9Rw9DxTrVC5u5Gu/pcRBDmjVUa7HdtIWhAiT4=
Date:   Fri, 3 Jul 2020 09:37:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 00/30] Fix a bunch of W=1 issues in USB
Message-ID: <20200703073725.GA2370189@kroah.com>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:45:55PM +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (30):
>   usb: phy: phy: Fix-up a whole bunch of formatting issues
>   usb: host: pci-quirks: Demote function header from kerneldoc to
>     comment block
>   usb: common: debug: Demote comment blocks which are obviously not
>     kerneldoc
>   usb: common: usb-conn-gpio: Demote comment block which is clearly not
>     kerneldoc
>   usb: dwc3: drd: File headers are not doc headers
>   usb: dwc3: ulpi: File headers are not doc headers
>   usb: common: ulpi: Fix a few kerneldoc related issues
>   usb: dwc3: dwc3-omap: Do not read DMA status
>   usb: dwc2: gadget: Do not read GINTMSK2
>   usb: dwc2: gadget: Remove assigned but never used 'maxsize'
>   usb: dwc2: gadget: Avoid pointless read of EP control register
>   usb: host: ehci-omap: Provide documentation for
>     ehci_hcd_omap_probe()'s arg 'pdev'
>   usb: cdns3: core: Fix incorrect formatting and misspelled function arg
>     docs
>   usb: cdns3: ep0: Fix a bunch of kerneldoc issues
>   usb: dwc3: dwc3-haps: Function headers are not suitable for kerneldoc
>   usb: mtu3: mtu3_trace: Function headers are not suitable for kerneldoc
>   usb: cdns3: gadget: Fix a bunch of kernel doc issues
>   usb: dwc3: dwc3-of-simple: Function headers are not good candidates
>     for kerneldoc
>   usb: host: isp1362: Mark the many unused ISP1362_REG entries as
>     __maybe_unused
>   usb: host: ohci-at91: Demote kerneldoc headers down to basic comment
>     blocks
>   usb: host: ohci: Mark cc_to_error as __maybe_unused
>   usb: cdns3: ep0: Move 'zlp' description to appropriate function header
>   usb: host: oxu210hp-hcd: Move declaration of 'qtd' into 'ifdef
>     OXU_URB_TRACE'
>   usb: mtu3: mtu3_trace: Supply missing mtu3_debug.h include file
>   usb: mtu3: mtu3_core: Demote obvious misuse of kerneldoc to standard
>     comment block
>   usb: c67x00: c67x00-ll-hpi: Demote obvious misuse of kerneldoc to
>     standard comment blocks
>   usb: class: cdc-wdm: Provide description for usb_cdc_wdm_register()'s
>     manage_power arg
>   usb: c67x00: c67x00-hcd: Demote obvious misuse of kerneldoc to
>     standard comment blocks
>   usb: class: usbtmc: File headers are not good candidates for kerneldoc
>   usb: c67x00: c67x00-sched: Demote obvious misuse of kerneldoc to
>     standard comment blocks

I've applied 25 of these, if you could rebase and resend the remaining
ones, after fixing up the review comments made on them, that would be
wonderful.

thanks,

greg k-h
