Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BEBC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706102065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boRNySGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGZI6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:58:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCBC0619D2;
        Sun, 26 Jul 2020 01:58:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m16so6599685pls.5;
        Sun, 26 Jul 2020 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1yGJnuNpD4do6FBG5mJhUC2P0QZnCXgqJQvqFc7BYo=;
        b=boRNySGGJxBWJtX6SQlUK/nW6EuoNyYorWR+XRHUVvjzoi5RZ4qTUEUL/j0OAfTD01
         8uytWTN5ntgW32dfW93cE2A7YnZlTFkzK4bZOwwtDgpjSe/hB6j4kHgvwUJUAD7YA0F/
         gYnaRCUxQi+OiCr1i42eu4C8R3Fjqk9cLqIEfWxg37Gq6VQS1zWu7d1/IyMObeQRs4BY
         /N751t7kH7YTyEKqidIW6vBwXSaMrq/pfTNSHxHf/FR2XupdtBiEfnjkpcP4F0giG/1Z
         aoTVV0jNK6SAJ9HMncQ2e0kxB+lPJ84tVeEBM6PWbrDjbddFzpDo20a8wisiStSmvyaV
         BPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1yGJnuNpD4do6FBG5mJhUC2P0QZnCXgqJQvqFc7BYo=;
        b=ZEjl/HW+SkR6AleejNLzFkrnJTw9RNCZ6Nc3XM0eILdROM9hQ+avAYkowXyOozTAWn
         dUh7al4A2GALoO6z1jIpVXbbJ1/cXH+IYuaWI6JpO02FIHwWb9ZBGtSQ5G3tKh7zDZFc
         tv2qkXFtKdId7IngLF3Dqs4w9dvQcZu1oGze8eA8tu317alfhyzbX06UiKD43GBu+syJ
         6P/40YFLE4t8um6m+68tvuNsSHcysHJvQdvzvBHkbnVIoURBGBW6jVss7nrde9g3qlhN
         E+QPdaXfqRGIMNJ6RixxfkBxsVJyRFTjtfyscH+W2p5SmoqSRxhbJPDbkWkaeU0Jz+yB
         LMVg==
X-Gm-Message-State: AOAM530iokC9uUk9Te0RgS1Qb/+UeOLuSCQJuQfsTEB2Xh1D0wxQXRxO
        Bd+hC1/WBxkCH2Fdbe6pTzZRXlXza8CzOIgMeuI=
X-Google-Smtp-Source: ABdhPJxC26t1TVcy2BCqXWYJOp1U0PTQPyZFkQTpOeUL9TGGQ4UfvPWOI+Hk4O0dYoLWVYDKACgPpCZivTvThQPKa4k=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr13187611pjb.181.1595753916026;
 Sun, 26 Jul 2020 01:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200726050713.9461-1-gaurav1086@gmail.com>
In-Reply-To: <20200726050713.9461-1-gaurav1086@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 11:58:20 +0300
Message-ID: <CAHp75Vf0F+vtgg_NB0dL5Ck9m4_7fEHyH84mWrhTOXrEoL5SGA@mail.gmail.com>
Subject: Re: [PATCH] [video/fbdev] fb_flashcursor: Remove redundant null check
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Qiujun Huang <hqjagain@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 8:17 AM Gaurav Singh <gaurav1086@gmail.com> wrote:
>
> ops cannot be NULL as its being accessed later without

it's

> checks. Remove the redundant NULL check.

Commit message doesn't clarify why your fix is the correct one.
Maybe it's the other way around, missed check in the rest of the code there?

-- 
With Best Regards,
Andy Shevchenko
