Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1963BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E636620809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EAgn+yg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgG3Wdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3Wdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:33:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B500C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=F8V5dJHtdOS7toaRAn2Ry59zBUcx5vitMpMVIJbeVfk=; b=EAgn+yg3QQpl9ZeRYNqax2++tY
        v9WOHaDz0CaO8A99zlFxGIOayyA+cQVtIkuhn91Dv1ReQzVauCGu+yHnAq3mcynE0AAgO1YgwW2nW
        HaSvOTyJxY90uSuTZSpaID7Bd7mz8AWGOo4pzxHT269INqcBbULiQRAw1yIyl070I6bzk57iM9o4X
        80OaIHdj7ChzLPaFRkxu03RtNE8iKioyHh2+z9RXoEWZSFKkmyrg0jci9+NN4iEPvcnLEF7ErZFAy
        rjalyyGIo9E7988CtYqd/npRv3hQyr73o1RVHukOWNhi5CPKd629y0HzUGq9so60iK0M1+fiYrNdk
        VEzfilnQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1H7Q-0006Vz-2W; Thu, 30 Jul 2020 22:33:45 +0000
Subject: Re: [PATCH] Platform lockdown information in SYSFS
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5bd9d37f-4567-f28b-3932-58bd9de38882@infradead.org>
Date:   Thu, 30 Jul 2020 15:33:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could we get some consistency in the use of "bios" vs. "Bios" vs. "BIOS", please.
BIOS is preferred IMO.

On 7/30/20 2:41 PM, Daniel Gutson wrote:
> 
> This initial version exports the BIOS Write Enable (bioswe),
> BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
> fields of the Bios Control register. The idea is to keep adding more
> flags, not only from the BC but also from other registers in following
> versions.
> 
> The goal is that the attributes are avilable to fwupd when SecureBoot

                                      available

> is turned on.
> 
> The patch provides a new misc driver, as proposed in the previous patch,
> that provides a registration function for HW Driver devices to register
> class_attributes.
> In this case, the intel SPI flash chip (intel-spi) registers three
> class_attributes corresponding to the fields mentioned above.
> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---
>  .../ABI/stable/sysfs-class-platform-lockdown  | 23 +++++++
>  MAINTAINERS                                   |  7 +++
>  drivers/misc/Kconfig                          |  9 +++
>  drivers/misc/Makefile                         |  1 +
>  drivers/misc/platform-lockdown-attrs.c        | 57 +++++++++++++++++
>  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
>  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 49 +++++++++++++++
>  drivers/mtd/spi-nor/controllers/intel-spi.c   | 62 +++++++++++++++++++
>  .../platform_data/platform-lockdown-attrs.h   | 19 ++++++
>  9 files changed, 228 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-class-platform-lockdown
>  create mode 100644 drivers/misc/platform-lockdown-attrs.c
>  create mode 100644 include/linux/platform_data/platform-lockdown-attrs.h
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-platform-lockdown b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> new file mode 100644
> index 000000000000..6034d6cbefac
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> @@ -0,0 +1,23 @@
> +What:		/sys/class/platform-lockdown/bioswe
> +Date:		July 2020
> +KernelVersion:	5.8.0
> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set BIOS Write Enable.
> +		0: writes disabled, 1: writes enabled.
> +Users:		https://github.com/fwupd/fwupd
> +
> +What:		/sys/class/platform-lockdown/ble
> +Date:		July 2020
> +KernelVersion:	5.8.0
> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set Bios Lock Enable.

                                           BIOS

> +		0: SMM lock disabled, 1: SMM lock enabled.
> +Users:		https://github.com/fwupd/fwupd
> +
> +What:		/sys/class/platform-lockdown/smm_bwp
> +Date:		July 2020
> +KernelVersion:	5.8.0
> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set SMM Bios Write Protect.

                                               BIOS

> +		0: writes disabled unless in SMM, 1: writes enabled.
> +Users:		https://github.com/fwupd/fwupd



cheers.
-- 
~Randy

