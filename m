Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475AD2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590632976;
	bh=I7d2ARYFNaoUS4y6HBudICV1DoitdBXWssMAGuzWnHE=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=HAsj5Vr8D1NVCMVolrjAkAvW/UG+Jh2alb5TuvQH/19sj0jDbr6uKGtKueTGAr/Vn
	 GUdDJLGNOrxrE2UQq+/Nqm+xhoPpussgrdvlrxHOaKX0+9HnRsjeFXbLiK8880/5/Y
	 jBHNvqO8anreyFbFhmq+sFWA8oUdr8au60PedE/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgE1C3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:29:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40640 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1C3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:29:35 -0400
Received: by mail-io1-f65.google.com with SMTP id q8so26961079iow.7;
        Wed, 27 May 2020 19:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uKUnnOxF9cpoRDQnA++h7CPfUqtyF29gVMBaKZyv/Y0=;
        b=kg1LTEZhQxb7HJVJ1IQog3JuWZ7xWR6fI5tmoDcEpTLC+8uxKKOPI1Pa6bdKXI+adX
         fWAha59YG9+r8Oxtu1l/VdwHbm1YrSOxYn/Vwl/N9LhwR5prt7bx5mUt4mnjm/aXkYEU
         5/XOr5Rm0gB2P3WF5Mg3n5r/8hiMJbwwK7ai59cyeXMWyc0+c31hp/vvuilDGDczDFsy
         2ekWgRwUphJ/wZdjqr82jXb+QA4xcpwK0x3CRKgVLwlM2eeQZdPIwlGf8qOCc1gUQDZY
         ReDxEmHM28aHnnmCBE2NkaCwdte8ybeAutJFJsALwojh9xMgQxLgktpDRSeIe73G1vj4
         owfA==
X-Gm-Message-State: AOAM5333u5ngyp7sm4VfOWFNqrI8abOEh1qPw3t8o0yiPDT/cbjXQ1bU
        aHVLJxgBSyOfabzv/iBOhg==
X-Google-Smtp-Source: ABdhPJwYED2xCAsIzgBVyE9vczourY10RCn6ClYw2lvBmJb5XU3kxN6F+mP9W19n8mYNqGq07R2dMg==
X-Received: by 2002:a05:6638:101c:: with SMTP id r28mr815783jab.84.1590632973069;
        Wed, 27 May 2020 19:29:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z75sm2638939ilc.50.2020.05.27.19.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:29:32 -0700 (PDT)
Received: (nullmailer pid 3243939 invoked by uid 1000);
        Thu, 28 May 2020 02:29:31 -0000
Date:   Wed, 27 May 2020 20:29:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, SoC Team <soc@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/3] arm64: dts: sparx5: Add hwmon temperature sensor
Message-ID: <20200528022931.GA3238321@bogus>
References: <20200513134140.25357-1-lars.povlsen@microchip.com>
 <20200513134140.25357-3-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513134140.25357-3-lars.povlsen@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:41:39PM +0200, Lars Povlsen wrote:
> This adds a hwmon temperature node sensor to the Sparx5 SoC.
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> index f09a49c41ce19..b5f2d088af30e 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> @@ -233,5 +233,11 @@ i2c1: i2c@600103000 {
>  			clock-frequency = <100000>;
>  			clocks = <&ahb_clk>;
>  		};
> +
> +		tmon0: tmon@610508110 {
> +			compatible = "microchip,sparx5-temp";
> +			reg = <0x6 0x10508110 0xc>;

These nodes are all very odd with a couple of registers spread out at 
randomish addresses. DT nodes should roughly correlate to h/w blocks, 
not sets of registers for a driver like this seems to be.

Please make the dts files one patch. Reviewing a node at a time is not 
all that effective.

Rob
