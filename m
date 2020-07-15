Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93338C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF7D2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgGOHCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:02:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44832 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgGOHCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:02:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id by13so786293edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyukl+R6sVf8zCCagfwZCOInI4MTxVtSLndOnpVXqyQ=;
        b=TnTqJIVvkRFpuDZgy1xiNWjPJ+Tm88KKHdWNnIeHU+MRhYI0lr6V+6FfSi4QAa7/We
         WsCiftO2F9I4sEBJ9mWAvIX6b3AfVpNyXArEfeEUYUOqx+Sqk20aF/d/t6okEdr4dyMs
         Z3psJiCxlwCVKqyfFY6YsoYWDwEinTB1pwJd3Apw+GKZXuUAak0typeki/rr+YO0gk9T
         cFMhw9YUQx80bbfH39fV/DTDqiDMf5ueTeUvNXInxsQ7lEqHEyXz8JEEdEhhqsNO2BtM
         PRLZ1xgsaCJi0PBAZcDX7YZX2ZRRo8gp3fC/G1xMfZBWdFGN4kcE7psOgNNLpc622ZjY
         Wqxw==
X-Gm-Message-State: AOAM5326PnEXXgwKigFBJd7BKwmB3SowqZCPhTRWrIkYRPcigWjXChdZ
        6DEsXB4+BbMvoYp+Dtf4EuQAZt1QhV+QNisXNDU=
X-Google-Smtp-Source: ABdhPJxvOn3jbL1613P6msMOTLrav1TH+NUmg4Q1KzxEZg2afZzaZYsUzrPRaV7KLFANsJ4+kDGUqyY8j3l/WpDB0T0=
X-Received: by 2002:a05:6402:1ca8:: with SMTP id cz8mr7938704edb.55.1594796568068;
 Wed, 15 Jul 2020 00:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200714175528.46712-1-grandmaster@al2klimov.de> <20200714193945.49915-1-grandmaster@al2klimov.de>
In-Reply-To: <20200714193945.49915-1-grandmaster@al2klimov.de>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Wed, 15 Jul 2020 09:02:36 +0200
Message-ID: <CAAdtpL43_=yhwvncsKDW_CFJv+FrnrO=hGRLOQja944yviBhiw@mail.gmail.com>
Subject: Re: [PATCH] CREDITS: remove link http://www.mathematik.uni-stuttgart.de/~floeff
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        luis.f.correia@gmail.com, cyphar@cyphar.com, ribalda@kernel.org,
        davej@codemonkey.org.uk, mchehab+samsung@kernel.org,
        martink@posteo.de, Paul Burton <paulburton@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
> The way it redirects looks like a fallback from a dead URL to a generic one.
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
> index 0787b5872906..151083e4245d 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2241,7 +2241,6 @@ S: France
>
>  N: Siegfried "Frieder" Loeffler (dg1sek)
>  E: floeff@tunix.mathematik.uni-stuttgart.de, fl@LF.net
> -W: http://www.mathematik.uni-stuttgart.de/~floeff

One can still use the Internet Archives:
https://web.archive.org/web/20070918070711/http://www.mathematik.uni-stuttgart.de:80/~floeff/

>  D: Busmaster driver for HP 10/100 Mbit Network Adapters
>  S: University of Stuttgart, Germany and
>  S: Ecole Nationale Superieure des Telecommunications, Paris
> --
> 2.27.0
>
