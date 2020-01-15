Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69483C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344AB2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzetdqJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAOIfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:35:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43007 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:35:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so14768212wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 00:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eRvli8YgKFQe9cmU0K1p9rrpoZHufZcYBpYEQaHFxL0=;
        b=TzetdqJlk2YpzjDvvTf+s9/5hFLcEJ6a80x3YuiXaTKcdPgGPYxVV1IDvy+rNDOyXQ
         LZ1W21CxFua4fF4kY71Sc57rGadWD02u9qf50TppfkKWcaVkX13w+Q9kdOf7G8VzSIX/
         HmouHIozIM3HWApUantWldT2IblvUt+dlVBWmfduZfMlpjJxAcPMBzozA99HwAwSm196
         MRLGYTWzTJ1wvalh+ygTf0QMhXLu7jjnbWG9h7gWrI8KjEQuKcHki8VaTm0pE8pEYsjd
         mZt0jCYOJPrxe/Gc5GxLIj7yTzqJq4LFOh+BhFma8S7Rq6U5WqQMskyEp2JzW8yLIaSB
         Os3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eRvli8YgKFQe9cmU0K1p9rrpoZHufZcYBpYEQaHFxL0=;
        b=Q2NgYyvPaUinovM3MaegvRpydxyqIDH+iTguYFqM3lvvHfnNb0/FWC3+zbYms3EzXU
         Smkh+zpnAp95+qxQh04rL7oNjSkL0OWnjAIOikycWR9KO8UuPRrFadeaID0AYExWDWmB
         n71BzIjYtxWwJVR1zu764ggWD9pY3q8voLWqjZP/qFDxwfnSiaapA0uy8Qwc98aa+6NM
         5iZ5waVMep2kCHPwnRD4B4P6Frz7AXGsJoQwDNlz5B0ui8lHMtivzakWIT3tOv/78bDH
         I6Xz1Jz/YSJRMXJ5u0y6uR/XIP88T1yc2/n3ZKhZmuHbqWX+28ygVnXDgrHWryPGtLtZ
         9kfQ==
X-Gm-Message-State: APjAAAUwUu1xoFeLBHioy+GCq3VCcOa9LUdZdQdx89TnSwMIwYkgrDxa
        7OpQC/DNt8GMfpAnq43ra5SEwQ==
X-Google-Smtp-Source: APXvYqyFVbyRKHUlTeFYYSnileyEVNZAT2S8Vj+lX47u+REFC9a2MnrTs1PAGRM9sksjK04cyg63TA==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr29974817wrm.131.1579077322109;
        Wed, 15 Jan 2020 00:35:22 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id 18sm21181823wmf.1.2020.01.15.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 00:35:21 -0800 (PST)
Date:   Wed, 15 Jan 2020 08:35:41 +0000
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
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/36] platform/x86: intel_scu_ipc: Split out SCU IPC
 functionality from the SCU driver
Message-ID: <20200115083541.GF325@dell>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-13-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113135623.56286-13-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Mika Westerberg wrote:

> The SCU IPC functionality is usable outside of Intel MID devices. For
> example modern Intel CPUs include the same thing but now it is called
> PMC (Power Management Controller) instead of SCU. To make the IPC
> available for those split the driver into library part (intel_scu_ipc.c)
> and the SCU PCI driver part (intel_scu_pcidrv.c) which then calls the
> former before it goes and creates rest of the SCU devices.
> 
> We also split the Kconfig symbols so that INTEL_SCU_IPC enables the SCU
> IPC library and INTEL_SCU_PCI the SCU driver and convert the users
> accordingly. While there remove default y from the INTEL_SCU_PCI symbol
> as it is already selected by X86_INTEL_MID.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/Kconfig                        |  2 +-
>  arch/x86/include/asm/intel_scu_ipc.h    | 14 +++++

>  drivers/mfd/Kconfig                     |  4 +-

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  drivers/platform/x86/Kconfig            | 26 ++++++---
>  drivers/platform/x86/Makefile           |  1 +
>  drivers/platform/x86/intel_scu_ipc.c    | 75 +++++++++----------------
>  drivers/platform/x86/intel_scu_pcidrv.c | 61 ++++++++++++++++++++
>  7 files changed, 122 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c

[...]

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 420900852166..59515142438e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -593,7 +593,7 @@ config INTEL_SOC_PMIC_MRFLD
>  	tristate "Support for Intel Merrifield Basin Cove PMIC"
>  	depends on GPIOLIB
>  	depends on ACPI
> -	depends on INTEL_SCU_IPC
> +	depends on INTEL_SCU
>  	select MFD_CORE
>  	select REGMAP_IRQ
>  	help
> @@ -625,7 +625,7 @@ config MFD_INTEL_LPSS_PCI
>  
>  config MFD_INTEL_MSIC
>  	bool "Intel MSIC"
> -	depends on INTEL_SCU_IPC
> +	depends on INTEL_SCU
>  	select MFD_CORE
>  	help
>  	  Select this option to enable access to Intel MSIC (Avatele

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
