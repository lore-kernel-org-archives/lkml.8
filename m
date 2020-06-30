Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AD2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1777206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593507407;
	bh=RMkfOv+c5EL2QlsPXrFbfPa5buPm5V8aN83cTazCr9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gm8jUsAi853eP/c/rDYsR6GI1tjhxEJdF1ej/r5KOsRY/JUUyXYNYEmot7W88jUBu
	 B2DYjJN36EEWUnn4nwqN60znqa0qLMMo53/VqC2SiOqK/no1ij2HtJ0PV/ya+vdL29
	 nuV/bpR/VuFXV88s7Ae+E62pI7pICvGAi6XOAtaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgF3I4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbgF3I4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:56:45 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544B220759;
        Tue, 30 Jun 2020 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593507405;
        bh=RMkfOv+c5EL2QlsPXrFbfPa5buPm5V8aN83cTazCr9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sORZvxL8YlMIovX+fTWnmJeH68eF70iC78FC6rsnRerQnoEzU9MGmg4rOEWWS5RvC
         0Z3kPFW6XcRofM0kLRef2FUs9aES0j3+1rOdb5JAeT2bs4iShNlnkg9EuHDXDT/T+n
         JI1+Zdsxm3TAYyyirQ/hC2Se4wpZQVq5B12o2NGU=
Date:   Tue, 30 Jun 2020 10:56:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200630085641.GD637809@kroah.com>
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

Why not use the simple_* functions which should prevent that type of
thing?



> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---
>  Documentation/ABI/stable/securityfs-spi-lpc |  23 +

Why is this going in securityfs at all?  Why not just sysfs as it is a
CPU attribute, right?


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
>  create mode 100644 Documentation/ABI/stable/securityfs-spi-lpc
>  create mode 100644 drivers/misc/spi_lpc/Kconfig
>  create mode 100644 drivers/misc/spi_lpc/Makefile
>  create mode 100644 drivers/misc/spi_lpc/bios_data_access.c
>  create mode 100644 drivers/misc/spi_lpc/bios_data_access.h
>  create mode 100644 drivers/misc/spi_lpc/low_level_access.c
>  create mode 100644 drivers/misc/spi_lpc/low_level_access.h
>  create mode 100644 drivers/misc/spi_lpc/spi_lpc_main.c
>  create mode 100644 drivers/misc/spi_lpc/viddid_arch_map.c
>  create mode 100644 drivers/misc/spi_lpc/viddid_arch_map.h
> 
> diff --git a/Documentation/ABI/stable/securityfs-spi-lpc b/Documentation/ABI/stable/securityfs-spi-lpc
> new file mode 100644
> index 000000000000..22660a7fd914
> --- /dev/null
> +++ b/Documentation/ABI/stable/securityfs-spi-lpc
> @@ -0,0 +1,23 @@
> +What:		/sys/kernel/security/firmware/bioswe
> +Date:		June 2020
> +KernelVersion:	5.8.0
> +Contact:	daniel.gutson@eclypsium.com
> +Description:	If the system firmware set BIOS Write Enable.
> +		0: writes disabled, 1: writes enabled.

THis is very x86-specific, what about ARM/MIPS/anything else?  Perhaps a
cpu/arch-specific thing instead?

Again, which makes it seem like securityfs is not the thing for this, as
it describes the hardware, not a security model which is what securityfs
has been for in the past, right?

thanks,

greg k-h
