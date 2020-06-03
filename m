Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B9DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC0C2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591215882;
	bh=aSC2B5FOwH/jbhjkwwbA2U3nvwRY/cfyOrIerqmUQNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=wl51ZsxIX5uTZzr+v4La1dfA77fI3L1okQmOCw3VO5SsvjiBZt4tb4HjTy2oikENI
	 j6DqiYG0zClOs9UOpFsHc0wEL9zspJVYKdlWezYlbD4CiID1Va7W0VMEKz5kpaEbR8
	 SDjlRSYjYNoC5h1v31vTOdV4LGlPrSNNoRFg79B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFCUYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgFCUYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:24:41 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF9320734;
        Wed,  3 Jun 2020 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591215880;
        bh=aSC2B5FOwH/jbhjkwwbA2U3nvwRY/cfyOrIerqmUQNs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MnEtRzWw/iwVqJdM8XNSEZR3W1o2W/SiVyK+PNVgMdgyYP+4GTHe322d/sltjhL9O
         9hAVj5iGCUzUOH6dMBBLwcCJFScUduFRdcmtSV1YsSipf0MrAYWlnkzofpFA87vWYf
         akJfAM9AkwWT++7aDkOalDa/000MJkwGzuMUv6q8=
Date:   Wed, 3 Jun 2020 15:24:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/13] PCI: brcmstb: Add suspend and resume pm_ops
Message-ID: <20200603202438.GA946895@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603192058.35296-6-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:20:37PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
> and resume.  Now the PCIe driver may do so as well.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 49 +++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 7c707e483181..f444751e247c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -979,6 +979,49 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  	brcm_pcie_bridge_sw_init_set(pcie, 1);
>  }
>  
> +static int brcm_pcie_suspend(struct device *dev)
> +{
> +	struct brcm_pcie *pcie = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	brcm_pcie_turn_off(pcie);
> +	clk_disable_unprepare(pcie->clk);
> +
> +	return ret;

No need for "ret".

> +}
