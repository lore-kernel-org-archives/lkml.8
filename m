Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB057C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF49206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyAkfSNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMH2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:28:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46512 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMH2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:28:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id y30so4454742pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvA6h/ADCFmpO4/R58WqwTsyj0FZP41tEV3Px7U6ciw=;
        b=uyAkfSNHKkYjA+Ao2n9McRVmNL+oA0W06DzsicIwPy13UVOQPoRnEzPB+fYWQSNqFn
         hCer85T8KVYhhvKNgm1C/ud+9IAESjZqV5vQsDXMhfVQk1yfcUHyCzSL9GFwp5E5Xd5V
         N9sFhuifSO64xuoviHXsM0XziCYpGNEUo+J2mRkkilx01rKW0CzAvFjQyiBinqC1HGFy
         s6fAKlsFK2VbazbwSO3ILM+UNEaniNWnRgxKLFDIinTMjbeSHAqS8L7EUx97e9yTURaj
         RA8oQXMWWsKlISGqkRWzaQcnHQfRnY/LpxomBc21yeCxpROugy2MM/R9fD3TB+CafaMQ
         dx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvA6h/ADCFmpO4/R58WqwTsyj0FZP41tEV3Px7U6ciw=;
        b=Ki54GVXQUvzIv4t2r92Fn+eY7F3opMIT3gEBgrr6ZCCHkW3LztMyw04d9mb06KdTJv
         syhtyi1+BdAk7ryVvi7Zp0Ao69N8XjeZTKC6v9jSiFiixDoW98MWhTNUCa49Rmeo/Pq8
         Z87+IaQB3EkpRguWOQL7OTsYASO9tWUVOimp8n2ARAUGfhSGyZCBTSQIyMluHCmlCikX
         42Ojk4sqhNA5nVLgcOzaCZ/C3p+3n9h59X9iVPC1q87faIqNU5b9sdFaJ6SBzJ728peG
         xiG80X/NLwvEZ01rDG/0w3Hwq4YMq77+REHhHdc22JCV9ugudewzN/ZFqsgwx89XDtsM
         B1xw==
X-Gm-Message-State: ANhLgQ08pV1TJgPMhOBk/cMcDjZNCQfIJpGMgcF2/QnKq8SuD5gQNGJq
        B2q4XapCTRl6zD/rPLwNN6A=
X-Google-Smtp-Source: ADFU+vvsKOdZhRpVPKEtihUt4qwoBo6IF06H6dzQVfBXYYDmCpzKykdDoErfu+zAvN4SfAdRAILQDw==
X-Received: by 2002:a62:1a83:: with SMTP id a125mr12496744pfa.78.1584084478438;
        Fri, 13 Mar 2020 00:27:58 -0700 (PDT)
Received: from Shreeya-Patel ([1.23.249.228])
        by smtp.googlemail.com with ESMTPSA id y7sm17061880pfq.159.2020.03.13.00.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 00:27:57 -0700 (PDT)
Message-ID: <40e15d511cc2fbb4a13bb7df5a4f23ea942ab3a6.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: sdio_halinit:
 Remove unnecessary conditions
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Date:   Fri, 13 Mar 2020 12:57:50 +0530
In-Reply-To: <20200313072021.GQ11561@kadam>
References: <20200311133811.2246-1-shreeya.patel23498@gmail.com>
         <20200313072021.GQ11561@kadam>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-13 at 10:20 +0300, Dan Carpenter wrote:
> On Wed, Mar 11, 2020 at 07:08:11PM +0530, Shreeya Patel wrote:
> > diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > index e813382e78a6..643592b0bd38 100644
> > --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > @@ -551,18 +551,11 @@ static void HalRxAggr8723BSdio(struct adapter
> > *padapter)
> >  
> >  	pregistrypriv = &padapter->registrypriv;
> >  
> > -	if (pregistrypriv->wifi_spec) {
> > -		/*  2010.04.27 hpfan */
> > -		/*  Adjust RxAggrTimeout to close to zero disable
> > RxAggr, suggested by designer */
> > -		/*  Timeout value is calculated by 34 / (2^n) */
> > -		valueDMATimeout = 0x06;
> > -		valueDMAPageCount = 0x06;
> > -	} else {
> > -		/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
> > -		/*  TX/RX Balance */
> > -		valueDMATimeout = 0x06;
> > -		valueDMAPageCount = 0x06;
> > -	}
> > +	/*  2010.04.27 hpfan */
> 
> Delete these sorts of comments where it's just a name of someone and
> a time stamp when they wrote it.  We don't know how to contact
> "hpfan"
> so it's useless.
> 

Thanks Joe and Dan for your explanation. I will remove the comments and
send the patch again.

> regards,
> dan carpenter
> 
> 

