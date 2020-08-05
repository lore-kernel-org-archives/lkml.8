Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD1CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673E322CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8zkKwEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgHEUPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:15:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21064 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726459AbgHEQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVpgCBuAAnsCtvrERYgdCRjC/scatHyJclE27/3mCkw=;
        b=U8zkKwExRznM8pqplosJ/ua6azvHDRzUfAkNVSgc+Y88DP8UqFVjFQJmntB+XnLa+ZUxjz
        jqKOC+4jPoM7eeRB5X0FTHSaRHwAm87Z7xbNk1eoUs73Lq5eUn0JEvhZXkV5BTg5wkFCQy
        1YApHOo1iOJ2czYwcYfUbx/kuh54Weg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-Oajkk616PMeyboigt-8DAw-1; Wed, 05 Aug 2020 12:02:14 -0400
X-MC-Unique: Oajkk616PMeyboigt-8DAw-1
Received: by mail-qt1-f197.google.com with SMTP id q19so22642053qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QVpgCBuAAnsCtvrERYgdCRjC/scatHyJclE27/3mCkw=;
        b=JqBNipwRk+fg0QlpjlmLDWMJajYa8LkrzpwRYRATvHCQLErA6r93c9iWN0SRSQOpOW
         feNm/gjgxYPJ0qWpjlLibscVr+JZQW4ebQfgUdVRSMRuoT/GPJWqWaDq90XD2FuuixBh
         dbWIghQRQuHZtSXMDqC28ORpRc2DZe9SADT22VGyY4Zz6zgjBf8C2r6nf1f0PFONb7rR
         rtsc8xpP0Z52/RDd2VJhvcE6KHz66wLSCd2ely9Wtx8hOr7Ib1GyuQOZknClGMSgTNFI
         SOtFkcO4pRG/8EqQx6nidxFkJzX3310xdJUKYt8ovau1Xfy77SHHLRviWNQ5IvfXY+iF
         cLdQ==
X-Gm-Message-State: AOAM531HFqkgw4Jow/hbGyqFXpwZUOPH2x/hF0Q2x7m6pNv9Lut0pAKW
        ASlls5LXQ5G4wFd6C7rqRWWhZGL9Atj5AT4C5F4p+spylBZC+UFDS03D1NKu1n9AXx4zZ4tC/cS
        ZeeQIwkUcOnDjnkgVghdE3HLM
X-Received: by 2002:ad4:554f:: with SMTP id v15mr4340227qvy.30.1596643333107;
        Wed, 05 Aug 2020 09:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCEt6SOCQIQNlgWFc2fSlY6oagtplzPU3BVLGyxoUjfFLo9zIHh0cZuAl1swq7IdMfrOOlkw==
X-Received: by 2002:ad4:554f:: with SMTP id v15mr4340183qvy.30.1596643332734;
        Wed, 05 Aug 2020 09:02:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d46sm2548270qtk.37.2020.08.05.09.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 09:02:12 -0700 (PDT)
Subject: Re: [PATCH 5/6] include: fpga: adi-axi-common.h: add definitions for
 supported FPGAs
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org,
        Mircea Caprioru <mircea.caprioru@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
 <20200804110658.40911-6-alexandru.ardelean@analog.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f69c3dc7-be50-9685-b70f-8af2f7093646@redhat.com>
Date:   Wed, 5 Aug 2020 09:02:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200804110658.40911-6-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/4/20 4:06 AM, Alexandru Ardelean wrote:
> From: Mircea Caprioru <mircea.caprioru@analog.com>
>
> All (newer) FPGA IP cores supported by Analog Devices, store information in
> the synthesized designs. This information describes various parameters,
> including the family of boards on which this is deployed, speed-grade, and
> so on.
>
> Currently, some of these definitions are deployed mostly on Xilinx boards,
> but they have been considered also for FPGA boards from other vendors.
>
> The register definitions are described at this link:
>   https://wiki.analog.com/resources/fpga/docs/hdl/regmap
> (the 'Base (common to all cores)' section).
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  include/linux/fpga/adi-axi-common.h | 37 +++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index 141ac3f251e6..7cca2d62cc45 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -13,6 +13,9 @@
>  
>  #define ADI_AXI_REG_VERSION			0x0000
>  
> +#define ADI_AXI_REG_FPGA_INFO			0x001C
> +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
> +
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
>  
> @@ -20,4 +23,38 @@
>  #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
>  #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
>  
> +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)		((val) & 0xffff)
> +
> +#define ADI_AXI_INFO_FPGA_TECH(info)		(((info) >> 24) & 0xff)
> +#define ADI_AXI_INFO_FPGA_FAMILY(info)		(((info) >> 16) & 0xff)
> +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)	(((info) >> 8) & 0xff)
> +
> +enum adi_axi_fgpa_technology {

enum types are defined but not used.  It would be better to convert all of these to #defines.

These are only the Xilinx values. Need to add the Intel values from

https://github.com/analogdevicesinc/hdl/blob/master/library/scripts/adi_intel_device_info_enc.tcl

The #define names need to include XILINX or INTEL.

Tom

> +	ADI_AXI_FPGA_TECH_UNKNOWN = 0,
> +	ADI_AXI_FPGA_TECH_SERIES7,
> +	ADI_AXI_FPGA_TECH_ULTRASCALE,
> +	ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS,
> +};
> +
> +enum adi_axi_fpga_family {
> +	ADI_AXI_FPGA_FAMILY_UNKNOWN = 0,
> +	ADI_AXI_FPGA_FAMILY_ARTIX,
> +	ADI_AXI_FPGA_FAMILY_KINTEX,
> +	ADI_AXI_FPGA_FAMILY_VIRTEX,
> +	ADI_AXI_FPGA_FAMILY_ZYNQ,
> +};
> +
> +enum adi_axi_fpga_speed_grade {
> +	ADI_AXI_FPGA_SPEED_UNKNOWN	= 0,
> +	ADI_AXI_FPGA_SPEED_1		= 10,
> +	ADI_AXI_FPGA_SPEED_1L		= 11,
> +	ADI_AXI_FPGA_SPEED_1H		= 12,
> +	ADI_AXI_FPGA_SPEED_1HV		= 13,
> +	ADI_AXI_FPGA_SPEED_1LV		= 14,
> +	ADI_AXI_FPGA_SPEED_2		= 20,
> +	ADI_AXI_FPGA_SPEED_2L		= 21,
> +	ADI_AXI_FPGA_SPEED_2LV		= 22,
> +	ADI_AXI_FPGA_SPEED_3		= 30,
> +};
> +
>  #endif /* ADI_AXI_COMMON_H_ */

