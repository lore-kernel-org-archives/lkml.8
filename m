Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE63C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D257B20578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG5aihcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCODdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:33:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37310 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgCODdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:33:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id w13so14074248oih.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 20:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IEb+NSlMbsrypsWmkX+nuM5EY+ct1whAxHi5by7wFZk=;
        b=bG5aihcWf/+r0MsUj2isrV4f3QSpFroQialqMuYStk5Nevs/PLSH6f2w49GWMx/oP6
         G2MdC00xkDVCEADr0Rjp6z5PRXrNvhCBgrvybUrvH4yVOZZh4GS9qNPsTlUlZ7B+4Fev
         9VT71bq8ZUBkWy2isWKKxhVd2GqnDj/abb8FkanwvIqVSVBlYXXPBrO3P9qaOUKvrAOV
         5x9sgvgdOlhXYH8lPEK7hfNHKkhKgf5w6dLTb/V0Ns1TIfcsJFplgHxrVOaNvSsa2pWy
         Sv/vGKqaEOmcV4kIUnJaUSZQU6+cumfyNoLy6T3rP8xyGpb9jJXOF0Y+h07gSmgKJqlO
         tNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEb+NSlMbsrypsWmkX+nuM5EY+ct1whAxHi5by7wFZk=;
        b=S5Nfydxtt42MYdfxw71kJfcJgQUzLHN7SdvUlHyi1RMEkLr4v/t8oGQcOtpXDyTaVq
         uS10BzC4S1JDyCn1ylV6RVvIXARL9sEGpByrTcT5Wm3uZ6DJdeXDgiCifYg+7OgiyLqL
         Y/LxriIfm0N5rBaYzcVmZMxGDY4hVAuAH4aB7jJ0TXIEIX7QNcH+dukuhSDiw1IpOep+
         u7vSa3cmXdGx+pZVWSBdxXsLSFX9FJH9NcL4pogoD++XIHEyL3ZK9swoB8HzU483TshB
         K1wqWkHEQkltJt1GN/EIfJUaeDxcOGIWBvqtPl5yL4rCPyfS0b6kH73r9ks5MkGGG+2a
         5g2A==
X-Gm-Message-State: ANhLgQ3abCGCFgSom2be3vdlAnKcWiqwVmafJIUtBTIYZSQ2HN1sz/ZW
        ygrsI0lIGrhJ/heTFf1mypYDS2UdJ+o=
X-Google-Smtp-Source: ADFU+vvWDA/UB5PKw9LjOeGxLGURwiON+mQeVoXZ4PlIhdgEdD1da3aGdyT6lGwiv2m6wxkHaHO2lA==
X-Received: by 2002:a17:90a:c715:: with SMTP id o21mr15127998pjt.160.1584185301961;
        Sat, 14 Mar 2020 04:28:21 -0700 (PDT)
Received: from Shreeya-Patel ([113.193.35.211])
        by smtp.googlemail.com with ESMTPSA id 8sm21886437pfp.67.2020.03.14.04.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 04:28:21 -0700 (PDT)
Message-ID: <4deeaef8f8e0f23a9adbfd7d98840624e2994cf2.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: rtw_mlme:
 Remove unnecessary conditions
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
Date:   Sat, 14 Mar 2020 16:58:16 +0530
In-Reply-To: <25a1aca2c993ecb70ba7cd9c9e38bce9170a98b0.camel@perches.com>
References: <20200313102912.17218-1-shreeya.patel23498@gmail.com>
         <25a1aca2c993ecb70ba7cd9c9e38bce9170a98b0.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-13 at 14:21 -0700, Joe Perches wrote:

Hi Joe,

> On Fri, 2020-03-13 at 15:59 +0530, Shreeya Patel wrote:
> > Remove unnecessary if and else conditions since both are leading to
> > the
> > initialization of "phtpriv->ampdu_enable" with the same value.
> > Also, remove the unnecessary else-if condition since it does
> > nothing.
> 
> []
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> 
> []
> > @@ -2772,16 +2772,7 @@ void rtw_update_ht_cap(struct adapter
> > *padapter, u8 *pie, uint ie_len, u8 channe
> >  
> >  	/* maybe needs check if ap supports rx ampdu. */
> >  	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable ==
> > 1) {
> > -		if (pregistrypriv->wifi_spec == 1) {
> > -			/* remove this part because testbed AP should
> > disable RX AMPDU */
> > -			/* phtpriv->ampdu_enable = false; */
> > -			phtpriv->ampdu_enable = true;
> > -		} else {
> > -			phtpriv->ampdu_enable = true;
> > -		}
> > -	} else if (pregistrypriv->ampdu_enable == 2) {
> > -		/* remove this part because testbed AP should disable
> > RX AMPDU */
> > -		/* phtpriv->ampdu_enable = true; */
> > +		phtpriv->ampdu_enable = true;
> 
> This isn't the same test.
> 
> This could be:
>  	if ((!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable ==
> 1)) ||
> 	    pregistrypriv->ampdu_enable == 2)
> 		phtpriv->ampdu_enable = true;
> 
> Though it is probably more sensible to just set
> phtpriv->ampdu_enable without testing whether or
> not it's already set:
> 
> 	if (pregistrypriv->ampdu_enable == 1 ||
> 	    pregistrypriv->ampdu_enable == 2)
> 		phtpriv->ampdu_enable = true;

But the else-if block which I removed in v2 of this patch had nothing
in the block.
It was not assigning any value to "phtpriv->ampdu_enable". ( basically
it was empty and useless)

Now as per your suggestion if I do the change then the value of
"phtpriv->ampdu_enable" will be changed to true when we have
"pregistrypriv->ampdu_enable == 2" condition. But in real it should be
the same as it was by default coming from the start of the function.
( This is because the else-if block was empty and doing nothing )

Please let me know if I was able to make you understand my point of
view here. Also, please correct me if I am wrong.


Thanks


> 
> 

