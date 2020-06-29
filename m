Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AD5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B812063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456061;
	bh=KOWK4GzPHtsJt7GLaKVf1go3qUsF4/W/WpCc8e8O6I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hpBcI9P9OecuZGLZz5VvmKGorvJdtCRTqjetL2+w3IlQWU3YJ755bMZPD/0z4KwdU
	 GEmjqfyki/M0JPSdvoZl/JrKgQpXPYLMtmFvSmEFBC2GKca0jIgAxGXq43lTIY0c7Z
	 tNzE71zTZtBiXM8ignQk4K3TC9WcHIxpylwnJ2ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgF2SlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgF2Skv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:51 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7842923D58;
        Mon, 29 Jun 2020 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593436763;
        bh=KOWK4GzPHtsJt7GLaKVf1go3qUsF4/W/WpCc8e8O6I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzgs0amAInSU9KdERuWYQeSJdJTHDw3jGzv9bVTJhgB4VpvBpq08rKbQ8/WxEXlrf
         2s8epdDnV6ycWyCgvtRBXaTjQvElQFO9gxqcnJrwqQkn7aUbXNRuu0tJutBoYWUo01
         cQIK8z2P9K04Z3KjpUMDk6K1F5Ik5X/h6V068enA=
Date:   Mon, 29 Jun 2020 18:49:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v9 0/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
Message-ID: <20200629131917.GL2599@vkoul-mobl>
References: <20200629120054.29338-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629120054.29338-1-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 15:00, Laurent Pinchart wrote:
> Hello,
> 
> The patch series adds a PHY driver for the Xilinx ZynqMP gigabit serial
> transceivers (PS-GTR). The PS-GTR is a set of 4 PHYs that can be used by
> the PCIe, USB 3.0, DisplayPort, SATA and Ethernet controllers that are
> part of the Serial I/O Unit (SIOU).
> 
> The code is based on a previous version sent by Anurag Kumar Vulisha and
> available at [1]. The DT bindings have been converted to YAML, and both
> the bindings and the driver have been considerably reworked (and
> simplified). The most notable changes is the removal of manual handling
> of the reset lines of the PHY users (which belongs to the PHY users
> themselves), and moving to the standard PHY .power_on() and .configure()
> operations to replace functions that were previously exported by the
> driver. Please see individual patches for a more detailed changelog.
> 
> Compared to v8, the series has been rebased on phy/next, and a minor
> issue in MAINTAINERS has been fixed.

Thanks for quick rebase, Applied 1 & 2 now

> 
> [1] https://patchwork.kernel.org/cover/10735681/
> 
> Anurag Kumar Vulisha (2):
>   dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
>   phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver
> 
> Laurent Pinchart (1):
>   arm64: dts: zynqmp: Add GTR transceivers
> 
>  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++
>  MAINTAINERS                                   |   9 +
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  10 +
>  drivers/phy/Kconfig                           |   1 +
>  drivers/phy/Makefile                          |   3 +-
>  drivers/phy/xilinx/Kconfig                    |  13 +
>  drivers/phy/xilinx/Makefile                   |   3 +
>  drivers/phy/xilinx/phy-zynqmp.c               | 995 ++++++++++++++++++
>  include/dt-bindings/phy/phy.h                 |   1 +
>  9 files changed, 1139 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
>  create mode 100644 drivers/phy/xilinx/Kconfig
>  create mode 100644 drivers/phy/xilinx/Makefile
>  create mode 100644 drivers/phy/xilinx/phy-zynqmp.c
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
~Vinod
