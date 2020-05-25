Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DE2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CAF2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590390911;
	bh=YFgtG6huhkHRiOdwNZCAV+D12/UIoXk/fcLnM/lUdeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jAqNwZger0Ru4mxrlwNbSPlu/7v+QJpxEh88DIJebO7BXupEjLG+xZBBUSWiSvbJz
	 z/7ug8OgVXEfRKoegJ6/4Jxy+5aZ1HgfEv9h1YZCY9v8Ecb4GbQSbqnpMUWcLrluBY
	 OX7K8tQXmaUXeH+ixzLbJPGhUNGVp8+aS5kCVpe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbgEYHPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388982AbgEYHPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:15:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D01A2071A;
        Mon, 25 May 2020 07:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590390910;
        bh=YFgtG6huhkHRiOdwNZCAV+D12/UIoXk/fcLnM/lUdeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vtrWywB3/mB0QEDRNMzGH93WaxvezI456K+fFbe0o2XNJnOjXOunVsfW2JXT4Bmkm
         mU+uEh3a7fQ9AyHERKOZ4LmVbAnuKydoUcT1mJhDlYXIim/TJJWH9nBGVKlv5iD02K
         YX/oZJ7wPu96i4zzcBYWv4lwXWz/3XO9hrCcncnw=
Date:   Mon, 25 May 2020 09:15:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kyungtae Kim <kt0755@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: [PATCH v2] vt: keyboard: avoid integer overflow in k_ascii
Message-ID: <20200525071507.GA169307@kroah.com>
References: <20200523230928.GA17074@pizza01>
 <20200525000823.GE89269@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525000823.GE89269@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 05:08:23PM -0700, Dmitry Torokhov wrote:
> On Sat, May 23, 2020 at 11:09:35PM +0000, Kyungtae Kim wrote:
> > @@ -884,8 +884,11 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
> >  
> >  	if (npadch == -1)
> >  		npadch = value;
> > +	else if (!check_mul_overflow(npadch, base, &new_npadch) &&
> > +	    !check_add_overflow(new_npadch, value, &new_npadch))
> > +		npadch = new_npadch;
> >  	else
> > -		npadch = npadch * base + value;
> > +		return;
> >  }
> 
> So thinking about it some more, if we use unsigned types, then there is
> no issue with overflow UB, and thus maybe we should do something like
> this:
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 15d33fa0c925..568b2171f335 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -127,7 +127,11 @@ static DEFINE_SPINLOCK(func_buf_lock); /* guard 'func_buf'  and friends */
>  static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];	/* keyboard key bitmap */
>  static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. */
>  static bool dead_key_next;
> -static int npadch = -1;					/* -1 or number assembled on pad */
> +
> +/* Handles a number being assembled on the number pad */
> +static bool npadch_active;

Much nicer, thanks for that, -1 is not a good thing to try to understand :)

> +static unsigned int npadch_value;

Nicer to just make this a u32 to be explicit about it?

> +
>  static unsigned int diacr;
>  static char rep;					/* flag telling character repeat */
>  
> @@ -845,12 +849,12 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
>  		shift_state &= ~(1 << value);
>  
>  	/* kludge */
> -	if (up_flag && shift_state != old_state && npadch != -1) {
> +	if (up_flag && shift_state != old_state && npadch_active) {
>  		if (kbd->kbdmode == VC_UNICODE)
> -			to_utf8(vc, npadch);
> +			to_utf8(vc, npadch_value);
>  		else
> -			put_queue(vc, npadch & 0xff);
> -		npadch = -1;
> +			put_queue(vc, npadch_value & 0xff);
> +		npadch_active = false;
>  	}
>  }
>  
> @@ -868,7 +872,7 @@ static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
>  
>  static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
>  {
> -	int base;
> +	unsigned int base;

u32?


>  
>  	if (up_flag)
>  		return;
> @@ -882,10 +886,12 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
>  		base = 16;
>  	}
>  
> -	if (npadch == -1)
> -		npadch = value;
> -	else
> -		npadch = npadch * base + value;
> +	if (!npadch_active) {
> +		npadch_value = 0;
> +		npadch_active = true;
> +	}
> +
> +	npadch_value = npadch_value * base + value;
>  }
>  
>  static void k_lock(struct vc_data *vc, unsigned char value, char up_flag)
> 
> 
> I think if we stop overloading what npadch means, the code becomes more
> clear. What do you think?

I think it makes a lot more sense, care to turn this into a "real"
patch?

thanks,
greg k-h
