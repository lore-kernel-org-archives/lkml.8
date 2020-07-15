Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6306C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD13E20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhKTjk4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGOR40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGOR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:56:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EE4C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:56:20 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so2292903edz.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0ZW6+2wSAAvKeptmvS3TdVWhKSNDtE+RZ5Wnm+wGaE=;
        b=JhKTjk4BbKFQoyxETwWTq/M5U8QYrEqybvknl5jzSV98DOFBDsiOzEO5CH90YZeobH
         pWdmFf6NCTkMb6Lo01g2/HjhgQyDyHemL5J1gtG0OQVSYK16cpNBY+yzNsOvGWpMwgZc
         VnjFQnglBrv1D3SbKrFfHYZppu1Uqzp5GnQAOz5L4nJ3MLPNPdvbGjm2Yxln+FJ4NZBP
         2KgJtdG4PjvIqpgSIVkgTt9ENAlSAHbJhAxvgu07sLEfUrRO0Dc/9awb1pyRr1rGhEPQ
         PFVM4dFJxxNse8NwiUDCedpPyNo1G1QDs4px4FGAcLfc1YAl2jYepYpjXG4ea6lQUHVN
         oJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0ZW6+2wSAAvKeptmvS3TdVWhKSNDtE+RZ5Wnm+wGaE=;
        b=TgtNZtI9P0CnSKhIHp0LEbfqiDxvhU8LvTsfFGCzzXB4iI1fcHUT0TAkXtecvxmijX
         sQESBYXYZIB4rPWvZthfr/2Ip7BFAPlyxScjHg9x3RSZr6SrScQJzEia2Dar7w/XTfMt
         tlaBxhmMx7lUvrX3LPYef4oySw+bBAWXPjhO8uxbmRn2Lipp06HubuErEX682TXQDY8h
         /I+XC6NaeXISLO2FWZ32gIOQ+tsJ6Wi4HOdy01vcSG/Rw1fKwMIDJwuxYtNTyNVddeP3
         NXoFageYhFODeOJit45EtFuKJIbfhyKuV5FzfJ6RE27EgixrlxcwAUY/LNJQktv6n6ff
         h9TA==
X-Gm-Message-State: AOAM532sVJxz3mN1BEgd8eKjeBn2+oRuvlasiApvJ4oTVp214DpWla5y
        B8ugv/CZqLZhI7PP6oTB5GVFgfnvmlxACGjBJTc=
X-Google-Smtp-Source: ABdhPJwiGpxm2H2nTFAV4e5biQsdybReF+2s8VBt/yBMMu6X0KI5KzzjyHk2KdwODKFNIiKJCdSIa/ZEwu01gWKsHBU=
X-Received: by 2002:a05:6402:16c7:: with SMTP id r7mr796021edx.288.1594835779154;
 Wed, 15 Jul 2020 10:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200713114321.783f0ae6@lwn.net> <20200714193805.49746-1-grandmaster@al2klimov.de>
In-Reply-To: <20200714193805.49746-1-grandmaster@al2klimov.de>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Wed, 15 Jul 2020 14:56:07 -0300
Message-ID: <CAB9dFdsHfSqjvkAzOs6+Fp81qAZug2ROb2eyGOMbyLTda2x_-Q@mail.gmail.com>
Subject: Re: [PATCH] CREDITS: remove link http://www.dementia.org/~shadow
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
        ribalda@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        mchehab+samsung@kernel.org, luis.f.correia@gmail.com,
        geert+renesas@glider.be, paulburton@kernel.org, cyphar@cyphar.com,
        martink@posteo.de, davej@codemonkey.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 4:41 PM Alexander A. Klimov
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
> index 0787b5872906..92ad22b7ef56 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -483,7 +483,6 @@ D: Intel Wireless WiMAX Connection 2400 SDIO driver
>
>  N: Derrick J. Brashear
>  E: shadow@dementia.org
> -W: http://www.dementia.org/~shadow
>  P: 512/71EC9367 C5 29 0F BC 83 51 B9 F0  BC 05 89 A0 4F 1F 30 05
>  D: Author of Sparc CS4231 audio driver, random Sparc work
>  S: 403 Gilmore Avenue
> --
> 2.27.0

"dementia.org" became "dementix.org" a few years ago.

This happens to be a co-worker, who suggests replacing the entry as
per this commit:

   https://github.com/torvalds/linux/commit/d878bcc8695c5d8bd3ca8b8defa4d50ec2424859

Although that might be a bit beyond the scope of this particular patch
series; it should maybe be sent separately.

Marc
