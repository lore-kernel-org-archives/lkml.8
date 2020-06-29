Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B56DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434C8206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466759;
	bh=TinwdUAZToJYD7egtBNB4xARFfc3FZud3Ictzq3+erI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PqOEcu6ajPOlMN3J4kKM0qxTMDg7mZfvOm1WEc1f0qIF7p5R0HEhlsgMKYq+VyD/D
	 hoymrYrUqozJzsNBdWijEzbYLHqcrJaiAwADyJTCJ7A3qJPJkRQKhZWCslPGCxOj2q
	 4i8lB0+6MfEDnmMLL6taVn1rzmVlf8PKsKIPy/4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgF2VjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgF2Skb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:31 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241D123403;
        Mon, 29 Jun 2020 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593423590;
        bh=TinwdUAZToJYD7egtBNB4xARFfc3FZud3Ictzq3+erI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jx2KXQ6ef0yTIysJsCaHS6ElwJ0URrcG5mCHBaVbUC3kV98dGmqUtimtkEBriuOii
         fcuHYyPCi2Nxt0OvurxzzAvU/3UYZ1o6XR7LEC4Zos20CBHkOCuVvrEWtmAqO498Yo
         s6GDk0RUbJcBPoqoM1l/UtlFO2Xpxt8BwEXCbtTo=
Date:   Mon, 29 Jun 2020 15:09:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v8 0/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
Message-ID: <20200629093943.GB2599@vkoul-mobl>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-20, 20:22, Laurent Pinchart wrote:
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
> Compared to v7, review comments on the PHY driver have been taken into
> account, and the DT bindings have switched to the GPL-2.0-only OR
> BSD-2-Clause license
> 
> The code is based on v5.6 and has been tested with DisplayPort on the
> Xilinx ZC106 board.

This (dt patch and 8.1 update) fails to apply for me, can you please
rebased on phy-next and resend. Also I saw this while trying to apply:

WARNING: Misordered MAINTAINERS entry - list 'S:' before 'T:'
#403: FILE: MAINTAINERS:18605:
+T:	git https://github.com/Xilinx/linux-xlnx.git
+S:	Supported

Thanks
-- 
~Vinod
