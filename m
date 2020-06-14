Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C12C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9324204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQZ1gsfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFNTPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 15:15:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13ECC08C5C2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 12:15:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i25so15593365iog.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpwnKZ9Z6FevvyoUxw0sdksaS/2sRQ75c+duIaoaZRc=;
        b=kQZ1gsfj4lQvJR/H6vCmpiIkhHpY1f5kqABWgOdvQibUv+iHS3adjlq7sAmeP7nupv
         kTuTPf9cEZCfjSzEt5Pwjn2/Y5OJPqcXNKdEiYJ65tNm3lE5S//3/QUChsdLMiH3Ss5m
         IZmyOEbX7udSeeSl2jFkIBtVbh7C5D3OmB6KXnNmI+Sn5CM5R2Z+pEQJWLd2KrntjvW9
         8Eji/AAMtgS44m6p87Bwqpo51mPp2t5RWPvCuujfimgke9S/e5Ft+SqEfO/txsZqyZJQ
         LELwfOzqwyJJUYpIRnY4sDK8dODhipQ+tSIo4x5CmkOJnQGfk8VKCCiYCKAFYcBZgG/x
         1MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpwnKZ9Z6FevvyoUxw0sdksaS/2sRQ75c+duIaoaZRc=;
        b=Xr0jPu1br1LvpxeKiQjvjcYEJ4hj1uWpJlRrT9I7XCQm2wKboxxcT0OBz3XpOxOO/6
         zyMPDSw71xcxvvJSXNm9gCorCn91pt219Z9Q5cyceyv7XSsi3py627B3X50WFpjVp3KX
         hycEAlT7zeQAv9sN2EYdTeVQSUX6QMXaPS9qUrwsQBY/ozEXFGj6d6Va4GKdE3dJjQQx
         yXRULOg6UFFL4DqN/AcHNP7SOJReys3MPvbNYzdgbTfT0UC7TqR5EgjTWv3LT3EGNRJr
         LUMdF9Eve6pkpwxvDVb4C+MZmHUc+X5ipDzLasoNXPjz8MuZNUc1U3+RwfZRAG8Ip4Bl
         hdaQ==
X-Gm-Message-State: AOAM533lZfUUNzcRETH6eDTb2k2zdfsub2m1KkuYgAe3xRUjFk00hFg0
        XbEKXWf/INArlk08R93vhv9Qsorxx3sbiL/j8cQ=
X-Google-Smtp-Source: ABdhPJyOaUbf6w/OzApnwrzsYrF07Gr4v+amCoL5dWrIxkwQePYhnfiW6OXCJxV+poNC+TJA0dsvW1qrLKIoTHB/K70=
X-Received: by 2002:a02:380d:: with SMTP id b13mr17917547jaa.107.1592162118632;
 Sun, 14 Jun 2020 12:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200614065251.94106-1-navid.emamdoost@gmail.com> <CAHp75VfGHab7Oy5hhW+6rWxkcB5ZHif2hK7inbbdvfF-k0wX0A@mail.gmail.com>
In-Reply-To: <CAHp75VfGHab7Oy5hhW+6rWxkcB5ZHif2hK7inbbdvfF-k0wX0A@mail.gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sun, 14 Jun 2020 14:15:07 -0500
Message-ID: <CAEkB2ESj-SgM9aSHdMp_wx_gUETO-CoD4jkR+nr_CLZRShrp5g@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: fix ref count leak in vc4_dsi_encoder_enable
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 7:32 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jun 14, 2020 at 9:55 AM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> >
> > in vc4_dsi_encoder_enable, the call to pm_runtime_get_sync increments
> > the counter even in case of failure, leading to incorrect
> > ref count. In case of failure, decrement the ref count before returning.
>
> ...
>
> > +out:
> > +       pm_runtime_put(dev);
>
> Better to use pm_runtime_put_noidle() for error case.
> And here is a change of semantics, i.e. before your patch there was no
> put at all. How did you test this?
I had no way to test this but looked to me like a miscalculation of
ref count when there is a get and an error happens then the ref count
should be restored. Does that look incorrect?

>
> --
> With Best Regards,
> Andy Shevchenko



-- 
Navid.
