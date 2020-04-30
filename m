Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58615C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDDE207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588279384;
	bh=u75tJYVYqVgwKuxyvKak/ZmBpHgmj5uCJfAwjytROXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=saNOKYYMTJ87cxpTszlLZ3vpwnPeYdZhpMNslo1y4J4ZKgIDeJlHxF5nFdEfeOF3U
	 F3Rmhhnn8ZfdhxI6zdt34uXxU6uo7mlM0yC0/EDeOGEeaNIOIr5Sz/C+64lc0vzBF0
	 OIx6NeytfJghSXHtmW4sJP6RSvMwdLYh6TP/RmXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgD3UnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgD3UnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:43:02 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5150206C0;
        Thu, 30 Apr 2020 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588279382;
        bh=u75tJYVYqVgwKuxyvKak/ZmBpHgmj5uCJfAwjytROXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lo/oqZaXh7vcHQFfdXlnjaGTon80H4R9d/gJ3gIDroMAlE999ZPhFGt2CAgEd0l/+
         RhvqHzdgIGpb0FfKhafe0UqCs5Chv22vRnKMSnwtUjSdupAg1L8EyzHVSOJJt44VJt
         KJI7OV0aIbDtt8gAcJ0q0cgaWxNy4RlP1imVGnYU=
Date:   Thu, 30 Apr 2020 15:43:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] PCI: brcmstb: fix window register offset from 4 to 8
Message-ID: <20200430204300.GA63206@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430185522.4116-2-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 02:55:19PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> The oubound memory window registers were being referenced
> with an incorrect offset.  This probably wasn't noticed
> previously as there was likely only one such outbound window.

If you repost these for any other reason:

Capitalize the first word of all the subject lines to match history.
s/oubound/outbound/

> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 454917ee9241..5b0dec5971b8 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -54,11 +54,11 @@
>  
>  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
>  #define PCIE_MEM_WIN0_LO(win)	\
> -		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 4)
> +		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
>  
>  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
>  #define PCIE_MEM_WIN0_HI(win)	\
> -		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 4)
> +		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
>  
>  #define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
>  #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
> -- 
> 2.17.1
> 
