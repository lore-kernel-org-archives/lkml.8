Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A2C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2230F206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3xL0M+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgBLJKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:10:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43341 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbgBLJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:10:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so517876pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 01:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMWEtLnC4u+GSkpyrMggEcsRqsLKGC5Kgx8RCoWgoP8=;
        b=S3xL0M+iWbah1a5O2X9Ter5DBgCXGP2spoBe9HeyBU9F+JKH06Wyyhjtp44GJAmUmf
         3/6rdzhHsX3KBDKwzgUYBO2mwQztR6RuS0ZOS5LgRabbo8YvX0WcqTmQigE8PIYstjSG
         m4A4xvsSBQzUKebBqoyei996nGneoiREz8kmx4gOO2IK0E/8vm9C5eRwFOI4jD++hApP
         J1m5Hv8S+H8IkB7fj1mWC9DkKSR7Dw4VhwzffPlgzheUn0lxjHlnojexRA6PooAc5I8H
         z+G8WTgzb5UwWqHYiJp2gAmH2a1oCcDq35n4azrD8wvuJytckCaU0Ur10YkzLksVFP5E
         idSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMWEtLnC4u+GSkpyrMggEcsRqsLKGC5Kgx8RCoWgoP8=;
        b=EvZfpOlzfJM4L8iCDZU5OKLdLJEqoCOIMMt1TDhEJELW87tTt2CB65edjb6eq1Sc6J
         zV8DO5Cp7httE1N9mxaA6uAtqAxIKb/UFIyZwOn2MSYWlwqIZQrGY/EULBUc2Ge+WobJ
         13optf6FLRAEmAByu7qmrOoSNrGd1OxShY6ykg2KA2f9HSn13EQusVdQNaE6IjCEWWKl
         0V57+z2dJZW0sT5eKsgkKDH0qBKjBF8PtnSgzXYMNMRyjowjfmnCM7MJVSKafxv7BBJ7
         GI6NS5c4Uc8siOqQruxGp60Y3J9cDQVsPt05I5Vo8x/tm/Vn0zXx3jhWX6gc7uVvTe+O
         THfw==
X-Gm-Message-State: APjAAAXNR/wZ38IN+8ZLvSnJSzRv/mO7iO0drpKBpJbv8DJqsDXBzHux
        xV+YvwNpkbhRi7sGcWVDkTO+qR8imxZwrwH2Esg=
X-Google-Smtp-Source: APXvYqzTyTPBy6ErJ7sdnn64C7zYEpu4NkgvC94ld48iVT2BcZSQyrHuPKvNYehhj2FTj2NFitd4ubKoO4TcYjWQO2s=
X-Received: by 2002:a63:fc0c:: with SMTP id j12mr11223909pgi.378.1581498611254;
 Wed, 12 Feb 2020 01:10:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com> <85574e1ae1e6870ef01b6e61c5b1c5f393c2ac4b.1581478324.git.afzal.mohd.ma@gmail.com>
In-Reply-To: <85574e1ae1e6870ef01b6e61c5b1c5f393c2ac4b.1581478324.git.afzal.mohd.ma@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 12 Feb 2020 01:10:00 -0800
Message-ID: <CAMo8BfJU5Uz7uDcbX8QZX=16JJNKvaZvDoS1fqK1fsOaKQ-0mg@mail.gmail.com>
Subject: Re: [PATCH 15/18] xtensa: replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:05 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> request_irq() is preferred over setup_irq(). Existing callers of
> setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
> memory allocators are ready by 'mm_init()'.
>
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
>
> Hence replace setup_irq() by request_irq().
>
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().
>
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
>  arch/xtensa/kernel/smp.c  |  8 ++------
>  arch/xtensa/kernel/time.c | 10 +++-------
>  2 files changed, 5 insertions(+), 13 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
