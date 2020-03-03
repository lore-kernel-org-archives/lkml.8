Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ABBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F9521556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583228786;
	bh=MmjhBwP0OJeH1drIjVjbIx9lndXBvbV9c68cDCjWLJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ty2++cCdtns3RJqLbMBpRwvLsAQ3GwLAyV70/4DtgKKBgGKCuPHlFGMl28ffl6Ytl
	 GrAdEgwuFkmBFQyf/Q9GEiG8oQQE9nbDc1YKhdbBEPWE7LQsLtoMfNMM3QuK+KBA/s
	 fkwunjntaV2kBTOQGRKLjDfr53hUmwQNX2+uC2jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgCCJqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:46:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39771 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgCCJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:46:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so3490100edb.6;
        Tue, 03 Mar 2020 01:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kH1X2D2b4dxEsrD1WLS0yi7/4Un3F5auBBafyxkyk3E=;
        b=H4vK3b2vCIkW0nESLucSGpVLVGDFKIcr270Yif5KPhipYdwyFneoap0sQ615V9nHGe
         u8pBJ+Z6ER1k7axQ0J3Qn2fGi0h0i+eiNV6f8DhIe7PDOmqkxgcdsgli4PcSdYS4lySi
         P8o9cR2MuLy7/9wsoLh+ycmu2VKKnvJRhlzdC6lniy9Jy+1/1F3Bkm2Ox0FLXNZnzCWu
         4qwR+32rZgeBwTJiB1GLM5tK5vQkw6jtHmxfL1KD/aGJpT0AXmfJ+XOdSoaqV9gWWx0y
         Jd+rINagOzwj6vQPZmoS0y9HBJcl+xnJTSBcUfXlYG6DzwY0tWTehrGQYFvwF3gT8PpP
         OMcg==
X-Gm-Message-State: ANhLgQ0JgHrnW4psk2uEW4vaG7CAQg4yFD5N27zISZBBZNYx/v+i+JSF
        G/f4cOxFBjTQBD4KS0gC3rM=
X-Google-Smtp-Source: ADFU+vtIFkJ0Ojpmt4sIzlMtbbpQ2p7WqilCvmNNEM5/2XzXv5agArQPt5qR3v51ebMmhc9eIYM6zw==
X-Received: by 2002:a17:906:c345:: with SMTP id ci5mr3170236ejb.132.1583228782674;
        Tue, 03 Mar 2020 01:46:22 -0800 (PST)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id r26sm657866edw.46.2020.03.03.01.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 01:46:21 -0800 (PST)
Date:   Tue, 3 Mar 2020 10:46:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/3] devicetree: bindings: exynos: Add new compatible
 for Exynos5420 dwc3 clocks support
Message-ID: <20200303094619.GA20181@pi3>
References: <20200301212019.2248-1-linux.amoon@gmail.com>
 <20200301212019.2248-2-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200301212019.2248-2-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 09:20:16PM +0000, Anand Moon wrote:
> This patch adds the new compatible string for Exynos5422 DWC3
> to support enable/disable of core and suspend clk by DWC3 driver.
> Also updated the clock names for compatible samsung,exynos5420-dwusb3.

Some time ago I mentioned this... so once more:
Do not use "This patch adds" but simple "Add".
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L151

Best regards,
Krzysztof

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Previous changes:
> 	Added the missing clock name for Exynos5420 complatible
> ---
>  Documentation/devicetree/bindings/usb/exynos-usb.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> index 6aae1544f240..220f729ac8eb 100644
> --- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> @@ -69,7 +69,9 @@ DWC3
>  Required properties:
>   - compatible: should be one of the following -
>  	       "samsung,exynos5250-dwusb3": for USB 3.0 DWC3 controller on
> -					    Exynos5250/5420.
> +					    Exynos5250.
> +	       "samsung,exynos5420-dwusb3": for USB 3.0 DWC3 controller on
> +					    Exynos5420.
>  	       "samsung,exynos5433-dwusb3": for USB 3.0 DWC3 controller on
>  					    Exynos5433.
>  	       "samsung,exynos7-dwusb3": for USB 3.0 DWC3 controller on Exynos7.
> @@ -82,6 +84,7 @@ Required properties:
>                  Following clock names shall be provided for different
>                  compatibles:
>                   - samsung,exynos5250-dwusb3: "usbdrd30",
> +                 - samsung,exynos5420-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
>                   - samsung,exynos5433-dwusb3: "aclk", "susp_clk", "pipe_pclk",
>                                                "phyclk",
>                   - samsung,exynos7-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
> -- 
> 2.25.1
> 
