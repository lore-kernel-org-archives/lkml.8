Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD078C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915B620720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgGOHIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:08:10 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33152 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgGOHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:08:09 -0400
Received: by mail-ej1-f65.google.com with SMTP id n26so1085129ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZGz/keVOjyZVsGkANAH8o1c0HX4ozCWlEn94gUYQuo=;
        b=UAy4sA6QzKv/q1lxzpFW30DNiJ+067UtfVBR+Bj4fhLIipJDgN/ijq4Hc9ad+yLqUY
         IJfjad/eWx0uDuGt0CUNBaxHZ7gKCefH7ZBPPSVQVdpxP76RLkWDYeZBVH0TNnWsRK1F
         jZYQWdc2cToJ4TX0m4ajY54nlkqcvPD96k+Fxo5aXxGxKY+i+sLirojdtzNE+AnjBfy6
         65tIJnrPDoVyTKvyJgyrpEO/wl3mvdxa8gry4HbeEAcrsvS+oe8uACR1S2p+bGmWHesE
         R3l/iPeXUYDafBIUaEjvbqgmmar97zpNBKWoDjzHagBkOvinESJQtupbzmzHJ+eSeXrJ
         quEQ==
X-Gm-Message-State: AOAM532Qh6VKAU+KQvHuy4dOqeYcR7QabHs2LnSdsgyQQW9opSnGfiiF
        g3OyvK0KxB0nwLC6B+T9WAYT5zHUHyhubfpiXvA=
X-Google-Smtp-Source: ABdhPJz5lRsChZsD8PsNNX5CbRJ5xlFFJALS/h4WC8urt3Oh2bF6b1vdtcWSjfwDpeIBIuzN0wCYEWKXA0m/faipNp4=
X-Received: by 2002:a17:906:6d0e:: with SMTP id m14mr7791625ejr.251.1594796887466;
 Wed, 15 Jul 2020 00:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200714175528.46712-1-grandmaster@al2klimov.de> <20200714193954.49979-1-grandmaster@al2klimov.de>
In-Reply-To: <20200714193954.49979-1-grandmaster@al2klimov.de>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Wed, 15 Jul 2020 09:07:56 +0200
Message-ID: <CAAdtpL5D59wkRtqVTYxe38Syu_h1c0eec6U=dXa+gq_Ui3mjqA@mail.gmail.com>
Subject: Re: [PATCH] CREDITS: remove link: http://www.andante.org
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Burton <paulburton@kernel.org>,
        mchehab+samsung@kernel.org, ribalda@kernel.org, martink@posteo.de,
        cyphar@cyphar.com, davej@codemonkey.org.uk,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Tue, Jul 14, 2020 at 10:18 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> A completely white page with just an <iframe> in the <body>.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Yes, I noted that some of the links removed by these "CREDITS: remove link:"
>  patches have email addresses with the same domain nearby.
>
>  Don't worry, I'll take care of them together with all other
>  dead email addresses - but not right now.
>
>
>  CREDITS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/CREDITS b/CREDITS
> index 0787b5872906..ed58df9db15b 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -4113,7 +4113,6 @@ S: Japan
>
>  N: Eric Youngdale
>  E: eric@andante.org
> -W: http://www.andante.org

Similarly, this historical information is still available in the
Internet Archives:
https://web.archive.org/web/20080928071628/http://www.andante.org:80/scsi.html

There are thousands of outdated URLs in the source and documentation which
are still useful today, in particular the references to datasheets. I
consider these
outdated links as still valuable source information, and find removing
them a loss.

My 2 cents.

Regards,

Phil.

>  D: General kernel hacker
>  D: SCSI iso9660 and ELF
>  S: 6389 Hawk View Lane
> --
> 2.27.0
>
