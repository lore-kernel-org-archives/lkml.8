Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA441C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A667A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593168207;
	bh=u5e+0XViLwBFBmMCmVY3ZWAdoyXGqTm1JYRhGJlcYYk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rNH9/3UD2DcTp6fRHQbSwDXgQN/U+ZanTYtSN/vw089QhdjnE1GrgLJBd4jDQ8X6P
	 qRiU6MIITfCRLMuXON8A/vkANowDIboNmW1CWHIEydHfJaAjRfhD+V/XM5R4dSOMB6
	 F53WRaqnjX+To8BAm+NuXcXvlSGGzs4txYu3ot8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFZKn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:43:26 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:43579 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgFZKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:43:25 -0400
Received: by mail-ej1-f68.google.com with SMTP id l12so8859738ejn.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 03:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fBCNpYHArbaIvTCXoaDbzGjMNkwy0xtfnskWd/C/q3A=;
        b=sM2tJF/q3uHToD+jVU60OJod6A/yTiDiLhxD4mFJHI1w9iz8lcv09cqlbb57lIDmQD
         eY1Fc42OMFvKZTGsTuMUCmVdsbzOnvc91tVa3UwCraYZzkvfNUKbOyR271Gq3RW3XJyk
         9OgHWjrgQKLl0YydiZe66r7Elwblyosdcpe0eCz59inBL7NX/utBzH07YDF7cFpAnB5P
         HQMcgC+HJtZ/kfVKzPSX3bBMOnqqAfJ1O/fW4HptXQ+gxgOEHEScDsPLB2e3jz1Cktsy
         H3ieMLbROI7b9zxFX34qq79ChfErp6IRQpUrpFuktQzgWU53nhcUqr/8O/qzb05emR0L
         0xDQ==
X-Gm-Message-State: AOAM530JLlwe+qfS/1ogTN0o+EWw0jayQQkgNC/ZA7RRxNgaunZOBlCn
        azPfrUVPjnXVGrEyzAbABik=
X-Google-Smtp-Source: ABdhPJyiHsevGDn5YCuwfV4gTq8a/llFmGbZYHpYjbX+BcuWGLpbKjaWLTOx1YR/g62BphtS0UOL8w==
X-Received: by 2002:a17:906:d79c:: with SMTP id pj28mr1858400ejb.397.1593168203408;
        Fri, 26 Jun 2020 03:43:23 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id 23sm14333552edw.63.2020.06.26.03.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 03:43:22 -0700 (PDT)
Subject: Re: [PATCH v0 2/5] Make it possible to enable/disable SRG mouse
 reporting
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1593155911.git.tammo.block@gmail.com>
 <d0951dcf5fb4cf8bfa19940953bce55ad0ee0510.1593155911.git.tammo.block@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8e75c573-c66d-f79b-ad09-bbac280a5c91@kernel.org>
Date:   Fri, 26 Jun 2020 12:43:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d0951dcf5fb4cf8bfa19940953bce55ad0ee0510.1593155911.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 06. 20, 9:22, Tammo Block wrote:
> The report protocol stored in vc_report_mouse is not a bitmask, the
> protocols are mutually exclusive, last one wins. Values are chosen to
> maximize compatibility.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 48a8199f7845..d52ac57034e0 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1890,13 +1890,22 @@ static void set_mode(struct vc_data *vc, int on_off)
>  					clr_kbd(vc, decarm);
>  				break;
>  			case 9:
> -				vc->vc_report_mouse = on_off ? 1 : 0;
> +				vc->vc_report_mouse = on_off ? TIOCL_REPORTBTNPRESS : 0;
>  				break;
>  			case 25:		/* Cursor on/off */
>  				vc->vc_deccm = on_off;
>  				break;
>  			case 1000:
> -				vc->vc_report_mouse = on_off ? 2 : 0;
> +				vc->vc_report_mouse = on_off ? TIOCL_REPORTRELEASE : 0;
> +				break;
> +			case 1002:
> +				vc->vc_report_mouse = on_off ? TIOCL_REPORTDRAG : 0;
> +				break;
> +			case 1003:
> +				vc->vc_report_mouse = on_off ? TIOCL_REPORTANYMOVE : 0;
> +				break;
> +			case 1006:
> +				vc->vc_proto_mouse = on_off ? 1 : 0;

So simply:
vc->vc_proto_mouse = on_off;

The others could be "on_off * TIOCL_XXX", but I don't think it would
improve anything.

thanks,
-- 
js
suse labs
