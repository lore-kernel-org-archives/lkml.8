Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FEAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4BD2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594378500;
	bh=nVkj9fApfY/h+LnDEZKieXpdvJWekmozPHOqbNPJLso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T6NbGvTTqpnvZbrX8lgArgo2WKIop+psB9z4nVDcwhsY6Sp1WGIT+m05FfWOnacG+
	 L2pg1OibVs4aRlsnYaOGl/KCX7+ZYnYlKhr6VLDoCTzV0cXz64yaS3dNS3HNYf6c1H
	 M1ZgHItllliq+6xsNbSBbDgaLDWlAVgFgaHeoAbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJKy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgGJKy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:54:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31EFD2077D;
        Fri, 10 Jul 2020 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594378495;
        bh=nVkj9fApfY/h+LnDEZKieXpdvJWekmozPHOqbNPJLso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkeML4mheYYMY5byhpedHq4Pa0W7/9sCXWhg6FTUyfv+wYDSaIkHzHoKSiG/OQki8
         0yzH0EfaDzdMAgjg9ZOWRI7sb4KI9ZOsVEoXxMOjGpoJBG/ZTs+/5VBqYhKJYYWDjL
         N7cAkwokiWt8AEHG0Qj77Jm4RKmnr2DSnNvpeZNc=
Date:   Fri, 10 Jul 2020 12:55:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
Subject: Re: [PATCH] vt: Reject zero-sized screen buffer size.
Message-ID: <20200710105500.GA1232395@kroah.com>
References: <20200710055329.3759-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710055329.3759-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:53:29PM +0900, Tetsuo Handa wrote:
> syzbot is reporting general protection fault in do_con_write() [1] caused
> by vc->vc_screenbuf == ZERO_SIZE_PTR caused by vc->vc_screenbuf_size == 0
> caused by vc->vc_cols == vc->vc_rows == vc->vc_size_row == 0 being passed
> to ioctl(FBIOPUT_VSCREENINFO) request on /dev/fb0 , for gotoxy(vc, 0, 0)
>  from reset_terminal() from vc_init() from vc_allocate() on such console
> causes vc->vc_pos == 0x10000000e due to
> ((unsigned long) ZERO_SIZE_PTR) + -1U * 0 + (-1U << 1).
> 
> I don't think that a console with 0 column and/or 0 row makes sense, and
> I think that we can reject such bogus arguments in fb_set_var() from
> ioctl(FBIOPUT_VSCREENINFO). Regardless, I think that it is safer to also
> check ZERO_SIZE_PTR when allocating vc->vc_screenbuf from vc_allocate()
>  from con_install() from tty_init_dev() from tty_open().
> 
> [1] https://syzkaller.appspot.com/bug?extid=017265e8553724e514e8
> 
> Reported-by: syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/tty/vt/vt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 48a8199f7845..8497e9206607 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1126,7 +1126,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  		con_set_default_unimap(vc);
>  
>  	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> -	if (!vc->vc_screenbuf)
> +	if (ZERO_OR_NULL_PTR(vc->vc_screenbuf))

No, let's check this before we do kzalloc() please, that's just an odd
way of doing an allocation we shouldn't have had to do.

>  		goto err_free;
>  
>  	/* If no drivers have overridden us and the user didn't pass a
> @@ -1212,7 +1212,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
>  		return 0;
>  
> -	if (new_screen_size > KMALLOC_MAX_SIZE)
> +	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
>  		return -EINVAL;
>  	newscreen = kzalloc(new_screen_size, GFP_USER);
>  	if (!newscreen)
> @@ -3393,6 +3393,7 @@ static int __init con_init(void)
>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
> +		/* Assuming vc->vc_screenbuf_size is sane here, for this is __init code. */

Shouldn't we also check this here, or before we get here, too?

Just checking the values and rejecting that as a valid screen size
should be sufficient.

thanks,

greg k-h
