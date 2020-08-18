Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7F0206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597763208;
	bh=EWjrUEn8Fdl8vRk5AW0ZEQ0oQDuBzaEaX+X3DssIftw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZYwaM4rYJEROJ7efftFZX6QGznMnbayk4+wUUslZG3FWkoCYJCvtHPsfaeHmUXXQ3
	 hiZ08XLTJrbIhhKCROyiSHotyIp5RKGH8lU7ZrMzl5Teo4Uy4qqd6ukbGKHMZgsTAw
	 BrsvjX3iDbE6v1/iQp6fQymGer/znlu4fvToyf+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHRPGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHRPGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:06:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21FD7207D3;
        Tue, 18 Aug 2020 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597763200;
        bh=EWjrUEn8Fdl8vRk5AW0ZEQ0oQDuBzaEaX+X3DssIftw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdnPgih/agxspQ3O97ozg+vfLTKhbe903DSbfSdPJPdNgPfjbfpNrw9kTy2acF2Er
         qeHmtCEY0hxPYbnljXO+hvtujxi6rif6YSLQOweYR8ysm10y5Th6fWLxpoyn2pBxW1
         o4dZJ0kBLmyt9us1ueN0PezqTv4EdBeq1ovCkHOs=
Date:   Tue, 18 Aug 2020 17:07:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     devel@driverdev.osuosl.org,
        Manivannan Sadhasivam <mani@kernel.org>, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        mauro.chehab@huawei.com
Subject: Re: [PATCH 1/6] staging: hikey9xx: fix Kconfig dependency chain
Message-ID: <20200818150704.GA665815@kroah.com>
References: <cover.1597762400.git.mchehab+huawei@kernel.org>
 <1b7e23500e7449593393115cc0954af441b0c730.1597762400.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7e23500e7449593393115cc0954af441b0c730.1597762400.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:58:53PM +0200, Mauro Carvalho Chehab wrote:
> Both the SPMI controller and the SPMI PMIC driver
> depends on the SPMI bus support.
> 
> The dependency for the regulator is also wrong:
> it should depends on the SPMI version of the HiSilicon 6421,
> and not on the normal one.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/staging/hikey9xx/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
> index 76267b9be562..a004839e8fa9 100644
> --- a/drivers/staging/hikey9xx/Kconfig
> +++ b/drivers/staging/hikey9xx/Kconfig
> @@ -5,6 +5,7 @@ config SPMI_HISI3670
>  	tristate "Hisilicon 3670 SPMI Controller"
>  	select IRQ_DOMAIN_HIERARCHY
>  	depends on HAS_IOMEM
> +	depends on SPMI
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
> @@ -14,6 +15,7 @@ config SPMI_HISI3670
>  config MFD_HI6421_SPMI
>  	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
>  	depends on OF
> +	depends on SPMI
>  	select MFD_CORE
>  	help
>  	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
> @@ -28,7 +30,7 @@ config MFD_HI6421_SPMI
>  # to be placed at drivers/regulator
>  config REGULATOR_HI6421V600
>  	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
> -	depends on MFD_HI6421_PMIC && OF
> +	depends on MFD_HI6421_SPMI && OF
>  	help
>  	  This driver provides support for the voltage regulators on
>  	  HiSilicon Hi6421v600 PMU / Codec IC.

Better, but now I get the following build error:

ERROR: modpost: "regulator_map_voltage_iterate" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
ERROR: modpost: "regulator_list_voltage_table" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
ERROR: modpost: "of_get_regulator_init_data" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
ERROR: modpost: "regulator_register" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
ERROR: modpost: "regulator_unregister" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
ERROR: modpost: "rdev_get_drvdata" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!

Someone need CONFIG_REGULATOR enabled?

Another follow-on patch?  :)

thanks,

greg k-h
