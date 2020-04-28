Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E282AC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBEC206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588069769;
	bh=THaChkg5CfTRb/fnLGAj3AdME68M3CyZDkf7IbMTH44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nx90pgt4dkYhigqE1hluY20Xl05UzWH5JOnmUo5Dz5F57RCzFhdrEdDIxPpVSsEiJ
	 u1y+k6Xi7Vhlhf+TJ09b3k2c6S2J3iEATn0Wt4n7TZi2kRYQ24cl5+SGOHJ3IFOIkl
	 fso7iH7VEnHHRcihQ4Jb7xcIvtUgQ457dGpWmrlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgD1K32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:29:28 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36271 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgD1K31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:29:27 -0400
Received: by mail-ej1-f68.google.com with SMTP id k8so16829075ejv.3;
        Tue, 28 Apr 2020 03:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0Hk2jtlMPUmgk5wMBNCoFe9z4FQnbCVLFfNI9DYDMA=;
        b=mENfK3UY8S8AHWDFfqu+FkvIfP5ugorOaDdNnZKmFGaNDX9UQ7zTy9qrR6Y1zeM2/K
         vOtCuZL3M7tCCUPeOclKThZZe49yUZhHpPtOyR1Nrd+CdU4C4OEEvSkAu7TI1uPoQe4Y
         Afxdf+vcrnE1Ydfc5GqtbBJbGzhkb51kmf/dT6Kq6E627lg0NF/Skaq8AU76j9IKOFyv
         lEMf5wWbbxj1pxJcoKgaETz6Zw8UtEnwsb9sfLwuVJfe+02iWDFlLAE0DeotAMAhqn07
         WjGZnc+Y1mQGJrs472Va5SX7BbUcbfDuiMa5Waul+NS5NgV/GNWk6eJHWP0vUycGg1gI
         caAw==
X-Gm-Message-State: AGi0Puak5GLKomZ0njwnIhJhrDEPMijTCZtXuVThwWSYdOF8vF+UA3U2
        iICJ3pQZ5XKFJhraJhxS9rFKGAGi
X-Google-Smtp-Source: APiQypKr6GD2aL3tPPbUuTROzheEEApy8SmudCRSo6VlI58fGXenrzH7a3YUW+NMM0uTKxPwP6jB8w==
X-Received: by 2002:a17:906:6441:: with SMTP id l1mr24694220ejn.148.1588069765119;
        Tue, 28 Apr 2020 03:29:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id gh8sm409642ejb.32.2020.04.28.03.29.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 03:29:24 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:29:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] arm: dts: s5pv210: aries: Enable ADC node
Message-ID: <20200428102921.GD23963@kozik-lap>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660998092302F2A78065E79A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660998092302F2A78065E79A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:36:01AM -0700, Jonathan Bakker wrote:
> On aries boards, the ADC is used for things such as jack detection
> and battery temperature monitoring.  It is connected to ldo4 of max8998,
> so only enable that regulator when we are actually using the ADC.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> index f30bdcb9c083..a103ddb0d720 100644
> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -193,11 +193,6 @@
>  					regulator-name = "VADC_3.3V";
>  					regulator-min-microvolt = <3300000>;
>  					regulator-max-microvolt = <3300000>;
> -					regulator-always-on;
> -
> -					regulator-state-mem {
> -						regulator-off-in-suspend;
> -					};

I would expect to keep it disabled during suspend. Why you had to remove
this part?

Best regards,
Krzysztof

