Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C362053B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6NFJSfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgEWRIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgEWRIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:08:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38215C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:08:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q11so1199034wrp.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iWQIftxz3JeSaFEWyWP77ojPUmj1NWrh+y4jjgLcyKs=;
        b=X6NFJSfvxhSBC8xSxM9yjKJkz2nxTH5gH4dXKNaCutG6fFfS/wfMvMydQ0q8/tNa6d
         pE5sP+aF8/3zkwmun4En6jlpuqANyDKlYREYvDb9mcQegZeO2TXg1cMLEINOOvBU6a9W
         FEwJbvhQmkCgd8pblNm7rrth/+DqAeINXltC0GKMusdgqlu8z+Wq6ls47VxLwHwxFEQx
         tl16N9XGrdP9thrZ2fi8Bak+/cK/eYuaOYU0oQtc9DdaYbrasOSRNWvpZkF12HgNS1pc
         E/HoKao6xztJdQJT231Bm6RLIZh6nC9m1LBsI4EN7Y55MWGloYoDx862cSyBH37SgRwR
         Aoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iWQIftxz3JeSaFEWyWP77ojPUmj1NWrh+y4jjgLcyKs=;
        b=DlSH7jvWyi8Nwy1ZH0QLQckdzaMd5/DVJwVPFPa95dC8UHCGljiY/cVOIp3CplDqFL
         rDdKpi3AsEuemq47/qbmggLCSIAX1tJc6sILqrfvvFXBQU91ncnnkQKfxGHGH8o7CBg0
         Rnapf6+/YI+p7VKmbiSOtycgueZD7Kegu8wcqzQZ46O0GmYGxGm+OtOw2IV+mRN/uTSW
         M/P+qIzW+ZwKwMVmuuYIj7hSJAS7M7820CwZhR+gHTekxgRFVnU8eik4f4zcJq7lmqNc
         Xv2FyEvA7FH/qmGdo4PQPznmgPhMlLxn++EZONgXyf/+lLXAg5x2zIh9MjqRpw1Uc9L+
         iKdQ==
X-Gm-Message-State: AOAM532l6HLa3Mk1ReeaTVRI7jF279J/e8zIYuwDvoaJkjJZVOpkZSci
        IXimblxNpGBxr4hJsuLghUMO3w==
X-Google-Smtp-Source: ABdhPJzi3zszxm/Xbxerc+UfbB5JYNQ3nEwV6m60j+HLsiFl+k0r3Alw3K6KWTZtS6WdRmhanRvhCw==
X-Received: by 2002:adf:9447:: with SMTP id 65mr8138681wrq.331.1590253689843;
        Sat, 23 May 2020 10:08:09 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 88sm12485764wrq.77.2020.05.23.10.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 10:08:08 -0700 (PDT)
Date:   Sat, 23 May 2020 18:08:06 +0100
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
Subject: Re: [RESEND PATCH v14 04/11] pwm: clps711x: Cast period to u32
 before use as divisor
Message-ID: <20200523170806.kzqcqzp2rtoqkqk4@holly.lan>
References: <cover.1589330178.git.gurus@codeaurora.org>
 <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1589330178.git.gurus@codeaurora.org>
 <20200521101934.j5ivjky4e6byveut@holly.lan>
 <20200521202525.GA24026@codeaurora.org>
 <20200522093738.cko5rj4wrxfd4hxu@holly.lan>
 <20200522231904.GB2873@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522231904.GB2873@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 04:19:04PM -0700, Guru Das Srinagesh wrote:
> On Fri, May 22, 2020 at 10:37:38AM +0100, Daniel Thompson wrote:
> > On Thu, May 21, 2020 at 01:25:25PM -0700, Guru Das Srinagesh wrote:
> > > On Thu, May 21, 2020 at 11:19:34AM +0100, Daniel Thompson wrote:
> > > > On Wed, May 20, 2020 at 03:55:57PM -0700, Guru Das Srinagesh wrote:
> > > > > Since the PWM framework is switching struct pwm_args.period's datatype
> > > > > to u64, prepare for this transition by typecasting it to u32.
> > > > > 
> > > > > Also, since the dividend is still a 32-bit number, any divisor greater
> > > > > than the numerator will cause the quotient to be zero, so return 0 in
> > > > > that case to efficiently skip the division.
> > > > > 
> > > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > > ---
> > > > >  drivers/pwm/pwm-clps711x.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)> > > 
> > > > > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > > > > index 924d39a..da771b1 100644
> > > > > --- a/drivers/pwm/pwm-clps711x.c
> > > > > +++ b/drivers/pwm/pwm-clps711x.c
> > > > > @@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> > > > >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> > > > >  {
> > > > >  	/* Duty cycle 0..15 max */
> > > > > -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > > > +	if (pwm->args.period > (v * 0xf))
> > > > > +		return 0;
> > > > 
> > > > This doesn't look right to me.
> > > > 
> > > > DIV_ROUND_CLOSEST() does rounded division and the short circuit doesn't
> > > > implement that.
> > > 
> > > My initial patch [1] was to simply use DIV64_U64_ROUND_CLOSEST(), but I
> > > got review feedback to add a short-circuit (same thread, [2]). I feel
> > > like I should skip the short-circuiting and type casting and simply just
> > > use DIV64_U64_ROUND_CLOSEST() - what do you think?
> > 
> > A trivial review of pwm-clps711x.c suggests that the period is always
> > 32-bit anyway so why not just throw away the short circuit entirely and
> > replace with a comment saying that CLPS711X has a hard coded period
> > that is always >1000000000 ?
> 
> Sorry, I don't follow the significance of 1000000000 - could you please
> explain?

One of the questions you are asked (by Arnd) was whether the period
could ever be larger than UINT_MAX. I think you gave the wrong answer
to that question when you said the divisor could be 64-bit. For this
driver I don't see how the period could ever be larger than 1000000000
(a number that is approximately 4x smaller than UINT_MAX).
 

> Just to clarify, what I was saying in my previous email was the
> following: I think it might be simpler to just throw away the short
> circuit and just do:
> 
> 	s/DIV_ROUND_CLOSEST/DIV64_U64_ROUND_CLOSEST
> 
> like in another patch in this series [1]. That should handle the
> rounding properly as per design. Is that okay?

The short circuit must go because it is broken and we wouldn't want
that code copied somewhere where the code would actually be reachable.
Personally I don't much care which macro you use although given the
divisor cannot be greater then UINT_MAX I guess DIV_ROUND_CLOSEST
is marginally better.


Daniel.
