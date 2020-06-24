Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A23C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F91C20706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Olmv6gOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404350AbgFXPn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404253AbgFXPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:43:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C832C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:43:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so4783667wmn.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QM8WHNX4JVzp1tT3alZnq1KeTZs+/wuqZ6hsAIKxcMA=;
        b=Olmv6gOFR6NbOAqgFzCBJx/sCYV/IREx2uVFDnyNUpwSY/mDxH4RQEaIIqwkxB4ICw
         OmlyLQtUPS7BKq9rjxqW7PsmSayRlxNsp3CBwqOphzrTJesmqsd/9oNQrA3IlpYUW0PZ
         fudSy31IumvzQrnLbUbjZSN5JGU9DP5XWjcMbAryKvmqsYifSefNVUqu2Su8OXQvPMVE
         dsVZolchYV5cK7gk0/DRSho+Ia0WuTzYBvKGvhRhtgPUURP4Ndkk9KgCqzQ81nwD7C0z
         CNpkJgEMvLNJ4qfZ1RFZnaKXBpWwSTDYACp0W4/tSjgSY9pUvicATh27hnBP4HKau3Ho
         XwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QM8WHNX4JVzp1tT3alZnq1KeTZs+/wuqZ6hsAIKxcMA=;
        b=LjfApev1z5DupqBGM8J56w48c3mO4Y9maMPS9/Rt5Lo54P8gQAiM0kKrocJlU31SPh
         ClvNVj8o+mZRv2oiXpz2UYoObWXeklVqU7Q/nTNaxczz027DuOqBXJBU+e4Nthzd0Kyz
         TGEZgOqEySWR0i+obwz7rpWBKky48X7kAJP+NP71v6XGgs9DyLLkQ2Mq3nTC87F1TJ5i
         UTeAkHT86XIaxPEYpTX190sSdFtq2pyeCaucLXilOeWbJykMcZknV0Xq9pAeoK0z55Ts
         Y2qM48Ckpng3LZxjDGN8J87OA7XAvHJHqRo2mFSevMPK1yCHHAn4SDfQHvAKdAJiHfHU
         DEZg==
X-Gm-Message-State: AOAM530byGlGtvkmyig3/CgvuTdmbD9c6N2tJxibVCdBpPB8fwJ/a28b
        eJb6zOBuPdAVelPJE4Q8wCFDeQ==
X-Google-Smtp-Source: ABdhPJwj67zlK538LD9M3+i8IFmwRhOZYaUWn/TQagj8Vmc62JySmFUQKYtWcbTLacIAWDoe1q9dnA==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr32069049wmj.31.1593013403867;
        Wed, 24 Jun 2020 08:43:23 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c143sm8597840wmd.1.2020.06.24.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:43:23 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:43:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8] Fix a bunch of W=1 warnings in Backlight
Message-ID: <20200624154321.GH954398@dell>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624153216.GA1814806@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624153216.GA1814806@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Sam Ravnborg wrote:

> Hi Lee.
> 
> On Wed, Jun 24, 2020 at 03:57:13PM +0100, Lee Jones wrote:
> > Attempting to clean-up W=1 kernel builds, which are currently
> > overwhelmingly riddled with niggly little warnings.
> > 
> > Lee Jones (8):
> >   backlight: lms501kf03: Remove unused const variables
> >   backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
> 
> 
> >   backlight: ili922x: Add missing kerneldoc descriptions for
> >     CHECK_FREQ_REG() args
> >   backlight: ili922x: Remove invalid use of kerneldoc syntax
> >   backlight: ili922x: Add missing kerneldoc description for
> >     ili922x_reg_dump()'s arg
> I wonder why these warnings show up as nothing pulls in this .c file.
> Anyway I would suggest to drop using kerneldoc syntax for single drivers
> like this - and the benefit here is low.
> Now they are typed, otherwise this ahd been fine in a single patch.

What do you mean by 'nothing pulls it in'?

> >   backlight: backlight: Supply description for function args in existing
> >     Kerneldocs
> >   backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
> >   backlight: qcom-wled: Remove unused configs for LED3 and LED4
> 
> The other fixes looks good.
> They are all:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks (although this should be Reviewed-by).

> >  drivers/video/backlight/backlight.c  | 2 ++
> >  drivers/video/backlight/ili922x.c    | 8 ++++++--
> >  drivers/video/backlight/lcd.c        | 1 +
> >  drivers/video/backlight/lm3630a_bl.c | 4 ++--
> >  drivers/video/backlight/lms501kf03.c | 8 --------
> >  drivers/video/backlight/qcom-wled.c  | 8 --------
> >  6 files changed, 11 insertions(+), 20 deletions(-)
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
