Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FCAC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1264C2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEMqk30i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgAOInx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:43:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34042 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgAOInw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:43:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so14877150wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 00:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JgJxRJ3XdO/mGpmO1AU6iAV+74WpEq8F/G6duRRzsrg=;
        b=LEMqk30iZ9eJOob2PxVAoEtQ1V1FVARgOanVxg23K23TlNYZofIhM5Fqmdd/gnvkvx
         eP9aJ/Ziqn/M+7X5rPzPkKvKPi7jyNNozvGpW3EEgBdCtX5zLIrR7eTdUqkCWvq4cxfD
         2+CbRb8GKVkX6UFLVUeNvb6XSytUrEHi1LWrYHtd7zN3fIq5UOXEGHX2CJeiWL7Qqn4+
         jNhNc0ZaJaDDBz4KyimfYc+7gwzy6ULP+F1vYKkRLW9elOz5UpATUtESCYjDeyHSjrQb
         1CckX2prCA/MWzouLK9b8znrzMyA3kINC0y/vdyLsAvbXQ224zNksdkjOfAR03vqxLUr
         Ipyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JgJxRJ3XdO/mGpmO1AU6iAV+74WpEq8F/G6duRRzsrg=;
        b=CW6OX8O+uY+YIAAzG0NQn4tAG7t1qwvRXbDXApVWJW9iwD2FKK24QSY54uiRJKQba+
         CPIGpxveSQElfutvUGpU5b6cRiK8Y7pU+Otj7jh1hy3T/4o/28E55DTZJp9s6upDO5Nk
         1bz9r8Pov3sBPjLFVhjbAYXnlNb2oPMLiN7Gft/NiNYXAk9jcOqZm1UpQ45xvIYuvsGZ
         WPuf/7keS6K7/ci/LHXqN8b/ds7uV1hSBWqwuuiiRwYUjrKVUxX6xB8SEQ6r5qE78POr
         n4oRVBF6ykLkyYo/UBBsL9WX/5P+DxOsbhAvoXql6UlSto8pa1rBI8qLkA8kHhOpkbJb
         k1Jg==
X-Gm-Message-State: APjAAAXXif3UDJS0Kp5Z6e9zwz7WgvxK03R/I+TPOCA4V52747nbN/ST
        JWOXokfIQzkUeq+fuB1Av4aLEw==
X-Google-Smtp-Source: APXvYqwpifldiukskyzSH16X5ZU/IcnLnfby0n/XDK7fM++cvEcfBnkYcVOF03qVLRnQbL3LwL5srA==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr30582601wrn.239.1579077830593;
        Wed, 15 Jan 2020 00:43:50 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id e12sm23609153wrn.56.2020.01.15.00.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 00:43:50 -0800 (PST)
Date:   Wed, 15 Jan 2020 08:44:10 +0000
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
Subject: Re: [PATCH v3 26/36] mfd: intel_soc_pmic: Add SCU IPC member to
 struct intel_soc_pmic
Message-ID: <20200115084410.GG325@dell>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-27-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113135623.56286-27-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Mika Westerberg wrote:

> Both PMIC drivers (intel_soc_pmic_mrfld and intel_soc_pmic_bxtwc) will
> be using this field going forward to access the SCU IPC instance.
> 
> While there add kernel-doc for the intel_soc_pmic structure.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/mfd/intel_soc_pmic.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
> index bfecd6bd4990..bda22d750be6 100644
> --- a/include/linux/mfd/intel_soc_pmic.h
> +++ b/include/linux/mfd/intel_soc_pmic.h
> @@ -13,6 +13,20 @@
>  
>  #include <linux/regmap.h>
>  
> +/**
> + * struct intel_soc_pmic - Intel SoC PMIC data
> + * @irq: Interrupt number

Whose IRQ is this?  I guess the parent's/PMIC's?

> + * @regmap: Pointer to the regmap structure

Whose Regmap is this?  I guess the parent's/PMIC's?

> + * @irq_chip_data: IRQ chip data for the PMIC itself
> + * @irq_chip_data_pwrbtn: Chained IRQ chip data for the power button
> + * @irq_chip_data_tmu: Chained IRQ chip data for the TMU
> + * @irq_chip_data_bcu: Chained IRQ chip data for the BCU
> + * @irq_chip_data_adc: Chained IRQ chip data for the ADC
> + * @irq_chip_data_chgr: Chained IRQ chip data for the CHGR
> + * @irq_chip_data_crit: Chained IRQ chip data for the CRIT

Documentation is an ideal place to expand out these abbreviations.

> + * @dev: Pointer to the PMIC device
> + * @scu: SCU IPC pointer used for IPC operations

By this description I would have expected to find a struct of ops
(operations [call-backs]), but instead I found this:

 struct intel_scu_ipc_dev {
         struct device *dev;
         void __iomem *ipc_base;
         void __iomem *i2c_base;
         struct completion cmd_complete;
         u8 irq_mode;
 };

Probably better to describe it as a "pointer to SCU (whatever that
means) IPC (slightly more common, but still better to expand I think)
device data structure".

> + */
>  struct intel_soc_pmic {
>  	int irq;
>  	struct regmap *regmap;
> @@ -24,6 +38,7 @@ struct intel_soc_pmic {
>  	struct regmap_irq_chip_data *irq_chip_data_chgr;
>  	struct regmap_irq_chip_data *irq_chip_data_crit;
>  	struct device *dev;
> +	struct intel_scu_ipc_dev *scu;
>  };
>  
>  int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
