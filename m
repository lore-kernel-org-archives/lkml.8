Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED01C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44832072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENdm0iBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgAQKR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:17:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37555 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAQKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:17:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id o13so25875150ljg.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqzjMr2PJAnjcxq+6uZCxmdGeRZLof2Ss3Hg+J9vbXo=;
        b=ENdm0iBUmuUTdA0B40XLa4v0P1ePchisZRxP+W10o2ohM1QWOqdEKLUQsSrngYZlZm
         Zqd1bGhi7EqEYUugnKVqmL0CEQoWRfzZJUJ1Hy7JFVn+ymSrbyH8MJYUQLbehFpFA+vg
         TUroW1b56oyl8tlKIorlymqRE0R/Oc+xfbVFfCFXt2V083PnFsCEYBQhXygGmvvv89Jf
         OassI+gQgWWc1CoPQgIvFoUNUKxDpfJNvGcYiuc0YiYejpEv/Lmxpi9bskQxI8f47zO7
         MHrpZm8TxW+JpkcAKK6MvKsJAS1zWfzGqJ4SZq9PSBrc4Dbmbkai5EQWOPy0E3m8El6X
         69Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqzjMr2PJAnjcxq+6uZCxmdGeRZLof2Ss3Hg+J9vbXo=;
        b=fQIfJgcSwjrIXKBogQfQSFffw8TiBXYQEBNE6t695MYyKbpuCd5pUnrHFjPWTGcPGe
         dvTsLgHU4zoGtVUTqMymNHO5M0mKcM/uM1t8WNttPYu7NzkeN/CJv79VMILf9FBaDybU
         GS4Dcc5TxjgKK8GWSBnMgxrIlGKNYoSU5fjdBmaD47eTbW3EAz3Ys3LqSvTLzjfwrJaA
         BQubZ6MS7k8m78/SSr94e2mnWmvHTY1/OywssjF3mRWRXTEf8RgPfXQbLiffr9wAnba/
         S3PrbtMmIxD4s0XV4PjYu+JMxIS8ael9zyNLC0zCuPVFl/GU3GI8FatNuGcPpbFAPp39
         w19Q==
X-Gm-Message-State: APjAAAU2rFLu1R0H7I/ETKaejIuZXCfOVXJhivAbP0Ey+gtFE3ECYRUt
        cBU9M/EST808BZJS6a6trz5VTcwzkPSzVLTBSeSvDg==
X-Google-Smtp-Source: APXvYqxYMLhucMLN4a7oTA218YoFopo2BZSDYlOpuBZh+fHJ/xSs+KlR2593lzW3NjSVVUxF6JLfiHAyFKKqppxU4uM=
X-Received: by 2002:a2e:9143:: with SMTP id q3mr5130125ljg.199.1579256275071;
 Fri, 17 Jan 2020 02:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20191211114639.748463-1-linus.walleij@linaro.org> <20191216152240.GG2369@dell>
In-Reply-To: <20191216152240.GG2369@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jan 2020 11:17:44 +0100
Message-ID: <CACRpkdYQjXyFZfwpk8y66R2XTSm5fEMCb-s-WzPt0KegsCptFQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: ab8500: Fix ab8500-clk typo
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 4:22 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 11 Dec 2019, Linus Walleij wrote:
>
> > Commit f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
> > has a typo error renaming "ab8500-clk" to "abx500-clk"
> > with the result att ALSA SoC audio broke as the clock
> > driver was not probing anymore. Fixed it up.
> >
> > Cc: Stephan Gerhold <stephan@gerhold.net>
> > Fixes: f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/mfd/ab8500-core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Applied, thanks.

For some reason this patch doesn't appear in mainline or linux-next,
I guess it fell off the planet somehow :D

Or do I look in the wrong place?

Lee, could you look into it?

Yours,
Linus Walleij
