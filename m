Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B95AC3405F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2724B24670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaqnOCST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSSXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:23:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41205 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgBSSXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:23:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so1389908ljc.8;
        Wed, 19 Feb 2020 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A0DawmgTFOk5Mt/7IqD0y3krbs71MNO7CcDeqbzxFm8=;
        b=GaqnOCSTizR20UQOmQuOlyFxwqgWaRBW3GMqMLEuDrM6bpoSy0grtSEt4X5nz7L5a6
         Ft2AgACH/A+x4efhf60jM7ChmmY24ZCPmCCXnZylRIeUQ2GP3SUY+xIrVWY52V7Qu3Tp
         Xh0FmSTYQ7ND2F0fPqFjh7lbruvo5KmAGgS9eJ34Q4LU+82h5vuuPt7tUa43MDsvgVoq
         kfova+Mzh8AV98TtPx3CFnGCjRQCnstRUwoeyfTLX+4ZWe5LtnRdrymGAd3NfGY9G3Tj
         aMcK65gABupR8gAgBwwlcEQ1/CiB1F0T3eszAAoZepakDzQ9moMyW6T4Fnr0KzPNe6Rd
         TbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0DawmgTFOk5Mt/7IqD0y3krbs71MNO7CcDeqbzxFm8=;
        b=Yp3oogapsweIvDpZNZCqqYrP95j5CeESTrvMJMqMbml9DdBfIFVXVZQ+lfJweUam85
         ODLZyrRgKNZBfBfNuApOGGzOXpMI4dDFggwUUufEXvImNHpMDjEMN+COUe10PV+ITwfp
         S9tLMDnXK9dkYxJsH1UZQFw9/yPpV4nJxzNMiUPv8OV11YOWhKpHBdsvrlbEzyHx8rId
         uRjMDFXbrYizdsAXM0f8ve5abfo8eFjtWJgFzVeuqsvejaE/IDEmheMzWGlL0iujvM2c
         ei7ERFdX7aUBfONPDdQdc5fS631POiaKXhgGaCvDShUgI/lKJXO5bbHJU+06RxixRHVj
         f3Ew==
X-Gm-Message-State: APjAAAVw2/O8iX2kQgA7NejQ1QT7pXMPZjuHf+B3fFKUGSVW2akooykR
        j2Dk0vep5Xly8vm1YPWzqQKXdge976I8HA==
X-Google-Smtp-Source: APXvYqzQD8cYW2x08QgY7vSJARPguIoWGRl3Toe0iZU9Smf5PWnzwSEyQKMwWxswm+NjYKjmNIquFQ==
X-Received: by 2002:a2e:3619:: with SMTP id d25mr16201768lja.231.1582136590922;
        Wed, 19 Feb 2020 10:23:10 -0800 (PST)
Received: from Vesas-MacBook-Pro.local (87-100-247-140.bb.dnainternet.fi. [87.100.247.140])
        by smtp.googlemail.com with ESMTPSA id e5sm201582lfn.66.2020.02.19.10.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 10:23:10 -0800 (PST)
Subject: Re: [PATCH] devicetree: zynqmp.dtsi: Add bootmode selection support
To:     Mike Looijmans <mike.looijmans@topic.nl>, robh+dt@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     m.tretter@pengutronix.de, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200219122036.24575-1-mike.looijmans@topic.nl>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <07c68809-f65f-91ff-62eb-f12aa8960634@gmail.com>
Date:   Wed, 19 Feb 2020 20:23:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219122036.24575-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 19.2.2020 14.20, Mike Looijmans wrote:
> Add bootmode override support for ZynqMP devices. Allows one to select
> a boot device by running "reboot qspi32" for example. Activate config
> item CONFIG_SYSCON_REBOOT_MODE to make this work.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 26d926eb1431..4c38d77ecbba 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -246,6 +246,30 @@
>   			};
>   		};
>   
> +		/* Clock and Reset control registers for LPD */
> +		lpd_apb: apb@ff5e0000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0xff5e0000 0x0 0x400>;
> +			reboot-mode {
> +				compatible = "syscon-reboot-mode";
> +				offset = <0x200>;
> +				mask = <0xf100>;
> +				/* Bit(8) is the "force user" bit */
> +				mode-normal = <0x0000>;
> +				mode-psjtag = <0x0100>;
> +				mode-qspi24 = <0x1100>;
> +				mode-qspi32 = <0x2100>;
> +				mode-sd0    = <0x3100>;
> +				mode-nand   = <0x4100>;
> +				mode-sd1    = <0x6100>;
> +				mode-emmc   = <0x6100>;
> +				mode-usb0   = <0x7100>;
> +				mode-pjtag0 = <0x8100>;
> +				mode-pjtag1 = <0x9100>;
> +				mode-sd1ls  = <0xe100>;

This kinda looks a bit misuse of reboot mode support.

Usually you are signal with reboot-mode that you want to do factory 
reset, enter recovery mode or such things.

Now this signaling here is telling that this is used for selecting from 
what device to boot from.

Another problem is that this now modifies all Xilinx Zynq MPSoCs which 
is kinda wrong. This behavior should really be product/board specific 
and not common for all boards -- undoing this in product/board is 
somewhat cumbersome. Now this change hijacks the "reboot <arg>" with 
this behavior which is not so nice.

Thanks,
Vesa Jääskeläinen
