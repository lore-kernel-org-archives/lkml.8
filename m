Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F9C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C352464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bknF87lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCJLzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:55:47 -0400
Received: from first.geanix.com ([116.203.34.67]:47896 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgCJLzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:55:47 -0400
Received: from localhost (unknown [85.191.123.149])
        by first.geanix.com (Postfix) with ESMTPSA id B1D50C62C6;
        Tue, 10 Mar 2020 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1583841344; bh=tBmlMn2UhNtC3VSTWAV5c9jmOKvQNedYrfvi/K5ohGg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=bknF87lxIHrTbRn9f0bMCZpIXWn6y6n/jJv5jJx4GVZKoB64Bw/amu1yPpyVKyVQj
         aDjg9xvogqkkpUaBj6U1zLi7FDZ7jgc/lt0AQ7sUkLej0RuMOPNnUbMiabQ0fXaF3F
         GqzKb194kcK1dP47haALH8WbY4oYbH2mWa2xem4iWz3m7mGF5FzMwE+UKOsG9b21KT
         7zDI2UVEr6q5+mOMC2lLtsKA+WBZIcauOWojzeohBdKNJXmicDsolfYIO7XZcefQbU
         KG/C+18nWtm7arWOt9VX4mQPTBUPibR+FAKQz4hD+pjYtuCsX6iCiLLkTWYHnhoa4m
         z3dIPzS6qGtzw==
From:   Esben Haabendal <esben@geanix.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
        rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 01/14] net: xilinx: temac: Relax Kconfig dependencies
References: <20200309181851.190164-1-andre.przywara@arm.com>
        <20200309181851.190164-2-andre.przywara@arm.com>
Date:   Tue, 10 Mar 2020 12:55:44 +0100
In-Reply-To: <20200309181851.190164-2-andre.przywara@arm.com> (Andre
        Przywara's message of "Mon, 9 Mar 2020 18:18:38 +0000")
Message-ID: <871rq0a0fz.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Przywara <andre.przywara@arm.com> writes:

> Similar to axienet, the temac driver is now architecture agnostic, and
> can be at least compiled for several architectures.
> Especially the fact that this is a soft IP for implementing in FPGAs
> makes the current restriction rather pointless, as it could literally
> appear on any architecture, as long as an FPGA is connected to the bus.
>
> The driver hasn't been actually tried on any hardware, it is just a
> drive-by patch when doing the same for axienet (a similar patch for
> axienet is already merged).
>
> This (temac and axienet) have been compile-tested for:
> alpha hppa64 microblaze mips64 powerpc powerpc64 riscv64 s390 sparc64
> (using kernel.org cross compilers).

The temac driver is being actively used on x86_64, so please include
that for future compile-tests of it.

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/net/ethernet/xilinx/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> index 6304ebd8b5c6..0810af8193cb 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -32,7 +32,6 @@ config XILINX_AXI_EMAC
>  
>  config XILINX_LL_TEMAC
>  	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
> -	depends on PPC || MICROBLAZE || X86 || COMPILE_TEST
>  	select PHYLIB
>  	---help---
>  	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC

Acked-by: Esben Haabendal <esben@geanix.com>
