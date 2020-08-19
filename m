Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D9FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FF6207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCVFYUUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHSQ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgHSQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:57:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5BDC061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:57:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so2761824wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pYhO7PbSDe8dru1dk/4z1pXylH1/0mvxSDfzBAAOOrk=;
        b=CCVFYUUES1mcKzrLyt3Uqs9hjoeY+tJL5sKDMD90jBM3CZHjqak1l36nSYdbzmwHiM
         ShBiyCY0+gsgm2uPLeGH7G2dj9qmxT9SsE0Gr1R5exx5TeLVWfX6zkwSGuuAegx+feg9
         cd+kDQto4FDMM8i0SIpIsYNdmSqqDHNglX9B9xFrE/aL/GgzJ52q3fO+bVw7zQvPgWSb
         PvOzsN6j3X1nHaXqiW8Mx959AAaS7Hgg8/JFaY9LRnHCBDNWUHK0xgaeFzf6fqkFc0/e
         j6OuefwpxT6vbWxzlisTrBHsiDSOsGTXRXtsFzWaDolcVpQrLKf/xLen8IASn9H5CKDj
         y2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pYhO7PbSDe8dru1dk/4z1pXylH1/0mvxSDfzBAAOOrk=;
        b=qN7ZezDB3C1d3HsNmmMhln1P6GAvy1jpAJJC8odxXvJQ04ThgE9v+DyCFMZmkgomUz
         6dFYgTzu3eEy++qexSvFHq+la01//yrbYnBKmemhdYftaNcPp1Uf3ZU9rQ2lHfAJCtI6
         j4tFapEsVD81JaBvlEcdOjqGDf2aL1n3U2CHnP+s24il/gTG547OE058pYWaZiyUXd6l
         bGn+P57pgCvPjiww6JA2smahgwANIm4WkYRrcUII9+Vz1j9bRdtkphLxbG1P6vlRdIu9
         OjGNSRJ6g+tl6d8LZvVf0K9/gllxGpKjHQaGHP8Z07Y0aqqef+4TPTA+Vt22Q6Hnioj9
         79ow==
X-Gm-Message-State: AOAM532jLycXIoKzhNlV/exr8gOhFvmvZi7ODDUyoVvGxxAF5rZ7KlR0
        57bQlvhqVh2rxX+/1k7UiIORTA==
X-Google-Smtp-Source: ABdhPJz8qA3JOjs+ieJsjG0S48f11108VeZdaRV17brCNc3yaDMVfbUHOgU27SWVv+InAy1PTRPfOw==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr5661262wma.158.1597856225352;
        Wed, 19 Aug 2020 09:57:05 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c4sm41113675wrt.41.2020.08.19.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 09:57:04 -0700 (PDT)
Date:   Wed, 19 Aug 2020 17:57:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bryan Wu <cooloney@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Gyungoh Yoo <jack.yoo@skyworksinc.com>,
        Jingoo Han <jingoohan1@gmail.com>, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] video: backlight: sky81452-backlight: Fix reference
 count imbalance on error
Message-ID: <20200819165702.GC3248864@dell>
References: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020, Markus Elfring wrote:

> > When of_property_read_u32_array() returns an error code,
> > a pairing refcount decrement is needed to keep np's refcount balanced.
> 
> Can another imperative wording be helpful for the change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151
> 
> Would an other commit message be a bit nicer?
> 
> 
> …
> > +++ b/drivers/video/backlight/sky81452-backlight.c
> > @@ -217,6 +217,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> >  					num_entry);
> >  		if (ret < 0) {
> >  			dev_err(dev, "led-sources node is invalid.\n");
> > +			of_node_put(np);
> >  			return ERR_PTR(-EINVAL);
> >  		}
> 
> I propose to add the jump target “put_node” so that a bit of common exception
> handling code can be better reused at the end of this function implementation.
> 
> Regards,
> Markus

You can safely ignore any review comments from Markus!

However, this patch doesn't appear to be in my inbox.

Any ideas as to why?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
