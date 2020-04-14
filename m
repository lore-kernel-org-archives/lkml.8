Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A4C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D06320656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586882845;
	bh=p5nc/lS/aFuat40LXs0jVuAPU/GrR8x1nNVZ6fkkebQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=whxAo9+8LS0xgtOOEl2lfPg4GvPy4iS35F92u1WyH9R0iK3u+53fuVWqUO0WwztAG
	 x21wNWwz76fmUp58vx0yQprlrBojaRLHmFq1IczQR12d+I52HGUv+iyQIiEzVENTdE
	 ry0Bkrbg9hKBQvjPEqrRui2KHLMiQH7ONoZlbeVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440229AbgDNQrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:47:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44980 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgDNQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:47:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id o25so10946787oic.11;
        Tue, 14 Apr 2020 09:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RufIOjAax09z6p+EG1YT6Ob64oYyYsdH4DdGZYIwPE=;
        b=t6W4aJmpnQ+Y8eDhQp7N57PM+aiIBHGwEo581ait+eh17QpWKMq26bFli4sgjZw7pv
         LZccZK5Mw9++H2Hn32GUST08ckdUlRpI9MIY/Pfb+W11fFxE1Cv9Gh9AQhjlE/dDvpka
         gT15QwpxDuP0XWxMrvOmjBn1lMZKLE+uMXXP8N13UM/CidaI0ZAYDGt8zak50NynMY4Y
         sPJoHvhPgVfo7hAy7o+xrLmpGld0eLuyZjQLWe43mnZRyFmXJni9jIcrpa3LP9qj4Fla
         +X6v5S2dBZC0gTqhddFG0X5uN7iRqAzb0LY890TNOkJzDy1QUwE2ZtlZ2rCEplqAacya
         9CdA==
X-Gm-Message-State: AGi0PuaEnvqSZpfjkKtODLACAfCoquC5hyEf3m9PxuruzhF2TJ1vKY+i
        fghsOrl0cadnfX992+osreGngEY=
X-Google-Smtp-Source: APiQypKKZktvfxf4TYtboqo5jbTYGG17/gcuEfCVgh6QLUUyxPMNxWbzj1tHXUOYAziyjSGn8NwTSA==
X-Received: by 2002:aca:ad87:: with SMTP id w129mr10028297oie.173.1586882839593;
        Tue, 14 Apr 2020 09:47:19 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c18sm5738621oig.53.2020.04.14.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:47:18 -0700 (PDT)
Received: (nullmailer pid 15830 invoked by uid 1000);
        Tue, 14 Apr 2020 16:47:17 -0000
Date:   Tue, 14 Apr 2020 11:47:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200414164717.GA11384@bogus>
References: <20200401221025.26087-1-laurent.pinchart@ideasonboard.com>
 <20200401221025.26087-2-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401221025.26087-2-laurent.pinchart@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 01:10:23AM +0300, Laurent Pinchart wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> 
> Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> Processing System Gigabit Transceiver which provides PHY capabilities to
> USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v6:
> 
> - Fixed specification of compatible-dependent xlnx,tx-termination-fix
>   property
> - Dropped status property from example
> - Use 4 spaces to indent example
> 
> Changes since v5:
> 
> - Document clocks and clock-names properties
> - Document resets and reset-names properties
> - Replace subnodes with an additional entry in the PHY cells
> - Drop lane frequency PHY cell, replaced by reference clock phandle
> - Convert bindings to YAML
> - Reword the subject line
> - Drop Rob's R-b as the bindings have significantly changed
> - Drop resets and reset-names properties
> ---
>  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++++++++++++++++++
>  include/dt-bindings/phy/phy.h                 |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> new file mode 100644
> index 000000000000..d28ddca7b90e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0

I think I said this already, but dual license please.

Rob
