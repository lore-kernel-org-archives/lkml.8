Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B754C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1839621D81
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMnh4QiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgIINFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:05:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34490 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730244AbgIIM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599656139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwYS+mSAZh9umKPn+XGPvMZJwr6XsPjld2rKUSGA8Rw=;
        b=GMnh4QiPuS8omOo8XoOCnqWsZUKyNHS/LBIghfFkuD2nMF+vdLRU+2fxJ5NTljhNe+UtoM
        3D4XLn6kZcWxO39s/d1ARDtC7IuZ3VJ0p/TGvlw7Pz8qnIsV5Vlpnn/JOgtxNUnf6ZgNpE
        QZcefmKZX9w3KqauqAppZfsXGwgtKRM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-VulnUJBrOG2rleZuuSfpDA-1; Wed, 09 Sep 2020 08:55:37 -0400
X-MC-Unique: VulnUJBrOG2rleZuuSfpDA-1
Received: by mail-qt1-f197.google.com with SMTP id a26so1675623qtb.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cwYS+mSAZh9umKPn+XGPvMZJwr6XsPjld2rKUSGA8Rw=;
        b=KTkbN7Lbz6x89iDgoVEB5Di+zCZRhLySrfGKwlMMCB6r95WJOJzTqUuAeWaqyqVQwz
         EEBCj7WsskyRgeN57963qtZrUOpoXGyQE1uzFrhHNecVyeD7Yo1IkTq1eBCVFPaSYh4W
         lHfD7DjfQ2ntv4wNtqoIlT2+nDBbvTpXUIH0r7GDF8p/l48dm5FLrSLDU3FleEyWb8PB
         qcns+FChw/qPUPHMSjNovpmFNWW3ewzBYno4iEeUYfcDG4zqyk1cG+pv6DxKbvAkKbdo
         5UcJbJKEdG+HXmL+sAzgyRkx2fx3bWzpBY2Ftj5vS/ir4mkbOUg9dsbrG0Ot0b0ReNEk
         Buog==
X-Gm-Message-State: AOAM531NiMJzbZfQmpEegAfvp0Ow7kbRxSsZtcMB/4pEKdBB/3QcAhqf
        W+kl++nqL6piWoniysFLoHHg7Y+sXHz6UwGCyuzjbwnkcQUYTFyPaO5g/3GPNR0WNaeQDCrzm+g
        jYQFgOke90cpQVIihCCLI6HSE
X-Received: by 2002:ac8:6f21:: with SMTP id i1mr2884984qtv.89.1599656136989;
        Wed, 09 Sep 2020 05:55:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAIj5zzLDvbU03DdW5LzH2DlTOLQd0MX70bcYW8JI6RyB44+LsfBXI3JEmCXCLfXZjSEjh9g==
X-Received: by 2002:ac8:6f21:: with SMTP id i1mr2884957qtv.89.1599656136618;
        Wed, 09 Sep 2020 05:55:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 205sm2426626qki.118.2020.09.09.05.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:55:35 -0700 (PDT)
Subject: Re: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
Cc:     lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
Date:   Wed, 9 Sep 2020 05:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/20 10:48 PM, Xu Yilun wrote:
> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> patch moves struct dfl_device_id to mod_devicetable.h
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl.h              | 13 +------------
>  include/linux/mod_devicetable.h | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5dc758f..d5b0760 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
>  #include <linux/fpga/fpga-region.h>
> +#include <linux/mod_devicetable.h>
>  
>  /* maximum supported number of ports */
>  #define MAX_DFL_FPGA_PORT_NUM 4
> @@ -526,18 +527,6 @@ enum dfl_id_type {
>  };
>  
>  /**
> - * struct dfl_device_id -  dfl device identifier
> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> - * @driver_data: driver specific data.
> - */
> -struct dfl_device_id {
> -	u8 type;
> -	u16 feature_id;
> -	unsigned long driver_data;
> -};
> -
> -/**
>   * struct dfl_device - represent an dfl device on dfl bus
>   *
>   * @dev: generic device interface.
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 5b08a47..407d8dc 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -838,4 +838,16 @@ struct mhi_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +/**
> + * struct dfl_device_id -  dfl device identifier
> + * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> + * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> + * @driver_data: driver specific data.
> + */
> +struct dfl_device_id {
> +	__u8 type;
> +	__u16 feature_id;

I thought i saw feature id's going to 64 bit, does this type need to expand ?

Tom 

> +	kernel_ulong_t driver_data;
> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */

