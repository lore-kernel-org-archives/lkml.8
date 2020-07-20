Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6191C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BD52064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1/MB0IQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgGTPkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbgGTPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:40:21 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9979C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:40:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so422378qti.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e2AvEL9u1tS3PW7vmakN2k5lYWQdlOwSGyaF0PrRKWs=;
        b=B1/MB0IQImHJKRcfjhW4iXX3bXtDKowfr7KBE4BEZBGMQK5PDnkWsSEdI+FFNihpY2
         muAURHKdTUjg3av0buGdtY41sVYwccRuAUngISCiTnaQ+beykhxpIVg7jlg2XqVpkjdh
         B9uos2y34LstplixdnWxqR696MgNOIL1w3meyCXJSzRazlsfU4oQsK3GNr1/wjyOFrMe
         x3+RCSwLHjgmr2bhvuMNn9EUp6zUN3mN/yLZB58kIQaccgdEAAir0VeNtD2FfGLFVOah
         mi2V1lFv9KA5GkEfiH3y/rjdKRHj36hrIjpQfqvy+z9i676lBL8WrRtD77FipfPLqQdJ
         1law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e2AvEL9u1tS3PW7vmakN2k5lYWQdlOwSGyaF0PrRKWs=;
        b=rAwNPVzW5rJ+ek3vdAnZ8WQ43pvuwb+FIN1h9aECqBK1BB3We2KCTlA86wqZRy8PBT
         TH+Np3mxa3gB14ls9LNr0JclBXr3uEbpwk+lEYwlHYEVMvkuhmam4C5ITfkQcJIyAETs
         n0xuenJLnCKpy2yvovHVQCfgfYB1GUq3yjtCx5eA5BEWXWHG+btMYXQHcZlkx4hoJxYg
         RO5YCxduDL15bIXcVKMpf7uA7I682+NSv/hrLH2G24fXgbmg5ONhOEDiNFooWgSTGYt1
         3Q4QJWzvlAZAVbGpZ1k5hssweETP6UDqSAU2u4FNuhdyfGLQz60+G2XXbl1VJDEUCfLg
         iIyw==
X-Gm-Message-State: AOAM531dXQL/tN0kGtjo/Xvft25I1xviDZlhYcwo3DJL6G2TPKA7CIKf
        MXFap9BynolpcqMnBWPUOyY=
X-Google-Smtp-Source: ABdhPJybKH7luYUYMuw4uPjoIb3JYqwyFCPvdXRnnOFBDjywQD9DBmMZ3QzJ/XvD14eydeEfj7h1hA==
X-Received: by 2002:ac8:6f7a:: with SMTP id u26mr24816471qtv.33.1595259620040;
        Mon, 20 Jul 2020 08:40:20 -0700 (PDT)
Received: from [192.168.1.165] (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id c24sm21612313qtd.82.2020.07.20.08.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 08:40:19 -0700 (PDT)
Subject: Re: [PATCH v2] vt: Reject zero-sized screen buffer size.
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
        syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
References: <20200710113658.GA1238355@kroah.com>
 <20200710143455.3438-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Brooke Basile <brookebasile@gmail.com>
Message-ID: <741c66b4-3855-9c5e-ca67-9e44eb6fa083@gmail.com>
Date:   Mon, 20 Jul 2020 11:40:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710143455.3438-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/20 10:34 AM, Tetsuo Handa wrote:
> syzbot is reporting general protection fault in do_con_write() [1] caused
> by vc->vc_screenbuf == ZERO_SIZE_PTR caused by vc->vc_screenbuf_size == 0
> caused by vc->vc_cols == vc->vc_rows == vc->vc_size_row == 0 being passed
> to ioctl(FBIOPUT_VSCREENINFO) request on /dev/fb0 , for gotoxy(vc, 0, 0)
>   from reset_terminal() from vc_init() from vc_allocate() on such console
> causes vc->vc_pos == 0x10000000e due to
> ((unsigned long) ZERO_SIZE_PTR) + -1U * 0 + (-1U << 1).
> 
> I don't think that a console with 0 column and/or 0 row makes sense, and
> I think that we can reject such bogus arguments in fb_set_var() from
> ioctl(FBIOPUT_VSCREENINFO). Regardless, I think that it is safer to also
> check vc->vc_screenbuf_size when allocating vc->vc_screenbuf from
> vc_allocate() from con_install() from tty_init_dev() from tty_open().
> 
> Theoretically, cols and rows can be any range as long as
> 0 < cols * rows * 2 <= KMALLOC_MAX_SIZE is satisfied (e.g.
> cols == 1048576 && rows == 2 is possible) because of
> 
>    vc->vc_size_row = vc->vc_cols << 1;
>    vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
> 
> in visual_init() and kzalloc(vc->vc_screenbuf_size) in vc_allocate().
> 
> But since vc_do_resize() requires cols <= 32767 and rows <= 32767,
> applying 1 <= cols <= 32767 and 1 <= rows <= 32767 requirements to
> vc_allocate() will be practically fine. (cols != 0 && rows != 0 is
> implicitly checked via screenbuf_size != 0.)
> 
> This patch does not touch con_init(), for returning -EINVAL there
> does not help when we are not returning -ENOMEM.
> 
> [1] https://syzkaller.appspot.com/bug?extid=017265e8553724e514e8
> 
> Reported-by: syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>   drivers/tty/vt/vt.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 48a8199f7845..42d8c67a481f 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1092,10 +1092,19 @@ static const struct tty_port_operations vc_port_ops = {
>   	.destruct = vc_port_destruct,
>   };
>   
> +/*
> + * Change # of rows and columns (0 means unchanged/the size of fg_console)
> + * [this is to be used together with some user program
> + * like resize that changes the hardware videomode]
> + */
> +#define VC_MAXCOL (32767)
> +#define VC_MAXROW (32767)
> +
>   int vc_allocate(unsigned int currcons)	/* return 0 on success */
>   {
>   	struct vt_notifier_param param;
>   	struct vc_data *vc;
> +	int err;
>   
>   	WARN_CONSOLE_UNLOCKED();
>   
> @@ -1125,6 +1134,11 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>   	if (!*vc->vc_uni_pagedir_loc)
>   		con_set_default_unimap(vc);
>   
> +	err = -EINVAL;
> +	if (vc->vc_cols > VC_MAXCOL || vc->vc_rows > VC_MAXROW ||
> +	    vc->vc_screenbuf_size > KMALLOC_MAX_SIZE || !vc->vc_screenbuf_size)
> +		goto err_free;
> +	err = -ENOMEM;
>   	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
>   	if (!vc->vc_screenbuf)
>   		goto err_free;
> @@ -1143,7 +1157,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>   	visual_deinit(vc);
>   	kfree(vc);
>   	vc_cons[currcons].d = NULL;
> -	return -ENOMEM;
> +	return err;
>   }
>   
>   static inline int resize_screen(struct vc_data *vc, int width, int height,
> @@ -1158,14 +1172,6 @@ static inline int resize_screen(struct vc_data *vc, int width, int height,
>   	return err;
>   }
>   
> -/*
> - * Change # of rows and columns (0 means unchanged/the size of fg_console)
> - * [this is to be used together with some user program
> - * like resize that changes the hardware videomode]
> - */
> -#define VC_RESIZE_MAXCOL (32767)
> -#define VC_RESIZE_MAXROW (32767)
> -
>   /**
>    *	vc_do_resize	-	resizing method for the tty
>    *	@tty: tty being resized
> @@ -1201,7 +1207,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>   	user = vc->vc_resize_user;
>   	vc->vc_resize_user = 0;
>   
> -	if (cols > VC_RESIZE_MAXCOL || lines > VC_RESIZE_MAXROW)
> +	if (cols > VC_MAXCOL || lines > VC_MAXROW)
>   		return -EINVAL;
>   
>   	new_cols = (cols ? cols : vc->vc_cols);
> @@ -1212,7 +1218,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>   	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
>   		return 0;
>   
> -	if (new_screen_size > KMALLOC_MAX_SIZE)
> +	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
>   		return -EINVAL;
>   	newscreen = kzalloc(new_screen_size, GFP_USER);
>   	if (!newscreen)
> @@ -3393,6 +3399,7 @@ static int __init con_init(void)
>   		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>   		tty_port_init(&vc->port);
>   		visual_init(vc, currcons, 1);
> +		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
>   		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
>   		vc_init(vc, vc->vc_rows, vc->vc_cols,
>   			currcons || !vc->vc_sw->con_save_screen);
> 

Hi,

Looks like this patch also fixes this bug reported by syzbot:
	https://syzkaller.appspot.com/bug?id=dc5c6b1ae4952a5d72d0e82de0eeeb9e5f767efc

There's a lot of other bugs that were reported by syzbot that also touch 
this code, so I just wanted to give a heads up in case you weren't 
already aware of them.  It seems like this patch could be a fix for all 
of them.

Here are the links to those other bugs:
	https://syzkaller.appspot.com/bug?id=3e2ad4922b18026c1579f50900747401842acdff
	https://syzkaller.appspot.com/bug?id=7329638ab83b70fc8fab07e14c4b2fcdc73af21d
	https://syzkaller.appspot.com/bug?id=01703eb07363bd1f9757bc4a54994455fc9db9dc
	https://syzkaller.appspot.com/bug?id=7a04be77a06aae337077e00f0ecdb2239dfc2fc3
	https://syzkaller.appspot.com/bug?id=ff1543b5ade351b9d6c4ef51c805d89422a8271d

Best,
Brooke Basile


