Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BCDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18985206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593168764;
	bh=F4sUd4bcE3DxUva0Rhax0NeNwCDh90n0qHTtqKldxd4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=CB0fWNZ4PpAzv9FL2wfEOVQVv0NWFiZtJh2eDnnpJp3m+mqkpPuV1sG+g8NyC/kwQ
	 0T05n2vqPCHJv9pI1Bh5KoLOoANwVWJA8CfMVJu6bHmowm9xJcsmi+9YkSpPibnB8R
	 EFwO9rmr7pVLgBQXLyw7njkUrYlHyywRXd63UAuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgFZKwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:52:42 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:40731 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgFZKwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:52:41 -0400
Received: by mail-ej1-f67.google.com with SMTP id o18so4468637eje.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 03:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0MvpkwOhvWW7vSKtEDPQ+KUpqwlCT1LUUMsvXG3paHI=;
        b=IOLpRjytLb+FLeP3OeKjiaRjh77Aj38TffYxHKX1pSLUPOAYp8fgi2/LlpWaE5xcYT
         OBPWTTknBRfRCKRyWiFffhfG/JZ+JdJN4hjSs6W786ekXb+zRv7/+PliFBuS/i65kIB5
         NB3K+ZdWVErgnbxIMzyKkLJxdYfk6JDcMeBF57gjc7OdkuJ4MoA1+AyBk1/pkBmL+KQQ
         jdzijhl/EQ1VSJjnVHBzvN5ZpjM6hpyW9A9mqy0OhUnyLssvcc6BY5NyBYTQ76hXfpCO
         zWwP2X+2XXRGAoZpE9MxP/611SuAtN0e3ebQBaRGer8ELDBhLCRE2nwmSRQGZWW23YrM
         21hw==
X-Gm-Message-State: AOAM533nMZRlddk48i9ehsTepr36jLT2yYIJg6A4aOP08ORHlQYdDS9/
        /D0Nh/wLLOU4++ml0Fq9a2o=
X-Google-Smtp-Source: ABdhPJzDDCfqOFBFTEPa0pUq1BSp8uOb1Vj0RpKePW1ms6hYp4Kdbqv59bSteA/epfLjO3s0fojroA==
X-Received: by 2002:a17:906:f183:: with SMTP id gs3mr1859019ejb.361.1593168760253;
        Fri, 26 Jun 2020 03:52:40 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id gu16sm10591983ejb.35.2020.06.26.03.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 03:52:39 -0700 (PDT)
Subject: Re: [PATCH v0 4/5] Add support for SRG report output format
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1593155911.git.tammo.block@gmail.com>
 <f703a17a02475251e50071354977dca8544f969a.1593155911.git.tammo.block@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <5ad95786-3c3b-7a1e-c3db-2d03e4319fad@kernel.org>
Date:   Fri, 26 Jun 2020 12:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f703a17a02475251e50071354977dca8544f969a.1593155911.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 06. 20, 9:23, Tammo Block wrote:
> Add SRG ("1005") style mouse reports. Always use them to create a report to
> userspace if they are available because they may contain more information
> (e.g. scroll wheel events).
> 
> Do not send reports at all if report information is not sufficient.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 5c9c449dc150..af0c58a9b108 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1835,10 +1835,30 @@ static inline void respond_ID(struct tty_struct *tty)
>  
>  void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
>  {
> -	char buf[8];
> +	char buf[20];
> +	char rel;

bool rel;

>  
> -	sprintf(buf, "\033[M%c%c%c", (char)(' ' + (butt & TIOCL_SELBUTTONMASK)),
> -		(char)('!' + mrx), (char)('!' + mry));
> +	if (butt & TIOCL_SELSRGREPORT) {
> +		rel = (butt & TIOCL_SELSRGRELEASE) ? 1 : 0;

Ternary operator superfluous.

> +		butt = butt >> 8;

butt >>= 8;

> +
> +		if (vc_cons[fg_console].d->vc_proto_mouse) {
> +			sprintf(buf, "\033[<%d;%d;%d%c", butt, mrx + 1, mry + 1, rel ? 'm' : 'M');
> +		} else {
> +			if (rel)
> +				butt = (3 | butt);

butt |= 3;

> +			sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
> +				(char)('!' + mrx), (char)('!' + mry));
> +		}
> +	} else {
> +		/* Compatibility for older protocol */
> +		if (vc_cons[fg_console].d->vc_proto_mouse)
> +			return;
> +		if (vc_cons[fg_console].d->vc_report_mouse > 2)
> +			return;
> +		sprintf(buf, "\033[M%c%c%c", (char)(' ' + (butt & TIOCL_SELBUTTONMASK)),
> +			(char)('!' + mrx), (char)('!' + mry));
> +	}
>  	respond_string(buf, tty->port);

thanks,
-- 
js
suse labs
