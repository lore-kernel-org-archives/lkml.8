Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C23C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9FA2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIBQBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:01:34 -0400
Received: from foss.arm.com ([217.140.110.172]:41474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgIBQBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:01:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24BFE101E;
        Wed,  2 Sep 2020 09:01:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23D893F66F;
        Wed,  2 Sep 2020 09:01:31 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:01:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
Message-ID: <20200902160110.GA30014@e121166-lin.cambridge.arm.com>
References: <20200829164920.7d28e01a@DUFFMAN>
 <65d88bdd0888a69849327501a2aad186@kernel.org>
 <20200831031838.2d6d76d9@DUFFMAN>
 <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
 <20200831234542.295b1275@DUFFMAN>
 <5db50a8e5b251714cebe0a719ee9dc73@kernel.org>
 <20200901164249.GA15045@e121166-lin.cambridge.arm.com>
 <20200901143356.0425d9ba@DUFFMAN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901143356.0425d9ba@DUFFMAN>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:33:56PM -0400, Samuel Dionne-Riel wrote:
> On Tue, 1 Sep 2020 17:42:49 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Tue, Sep 01, 2020 at 04:37:42PM +0100, Marc Zyngier wrote:
> > > On 2020-09-01 04:45, Samuel Dionne-Riel wrote:  
> > > > -	if (pci_is_root_bus(bus->parent) && dev > 0)
> > > > +	if (bus->primary == rockchip->root_bus_nr && dev > 0)  
> > 
> > Can you dump bus->primary when this condition is hit please ?
> 
> With the following diff
> 
> ---
> @@ -79,6 +79,8 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>          * do not read more than one device on the bus directly attached
>          * to RC's downstream side.
>          */
> +       printk("[!!] // bus->parent (%d)\n", bus->parent);

Please print a pointer as a pointer and print both bus and bus->parent.

> +       printk("[!!] bus->primary (%d) == rockchip->root_bus_nr (%d) && dev (%d) > 0\n", bus->primary, rockchip->root_bus_nr, dev);
>         if (bus->primary == rockchip->root_bus_nr && dev > 0)
>                 return 0;
> 
> --
> 
> I get two kind of results
> 
> [    1.692913] [!!] // bus->parent (0)
> [    1.692917] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0
> 
> and
> 
> [    1.693055] [!!] // bus->parent (-256794624)
> [    1.693058] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0
> 

Looks like this is the condition that pci_is_root_bus(bus->parent) is
not hitting.

[...]

> > > > +	/* HACK; ~equiv to last param of
> > > > pci_parse_request_of_pci_ranges */
> > > > +	bus_res = (resource_list_first_type(&bridge->windows,
> > > > IORESOURCE_MEM))->res;  
> > 
> > IORESOURCE_MEM ? I am a bit puzzled by this hack, what is it supposed
> > to do ?
> 
> It's not really supposed to do anything. I only needed access to
> bus_res for bus_res->start to keep as root_bus_nr. My complete lack of
> familiarity with all of this meant that I simply borrowed something
> that was in use in another function to give me the bus_res.

You are accessing a resource IORESOURCE_MEM that has nothing to do
with bus numbers.

s/IORESOURCE_MEM/IORESOURCE_BUS

should be better ;-)

Lorenzo
