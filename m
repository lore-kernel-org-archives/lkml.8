Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC73C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F059C20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593679716;
	bh=n0/ETBMZtZXEXcMd3jAalXfRHi+uZlBk4qzRq7lhjDI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=j0GmmIlnNk3KZAgWNju2Q5JFHctT65Pbxw5WuTZrYStj9dhor9DHwmL7QRHCJapd4
	 PnXKHvNozthA0lqqXbfWninr0KQKaFS4ooTznq6TaqDstuxhwmPteRuGgjHvXqTAQ4
	 QvDm2SUriHmQx84a4H2kW0IfR0noTL+NAcWX7Y70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGBIse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:48:34 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37423 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:48:33 -0400
Received: by mail-ej1-f68.google.com with SMTP id lx13so9675020ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 01:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VV1IWx8EqKynJvKotPIzTeJfmbIIq4AFHL6hpTY0F+8=;
        b=qMpLBFfe8oPGuCGzSnxLONcwKlzJwTxG2RkFC7qEVrwpwO4s4pK1SDzFPyyIeig+Fj
         wiEVC+tkrQJnKQCRfPLxDVKfEX35APsiovt0hHjrCTvo1Ed0HgA9LbcbRxc1NOzh7wZb
         qXE6pofBYB9521ndyg7m25XSSTuNmYVrUXaQMk5dk85+unymYQImq8jD1bqVKMMP+fqW
         7PyWpzddhrDLKYzRUTdtZP/jcmP6TzfHBvop4JcVpadyOKAk6Xuu9uxgrnISTsYai7WT
         QIqH7swtFYxgQMmLoM9yXqk1ibddRNRoVXGJvlbs/56TiO/wiNE4JrPN4pUoRaRGttfz
         sjfg==
X-Gm-Message-State: AOAM5323uGRZuWrLFsjh4hz503t8E2iu6QhoBUkDMvmABw5W8kg+lpcY
        Id/uUlK+A/0sfczRXMpPGXo=
X-Google-Smtp-Source: ABdhPJyifjHc0ekAqGbB27X8AE7wiggeyVGFKiu3r40T6bWl+ZPtFnKUGCg4GtOMwanmlddrur4rEg==
X-Received: by 2002:a17:906:57da:: with SMTP id u26mr27426643ejr.157.1593679711112;
        Thu, 02 Jul 2020 01:48:31 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id q24sm9465979edg.51.2020.07.02.01.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 01:48:30 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] vt/vt: Add SRG mouse reporting protocol
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1593615440.git.tammo.block@gmail.com>
 <167e1d106125e5401fd907d6febdec4273cfdd3e.1593615440.git.tammo.block@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <db653724-2706-b2c1-8889-ebb60af80ab1@kernel.org>
Date:   Thu, 2 Jul 2020 10:48:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <167e1d106125e5401fd907d6febdec4273cfdd3e.1593615440.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 07. 20, 17:13, Tammo Block wrote:
> The SRG protocol indicates a button release by appending a "m" to the
> report. In this case the button number is not 3 (RELEASEEVENT) but
> the number of the button that was released. As release event are only
> reported for the first three buttons (LOWBUTTONMASK), we need to store
> the number on click events because it is not sent to us from userspace.
> 
> We also need to check for the case where no button state change occurred
> at all (bit 6 set), in this case a value of 3 is OK even in SRG.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 9abf2829b1d3..9aae3eac7989 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1838,15 +1838,34 @@ static inline void respond_ID(struct tty_struct *tty)
>  	respond_string(vt102_id, strlen(vt102_id), tty->port);
>  }
>  
> +#define ANYBUTTONMASK	0xc3
> +#define LOWBUTTONMASK	0x03

Insert _ before MASK.

> +#define RELEASEEVENT	0x03
> +
>  enum { Mouse_X10 = 0, Mouse_SRG, Mouse_URXVT};

= 0 in unnecessary. And put one per line. And all capitals as
CodingStyle says.

You should name the enum somehow and use it as a type for
vc_protocol_mouse (you'd need a forward declaration of the enum in the
header).

>  void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
>  {
> -	char buf[8];
> +	static char last_btn = RELEASEEVENT;
> +	char buf[20];
> +	bool rel;
>  	int len;
>  
> -	len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
> -			(char)('!' + mrx), (char)('!' + mry));
> +	switch (vc_cons[fg_console].d->vc_protocol_mouse) {
> +		case Mouse_SRG:

This is not how we indent switch-case.

> +			rel = (butt & ANYBUTTONMASK) == RELEASEEVENT;
> +			if ((butt & ANYBUTTONMASK) < RELEASEEVENT)
> +				last_btn = butt & LOWBUTTONMASK;
> +			if ((butt & TIOCL_SELBUTTONMASK) == RELEASEEVENT)
> +				butt = (butt & ~LOWBUTTONMASK) | last_btn;
> +			len = sprintf(buf, "\033[<%d;%d;%d%c", butt,
> +					mrx + 1, mry + 1, rel ? 'm' : 'M');
> +			break;
> +		default:
> +			len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
> +					(char)('!' + mrx), (char)('!' + mry));
> +			break;
> +	}
>  	respond_string(buf, len, tty->port);
>  }

thanks,
-- 
js
suse labs
