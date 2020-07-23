Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51489C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC67207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595526549;
	bh=L7mAxmHVhkd9XAl/j8yi81JBdCHJCn6CjruuXCp81Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2DCtqMpFyUpS6XvTEYLG6W2ZMK788zilIQA1AbH3/fYz0wzB67KbAW+YFThH3JEg+
	 451E5j/cMr5tmnOiyS5oZZOPR9gUe6E+oRaqUVceEDuckn4sajImuW88jvQQcw4x05
	 SRGSmzxFzRn0PpaEma5LZqkLQp/DP7i4xPk495v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgGWRtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:49:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34263 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgGWRtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:49:07 -0400
Received: by mail-io1-f66.google.com with SMTP id q74so7181067iod.1;
        Thu, 23 Jul 2020 10:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2YqHLx33D3lKQvsVIeu4fr2sY1tMGjPB3BoYpQvDkyk=;
        b=VcOXQGj8cS4Hu1inEHWtMPIDB9k7pUYZacGscPw3jELZxt33U2XFuPpQ4OkkG4bA9J
         C+sfM9+bFa1kJcAayLq8wS5+rgrcVUz84s/whdM4LzujO97d5GN2WHs+m7btQI0R4UOU
         DvoewFAJBy9RVyyapuW2pPjM8PFdQB3Ibjv1mHWZtPu/I6Aze8qv5LL19NusqNt3uKRn
         DBYiSCc3izmKCwM0l9JzChiKMv7F7RQdtq1PSOndxx2lObmVqMlpT4/nRWP1Usc3sJfm
         4Cv0ZbtUkMdtvOAp3/xFjwgUlseZ1mt1Cr2ywuBMngVXN/mvVUagm4GiyJS2HUQodBrK
         tylQ==
X-Gm-Message-State: AOAM531e2OZNW09HhsrbBHe31zzCKYbKfSsu8HZN4UAI/F5PnzH52NU5
        J9QgTcrA1tsQpcnbVeGsprA8tO7LyA==
X-Google-Smtp-Source: ABdhPJzMt9kdwyy1jgkZzCBgVSV/BYhakcwYiid0IQjxc9Xt7Tc5qUdDCRcJRJ0xVc1wcAH/BlPJGg==
X-Received: by 2002:a02:cb97:: with SMTP id u23mr6003181jap.113.1595526546930;
        Thu, 23 Jul 2020 10:49:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v10sm1797167ilj.40.2020.07.23.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:49:06 -0700 (PDT)
Received: (nullmailer pid 598211 invoked by uid 1000);
        Thu, 23 Jul 2020 17:49:05 -0000
Date:   Thu, 23 Jul 2020 11:49:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     miguelborgesdefreitas@gmail.com
Cc:     a.zummo@towertech.it, baruch@tkos.co.il, linux@armlinux.org.uk,
        alexandre.belloni@bootlin.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200723174905.GA596242@bogus>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 12:23:59PM +0100, miguelborgesdefreitas@gmail.com wrote:
> From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> 
> This adds direct-switching mode as a configurable DT flag for
> RTC modules supporting it (e.g. nxp pcf8523).
> DSM switches the power source to the battery supply whenever the
> VDD drops below VBAT. The option is recommended for hw designs
> where VDD is always expected to be higher than VBAT.
> 
> Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> ---
> Changes in v2:
> - Added extended commit message for git history
> - Separate dt bindings documentation into a single patch
> 
>  Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 7 ++++++-
>  Documentation/devicetree/bindings/rtc/rtc.yaml        | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> index 0b1080c..f715a8f 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> @@ -4,10 +4,14 @@ Required properties:
>  - compatible: Should contain "nxp,pcf8523".
>  - reg: I2C address for chip.
>  
> -Optional property:
> +Optional properties:
>  - quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
>    expressed in femto Farad (fF). Valid values are 7000 and 12500.
>    Default value (if no value is specified) is 12500fF.
> +- pm-enable-dsm: battery switch-over function is enabled in direct
> +  switching mode. The power failure condition happens when VDD < VBAT,
> +  without requiring VDD to drop below Vth(sw)bat.
> +  Default value (if not provided) is the standard mode.
>  
>  Example:
>  
> @@ -15,4 +19,5 @@ pcf8523: rtc@68 {
>  	compatible = "nxp,pcf8523";
>  	reg = <0x68>;
>  	quartz-load-femtofarads = <7000>;
> +	pm-enable-dsm;
>  };
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
> index ee237b2..a0048f4 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> @@ -47,4 +47,11 @@ properties:
>      description:
>        Enables wake up of host system on alarm.
>  
> +  pm-enable-dsm:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enables the battery switch-over function in direct switching
> +      mode. Should be set in systems where VDD is higher than VBAT
> +      at all times.

I'm all for common properties, but is this common across vendors?

> +
>  ...
> -- 
> 1.8.3.1
> 
