Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4140C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C063206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlvw0sY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgEYWwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 18:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEYWwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 18:52:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 15:52:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y198so9294934pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PfS07SSYiDiBV7H6R+V0kW3PTtsPubPZKhzy0mE28v0=;
        b=jlvw0sY3S9oaxStamzqVdRemJG4iqQRwKc/q/wpWRTUFEivZSQvqEWURBAmkEb/0FJ
         mSlt9poFXH/rdogw/qMHukDjzO8Wwgrjnh9FR0dUcMtF61CqEnORUjCzbiLWnvHPeIc6
         zpCY2+XwmVceu3I5dr9UHyw4AB/2V8pjUgO/tmyNZK2H6MFmY6Is6uisNfax+e95tD0O
         EjqPOvJjRePwwdTEoQnwTaWCi2fyBXY3EA7C3Q2Krb/HGgFefnvTwqigP9vrP+B8lD76
         ZzftqD7OH5xYXvT4h8FYgjgX+Iu1N0eMDhW0uEpNqEag2rUfEi7cdrJtHQGt284FtwQc
         ju9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PfS07SSYiDiBV7H6R+V0kW3PTtsPubPZKhzy0mE28v0=;
        b=aMCzA6tIe/ZNoycXc71H7QDwTgUI1oMsZzBDKj8lOZiuWzFZ0X85Ei8q7sXppOceqZ
         ZOzx6I5JtBc6BCllEShHTa5i7HW7FJX6Y+4jxpVPLHhtx3TgRdr/4cD9B9wpQUFnj2IJ
         gt30S1BdyWN31l8fymNAPs4BnIWXNmoscZW0HKCW00VwoINQ/JDIQZTXLNPLQc78pqHN
         IJYyj0OI6wHMqJN6pVWU0o03yYaGvrpP945Uuh7Z7WDgYy9bI4Z6a2RAPE7MBTIQyERZ
         9GFH19lrpTvBW5TyXY1yyqYQZ0ibqUemOlEp4gKyZtJ5RXI68L0oVCb1VDiFdM5ixHkf
         EzaQ==
X-Gm-Message-State: AOAM53004dd1TuhNvz5c5rE22kN4v9otY3JM//hfrj75NQh5U3Bn9awo
        4M9OTsF4YLp77lv802YTw9U=
X-Google-Smtp-Source: ABdhPJx0XTvI4+EBWmJvUeEhjXDTKg5e77+fiyu8VMGad0TlpTrCSdhPGOU7pYNL00UjO0K3FqpO4Q==
X-Received: by 2002:a63:348b:: with SMTP id b133mr7926735pga.319.1590447120327;
        Mon, 25 May 2020 15:52:00 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id co16sm13292679pjb.55.2020.05.25.15.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 15:51:59 -0700 (PDT)
Date:   Mon, 25 May 2020 15:51:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kyungtae Kim <kt0755@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: [PATCH v2] vt: keyboard: avoid integer overflow in k_ascii
Message-ID: <20200525225157.GF89269@dtor-ws>
References: <20200523230928.GA17074@pizza01>
 <20200525000823.GE89269@dtor-ws>
 <20200525071507.GA169307@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525071507.GA169307@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 09:15:07AM +0200, Greg KH wrote:
> On Sun, May 24, 2020 at 05:08:23PM -0700, Dmitry Torokhov wrote:
> > On Sat, May 23, 2020 at 11:09:35PM +0000, Kyungtae Kim wrote:
> > > @@ -884,8 +884,11 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
> > >  
> > >  	if (npadch == -1)
> > >  		npadch = value;
> > > +	else if (!check_mul_overflow(npadch, base, &new_npadch) &&
> > > +	    !check_add_overflow(new_npadch, value, &new_npadch))
> > > +		npadch = new_npadch;
> > >  	else
> > > -		npadch = npadch * base + value;
> > > +		return;
> > >  }
> > 
> > So thinking about it some more, if we use unsigned types, then there is
> > no issue with overflow UB, and thus maybe we should do something like
> > this:
> > 
> > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > index 15d33fa0c925..568b2171f335 100644
> > --- a/drivers/tty/vt/keyboard.c
> > +++ b/drivers/tty/vt/keyboard.c
> > @@ -127,7 +127,11 @@ static DEFINE_SPINLOCK(func_buf_lock); /* guard 'func_buf'  and friends */
> >  static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];	/* keyboard key bitmap */
> >  static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. */
> >  static bool dead_key_next;
> > -static int npadch = -1;					/* -1 or number assembled on pad */
> > +
> > +/* Handles a number being assembled on the number pad */
> > +static bool npadch_active;
> 
> Much nicer, thanks for that, -1 is not a good thing to try to understand :)
> 
> > +static unsigned int npadch_value;
> 
> Nicer to just make this a u32 to be explicit about it?

I disagree, as this is simply an accumulator of an indeterminate size.
We are not talking to hardware here, so it does not have to be 32 bits,
just "large enough".

I'll resubmit with "unsigned int" and if you feel strongly about this
please tweak the patch to taste ;)

Thanks!

-- 
Dmitry
