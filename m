Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344F8C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F54320575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf1WP5Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgD0Mgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgD0Mga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:36:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70507C0610D5;
        Mon, 27 Apr 2020 05:36:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t12so13319757edw.3;
        Mon, 27 Apr 2020 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PLUp+H7tLoE7SqL2B/5Sr5RyPMPq2y7xz4BTXAvd9zk=;
        b=Mf1WP5XnzaDH9wPHukRV8bbvRPNRmZ2+SC0Y3EZgsPhYhW+DN+4m+XsX6HAJMlmJFd
         9wjS25y9Zb1+0Z7IxanewEwe1SvR1CymsXiS0Mvyy7I3Ymvn7ek3E7B6bVbN3Gni+Or4
         vlleN1AxUg+T/IJGQ3MDxDoeeQqj6mhCk2Q+1WzBPAMItDnER+7Hv0oOQBpWUVyYUbKl
         YTKdKJ/tk7xyobHPvOf1TOkEVdTCvPggyXpDfakHgb1jrn722RJRqf2B+bx2gaQhJGS8
         lLNnttJpyVU4XSwBqVvcDR7jUydDRzNvqiIUOrzcK+pEu4QoPT8/8y8FbjnLzq553q9v
         utPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PLUp+H7tLoE7SqL2B/5Sr5RyPMPq2y7xz4BTXAvd9zk=;
        b=fAsovNJaz/0u5XyIjPiozg0XxL0YJ0PgX6OnUbTg5d7USnGuWyZN2E2lYhEk7AjzFt
         c6EXIBeONx5GgaxeUIhmKzn4wgbC3Dg5dyYd2RMHoXbC9hoVPGbHEhiTSM9aTPIWWsKU
         0bhI0ODW4E5KZGlHTiN0HaP+XTbsfGluo/7h/Uek/PZyhP+W3KKb0lbRK0K828DQ5mcW
         0W28GcmF2e1+3u2jrBRqdj52OlAZ5F3+iDf+czJmLL5XglcvdI61WI+CpmApH+jEMCAk
         F9sA8RrKaB1CQjU/9Ody4vhtC4ckBZqZiCH+/18BhSTo7IFGahRMLYir8kKwDp5TcSty
         t27Q==
X-Gm-Message-State: AGi0Pub/VKb4Kegyzu5NAdZS6SeHrF5fAE+Uvqlpyhs39tmq6XC3/SZn
        RjxiEjDd5Ekd29LJoLzB3/9+v3qeXztwZg==
X-Google-Smtp-Source: APiQypIWrAvc4+fSH7YxABePAo7Zu9cVJBR6VJKr1ooQvQPnNyq7X9TWDSeFjgjWJ2uHKxGNGt1ZSA==
X-Received: by 2002:aa7:dd84:: with SMTP id g4mr14403690edv.257.1587990987953;
        Mon, 27 Apr 2020 05:36:27 -0700 (PDT)
Received: from localhost (ipv6-80adf4751ff4da96.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:80ad:f475:1ff4:da96])
        by smtp.gmail.com with ESMTPSA id z26sm2941505ejb.36.2020.04.27.05.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 05:36:27 -0700 (PDT)
Date:   Mon, 27 Apr 2020 14:36:25 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: Initialize the Display
Message-ID: <20200427123625.GE18436@portage>
References: <1586424337-26602-1-git-send-email-oliver.graute@gmail.com>
 <20200409102013.GP2001@kadam>
 <20200427083642.GD18436@portage>
 <20200427093306.GU2682@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427093306.GU2682@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/20, Dan Carpenter wrote:
> On Mon, Apr 27, 2020 at 10:36:42AM +0200, Oliver Graute wrote:
> > On 09/04/20, Dan Carpenter wrote:
> > > On Thu, Apr 09, 2020 at 11:25:32AM +0200, Oliver Graute wrote:
> > > > From: Oliver Graute <oliver.graute@kococonnector.com>
> > > > 
> > > > Set Gamma Values and Register Values for the HSD20_IPS
> > > > 
> > > > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > > > ---
> > > >  drivers/staging/fbtft/fb_st7789v.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> > > > index 84c5af2dc9a0..b0aa96b703a8 100644
> > > > --- a/drivers/staging/fbtft/fb_st7789v.c
> > > > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > > > @@ -17,8 +17,8 @@
> > > >  #define DRVNAME "fb_st7789v"
> > > >  
> > > >  #define DEFAULT_GAMMA \
> > > > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25\n" \
> > > > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25"
> > > > +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> > > > +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
> > > 
> > > How do you know this won't break someone else's setup?
> > 
> > Should I declare an extra define for my values?
> > 
> > +#define HSD20_IPS_GAMMA \
> > +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> > +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
> > 
> 
> That's fine, but it can't be a compile time thing.  Both types of
> hardware have to be working/available at run time.

ok, what is the proper way to handover the gamma values during run time?

Best Regards,

Oliver
