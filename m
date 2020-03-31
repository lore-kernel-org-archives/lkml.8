Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15404C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE05520786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLgHxdRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgCaNjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:39:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37586 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgCaNjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:39:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so4913643lfe.4;
        Tue, 31 Mar 2020 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ehKtKTWv5OyhK/hGbOxIcxVSEDA0CMEW5sXQeZ5+B9o=;
        b=gLgHxdRgN81Otol41/DHoOjlFwlqON+SrxjeJ/Mpf7S6ljPvZ0yl2WgV0Ov0S755Ej
         J8/Xpkno7dy9VnfXtBX4UmMreaU/B8+0A0LhUc0dt3RjLn5nNa8g1LUyCciuwqpGAPVM
         P5PsUu/z0yaO+2v6U2yZpAmPKw1tVFpTPcNx2M4iydOGozyZqxBTxEFVkyHGdD8pa4Qr
         SkUk24PyogAjDuYcLrzkktgJGxDCBq5eulmN43Ojbe7Jolgno/K8rGAg+FwZ1U/ZDFpq
         CFQWa+cfLl6B08GB6g00y+NcdpmU4DqDwKW/4B206cE6KPayopTIFolK7PdaMcda7CQS
         kr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ehKtKTWv5OyhK/hGbOxIcxVSEDA0CMEW5sXQeZ5+B9o=;
        b=gJCzbto3ueGfWkWtdR7YILQIAk33Jufkgem1rMtCyu9qqni7cENkER8uVZQSrCELlg
         7wz0suu4D+eJcNet7cRZWBaauyFNJPo+1NDq65UjuW1tdPht9nImyorNtjZFRcHL4+7E
         2HvksgAF1cn1QFJvtiGtVkcCtHbUY+nTJXZwEnvSqU7BhWYiMkWlue6we87VTC8AL2D8
         K6vD0j5ITNPf7XbTBwHrorsvKj4RGuDWzsl+HAzDyGXWsXBt4XsKhJyjkxRMLCF0kxEa
         Tg2bDsF0OF7vGzTC4vaHSEJEZIQm+GzQz/3ZMVMm7ei/HllDW3p1K8OyPN9I7CCx/UGq
         L8Dw==
X-Gm-Message-State: AGi0PuZTBj9RhmEd9BLOLgChtDelLEst/4puLj1owCjtqyeuUu5DU5i8
        tW9mPLKGR0Y3oGX5KD+xL2/g5yk0
X-Google-Smtp-Source: APiQypLMbRuqPTbzyhWJVMZKaKd9HESlTW88JEevuceUcltAFvBlfSuotj2xzvwzqHWTNBn3rtW3Sw==
X-Received: by 2002:ac2:5e27:: with SMTP id o7mr11685495lfg.163.1585661957416;
        Tue, 31 Mar 2020 06:39:17 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id x128sm9840997lff.67.2020.03.31.06.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 06:39:16 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] soc/tegra: fuse: Add custom SoC attributes
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200331103341.19571-1-jonathanh@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4f1fabbb-a0a3-6f7d-f62c-2bd545f2644a@gmail.com>
Date:   Tue, 31 Mar 2020 16:39:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331103341.19571-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.03.2020 13:33, Jon Hunter пишет:
> Add a custom SoC attribute for Tegra to expose the HIDREV register
> fields to userspace via the sysfs. This register provides additional
> details about the type of device (eg, silicon, FPGA, etc) as well as
> revision. Exposing this information is useful for identifying the
> exact device revision and device type.
> 
> For Tegra devices up until Tegra186, the majorrev and minorrev fields of
> the HIDREV register are used to determine the device revision and device
> type. For Tegra194, the majorrev and minorrev fields only determine the
> revision. Starting with Tegra194, there is an additional field,
> pre_si_platform (which occupies bits 20-23), that now determines device
> type. Therefore, for all Tegra devices, add a custom SoC attribute for
> the majorrev and minorrev fields and for Tegra194 add an additional
> attribute for the pre_si_platform field.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c    | 51 ++++++++++++++++++++++++++
>  drivers/soc/tegra/fuse/fuse-tegra20.c  |  1 +
>  drivers/soc/tegra/fuse/fuse-tegra30.c  |  6 +++
>  drivers/soc/tegra/fuse/fuse.h          |  8 ++++
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 10 +++++
>  5 files changed, 76 insertions(+)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
> index 802717b9f6a3..639734dca5df 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -300,6 +300,56 @@ static void tegra_enable_fuse_clk(void __iomem *base)
>  	writel(reg, base + 0x14);
>  }
>  
> +static ssize_t tegra_soc_majorrev_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	return sprintf(buf, "%d\n", tegra_get_major_rev());
> +}
> +
> +static DEVICE_ATTR(majorrev, S_IRUGO, tegra_soc_majorrev_show,  NULL);
> +
> +static ssize_t tegra_soc_minorrev_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	return sprintf(buf, "%d\n", tegra_get_minor_rev());
> +}
> +
> +static DEVICE_ATTR(minorrev, S_IRUGO, tegra_soc_minorrev_show,  NULL);

Checkpatch should give a warning about that permission isn't in octal
format, please don't ignore it.
