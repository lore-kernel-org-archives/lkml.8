Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0906CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F092073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPWyxXN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGRRXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgGRRXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:23:37 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED9C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:23:37 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so8219710pgc.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HcAfWAuJs7AnNRSRiy1oRmYmT0Pdkox9ao1uD5Mkx/Y=;
        b=bPWyxXN1h5W20gdA0xK4HiU6GdVqO7ebCxVKv/03F7Eslhe8nhI1NzX/aujdjP6Rox
         5yvEoXivKhEiAbamNsQOJxUCMrZh9rTqqplKu8CcUo67FpJJDHI/dq99hxulvEKpOk/j
         UyOpIMZXhrQ/57rfjN0PS950oJWPNHKIjjqI5DIlK/kji2llpmjLZ83y40KbckMFnDq0
         dnBLavB7dA5j0+LWh68SXr6moLXt6YvgIyDSMevXlgEuX2qIh2+KXcKXHSGD9Nqg6IMx
         9Cd1Rm6DZoqrivpcrxjp8O/A8EXCIfFvq2l/wwk6ITipgFSFwjawn+TqD5ND5gOj78IG
         XqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HcAfWAuJs7AnNRSRiy1oRmYmT0Pdkox9ao1uD5Mkx/Y=;
        b=ntAnVpPoa93kLQY55FJEnIXYp0ntMGnki4bm9pNB8cY5cz+rIJ2SisbplP7tWDG2el
         PeI7n6V10/CB9H1AXr4qIWcMjrHOGbUgbIQowYqVqco6pHnJzz0YMpoIctUdbg5kgzPG
         lRcoSAC+BSIHEJ01IvxPMu5xM5C0FZ+TSrdNPC380mj4utonnRxNYMcCyZFhyKe1Gy7H
         YftgJK6W4rwDcw2LN4KIw3KcVK01vGNbzSdfKoNYdmogrSD4SxskT1wX7islbDnvMtdL
         +ePfG1lSL05xjFnga2w7AXkKJWx7GQXRsf2sWaQkscUHtVGFdaRU5Bitb8FGaf+4MFN0
         BaEQ==
X-Gm-Message-State: AOAM532ahrBiHgPa33C9Up2BFUv+biMcTEQgrbUgGxMb+CydJghQDjJ7
        hlOVlSV7gherCeONGVM1Kf4m93usMuw=
X-Google-Smtp-Source: ABdhPJzgMIaNsupHLN9mrwUkeIirNGygTkZHn+ssWWxkmgekHUpklVBeI7PFsnj5KE5n7seJQVZFtA==
X-Received: by 2002:a63:7357:: with SMTP id d23mr13162695pgn.393.1595093016518;
        Sat, 18 Jul 2020 10:23:36 -0700 (PDT)
Received: from saurav ([203.109.108.46])
        by smtp.gmail.com with ESMTPSA id q20sm10903991pfn.111.2020.07.18.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 10:23:35 -0700 (PDT)
Date:   Sat, 18 Jul 2020 22:53:30 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>, gregkh@linuxfoundation.org
Cc:     hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] Staging: comedi: driver: Remove condition with no effect
Message-ID: <20200718172330.GA27103@saurav>
References: <20200712070628.GA18340@saurav>
 <20200713133438.GA3122574@kroah.com>
 <7653a794-d5ed-5d9f-95af-745a88769092@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7653a794-d5ed-5d9f-95af-745a88769092@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:41:19PM +0100, Ian Abbott wrote:
> On 13/07/2020 14:34, Greg KH wrote:
> > On Sun, Jul 12, 2020 at 12:36:28PM +0530, Saurav Girepunje wrote:
> > > Remove below warning in das1800.c
> > > WARNING: possible condition with no effect (if == else)
> > > 
> > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > ---
> > >   drivers/staging/comedi/drivers/das1800.c | 6 ------
> > >   1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/staging/comedi/drivers/das1800.c b/drivers/staging/comedi/drivers/das1800.c
> > > index f16aa7e9f4f3..7ab72e83d3d0 100644
> > > --- a/drivers/staging/comedi/drivers/das1800.c
> > > +++ b/drivers/staging/comedi/drivers/das1800.c
> > > @@ -1299,12 +1299,6 @@ static int das1800_attach(struct comedi_device *dev,
> > >   			outb(DAC(i), dev->iobase + DAS1800_SELECT);
> > >   			outw(0, dev->iobase + DAS1800_DAC);
> > >   		}
> > > -	} else if (board->id == DAS1800_ID_AO) {
> > > -		/*
> > > -		 * 'ao' boards have waveform analog outputs that are not
> > > -		 * currently supported.
> > > -		 */
> > > -		s->type		= COMEDI_SUBD_UNUSED;
> > 
> > What gave that warning?  The comment should show you why this is good to
> > keep as-is, right?
> 
> One option is to move the comment into the '} else {' part that follows this
> part.
> 
> -- 
> -=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
> -=( MEV Ltd. is a company registered in England & Wales. )=-
> -=( Registered number: 02862268.  Registered address:    )=-
> -=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
@gregkh : Got the warning using coccinelle. 
@Ian: Yes, we can move comment to else part.
