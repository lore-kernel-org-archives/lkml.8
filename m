Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E98C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E2620707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6ixCOK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbgFYJ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390163AbgFYJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:28:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9122C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:28:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so5074922wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wZ3xkBP5w3XYMTvLh2QI28P63jV7LX3p1gxwcLJzIps=;
        b=C6ixCOK/9LDYiY0Iwdj0/BoXa6w1A+fVDp3C9NTV870s6gG/5+o7RFK86X+TVtVjXO
         q2Fd7XtY4cMBU7LnlK1fi0oh+7mNOpseqKEEx36NJDl9hPhjbJG0IlU8uohfhCtMDDmA
         qI9QC4KmUOG0sd4/G44kphZaMTKwFcfcEdkm0zc+uLUEmRyccAU6b1/6tbokYvVESB5D
         biufTUOLOJGcIHM127C7NlQGB1lzC3AI2IWv+5KLP9NFdARQ+/N3HC0NNULNu+xMmNsU
         tF9Tf7mDvqc8a6Uvm+GRJhJgfjdseGRLI2jYuGgtAk2BrNA0qS29Wnmqa6LG7O5ktqYm
         C87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wZ3xkBP5w3XYMTvLh2QI28P63jV7LX3p1gxwcLJzIps=;
        b=ciTl8AjiVl75+RJVGRQdxDqT+sTJxQY9t6Mxl5BCl6LMUOTZzg14GpMYYKmFFt+kRA
         Il8Y6E3fAxZUZg+NDu9QSr9EK3cASsDx0MrbKVSPK+4HaUpUe2+Uu507FzyeetzhagPJ
         i+sQCvdch3f0miTOGpOa10a6rxSJ5g+DGrWpYSHlTJYPs4/fa2lo5KZuGdqy9ulC8mxb
         BcjgBFkS9J+abu0LbqdkEgFKgSUGaNdqUPNAieaD02YVIcKccCNhDldHGWn9zYoNh3Gj
         /YVMdk6tZULcfIO8cn2d0+Zfk8mROpD2VcMYz4IPTlLaXZxCMb1ET12kG/xm8A1TB7wu
         B9bw==
X-Gm-Message-State: AOAM530bNIQDLtPojuyK5mkel0mMhi3DTupApkkzQH/2lo9IHM4eAoBy
        +v2Eqa34XBMnQnCiIdakgWfYeA==
X-Google-Smtp-Source: ABdhPJx8YLsfpqLIR1nhVjd+aDujzMmrOlHvE8k8+Jx+sWaM87JAC9/9z7769ytqaaAAvW8mDEkHGw==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr14655476wrg.205.1593077310376;
        Thu, 25 Jun 2020 02:28:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g16sm26802137wrh.91.2020.06.25.02.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 02:28:29 -0700 (PDT)
Date:   Thu, 25 Jun 2020 10:28:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jamey Hicks <jamey.hicks@hp.com>,
        Andrew Zabolotny <zap@homelink.ru>
Subject: Re: [PATCH 2/8] backlight: lcd: Add missing kerneldoc entry for
 'struct device parent'
Message-ID: <20200625092828.2cpdofvor6ehhbwh@holly.lan>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624145721.2590327-3-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:57:15PM +0100, Lee Jones wrote:
> This has been missing since the conversion to 'struct device' in 2007.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jamey Hicks <jamey.hicks@hp.com>
> Cc: Andrew Zabolotny <zap@homelink.ru>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lcd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
> index 78b0333586258..db56e465aaff3 100644
> --- a/drivers/video/backlight/lcd.c
> +++ b/drivers/video/backlight/lcd.c
> @@ -179,6 +179,7 @@ ATTRIBUTE_GROUPS(lcd_device);
>   * lcd_device_register - register a new object of lcd_device class.
>   * @name: the name of the new object(must be the same as the name of the
>   *   respective framebuffer device).
> + * @parent: pointer to the parent's struct device .
>   * @devdata: an optional pointer to be stored in the device. The
>   *   methods may retrieve it by using lcd_get_data(ld).
>   * @ops: the lcd operations structure.
> -- 
> 2.25.1
> 
