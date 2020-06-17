Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36342C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E3A207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwPD8fK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgFQFfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgFQFf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:35:29 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D160EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:35:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s13so663708otd.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fHG/w1e8yLTHpzr4hwGwsEUCs6bE9NYtF8uNRp5AdUU=;
        b=nwPD8fK4PQg4o/1yR3F4U2FVp6SkohvK02Jo12KlG+lE4CvKKo3uzuUsUCaAuOWM+i
         BweN6R9rl/Oj0UT+wqVgkPLpVzXF0IFCS/HlQBzPpnYtebAOxK/D6EW8wOKGF8ISakGO
         Pvfciz4gpGntdifhUsMsh2wF7K/rQ2FXSQbdXIp33MuphrUuj2cmJhrPl2pDV1Ze8nX8
         AViBLqFenVRVbqQu496+XkSpl9cEnBlhOR1DgK2Qi0IHXqItacw7cYFZFcDGoy39ecrm
         4HTGDZT/vtkQJ0PUBvXO+8SgoWoEsvECFm5y+bj3z7JQA1sJXAfWcUFA23sUN0ut34wK
         DmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fHG/w1e8yLTHpzr4hwGwsEUCs6bE9NYtF8uNRp5AdUU=;
        b=DlDesdWYYYHFI1gWKCk/3WX+VCoDRAZdU0rcJHJ2w2eh7DxdxS3dUpjqTFinObHOWM
         5/IMoayvktZ5btyO8rxvEj7o85xAujrFqYn/ojD+AvCz06xpVacuHWcJojSyONMeZ9aH
         a4U39hktzVokbdiMjvyiJdAtu/dvSDCQhdELVPyNWr0JxmDzHu9FnBDQfjW5rt+jjLFZ
         YXZThlf0yGTrt+6x95nztsXfuMqNmoD1puUFhY+VwsXmo9dzEX2LQp+yE9WnBEh/KRJ8
         EDn2DMRqYln+yXczzEsGPvOyrtJ73Qz+2r4QBu2TYhmq4gLqBZtklUed0+mb8vtlo+ZK
         I/Kg==
X-Gm-Message-State: AOAM533G967ntdjhJoDbmd8/arsBKZPDkFB5BADx/uzAFV5CBZglfFZD
        KI7YtPICSgbRT5+rslf3ptwEuQ==
X-Google-Smtp-Source: ABdhPJwg1mt33T11n882LJlXCOpmqr4Mfv8iLvxPSI8/+BHZ4PTHoIG3vNbEKlfuxtahElyRBc88sw==
X-Received: by 2002:a9d:6949:: with SMTP id p9mr5645333oto.7.1592372128046;
        Tue, 16 Jun 2020 22:35:28 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 53sm4582582otv.22.2020.06.16.22.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 22:35:27 -0700 (PDT)
Date:   Tue, 16 Jun 2020 22:35:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] usb: dwc3: qcom: Make sure core device is fully
 initialized before it is used
Message-ID: <20200617053524.GD11847@yoga>
References: <20200616133734.1.I1902d0d48e4f3d4c5b5f1a2008108a4cd3c5ddb5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616133734.1.I1902d0d48e4f3d4c5b5f1a2008108a4cd3c5ddb5@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16 Jun 13:37 PDT 2020, Matthias Kaehlcke wrote:

> dwc3_qcom_of_register_core() uses of_platform_populate() to add
> the dwc3 core device. The driver core will try to probe the device,
> however this might fail (e.g. due to deferred probing) and
> of_platform_populate() would still return 0 if the device was
> successully added to the platform bus. Verify that the core device
> is actually bound to its driver before using it, defer probing of the
> dwc3_qcom device if the core device isn't ready (yet).
> 
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver").
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

I wish there was a better way than to unregistering the dwc3 device when
this happens. E.g. if dwc3 fails for some other reason we still would
keep probe deferring the qcom part and each time attempt to reprobe dwc3.

But with the way the device model is used here I don't have any better
suggestions, and until a better solution appears this does improve the
situation...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> depends on:
>   https://lore.kernel.org/patchwork/patch/1251661/ ("driver core:Export
>     the symbol device_is_bound")
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 1dfd024cd06b..5a9036b050c6 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -537,6 +537,16 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * A successful return from of_platform_populate() only guarantees that
> +	 * the core device was added to the platform bus, however it might not
> +	 * be bound to its driver (e.g. due to deferred probing). This driver
> +	 * requires the core device to be fully initialized, so defer probing
> +	 * if it isn't ready (yet).
> +	 */
> +	if (!device_is_bound(&qcom->dwc3->dev))
> +		return -EPROBE_DEFER;
> +
>  	return 0;
>  }
>  
> -- 
> 2.27.0.290.gba653c62da-goog
> 
