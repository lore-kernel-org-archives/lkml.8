Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128DDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D428920578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XGgn6wem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgC3R3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:29:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3R3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Eec66IHzo9JhGxFqh5B2ca0/H+pkRQeD1xGS5vVl0Tk=; b=XGgn6wemDLnsEEjjBAoPgGPPMq
        Pp4pgc6O9ULaqgz+kxuIuUcbO04oVA/SsyQx5vq62wSfueFQ1p3T8vJHnVeMkjHMBKYQm1tI8HCOY
        poW9ae5iX/Q2rB5OIaf3mDUb2mVc6LHTKDUf+aoMZPXdP+izDrpZdBQ96xC1xAkRocauNQzVEBkm0
        vOMinjfx86Dvbr/2RWCSj1hlNC373QnGMKkfovCCmM97s6cQCboG/bgvmF2i2QM9o+X/RK3CMk0lR
        Rc+AiuP4CeMZ4IO1soXSN2+elD3lYtV574LY02UzG8RKHlfB4KKnPVK+LrYrP9L1xg3MGuGiZLymG
        deOIonHw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIyDg-0007QP-Qg; Mon, 30 Mar 2020 17:29:04 +0000
Subject: Re: [PATCH v3] platform: x86: Add ACPI driver for ChromeOS
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, Collabora Kernel ML <kernel@collabora.com>,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
References: <20200330150617.1132570-1-enric.balletbo@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <843663ae-10bf-7dfa-4a1f-91493de882c5@infradead.org>
Date:   Mon, 30 Mar 2020 10:29:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330150617.1132570-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/30/20 8:06 AM, Enric Balletbo i Serra wrote:
> This driver attaches to the ChromeOS ACPI device and then exports the values
> reported by the ACPI in a sysfs directory. These values are not exported
> via the standard ACPI tables, hence a specific driver is needed to do
> it. The ACPI values are presented in the string form (numbers as decimal
> values) or binary blobs, and can be accessed as the contents of the
> appropriate read only files in the standard ACPI devices sysfs directory tree.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

> 
> Thanks,
>  Enric
> 
> [1] https://lkml.org/lkml/2017/7/31/378
> 
> Changes in v3:
> - Use attribute groups instead of adding files "by hand".
> - Add BUILD_TEST to increment build coverage.

Where was BUILD_TEST coverage added?
Is that the same as COMPILE_TEST?

> - Do not use "raw" kobject to create directories.
> - Do not abuse of the platform_device interface. Remove it.
> 
> Changes in v2:
> - Note that this version is a total rework, with those major changes:
>   - Use lists to track dinamically allocated attributes and groups.
>   - Use sysfs binary attributes to store the ACPI contents.
>   - Remove all the functionalities except the one that creates the sysfs files.
> 
>  drivers/platform/x86/Kconfig         |  12 +
>  drivers/platform/x86/Makefile        |   1 +
>  drivers/platform/x86/chromeos_acpi.c | 517 +++++++++++++++++++++++++++
>  3 files changed, 530 insertions(+)
>  create mode 100644 drivers/platform/x86/chromeos_acpi.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 587403c44598..917a1c1a0758 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -72,6 +72,18 @@ config ACERHDF
>  	  If you have an Acer Aspire One netbook, say Y or M
>  	  here.
>  
> +config ACPI_CHROMEOS
> +	tristate "ChromeOS specific ACPI extensions"
> +	depends on ACPI
> +	depends on CHROME_PLATFORMS
> +	help
> +	  This driver provides the firmware interface for the services
> +	  exported through the ChromeOS interfaces when using ChromeOS
> +	  ACPI firmware.
> +
> +	  If you have an ACPI-compatible Chromebook, say Y or M
> +	  here.
> +
>  config ALIENWARE_WMI
>  	tristate "Alienware Special feature control"
>  	depends on ACPI

thanks.
-- 
~Randy

