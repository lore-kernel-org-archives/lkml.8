Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E64EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520F7205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974777;
	bh=3xhdGOns6oOOFP+YeaR4IoE2mY67v6Wf2ZDw6rOAw1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CZjAdVuls6o0F5E1dkjDMaWoGRLi93OfieT4yd6puY+XNBz99Wl5AF63JS5xz1qGX
	 r8nc5R1lRenVuCi9UE+NQmBfHl/4Hu5L+ZwavJpXoqP2g7a0Rn4rRbmcjpHUOhOkvG
	 oMeyTFaYzrmDfa9BpTfP4VK6Grczyl0Rwa+5WcKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgIAPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbgIAPhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:37:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C1B205F4;
        Tue,  1 Sep 2020 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974664;
        bh=3xhdGOns6oOOFP+YeaR4IoE2mY67v6Wf2ZDw6rOAw1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=quk1xz8e8vnQbb/b0D+2H5SxYpUmCd5x1DQWc3AV+vsbl6hbm9UsA6Qogq692bXPX
         gWXYC4iCb1kuAVejFf1fF3SFj93OqZS4k07KxlJE+yIUzagIW2D1Y2Ghz9OdraTXYh
         erg6egmsedJQNcA9UxEk8fBQN4IwMZXIX8gL55SQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD8Lu-008K6i-C6; Tue, 01 Sep 2020 16:37:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Sep 2020 16:37:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
In-Reply-To: <20200831234542.295b1275@DUFFMAN>
References: <20200829164920.7d28e01a@DUFFMAN>
 <65d88bdd0888a69849327501a2aad186@kernel.org>
 <20200831031838.2d6d76d9@DUFFMAN>
 <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
 <20200831234542.295b1275@DUFFMAN>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <5db50a8e5b251714cebe0a719ee9dc73@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samuel@dionne-riel.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org, devicetree@vger.kernel.org, frowand.list@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-01 04:45, Samuel Dionne-Riel wrote:
> On Mon, 31 Aug 2020 10:27:37 +0100
> Marc Zyngier <maz@kernel.org> wrote:
>> 
>> Ah, so actually anything that *enables pcie* kills your system.
>> Great investigative work!
>> 
>> >
>> > And backed by a further bisection with this that points to
>> > d84c572de1a360501d2e439ac632126f5facf59d being the actual change
>> > that causes the tablet to fail to boot, as long as the pcie0 node is
>> > identified as pci properly.
>> >
>> > I am unsure if I should add as a Cc everyone involved in that change
>> > set, though the author (coincidentally) is already in the original
>> > list of recipients.
>> 
>> I've deliberately moved Rob from Cc to To... ;-)
> 
> Thanks, I don't actually know who to write to exactly.

Given that this is a PCI regression, I guess the PCI maintainers
are the likely victims. Adding Bjorn and Lorenzo to the list in
addition to Rob.

You can find the relevant people by looking at the MAINTAINERS
file.

>> > Any additional thoughts from this additional information?
>> 
>> What you could do is to start looking at which of the
>> pci_is_root_bus() changes breaks PCIe on this system.  The fact that
>> it breaks on your system and not on mine is a bit puzzling.
> 
> Let me show you, on top of v5.9-rc3 I can successfully boot using this
> partial revert / adaptation of d84c572d. In addition, it also allows
> the Wi-Fi to work again, compared to how it didn't in 5.9-rc1 or
> 5.9-rc[23] with the dumb revert of your fix.
> 
> So, if we number each pci_is_root_bus by order appearance, it is only
> the second use, in rockchip_pcie_valid_device, which seem to cause
> scarlet not to boot.
> 
> The patch (not actually a patch submission) reverts only that instance
> of pci_is_root_bus, while also doing some leg work to put back some
> functionally equivalent code that was refactored away since.
> 
> If there's anything else you want me to try, don't hesitate.
> 
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 8 +++++++-
>  drivers/pci/controller/pcie-rockchip.h      | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
> b/drivers/pci/controller/pcie-rockchip-host.c
> index 0bb2fb3e8a0b..5a27fa833fbd 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -79,7 +79,7 @@ static int rockchip_pcie_valid_device(struct
> rockchip_pcie *rockchip,
>  	 * do not read more than one device on the bus directly attached
>  	 * to RC's downstream side.
>  	 */
> -	if (pci_is_root_bus(bus->parent) && dev > 0)
> +	if (bus->primary == rockchip->root_bus_nr && dev > 0)
>  		return 0;
> 
>  	return 1;
> @@ -944,6 +944,7 @@ static int rockchip_pcie_probe(struct 
> platform_device *pdev)
>  	struct rockchip_pcie *rockchip;
>  	struct device *dev = &pdev->dev;
>  	struct pci_host_bridge *bridge;
> +	struct resource *bus_res;
>  	int err;
> 
>  	if (!dev->of_node)
> @@ -983,6 +984,11 @@ static int rockchip_pcie_probe(struct
> platform_device *pdev)
>  	if (err < 0)
>  		goto err_deinit_port;
> 
> +	/* HACK; ~equiv to last param of pci_parse_request_of_pci_ranges */
> +	bus_res = (resource_list_first_type(&bridge->windows, 
> IORESOURCE_MEM))->res;
> +
> +	rockchip->root_bus_nr = bus_res->start;
> +
>  	err = rockchip_pcie_cfg_atu(rockchip);
>  	if (err)
>  		goto err_remove_irq_domain;
> diff --git a/drivers/pci/controller/pcie-rockchip.h
> b/drivers/pci/controller/pcie-rockchip.h
> index c7d0178fc8c2..0952fec7e34d 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -298,6 +298,7 @@ struct rockchip_pcie {
>  	struct	gpio_desc *ep_gpio;
>  	u32	lanes;
>  	u8      lanes_map;
> +	u8      root_bus_nr;
>  	int	link_gen;
>  	struct	device *dev;
>  	struct	irq_domain *irq_domain;
> --
> 2.25.4
> 
> 
> Thanks again!

Hmmm. It seems that the original commit (d84c572d) considered that
root_bus_nr was always zero, while it may not have been.

Rob, Lorenzo: do you guys have any idea what is going on here?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
