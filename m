Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEBFC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B8220737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkKn03Z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgCLFNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:13:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387739AbgCLFNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 01:13:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id s2so2441157pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 22:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YEKIsskQn0GOha6Hy8EBgBpGLBH3R0T+GMiZwuU+3NI=;
        b=RkKn03Z0khNvGV49vae7g0mCMeSWxWcrTOH0vwkME15R5jHgdvGaF1fzrWixZXNhpz
         z7vwuAvDxXAQloCjyaMKOoatk63BYedEcrEQJQYtQ9Qo0RJvlKNIT0BuY5BZGV9jWYdE
         tbUyOmKYr9Zu0BMQouUb52PToIvH+Vqp+mDQ9+QhsF1p5jCu2yo64Q4ChO1Th/IeARhz
         H+AZ89aT9iRKOYdENHRtp5gYS8eWXZ+RYREC9J+2K7+Y+mMKvVcwBYa+Rp70udtd7iTL
         zRSJyuvMLmgnjZXeGC/mLWu75UQXf3rsRgfgYCpSoUCI1T6u0AKc2vmPEpI5UsJ6esnw
         J2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEKIsskQn0GOha6Hy8EBgBpGLBH3R0T+GMiZwuU+3NI=;
        b=hiHUG5J11h3kM+5jtm/dpnV0rSyHOHLQXWRmWrEXnCLHlbMJ6RhA4WkPa+TyaV3B7U
         wGSia+Asgl9BacjHcHXiLjDROOx2NvG018l4iCAwtDM5/vz6oPloMHnTf2tOphnkNnHS
         NrhxNL7p/Y+/Kze2bVtdRR1WC1rkBodFSeDQ8LdXJvoJL1unm5ELCiVRSUOCoDePaRyx
         lu8nZ0w+pdGa7nY7a2k0v7nlLk9y6k43stf3Jvppnwd5jsjjB/Yf1/F51ILImhGP3/AS
         DeOqlg40pf+g6wQYKvadJKhtSy9kMmgKTVq8hXEx2mFoeAM7PrtLOFTD9XtpAaKHcRHR
         DYAQ==
X-Gm-Message-State: ANhLgQ1m4iyFUveMKovHTmhbWSBZooWxK/Vc3QEvRn2m4QgQIbWg/yEW
        Z22jI3zz0Sip6gbqnRSbmf8kUw==
X-Google-Smtp-Source: ADFU+vtsAgyF9WS4YpdSeSG4o+74qHpCCJl/4A+wZ5CxbopnXAb1FWsKpqQjANUoZkL+SbpxxBJSGQ==
X-Received: by 2002:a63:ae0a:: with SMTP id q10mr6013377pgf.178.1583990026329;
        Wed, 11 Mar 2020 22:13:46 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a18sm136214pfr.109.2020.03.11.22.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 22:13:45 -0700 (PDT)
Date:   Wed, 11 Mar 2020 22:13:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        olof@lixom.net, Anson.Huang@nxp.com, maxime@cerno.tech,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [v1 4/6] arm64: dts: sdm845-db845c: Add pm_8998 gpio names
Message-ID: <20200312051342.GW264362@yoga>
References: <20200311123501.18202-1-robert.foss@linaro.org>
 <20200311123501.18202-5-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123501.18202-5-robert.foss@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11 Mar 05:34 PDT 2020, Robert Foss wrote:

> Add pm_8998 GPIO trace names. These names are defined in
> the 96boards db845c mezzanine schematic.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index a6b6837c3d68..e8c056d02ace 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -584,6 +584,36 @@
>  	};
>  };
>  
> +&pm8998_gpio {

Please sort nodes alphabetically by label.

Regards,
Bjorn

> +	gpio-line-names =
> +		"NC",
> +		"NC",
> +		"WLAN_SW_CTRL",
> +		"NC",
> +		"PM_GPIO5_BLUE_BT_LED",
> +		"VOL_UP_N",
> +		"NC",
> +		"ADC_IN1",
> +		"PM_GPIO9_YEL_WIFI_LED",
> +		"CAM0_AVDD_EN",
> +		"NC",
> +		"CAM0_DVDD_EN",
> +		"PM_GPIO13_GREEN_U4_LED",
> +		"DIV_CLK2",
> +		"NC",
> +		"NC",
> +		"NC",
> +		"SMB_STAT",
> +		"NC",
> +		"NC",
> +		"ADC_IN2",
> +		"OPTION1",
> +		"WCSS_PWR_REQ",
> +		"PM845_GPIO24",
> +		"OPTION2",
> +		"PM845_SLB";
> +};
> +
>  &cci {
>  	status = "ok";
>  };
> -- 
> 2.20.1
> 
