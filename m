Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A614C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 23:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720E12071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 23:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flg9K9go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgEYX3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 19:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgEYX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 19:29:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BB3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 16:29:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w20so4143651pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HtNezEclsV3pjj2sk3NG9HBDY2EhLkx6eltEU65OOyE=;
        b=flg9K9goUWDX1Mx2Rti/3IaC4zT5n8y/FrPVkiRBFnPbS2Myt7FIrm1Cu8Pf7lV1VL
         +HpLlwb0ocH+0cO+k7Oyjq34X5obQ0G0vS8d5uHDlL+VZ6NNJg270ltVqamYPVOOkmSL
         TkwYwURwmbaCUe7C8NcAlrAePX6h6trhKd9a9z4Pcx91He4lMqmqPT51dkEv2aIY4Fui
         WH6of9yOwdUj3VVsIxc+QF0dUVLzex1HlPmQlc7y2PaHOFt6Q85TwhZTzxobCbGbG9Vp
         hrhjgQAgTdGLpHA3UyvtqA7MtA1iDrBp8Xuu2y9HpwUOZ7BP90a4tmAiPs8n9jTVIYe7
         JC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HtNezEclsV3pjj2sk3NG9HBDY2EhLkx6eltEU65OOyE=;
        b=JscsJmqZqB4/axE0TbHcE80TPBZs2b8p/vgHqgHYNBCIAAw3emQyxBX0slmnp+JH/a
         LMZA3UrZ/lEM7q0pHlh5GyH6QzEae6lFZXWx+biMPDyzQSAnNLD++FzvHeynCMMw9jz/
         H1/JnC2v+hp5U8REqccdSDn4BuMiJo4g9wpLSApTX013xy0F/+yYQmpUZMzPFt24QX4F
         5pZ765brMrC8mjXLH0XdasjOeFRz/yxD0v5g8Xr9XuRTU1E05nBH0Qxq7reEruszy6mn
         NRQMSLjJlO3EdUXBLYsR+tYQhC3IR8aEAOUB3jCH1OcgLZ79RJHVAfp4o1jskUQ/IUER
         ZFIQ==
X-Gm-Message-State: AOAM5328nOI2BunR3to7jVwuvdFhH131khfHW5kQAI7CGwHE/J5j/wcf
        EL6So1rTpFdtwrzUrt6fmAs=
X-Google-Smtp-Source: ABdhPJy+rXHZam/ZjYMreNWMXR6YOu2irqO/I5ZNSMTlDazoeNOzOkGDuQpFmNX1ECrzpiTT2N4iMg==
X-Received: by 2002:a62:dd03:: with SMTP id w3mr18852903pff.76.1590449383322;
        Mon, 25 May 2020 16:29:43 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id h4sm14649006pje.29.2020.05.25.16.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 16:29:42 -0700 (PDT)
Date:   Mon, 25 May 2020 16:29:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Kyungtae Kim <kt0755@gmail.com>
Subject: Re: [PATCH v3] vt: keyboard: avoid signed integer overflow in k_ascii
Message-ID: <20200525232940.GG89269@dtor-ws>
References: <20200525232740.GA262061@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525232740.GA262061@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry, forgot to CC Kyungtae ]

On Mon, May 25, 2020 at 04:27:40PM -0700, Dmitry Torokhov wrote:
> When k_ascii is invoked several times in a row there is a potential for
> signed integer overflow:
> 
> UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c:888:19 signed integer overflow:
> 10 * 1111111111 cannot be represented in type 'int'
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.11 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xce/0x128 lib/dump_stack.c:118
>  ubsan_epilogue+0xe/0x30 lib/ubsan.c:154
>  handle_overflow+0xdc/0xf0 lib/ubsan.c:184
>  __ubsan_handle_mul_overflow+0x2a/0x40 lib/ubsan.c:205
>  k_ascii+0xbf/0xd0 drivers/tty/vt/keyboard.c:888
>  kbd_keycode drivers/tty/vt/keyboard.c:1477 [inline]
>  kbd_event+0x888/0x3be0 drivers/tty/vt/keyboard.c:1495
> 
> While it can be worked around by using check_mul_overflow()/
> check_add_overflow(), it is better to introduce a separate flag to
> signal that number pad is being used to compose a symbol, and
> change type of the accumulator from signed to unsigned, thus
> avoiding undefined behavior when it overflows.
> 
> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> - marking the patch as v3 as it is a successor of Kyungtae's patches.
> 
>  drivers/tty/vt/keyboard.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
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
> +static unsigned int npadch_value;
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
> -- 
> 2.27.0.rc0.183.gde8f92d652-goog
> 
> 
> -- 
> Dmitry

-- 
Dmitry
