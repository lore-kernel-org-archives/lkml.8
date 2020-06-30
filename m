Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08953C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8FE20775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593503968;
	bh=XMOMH6UjWMMz/zU5AkuWFlHeMYBgUXYfusDUefgj7NI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lGG6fXmkPz6Ifj04svky5Aan+zKrbTap37RdxAdkcxX8MZ1S3fAAnCgJbyls/xBtL
	 22tWpQw6Etj1rDgFq6YbgD7f0TQ5kaDaEILF1pfsuroTTtrCXJ/eRpY8HY+JiTDcNb
	 xYYef9uQ95N8LkDg6az3+cmg6u7paTdHIkqVyiCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgF3H71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:59:27 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:39445 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgF3H70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:59:26 -0400
Received: by mail-ej1-f67.google.com with SMTP id w6so19544835ejq.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7D2V9mpD134BewynmFSlbJNUC4Zgi7X013u5O1lES74=;
        b=uiXMKlU+dpmBCpIybTzlf2MDSOutZlOe3uiu7QmFD8ss/NQWdn2TOhT8BnPhivxLL3
         OSFLk5AvOdvIeWpfJ6KHa2vJT/RxbXchtK9vSq9NH1lxFc8O6h4G5DdSxJyqow/07YR6
         1DrMwxOwKE8nsLhnxnccgMKjwb9gLq/Qz0OEgTrfiZhWVTvLbDhwRYoAxCH0/4NxKorU
         //WEm/BQi+L0Wcaf4iK1C7kvm6tOiREsq13dofTeAyAo0D9/TtspBWVsObBKeOqboDgl
         I+49YU+76ZsE9IMO4qg5GaB9Upb/Hi0kdgrXLaVH0raCdIqJg1lVf5/nkvMuBB9jj5KB
         uZLg==
X-Gm-Message-State: AOAM533cvzqQVyZE2y6e/LYCVkFTqMnnrjSXw29SLnwcNJ2HDiZyf/MY
        +fiYSFPNO4MNsNsEdp4lpsQ=
X-Google-Smtp-Source: ABdhPJyJd8hIHYQvHyjaOYy6CJ0Pka1Ps2CqcVu9SpI0qezbI0UkyuEnBLchBjC34+pewR1IzNQhnA==
X-Received: by 2002:a17:906:4a45:: with SMTP id a5mr16799425ejv.384.1593503963301;
        Tue, 30 Jun 2020 00:59:23 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id jo25sm1397143ejb.116.2020.06.30.00.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:59:22 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] vt/vt: Add SRG mouse reporting protocol
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1593499846.git.tammo.block@gmail.com>
 <d0435e5d32f1b14033d3c4ba22457356e8ae85b3.1593499846.git.tammo.block@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a28ffa0d-01ca-7406-dbea-3eaf80dd72a8@kernel.org>
Date:   Tue, 30 Jun 2020 09:59:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d0435e5d32f1b14033d3c4ba22457356e8ae85b3.1593499846.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 06. 20, 9:11, Tammo Block wrote:
> The SRG protocol indicates a button release by appending a "m" to the
> report. In this case the button number is not 3 ("release state") but
> the number of the button that was released. As release event are only
> reported for the first three buttons, we need to store the number on
> click events because it is not sent to us from userspace.
> 
> We also need to check for the case where no button state change occurred
> at all (bit 6 set), in this case a value of 3 is OK even in SRG.
> 
> Bitmasks for your convenience:
> 195 - All bits related to any button number
> 227 - All bits related to button number and "state not changed" bit
> 252 - All, except low button numbers (left, middle, right button)

Ick, define macros for those (likely in 2/6 where you define the vc_data
members holding these bits) and use them below.

> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index e2324d8e4e74..36520f7f0315 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -183,6 +183,9 @@ core_param(consoleblank, blankinterval, int, 0444);
>  static DECLARE_WORK(console_work, console_callback);
>  static DECLARE_WORK(con_driver_unregister_work, con_driver_unregister_callback);
>  
> +/* remember mouse state */
> +unsigned char last_button_pressed = 3;

So this can be static, right? Can this be in mouse_report or is it used
elsewhere? If it has to be global, a mouse_ prefix would be good.

>  /*
>   * fg_console is the current virtual console,
>   * last_console is the last used one,
> @@ -1840,11 +1843,21 @@ static inline void respond_ID(struct tty_struct *tty)
>  
>  void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
>  {
> -	char buf[8];
> +	char buf[20];
> +	bool rel;
>  	int len;
>  
> -	len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
> -			(char)('!' + mrx), (char)('!' + mry));
> +	if (vc_cons[fg_console].d->vc_protocol_mouse == 1) {	/* SRG*/

So 1 is SRG, 2 is URXVT, 0 is X10, right? We need constants for those,
or maybe enum and switch+case here? No need for the comments here then.

> +		/* For SRG release events, we send the last clicked button < 3 */
> +		rel = ((butt & 195) == 3);

No need for the outer parentheses.

> +		if ((butt & 195) < 3)
> +			last_button_pressed = butt & 3;
> +		if ((butt & 227) == 3)
> +			butt = (butt & 252) | last_button_pressed;
> +		len = sprintf(buf, "\033[<%d;%d;%d%c", butt, mrx + 1, mry + 1, rel ? 'm' : 'M');
> +	} else							/* X10 */
> +		len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
> +				(char)('!' + mrx), (char)('!' + mry));
>  	respond_string(buf, len, tty->port);
>  }

thanks,
-- 
js
suse labs
