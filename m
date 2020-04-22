Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68365C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5049021473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgDVREH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:04:07 -0400
Received: from verein.lst.de ([213.95.11.211]:53695 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgDVREH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:04:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F82568C4E; Wed, 22 Apr 2020 19:04:04 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:04:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] amba: Initialize dma_parms for amba
 devices
Message-ID: <20200422170403.GB28781@lst.de>
References: <20200422101013.31267-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422101013.31267-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:10:13PM +0200, Ulf Hansson wrote:
> It's currently the amba driver's responsibility to initialize the pointer,
> dma_parms, for its corresponding struct device. The benefit with this
> approach allows us to avoid the initialization and to not waste memory for
> the struct device_dma_parameters, as this can be decided on a case by case
> basis.
> 
> However, it has turned out that this approach is not very practical. Not
> only does it lead to open coding, but also to real errors. In principle
> callers of dma_set_max_seg_size() doesn't check the error code, but just
> assumes it succeeds.
> 
> For these reasons, let's do the initialization from the common amba bus at
> the device registration point. This also follows the way the PCI devices
> are being managed, see pci_device_add().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
