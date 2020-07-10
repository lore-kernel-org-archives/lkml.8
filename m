Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88304C433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FC620748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594381021;
	bh=HbvkzCXrQUvGGQRjHnWmV8if5AoIJw8vGs4laXuFHZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mmAFbNw0V8c+UavOLlAtxryrnfJD6weZcIhGv0f0hSwdWK/87kIw5Gap+cYWSZXal
	 MXykT0poHBfUDP31orULmfqvnD4QIUiqXBzaR41iJdeLDz5uggx4kGh549itZcfzec
	 rX7dC7BttXkqPqsgZ7CDYAthV5XIIXaklgWcSLKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGJLhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgGJLgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:36:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E9EF2077D;
        Fri, 10 Jul 2020 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594381013;
        bh=HbvkzCXrQUvGGQRjHnWmV8if5AoIJw8vGs4laXuFHZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEgWNTxVkgi8WvHpvkba9nE4pNtwzhI+cTB5YCep38j+eU0aWu/HbG5MUqY/81wzU
         47GWmopSyrkM/dm7bcpztJZRcJFINRc3DbaQWS6sInHjvcw8BNjNXq/xZa96PPOe/R
         lZ1PoQAoNZW3oTZ/TIVQceCYk81CIynY8hR0M6dQ=
Date:   Fri, 10 Jul 2020 13:36:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
Subject: Re: [PATCH] vt: Reject zero-sized screen buffer size.
Message-ID: <20200710113658.GA1238355@kroah.com>
References: <20200710055329.3759-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200710105500.GA1232395@kroah.com>
 <7adf8aee-9bdd-8184-6cbe-291357677edd@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7adf8aee-9bdd-8184-6cbe-291357677edd@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:31:42PM +0900, Tetsuo Handa wrote:
> On 2020/07/10 19:55, Greg Kroah-Hartman wrote:
> >> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> >> index 48a8199f7845..8497e9206607 100644
> >> --- a/drivers/tty/vt/vt.c
> >> +++ b/drivers/tty/vt/vt.c
> >> @@ -1126,7 +1126,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
> >>  		con_set_default_unimap(vc);
> >>  
> >>  	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> >> -	if (!vc->vc_screenbuf)
> >> +	if (ZERO_OR_NULL_PTR(vc->vc_screenbuf))
> > 
> > No, let's check this before we do kzalloc() please, that's just an odd
> > way of doing an allocation we shouldn't have had to do.
> 
> OK. I can change to
> 
> +	if (vc->vc_screenbuf_size > KMALLOC_MAX_SIZE || !vc->vc_screenbuf_size)
> +		goto err_free;
>  	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
>  	if (!vc->vc_screenbuf)
>  		goto err_free;
> 
> like vc_do_resize() does. But I'm currently waiting for syzbot to test this patch, for
> I don't have an environment for reproducing this problem.

That looks much more sane, thanks.


> 
> > 
> >>  		goto err_free;
> >>  
> >>  	/* If no drivers have overridden us and the user didn't pass a
> >> @@ -1212,7 +1212,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
> >>  	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
> >>  		return 0;
> >>  
> >> -	if (new_screen_size > KMALLOC_MAX_SIZE)
> >> +	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
> >>  		return -EINVAL;
> >>  	newscreen = kzalloc(new_screen_size, GFP_USER);
> >>  	if (!newscreen)
> >> @@ -3393,6 +3393,7 @@ static int __init con_init(void)
> >>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> >>  		tty_port_init(&vc->port);
> >>  		visual_init(vc, currcons, 1);
> >> +		/* Assuming vc->vc_screenbuf_size is sane here, for this is __init code. */
> > 
> > Shouldn't we also check this here, or before we get here, too?
> 
> This is an __init function. Can we somehow pass column=0 or row=0 ?

You could, it's much less likely, but why not catch this if you can?

> > Just checking the values and rejecting that as a valid screen size
> > should be sufficient.
> 
> Hmm, where are we checking that column * row does not exceed UINT_MAX, given that
> "struct vc_data"->vc_{cols,rows,screenbuf_size} are "unsigned int" and we do
> 
>   vc->vc_size_row = vc->vc_cols << 1;
>   vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
> 
> in visual_init() ? Don't we need to reject earlier?

Probably, it's some twisty code :(

