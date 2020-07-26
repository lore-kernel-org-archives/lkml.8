Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED62EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF8F2065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKEnX2zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGZI5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:57:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6242C0619D2;
        Sun, 26 Jul 2020 01:57:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so940341pje.1;
        Sun, 26 Jul 2020 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZP6JsF3L+gDvWgHfD54eIIL78/CR3lRmnvV/akntuxo=;
        b=KKEnX2zyJ6WkI8ZbudaqCNi0gmqCxgGR74WNSBQn1L5ax2cCLiA4yIxbco/HI8MUEe
         /PWnKwGDsY2c4uH3zi7/nNB2V3aKPytCWS3gguyLYHNVQT1thhG25x7sp1KJBmraHmWh
         r2sGLen+0xjKZxb2J9K7oQ7IQTnWzz/b9jq+n5oVOF4ZUSMy7sb+cvXakBzJiyN9vdHk
         95zej/S8i0suWDfeg2ZLV5uLS4Jra1N01tVcu5BP/zccUYoirpfeAzo0J+39lI9zaKge
         bTvoPhu6kDIHbJ0suV41LNBb51EIHmjXorPfaKxRbwIbXMp03ES7a/6jD50ayrnFh81h
         Kerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZP6JsF3L+gDvWgHfD54eIIL78/CR3lRmnvV/akntuxo=;
        b=gEW1R0TJyTFrFpqlFeeBAD6okNbiYD39qi8R3du10Eq4dVXyZxDhqKTEFMMtY4qGgg
         lqFyAwNrUcteg964ky1dUnmU+bkoMtI7nv2B4SzxUovg6g+XW6hLBAmr3W9hqhddL1/9
         NAR63ehD+5GaR5IH/WaYzW8SgPYJs2MsPevvEkAJaDhFFYkOWXB7j8bn2FkeaNUkZhNy
         C/aFzEu13kcl4Lrvn/TssRAdegKNJ5L/AKmJHnffloYPAhOg+bWY1gg8DCdksTxVhyzQ
         gNyp8hD9uLi2yeMV/+hYPSUQzwyKPNVxZasl2E7xBGFVYpssgbuyDHOujlmTsYkSYibu
         KueQ==
X-Gm-Message-State: AOAM530B7yLRRwVVCRxQpN0J55+qKGhEraSO/ty4QrQzPg0sJ0VMgTME
        9g3mQhBTJ++BKagZLhojGVqglMCwd4VfPoCqwW4R43R6
X-Google-Smtp-Source: ABdhPJz/011v164prAx72VNLA4uAtxCJ1iLFgTJpcujNZYr5oVQ2I6rVwrYZrx3eEti8ZKJeynfcAEuaKvMiXDR5oRA=
X-Received: by 2002:a17:90a:498b:: with SMTP id d11mr14007458pjh.129.1595753836222;
 Sun, 26 Jul 2020 01:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200726052047.9856-1-gaurav1086@gmail.com>
In-Reply-To: <20200726052047.9856-1-gaurav1086@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 11:57:00 +0300
Message-ID: <CAHp75VcL9sT-Ff6FND1v5pWUF=Ey7MXE61uB5Ae3HMpJaOYaUg@mail.gmail.com>
Subject: Re: [PATCH] [video/fbdev] mbxfb_remove: fix null pointer dereference
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 8:26 AM Gaurav Singh <gaurav1086@gmail.com> wrote:
>
> Function mbxfb_debugfs_remove() accesses fbi->par without NULL check,
> hence do the NULL check in the caller mbxfb_remove().

...

> @@ -1012,11 +1012,10 @@ static int mbxfb_remove(struct platform_device *dev)
>
>         write_reg_dly(SYSRST_RST, SYSRST);
>
> -       mbxfb_debugfs_remove(fbi);
> -

>         if (fbi) {

Can you explain how this is NULL on ->remove()?

I bet this check is simply redundant. But you have to check and update
commit message accordingly.

>                 struct mbxfb_info *mfbi = fbi->par;
>
> +               mbxfb_debugfs_remove(fbi);
>                 unregister_framebuffer(fbi);
>                 if (mfbi) {
>                         if (mfbi->platform_remove)


-- 
With Best Regards,
Andy Shevchenko
