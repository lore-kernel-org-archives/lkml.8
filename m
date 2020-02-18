Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804F9C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5416920801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="d3gbxN0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgBRTSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:18:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43419 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgBRTSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:18:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so11053140pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdis5Be2VylUOrCt10Cz6Yqnuk5YbPer1SATYKuRYm8=;
        b=d3gbxN0Eb1BCaa9gLyAoMPLm5uMOU4lHLgDMa8jfpH75ogLpXd95m95AIF0mTusmEH
         MUeKNqN0pYIwbAenzEdd6QpZDEC3FdYztj5vWXSffv/HT+hONr42+wiXCyRKuFNj1apz
         n1LZFAkPvnE/YliBP06K+CKh6vpG8IpwT9/g3jh7gZqPhdmJRh3TxNCoygUucNGuzWMU
         b912pH7Dx43ouulUY7T/lbOSD+DiLBgyaO1gaPYf2pN8VNRYmL0dwodx8Rc4fiBCYnJ9
         LS39tFVs1CRnOIgEToMois9djIZNuXBl5ptwoeDJX0ldqSpEPS5DeLhZj0mIua5gEtGN
         rCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdis5Be2VylUOrCt10Cz6Yqnuk5YbPer1SATYKuRYm8=;
        b=fAujNfaeFOEcle4yFNeLbqbZAITLh/Ns2OTKkMRwMWO0iTvXsRSpKvDDVzM0jgVauJ
         wvyn3qAkchpNraijYMGyHLdS4mxa2KmdFfhSO/o4hu1IcfwdpYe5KwzLJN57WfrP/dkk
         0RO5pVS4d1PQ9hVZycA6hxFSo2Q4JNEcGcRypg7DVhUuWZjvHLYtpDVDv/4c3/UhfeKA
         9n61gSrZ3JA/wUND73sfhglwKKdakH+vfh8YO1VrjpFBYui+OYhEJsOc/GyYp2NHsMVL
         juGY4Rv7RyT2rGqtjPSORw2XZivLdZvx2wRszUoWVHZSdMdViLHXDSpRK4hbmPVzmnyC
         fd0A==
X-Gm-Message-State: APjAAAUlNdxfLzd/b/QWOkXjltIOkCS3Tc//mtuzVKP77EJmpggJe7Qx
        pxKmVHRtnVg9iQLmiUoI8SlB59fUeo/TN1EX
X-Google-Smtp-Source: APXvYqyh0pn6jwE7x9qEuaVNzph8xYHQuv1XhcCWUwyL8qLvGC2/yIcQyOL4I2O/iBd7nq53fqFDCg==
X-Received: by 2002:a63:d18:: with SMTP id c24mr24447947pgl.218.1582053478100;
        Tue, 18 Feb 2020 11:17:58 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id a35sm5769697pgl.20.2020.02.18.11.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 11:17:57 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Wed, 19 Feb 2020 00:47:47 +0530
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835-camera: call function instead of macro
Message-ID: <20200218191747.GA12782@kaaira-HP-Pavilion-Notebook>
References: <20200218160727.GA17010@kaaira-HP-Pavilion-Notebook>
 <20200218183711.GE19641@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218183711.GE19641@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:37:11PM +0300, Dan Carpenter wrote:
> On Tue, Feb 18, 2020 at 09:37:28PM +0530, Kaaira Gupta wrote:
> > Fix checkpatch.pl warning of 'macro argument reuse' in bcm2835-camera.h
> > by removing the macro and calling the function, written in macro in
> > bcm2835-camera.h, directly in bcm2835-camera.c
> > 
> > Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> > ---
> >  .../bcm2835-camera/bcm2835-camera.c           | 28 +++++++++++++++----
> >  .../bcm2835-camera/bcm2835-camera.h           | 10 -------
> >  2 files changed, 22 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > index 1ef31a984741..19b3ba80d0e7 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > @@ -919,9 +919,17 @@ static int vidioc_g_fmt_vid_cap(struct file *file, void *priv,
> >  	else
> >  		f->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
> >  	f->fmt.pix.priv = 0;
> > -
> > -	v4l2_dump_pix_format(1, bcm2835_v4l2_debug, &dev->v4l2_dev, &f->fmt.pix,
> > -			     __func__);
> > +	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
> > +		 "%s: w %u h %u field %u pfmt 0x%x bpl %u sz_img %u colorspace 0x%x priv %u\n",
> > +		  __func__,
> > +		 (&f->fmt.pix)->width,
> > +		 (&f->fmt.pix)->height,
> > +		 (&f->fmt.pix)->field,
> > +		 (&f->fmt.pix)->pixelformat,
> > +		 (&f->fmt.pix)->bytesperline,
> > +		 (&f->fmt.pix)->sizeimage,
> > +		 (&f->fmt.pix)->colorspace,
> > +		 (&f->fmt.pix)->priv);
> 
> This is not as nice to look at as the original.  Just ignore the
> warning.
> 
> regards,
> dan carpenter
>
So, is this warning to be ignored from everywhere in every driver, as it
doesn't look good? And if yes, then why is it there in the first place?

Thanks!
