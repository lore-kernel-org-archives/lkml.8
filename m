Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23291C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A0F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj8ywQtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgHaLtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHaLtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:49:46 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BA6C061573;
        Mon, 31 Aug 2020 04:49:45 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ay8so5126440edb.8;
        Mon, 31 Aug 2020 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i3tk+pyCCALzmGiIIr14GTW97MYgxFsJAQqrrTnBu9Y=;
        b=Gj8ywQtnXqY1ivL8gvWTmcbAXVsPPxDJB1dMkPZE3GVG4SOwLd7lBu5p5E1hbG0Epp
         O3/yVRZqvARRT8qOSjWIvJQHvd4CS/WhstfOVyl7SsA3IrihpCRqBSj8QnL9wwzxJaWH
         02eIDL3/A1WRfcWMP1aodVBkpfMLkOFPJdvOcON7lAN+yOLWuJs3I+fAZivwcfNA+3vc
         6MarcedCWHn+OEzRYL3T8/vo6bBLuI6ZNuFt0T1xkdEcftKD2MkwL8pu8hBJHhm7wfhn
         eEIo4hBzy1Iz6egnNynk7kDAtJFeq/+MBi2ooLR8wf72cvDFdyF+ucQVvPJkInYDbUgq
         fTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i3tk+pyCCALzmGiIIr14GTW97MYgxFsJAQqrrTnBu9Y=;
        b=WQiw3508iOtBy4S8USu+J/6eDglbqFjFgmiCcBVv/kJNVEYvCw4PlrvjRMdE18WMql
         4QNSAg47ZP+lSc0O+d4hHw0CvtuPIDuyQaWCbp9XXornGOnTlUjl0Bre/Dfks3U5iqwg
         gCQyLcpcfDV6uf6Iopp26+nl038hZdH3QmO9OgUkCf/LfFuJAeQ8LH1NxCaGN9Jsse/n
         QZARaThu4+KfvXeg0A5+xggXjKczbmM7rMb2Jvs7ei/5NgmNVxHZr1Ss4tdH0AtSVTvg
         6zWSNZylQXTwgRn+SoKy6hpO6ddRPVQSUTT3dzuJrin5LUR/fbIP9yI0zDObIXRnUt3n
         G+KQ==
X-Gm-Message-State: AOAM532ozc5uHMkVbz3WwukNL6awHctjluDXLbsvbvLAZhMHJwsR65x5
        hPPUbE0liNT1QM4b0OQsxdM=
X-Google-Smtp-Source: ABdhPJzCzjISaXtxp0dKAAl1ICyA6IktfHJZxUfHHAXCafvG8aEkZ7bxWyUz7wpXVmkVAfgeDPMR3g==
X-Received: by 2002:a50:fa94:: with SMTP id w20mr922495edr.82.1598874584406;
        Mon, 31 Aug 2020 04:49:44 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cf7sm4972592edb.78.2020.08.31.04.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:49:43 -0700 (PDT)
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: enable rk3328-rock64 usb3 nodes
To:     lindsey.stanpoor@gmail.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, cnemo@tutanota.com, robh+dt@kernel.org,
        heiko@sntech.de, balbi@kernel.org
References: <20200826170623.15469-1-travelvia@airmail.cc>
 <20200826171230.17041-1-lindsey.stanpoor@gmail.com>
 <20200826171230.17041-2-lindsey.stanpoor@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <9751e24e-1fe2-33ab-4fa5-019af9ea7746@gmail.com>
Date:   Mon, 31 Aug 2020 13:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826171230.17041-2-lindsey.stanpoor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cameron,

Increase the version number for each new patch serie.

git format-patch -v4 -4 HEAD

In a previous comment I gave a sort example.
However, this patch serie is about usb3, so only touch the things
related to usb3 and leave the &uart2 node (legacy ;) ) untouched.

Improve the way in which your patches are send.

Your previous serie was incomplete.
Submit all patches with the same news server (Gmail for example) that
can handle plain text, because else you get 2 different Message-Ids:
<20200826171230.17041-2-lindsey.stanpoor@gmail.com>
<20200826170623.15469-2-travelvia@airmail.cc>

git send-email --suppress-cc all --annotate --to <..> --cc <..> <patch1
patch2>

Not sure how robh filters patches, but your serie 'must' show up in the
link below or else wait for an eternity to get a ack-by.

https://patchwork.ozlabs.org/project/devicetree-bindings/list/


On 8/26/20 7:12 PM, lindsey.stanpoor@gmail.com wrote:
> From: Cameron Nemo <cnemo@tutanota.com>
> 
> Enable USB3 nodes for the rk3328-based PINE Rock64 board.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 86cfb5c50a94..82c27eab6a52 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -363,10 +363,6 @@ &tsadc {
>  	status = "okay";
>  };
>  

> -&uart2 {
> -	status = "okay";
> -};
> -

>  &u2phy {
>  	status = "okay";
>  
> @@ -379,11 +375,24 @@ u2phy_otg: otg-port {
>  	};
>  };
>  

> +&uart2 {
> +	status = "okay";
> +};
> +

Don't touch/change.

>  &usb20_otg {
>  	dr_mode = "host";
>  	status = "okay";
>  };
>  
> +&usbdrd3 {
> +	status = "okay";
> +};
> +
> +&usbdrd_dwc3 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
>  &usb_host0_ehci {
>  	status = "okay";
>  };
> 

