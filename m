Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F97C34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBFD24699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byT2rBha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbgB0O5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:57:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbgB0O5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:57:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id v2so3683227wrp.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8UJCHjiQkoyahVk3JVpGT7p90RFMuXW7y1DGNJVn3I=;
        b=byT2rBhaJ3NpZXKQ3xNyKgwH/jTsZDf0x3JScBZse8RZ9ksFtO/1/rzbmUu0CFRSmu
         UdjxqFPEVzG5/nlQN1mO3unL4TpB2ZWZqMmJ1QFXtg0gtHTDJmuH5Mr9BHs1Z27Lz8kL
         uNlFPb6j5UW2b9rOFGC2vB0UPG4BqkPa/9nbKFUK4OLlUK/pY6kMcaGVXtUMgczw0Kp6
         oAm41AQENKBtmKvcKzZCOGkW797Vm6p0Mh+Z9k7y+u3Fd4p0Ai6LFLrNKSdom9zxuj/A
         QU7eFBjQf0U6mgt31hcNhrgdDBHWHjTyZwkPPZmLd1Qrq5BEShppzQjd8edcXAQXb6PS
         SaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8UJCHjiQkoyahVk3JVpGT7p90RFMuXW7y1DGNJVn3I=;
        b=JGCqSL/r68umICggsKkOzmPIV1JyhYAd5LywlI9rj9gqAhLTBBvZZKPJEAPKtmyGWw
         w3DjvhAOc4PQHLVGOCiubc7FhCTmSou+y+lfKQa8F7suokDrdCwQ/5KrRfjhkEPNSJ8U
         8bxa0FzMGxZmeMl20v8NTYJLXxCLnjVVA4GzP4Hasr7lovPR4KiCXeYcq5OOnIGPJQgW
         d0EPBj9Wo+pwbB31eR3Rp/5eYOJJxTQkL+lBAZO+HVVhn7pV9qFO6QBigZrQWSKMAPRV
         KFz9n3evx2I7+Ksf892Mx31HR5cjYCx2Gx9Too5Bv3DR+nuP3FGHQW0gi5KDz+ao6FbV
         0DFg==
X-Gm-Message-State: APjAAAWgHiaSab+NwaK0jAsHlN+vcrzGItTBAYvT+KXO/jU4boGEHqkf
        A8+T9NvOIVhcYAMAF1FiNHM0cA==
X-Google-Smtp-Source: APXvYqyyrixRf/9E0uAEum8ogR5+reOoYYP6OuOAEbkyXb2Dh9c2XHojBOJxbwOJHAKTPtAucIdiBw==
X-Received: by 2002:adf:f892:: with SMTP id u18mr5040913wrp.328.1582815463904;
        Thu, 27 Feb 2020 06:57:43 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h15sm1262654wrr.73.2020.02.27.06.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 06:57:43 -0800 (PST)
Date:   Thu, 27 Feb 2020 14:57:41 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gyungoh Yoo <jack.yoo@skyworksinc.com>,
        Bryan Wu <cooloney@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] backlight: sky81452: insure while loop does not
 allow negative array indexing
Message-ID: <20200227145741.v3r4qzkfsrwpy33h@holly.lan>
References: <20200226195826.6567-1-colin.king@canonical.com>
 <20200227114623.vaevrdwiduxa2mqs@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227114623.vaevrdwiduxa2mqs@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 11:46:23AM +0000, Daniel Thompson wrote:
> On Wed, Feb 26, 2020 at 07:58:26PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > In the unlikely event that num_entry is zero, the while loop
> > pre-decrements num_entry to cause negative array indexing into the
> > array sources. Fix this by iterating only if num_entry >= 0.
> > 
> > Addresses-Coverity: ("Out-of-bounds read")
> > Fixes: f705806c9f35 ("backlight: Add support Skyworks SKY81452 backlight driver")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> > 
> > V2: fix typo in commit subject line
> 
> Isn't the correct spelling "ensure"?
> 
> 
> > ---
> >  drivers/video/backlight/sky81452-backlight.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> > index 2355f00f5773..f456930ce78e 100644
> > --- a/drivers/video/backlight/sky81452-backlight.c
> > +++ b/drivers/video/backlight/sky81452-backlight.c
> > @@ -200,7 +200,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> >  		}
> >  
> >  		pdata->enable = 0;
> > -		while (--num_entry)
> > +		while (--num_entry >= 0)
> >  			pdata->enable |= (1 << sources[num_entry]);
> 
> This look still looks buggy to me (so I'd second Walter's request to
> change it to a for loop). If the code genuinely does not contain a
> bug then it probably needs a prominent comment explaining why it is
> correct not to honour sources[0]!

Ignore the "still looks buggy". A mental mis-step when switching
contexts...

I think my English is still correct though ;-)


Daniel.
