Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A08C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880012467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FwwQRJcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAVMen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:34:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37455 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgAVMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:34:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so7109692wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 04:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2GhRGBXZ61sShjbspHfKcYEQZWltM3X6lSFo674t7to=;
        b=FwwQRJcqKeYK89XfK/oqpBjkHe/ET6/B3wFHE96E1Fv3USCGYrXz9UWnYqIIpb5LZl
         3lao0QZ5pbKC9hTFCkWQpXIlGmbZn9zxuC45CJxLz0BYfpmQ7/wh7a8uQQ34mpwT9iwY
         HUpqTyFvG/+ob791WuSKlYbkXJSC5pwZPfWl/yyLx3TUHGLnbxk4CUNgCDfXlkGphLSF
         fKtM7fuQBc4UZ7JbUhGLuGCVOx3N/QP8cmt4s9w/4V9aFcOjHlqsFUXc/udsPrYW2N4J
         dBgkK00wbTZVqv0kfRSOenAE5uIDp/JdvVdFVCdRN31LkQgcjg4NXB33kakpPDRqhJR8
         EgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2GhRGBXZ61sShjbspHfKcYEQZWltM3X6lSFo674t7to=;
        b=nFIgNVmmYuI95UtLCQHTOFBhXL+aUMtfvZHaqFrgphEkZAOZWkEmTojxnH1RDG1zKV
         GlmIWB+VIdr2+PLvzB54KABMMg7LIk8F6t1fczFC5Nful7lMRmk2fF0Nb5YwZvEXISZb
         EGpLMbb4jinsJt61bBd7Poe6otsdFB5CDdq1JwryX5m3yPRk5cyKOCoxYjAsGo9dv+Yg
         5su9UIuJr1fwMnOXgDSZfxM9x5IIhEXFTPvK0Bla5jiPuMbIKb4olpsaxX0ESjV/9I1S
         rCzALKvAVgh5qCTbMmzBAeLqlZ/pCfwVWvWdjL4gAD7gZ7wTf4ifW59hNtbjHVEovrNl
         lCtw==
X-Gm-Message-State: APjAAAXhf/fU5dWpzoRKE3RYMT7EYC8TbgqOwolKtMN15c9IGFceBwUj
        VrsEIW1AD05pRUlsz5U8BOfmz8zTa/I=
X-Google-Smtp-Source: APXvYqyByoPvWV0lN8iAWU7bNGHwXyB94LMbplyJgmq9E//WLFRbgrouqlRAp+2Y9VbNJ+oLcMjDBQ==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr11101981wrx.14.1579696481402;
        Wed, 22 Jan 2020 04:34:41 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id h8sm60333141wrx.63.2020.01.22.04.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 04:34:40 -0800 (PST)
Date:   Wed, 22 Jan 2020 12:34:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 37/38] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200122123454.GL15507@dell>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-38-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121160114.60007-38-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020, Mika Westerberg wrote:

> This driver only creates a bunch of platform devices sharing resources
> belonging to the PMC device. This is pretty much what MFD subsystem is
> for so move the driver there, renaming it to intel_pmc_bxt.c which
> should be more clear what it is.
> 
> MFD subsystem provides nice helper APIs for subdevice creation so
> convert the driver to use those. Unfortunately the ACPI device includes
> separate resources for most of the subdevices so we cannot simply call
> mfd_add_devices() to create all of them but instead we need to call it
> separately for each device.
> 
> The new MFD driver continues to expose two sysfs attributes that allow
> userspace to send IPC commands to the PMC/SCU to avoid breaking any
> existing applications that may use these. Generally this is bad idea so
> document this in the ABI documentation.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
>  arch/x86/include/asm/intel_pmc_ipc.h          |  47 --
>  arch/x86/include/asm/intel_telemetry.h        |   1 +
>  drivers/mfd/Kconfig                           |  16 +-
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/intel_pmc_bxt.c                   | 496 ++++++++++++++
>  drivers/platform/x86/Kconfig                  |  16 +-
>  drivers/platform/x86/Makefile                 |   1 -
>  drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
>  .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
>  drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
>  drivers/usb/typec/tcpm/Kconfig                |   2 +-
>  include/linux/mfd/intel_pmc_bxt.h             |  21 +
>  13 files changed, 572 insertions(+), 710 deletions(-)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
>  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
>  create mode 100644 drivers/mfd/intel_pmc_bxt.c
>  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
>  create mode 100644 include/linux/mfd/intel_pmc_bxt.h

[...]

> +static int intel_pmc_probe(struct platform_device *pdev)
> +{
> +	struct intel_scu_ipc_pdata pdata = {};
> +	struct intel_pmc_dev *pmc;
> +	int ret;
> +
> +	pmc = devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
> +	if (!pmc)
> +		return -ENOMEM;
> +
> +	pmc->dev = &pdev->dev;
> +	spin_lock_init(&pmc->gcr_lock);
> +
> +	ret = intel_pmc_get_resources(pdev, pmc, &pdata);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request resources\n");
> +		return ret;
> +	}
> +
> +	pmc->scu = devm_intel_scu_ipc_register(&pdev->dev, &pdata);
> +	if (IS_ERR(pmc->scu))
> +		return PTR_ERR(pmc->scu);

*_register is better than *_probe.  If it was called that (or maybe
*_init) initially I may have missed the issue altogether ...

However, I still think it the SCU IPC *device* needs to be a device
driver and abide by the rules, ensuring it uses the device driver
model/API.  As such, it should be registered and probed as a device.

If you require something from it you should call into it (perhaps
using a register function like above), but that should be done *after*
the device has been bound and probed.

> +	platform_set_drvdata(pdev, pmc);
> +
> +	ret = intel_pmc_create_devices(pmc);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to create PMC devices\n");
> +
> +	return ret;
> +}

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
