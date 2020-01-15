Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C170C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F01424658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579052431;
	bh=RXCqTAs9B9sfiSzDG+Hn4rEic0C5Kj+LfKOUrqaq63A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LJULJcIqCdgVADIpdM6hI6QckEosS7fUNR7IWtEH0vuCNLic31d5iVSv7LYr+ZA9I
	 YiR/TrenxWyGLKnjp8VHiTYrSv5xOIvokk8vQGHAdgLZd6jQFcNMELrzkL7dGAfz+j
	 zX1oNICuJVDmaK6TskkZnDmMqi3HUzhKon/coYdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAOBka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:40:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33474 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgAOBk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:40:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so14711813otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 17:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bD/LT4C3MC6J/wcM/SaP9VxFISKGm7IY0gKpOMd0Pg=;
        b=gPnp+dLfcNh6gfE4x15XWGAoznX9QL1dNXnsMpg8nfKSl+HTa82Qt4fcUbVpyA5yvH
         FXoyOZr56Xpr5L6D/6wDausc+S76OVvZxOpJY4K7dtK0w8CRcWvbU8m1U0BYnYkpsrpQ
         Icvwke0L8EByZtc7/Bam4SiuMRqFe/oOjqtU498/7v6QsUBAw6gYJ7iiy2iKKgb2H+Hq
         Ovy8tJhD1dKs4BNdPRnSXGgsbaAcN9i3ZJNku9Z/i5q/PtKeIp6gtKYvcLUYTqVt41dj
         Q441JVieUtyXy8jcZd0xL3Te6NDPFx2y6EeQRS+AFq9OeXZC/AtkV/foWQCFbgw83Gnm
         ihEQ==
X-Gm-Message-State: APjAAAW0PHVdqGAglGgdJmGAAvk4QBNVBqDr7JJDg11Wm6g+FoB5bXsW
        ycS5itFAT/rVOM6KCDwaRB/luHA=
X-Google-Smtp-Source: APXvYqxkw5n6cmt0LD2Q1yilnyhevJBHLMEEEb68bZd32zBjXjyTtq/T9ydIKjugvtDtGRyAFsfgdw==
X-Received: by 2002:a9d:3e16:: with SMTP id a22mr1076244otd.259.1579052428575;
        Tue, 14 Jan 2020 17:40:28 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm5189992oin.5.2020.01.14.17.40.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:40:27 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 19:40:26 -0600
Date:   Tue, 14 Jan 2020 19:40:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] dt-bindings: PCI: cadence: Add binding to specify
 max virtual functions
Message-ID: <20200115014026.GA10726@bogus>
References: <20191231113534.30405-1-kishon@ti.com>
 <20191231113534.30405-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231113534.30405-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 05:05:29PM +0530, Kishon Vijay Abraham I wrote:
> Add binding to specify maximum number of virtual functions that can be
> associated with each physical function.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt         | 2 ++
>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml          | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> index 4a0475e2ba7e..432578202733 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> @@ -9,6 +9,8 @@ Required properties:
>  
>  Optional properties:
>  - max-functions: Maximum number of functions that can be configured (default 1).
> +- max-virtual-functions: Maximum number of virtual functions that can be
> +    associated with each physical function.
>  - phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
>    than one in the list.  If only one PHY listed it must manage all lanes. 
>  - phy-names:  List of names to identify the PHY.
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> index 4621c62016c7..1d4964ba494f 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> @@ -61,6 +61,12 @@ properties:
>      minimum: 1
>      maximum: 6
>  
> +  max-virtual-functions:
> +    minItems: 1
> +    maxItems: 6

Is there a PCIe spec limit to number of virtual functions per phy 
function? Or 2^32 virtual functions is okay.

> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt

I suspect this this be a common property.

> +
>    dma-coherent:
>      description: Indicates that the PCIe IP block can ensure the coherency
>  
> @@ -85,6 +91,7 @@ required:
>    - cdns,max-outbound-regions
>    - dma-coherent
>    - max-functions
> +  - max-virtual-functions
>    - phys
>    - phy-names
>  
> @@ -107,6 +114,7 @@ examples:
>              clock-names = "fck";
>              cdns,max-outbound-regions = <16>;
>              max-functions = /bits/ 8 <6>;
> +            max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>              dma-coherent;
>              phys = <&serdes0_pcie_link>;
>              phy-names = "pcie_phy";
> -- 
> 2.17.1
> 
