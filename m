Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4162074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1cq8qUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgFALdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgFALdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:33:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E750C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 04:33:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so5211532wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nd0MJv58FOzwtHGzKOAQUQrfp095J8UPcRViDxSn4NY=;
        b=W1cq8qUfXNb0j4Lq6BuNFnrIp53KOB8jyeE6rYZeTI51f51hwvHIG8BMXCMp30BfcV
         Kz/SCbb6ETAHq3dGo029IWxUjmMkUz9Max3D/z1jlGGo9qVQX5MaQ0y+BgRt/DHvwxo0
         RdVUU7GjYR/htIut780K5s1uKUZ3OK2iZVbmowEjMjE7GOiArJCYEkC6vgo9QPYK8nZO
         Lqab5QsLwiu8GkCE/AA07HEeFEaNoSkx5MwfuSlQJmGmLDy4JWZJBCDOv5WRJQzgVlwo
         r3zCmmu3iuz7KlkftwAHmjHe7lGtZDZgMfBzSIVGGV85FYemiKmMRx050a7sYfAPJPUW
         IkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nd0MJv58FOzwtHGzKOAQUQrfp095J8UPcRViDxSn4NY=;
        b=g412OeRGBZNqnymejuJYOTVNTPHJIe/ZVBCaH2UUOYOhe6P4FCe5qkBkF9/X5ndihj
         sFtnTRchkBgyH8XnYy/HMpd67sWHyaU5TcUnSoWder5Ds/vxOlfDSSjhx+5AaJvD/eMW
         hV+AQ8bs6d3kYSO9SFMgTw1qGG3OqzOkeAHou0ITpgP+yKsL8zemuxtKigpFY6y9XPkm
         Cu0UyyRO1xuse0rIhsoWikBXia/75BkYHEFwxZ7B/E7TjP97ok8PSaWP35yEkYfTGy21
         xWa6MNGe5JUzATF3mzZ4WAPmk+JKy8sydw4ejxDuTY8u+kxbyDQEvbK1dvbvT/mTHvM7
         pSYQ==
X-Gm-Message-State: AOAM530Dg+/jd1W14vnACzQVNxpCHkpjb8sn2XOKvpobhTqusK9582lJ
        0jm84ljV+vA7FVSed3LYAZW8TQ==
X-Google-Smtp-Source: ABdhPJznm2NwADIlcTttzQpXZsKob+NEyXiM45iR0TXFLhl9xhARzjwzu6BQz/MCHNd4RCDBIowhrg==
X-Received: by 2002:a5d:4e88:: with SMTP id e8mr22527436wru.188.1591011210824;
        Mon, 01 Jun 2020 04:33:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n23sm10731794wmc.0.2020.06.01.04.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 04:33:30 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:33:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 04/11] pwm: clps711x: Use 64-bit division macro
Message-ID: <20200601113328.oyhxosbtlfeaqytq@holly.lan>
References: <cover.1590514331.git.gurus@codeaurora.org>
 <dd03cc467ac3fc470826aef523822b32e15dc929.1590514331.git.gurus@codeaurora.org>
 <20200528203341.GA8065@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528203341.GA8065@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 01:33:41PM -0700, Guru Das Srinagesh wrote:
> On Tue, May 26, 2020 at 10:35:04AM -0700, Guru Das Srinagesh wrote:
> > Since the PWM framework is switching struct pwm_args.period's datatype
> > to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
> > handle a 64-bit divisor.
> > 
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > ---
> >  drivers/pwm/pwm-clps711x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > index 924d39a..ba9500a 100644
> > --- a/drivers/pwm/pwm-clps711x.c
> > +++ b/drivers/pwm/pwm-clps711x.c
> > @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> >  {
> >  	/* Duty cycle 0..15 max */
> > -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > +	return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> >  }
> >  
> >  static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > -- 
> 
> Hi Daniel,
> 
> Could you please review this patch when you get a chance to?

I don't normally review PWM patches... but this no longer has the bug
there was there when I first read this patch.


Daniel.
