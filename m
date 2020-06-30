Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF820206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593507577;
	bh=EV9ZqH5oEK7a6YYZW6fTv1AYKNoaDzHSVlCdKDobGyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MUSpfO8JZC/b60sRH+97pHNTL5LAPcEd21WbS8q0klhDwM4p0IYqYTywqr8NP1eOl
	 CiLR7o8AH1Cfr4/yObjS0fWYfVl8gr56dqBtS5j9A4NBAS0+Qxwxaf9zqZebCB/o8F
	 1uVvCDD6yPWgfb5Z55OUV7SbdgBncvHVQqOm/qMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgF3I7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgF3I7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:59:35 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C2F206BE;
        Tue, 30 Jun 2020 08:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593507575;
        bh=EV9ZqH5oEK7a6YYZW6fTv1AYKNoaDzHSVlCdKDobGyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZgC5J/RTiX2Kxby20jQ3LqKRg2WX+fffLCY591ZMMHOM4ZBNx/7+JyTOxaM/JNFe
         xptiNdXp9BZqYNrz6MW+K/SSzC7wP/VFMofmr64tsYMWIdK1+xjilUzrISRxJZLNrA
         KvB6oSajBv02CVQ0WL0vDGblfwfeLAioc2ODlgVg=
Date:   Tue, 30 Jun 2020 10:59:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200630085932.GF637809@kroah.com>
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:59:32PM -0300, Daniel Gutson wrote:
> This kernel module exports configuration attributes for the
> system SPI chip.
> This initial version exports the BIOS Write Enable (bioswe),
> BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
> fields of the Bios Control register. The idea is to keep adding more
> flags, not only from the BC but also from other registers in following
> versions.
> 
> The goal is that the attributes are avilable to fwupd when SecureBoot
> is turned on.
> 
> A technical note: I check if *ppos == BUFFER_SIZE in the reading function
> to exit early and avoid an extra access to the HW, for example when using
> the 'cat' command, which causes two read operations.
> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---
>  Documentation/ABI/stable/securityfs-spi-lpc |  23 +
>  MAINTAINERS                                 |   6 +
>  drivers/misc/Kconfig                        |   1 +
>  drivers/misc/Makefile                       |   1 +
>  drivers/misc/spi_lpc/Kconfig                |  20 +
>  drivers/misc/spi_lpc/Makefile               |   8 +
>  drivers/misc/spi_lpc/bios_data_access.c     | 559 +++++++++++++++++++
>  drivers/misc/spi_lpc/bios_data_access.h     | 181 +++++++
>  drivers/misc/spi_lpc/low_level_access.c     |  59 ++
>  drivers/misc/spi_lpc/low_level_access.h     |  21 +
>  drivers/misc/spi_lpc/spi_lpc_main.c         | 176 ++++++
>  drivers/misc/spi_lpc/viddid_arch_map.c      | 566 ++++++++++++++++++++
>  drivers/misc/spi_lpc/viddid_arch_map.h      |  17 +
>  13 files changed, 1638 insertions(+)

A single driver that is 1500 lines long is fine, why split this up into
tiny pieces?

thanks,

greg k-h
