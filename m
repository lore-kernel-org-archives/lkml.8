Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B71C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0041D2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582198025;
	bh=CEk8idDaWnhSZHqSnOYyFDbQj7mAiD4KIa+YtxoO+74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ms50aiKzM4NUeF+2xcXUdz898OpmR5ZuvjVQZq05+mb8JClEWVPbbR9jpTir/q1vy
	 EtyKS3pNfO7xGR8t/dMbVLGwCZdmCnB3OP2b44bSUftLXDqcrsMk51RVCSTgoHUCT9
	 tAHGQlxcVgJ0MgkunrqykJ/8lQ23fJnvngux5dfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBTL1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTL1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:27:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562672071E;
        Thu, 20 Feb 2020 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582198022;
        bh=CEk8idDaWnhSZHqSnOYyFDbQj7mAiD4KIa+YtxoO+74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oE+5vMySvi9PlHim4VNQTDn1Xdu7+jIng8by5DrKHwUmBtzXw/q+D0OuuFw31GjU4
         yHpVgEeeT6CivTYmiMgnaDHlu3RUlPRKIhCtsoiuGP3u+Ue25jjAbYnbS4K/6wxndy
         y8gXHMTIT/7Tpmh5Whdg6Z7BHDpWfN4N9ktjeA3g=
Date:   Thu, 20 Feb 2020 12:27:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v3] clk: Use new helper in managed functions
Message-ID: <20200220112700.GJ3374196@kroah.com>
References: <f48d1df3-fc1f-ac5c-b11e-330f18aad539@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48d1df3-fc1f-ac5c-b11e-330f18aad539@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:04:58AM +0100, Marc Gonzalez wrote:
> Introduce devm_add() to wrap devres_alloc() / devres_add() calls.
> 
> Using that helper produces simpler code, and smaller object size.
> E.g. with gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu:
> 
>     text	   data	    bss	    dec	    hex	filename
> -   1708	     80	      0	   1788	    6fc	drivers/clk/clk-devres.o
> +   1524	     80	      0	   1604	    644	drivers/clk/clk-devres.o
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Differences from v2 to v3
> x Make devm_add() return an error-code rather than the raw data pointer
>   (in case devres_alloc ever returns an ERR_PTR) as suggested by Geert
> x Provide a variadic version devm_vadd() to work with structs as suggested
>   by Geert
> x Don't use nested ifs in clk_devm* implementations (hopefully simpler
>   code logic to follow) as suggested by Geert
> 
> Questions:
> x This patch might need to be split in two? (Introduce the new API, then use it)
> x Convert other subsystems to show the value of this proposal?
> x Maybe comment the API usage somewhere
> ---
>  drivers/base/devres.c    | 15 ++++++
>  drivers/clk/clk-devres.c | 99 ++++++++++++++--------------------------
>  include/linux/device.h   |  3 ++
>  3 files changed, 53 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 0bbb328bd17f..b2603789755b 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -685,6 +685,21 @@ int devres_release_group(struct device *dev, void *id)
>  }
>  EXPORT_SYMBOL_GPL(devres_release_group);
>  
> +int devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)

Please add a bunch of kerneldoc here, as I have no idea what this
function does just by looking at the name of it :(

thanks,

greg k-h
