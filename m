Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E05C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA27A20786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT9q5/jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCXLGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:06:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53758 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:06:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so2696981wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=85coQpfIuRs+sPyYMKP16shkvF4ULZs9j9T/GaUTXMA=;
        b=VT9q5/jF2VHIjb1DZzmV5uWK7Uk3Y+xVfuIZA7l+c4XrodjvqMvAkW8PC0kNkLrgYM
         3iana2G8gyGAfBnuD3tWiwwsYyndM+xe6dTnJx4myohK1jgaOQlQisQ7OTsUcVb4TiHA
         02CR0L4AmTwZ6TWYAuBgOaGihewpebEYX1AZBguETu6kswW6pM8vMDVrOiQXeCUsunFq
         kEXdn3pTTM5sKdZAVZryI6XQZDdohQZwEGPxqePgXmdn6YyIfmajV2Z0g6BrJMMfVDSZ
         3pxXnSFuuNvVcIbxrbVnimLoPa7kg7P2p0ab+jA5qME9NUdm6UCRGEBAySrUTOyPCHYo
         wC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=85coQpfIuRs+sPyYMKP16shkvF4ULZs9j9T/GaUTXMA=;
        b=JCuxO3+fp9cSIiwNrMeUusKrk7nvmUCcOcoFsPSkOxIXLNQnWqiLwTHBh9NH85UtuM
         EsfBspWiG1xYBtJQlyGmB8VjaC+LBJH+4JkKURstUXADvXSvu3+J9Ddr0EP+tM6CjgTe
         0g478OprqSko1LvkoGulMrVQA3kd47TjLmZCI9bv7JcE+aQ4kPJLVZVlO4UCaYuFwtbR
         RSt+NaBs26h6PnsNSnL+m4iVlENr1AA3MqUxQy7ShWVn/EWVfMD3hA4CNxQxed2HkpkY
         mhYglJDnec6pYhr1K41cfYHBY4hniLuzBOcauCqsW/M/6g9dHrpaPxdr/VHeQ0+q4KLD
         KV9w==
X-Gm-Message-State: ANhLgQ2AeAmsjwlfEohFUiYJg2hK9hyg2i85hkHjCun3as7xX/EUDBxL
        GfYJACaTcmt6LYTKflWVhzR7pA==
X-Google-Smtp-Source: ADFU+vvewfCSPSJ/JtfjkuAPYyDeLB/atTsI2+R8ZuR0hHyIJno3qS1Oa/lOKqJLRVXNnbIQOwCyQA==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr4980605wmi.74.1585047981072;
        Tue, 24 Mar 2020 04:06:21 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id 98sm28341407wrk.52.2020.03.24.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 04:06:20 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:07:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Message-ID: <20200324110710.GL5477@dell>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
 <20200320133123.GD5477@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320133123.GD5477@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020, Lee Jones wrote:

> On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:
> 
> > Since the PWM framework is switching struct pwm_state.period's datatype
> > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > dividend instead of a straight division operation.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: linux-pwm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > 
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Can this patch be taken on its own?

Hellooooo ...

> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index efb4efc..3e5dbcf 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -625,7 +625,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  		pb->scale = data->max_brightness;
> >  	}
> >  
> > -	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> > +	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
> > +				pb->scale));
> >  
> >  	props.type = BACKLIGHT_RAW;
> >  	props.max_brightness = data->max_brightness;
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
