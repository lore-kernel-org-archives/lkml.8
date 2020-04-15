Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B5C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077E920768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAETmibb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895474AbgDOJZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895464AbgDOJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:25:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:25:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so18242339wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZWggYGy5+ypMqGqv3DNlvkeDC7Fwyk09CE6tJxrl9As=;
        b=yAETmibb8HvejiyM/sXx1gWJMBhdkYj+FhYy7xp+PelrTRoY6cWOI7vlWmSSyf3/r8
         Zs7zbY4OY0HkPENvC3MebqmtVYDArhkyX/g7FTCwfijd4SiDs1/6sbl1jq4MKLPElHnk
         9VKATFRT9sOJo4mRUK+WBMHugVTceCqQPi1zlKDZVNOSqDSOz+6uTukiwId07cKmWcgp
         XJxImHct6GIxxb7WyVTTlC6x3xy/LL9RImgVJnr1bV1Gk95SPry4pp++J2dF0JiCW1/i
         U/8iG7CmRO3gVZGqdupqmJQRzcbF2FVeyYIXOSA2bifkKrKSkYX5BoXstYm34gXq/2wL
         tN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZWggYGy5+ypMqGqv3DNlvkeDC7Fwyk09CE6tJxrl9As=;
        b=V+Wb0w7Nn8hRtFduu+3alUHhYQM4jurdRe2rp/AA+wakjHd9pDWrK63RAlG2iSAEhQ
         4YNVKdBU4QM4oZJAzL1Vim+lKjzqpiH66WuXcH1zI1Yo6pkBAaof2LW8QaWwAfdp7lGp
         hCqp7aB0xexdxyrQjLCt7ujGt7rL4djjdIUOz4CiBN6+jd2tWS1M90Gs+x5SebLGDINz
         6//2OwP1a3l5SJJr8kPQCSLEQWDW4QnyFUytFPcvhM2nJZ7mC59JMSlRxKRPP/1PsvXn
         pq7WQ5ZJQq0/TJYldFjd7kcEyF9Apyxiw0yR6K/r1N0plYn0QhoRq0dMrXwGrVqf+ZFI
         C/7Q==
X-Gm-Message-State: AGi0PuZ3bDWMhq55TJU7yztM7gm20hJS6gsNXd6KpwA5XFtA2MjPEd3G
        fzNDkmLrAleJTFv33lfpgaWj8g==
X-Google-Smtp-Source: APiQypIF43NYr8JHA746c2oer4jXDUVqBd6KdFR7FEBIeVOo3DZguLN98tLGGC6iP9SMBCFc+YgdsA==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr29224669wru.92.1586942738248;
        Wed, 15 Apr 2020 02:25:38 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id h16sm24769457wrw.36.2020.04.15.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:25:37 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:26:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Message-ID: <20200415092638.GG2167633@dell>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
 <20200320133123.GD5477@dell>
 <20200324110710.GL5477@dell>
 <20200324125735.2mjuvbxt5bpon2ft@pengutronix.de>
 <20200324130410.dwlg767ku6kwequv@holly.lan>
 <20200324142441.GD442973@dell>
 <20200324144307.kxhqzyjj4evrouqa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324144307.kxhqzyjj4evrouqa@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Uwe Kleine-König wrote:

> On Tue, Mar 24, 2020 at 02:24:41PM +0000, Lee Jones wrote:
> > On Tue, 24 Mar 2020, Daniel Thompson wrote:
> > 
> > > On Tue, Mar 24, 2020 at 01:57:35PM +0100, Uwe Kleine-König wrote:
> > > > Hello Lee,
> > > > 
> > > > On Tue, Mar 24, 2020 at 11:07:10AM +0000, Lee Jones wrote:
> > > > > On Fri, 20 Mar 2020, Lee Jones wrote:
> > > > > 
> > > > > > On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:
> > > > > > 
> > > > > > > Since the PWM framework is switching struct pwm_state.period's datatype
> > > > > > > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > > > > > > dividend instead of a straight division operation.
> > > > > > > 
> > > > > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > > > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > > > > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > > > > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > > > > Cc: linux-pwm@vger.kernel.org
> > > > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > > > Cc: linux-fbdev@vger.kernel.org
> > > > > > > 
> > > > > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > > > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/video/backlight/pwm_bl.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > Can this patch be taken on its own?
> > > > > 
> > > > > Hellooooo ...
> > > > 
> > > > Conceptually it can. As the last patch depends on this one (and the
> > > > others) some coordination might be beneficial. But that's up to Thierry
> > > > to decide how (and if) he want this series to be applied.
> > > 
> > > ... and on the backlight side we definitely need to know about the "if"
> > > otherwise there's no point in taking it.
> > 
> > Right.
> > 
> > I'm happy to wait for Thierry.  Although this isn't the only set he's
> > currently blocking.  Is he okay?  On holiday perhaps?
> 
> The newest commit by him in next is from last week. My guess is he
> just didn't come around yet to care for the PWM duties.

Looks like we missed the last release.

Let's hope we don't miss the next one also.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
