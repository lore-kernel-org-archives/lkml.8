Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31D1C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA47C2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582525924;
	bh=lsTwl9vRBan5+sk+4nn1qk4oJxnJ4hd8BTwTqpN2bu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U8qIo4LxQj9zlg6aLi8Fpbg9Bo4RSp4284ZwkkmyWpvBIzBrIEQEXiKUaR5g2LNoP
	 EwgIqVd3zdiCuyfJx8wzJJX8cuNqt8ZLRRu3si225MEjUztWii61RMUV8CWqE5lXWq
	 gp8YVCW9bVLlaP/MzNCUnoAofHKcMuyiW41i25SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBXGcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXGcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:32:03 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7022620661;
        Mon, 24 Feb 2020 06:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582525922;
        bh=lsTwl9vRBan5+sk+4nn1qk4oJxnJ4hd8BTwTqpN2bu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXEQEFbiD+UBqdNCHrJ5H/CXSOJ333ITUFcRoHCZVDWP3sbX1i742u682YY/KiBXW
         Y8bWl3nJiquNJgIeoxbzq0LAi3lmc9xvt7Ucztyai3w58JjOjR2jIRLYqiP79e2kJN
         ohn66lWlUvpC5gk43iboC7KGLhQIFow90zd6SuL4=
Date:   Mon, 24 Feb 2020 14:31:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next/devicetree 0/5] DT bindings for Felix DSA
 switch on LS1028A
Message-ID: <20200224063154.GK27688@dragon>
References: <20200219151259.14273-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219151259.14273-1-olteanv@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 05:12:54PM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This series officializes the device tree bindings for the embedded
> Ethernet switch on NXP LS1028A (and for the reference design board).
> The driver has been in the tree since v5.4-rc6.
> 
> As per feedback received in v1, I've changed the DT bindings for the
> internal ports from "gmii" to "internal". So I would like the entire
> series to be merged through a single tree, be it net-next or devicetree.

Will applying the patches via different trees as normal cause any
issue like build breakage or regression on either tree?  Otherwise, I do
not see the series needs to go in through a single tree.

Shawn

> If this happens, I would like the other maintainer to acknowledge this
> fact and the patches themselves. Thanks.
> 
> Claudiu Manoil (2):
>   arm64: dts: fsl: ls1028a: add node for Felix switch
>   arm64: dts: fsl: ls1028a: enable switch PHYs on RDB
> 
> Vladimir Oltean (3):
>   arm64: dts: fsl: ls1028a: delete extraneous #interrupt-cells for ENETC
>     RCIE
>   net: dsa: felix: Use PHY_INTERFACE_MODE_INTERNAL instead of GMII
>   dt-bindings: net: dsa: ocelot: document the vsc9959 core
> 
>  .../devicetree/bindings/net/dsa/ocelot.txt    | 96 +++++++++++++++++++
>  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 51 ++++++++++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 85 +++++++++++++++-
>  drivers/net/dsa/ocelot/felix.c                |  3 +-
>  drivers/net/dsa/ocelot/felix_vsc9959.c        |  3 +-
>  5 files changed, 232 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/ocelot.txt
> 
> -- 
> 2.17.1
> 
