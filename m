Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7F520706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgFVTAe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:00:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40195 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730584AbgFVTAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:00:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id t25so16597335oij.7;
        Mon, 22 Jun 2020 12:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z59w5oiWxqTwMyQwuHYI8ey8CfTBnQaiPGy2tHrE1Oc=;
        b=kRY6YDHpfLQEAztOC4Ywab6ilMvAmuAuWiSaXVUn22uJIEJvwHqhtDAmO1fj9jbNyJ
         vz/LORpkiccAZOWYd5g8RUBpXOuoEbDEsbkt3YCI0M7Bwn2vhJenHHnJrhaasYTnEw+g
         xGiHdj0fKc+xPIPCLO8bqHQiW7QH8vQ9YZrA1WG5eIEoUKQJE3udQJp8zP2SQH110Wdm
         kiFl0W4FTpTaT8pj4AmDHWXXlaJ5A+OU+ee75dycJODC3q4AlZkiuI6Tjg5kIJD2XQXg
         E9gimX1+bDJO6XJCCAtxiApHioh2dJMfVkMZ/Yu7zOiDad9BownqzrWLcyogJZoFnO8O
         T40A==
X-Gm-Message-State: AOAM532j3Dc4/LmfOzxI+9KevQH3wGW9+uFiueQ9yA+WoavbRng15CrH
        HAz13jDPsMWz5ExnrIZH6fu+ANYsR5O/Ww7HJRO2sA==
X-Google-Smtp-Source: ABdhPJwI07nEdURLpondejh5pGqI08dfdmqHKC9L6PmNZ7ntBKOHDPWXFaqyU2HpzIfswjDrRVT+XKP5PPe58sUQIKQ=
X-Received: by 2002:aca:849:: with SMTP id 70mr13140333oii.153.1592852428711;
 Mon, 22 Jun 2020 12:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdXHT9y09L19j2K=oQ1W+7x=SE7MEyjj6r1i=DPcokvWzg@mail.gmail.com>
 <20200617074023.30356-1-navid.emamdoost@gmail.com> <CAMuHMdULgdhgoydX-nnVSyCEBd4zkCgSyVZ+ojFzGM0gky6OJQ@mail.gmail.com>
 <CAMpxmJXV-Ujx2zgXxiYWOED2CYz_89aAiUUiqak1JbtNJKgSFg@mail.gmail.com>
In-Reply-To: <CAMpxmJXV-Ujx2zgXxiYWOED2CYz_89aAiUUiqak1JbtNJKgSFg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Jun 2020 21:00:17 +0200
Message-ID: <CAMuHMdV6oSWCt3+r-7X3VT7MkpxenYMvH1gHinU9nJUvKO3bsw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: rcar: handle pm_runtime_get_sync failure case
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        mccamant@cs.umn.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Mon, Jun 22, 2020 at 6:54 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> śr., 17 cze 2020 o 09:43 Geert Uytterhoeven <geert@linux-m68k.org> napisał(a):
> > On Wed, Jun 17, 2020 at 9:40 AM Navid Emamdoost
> > <navid.emamdoost@gmail.com> wrote:
> > > Calling pm_runtime_get_sync increments the counter even in case of
> > > failure, causing incorrect ref count. Call pm_runtime_put if
> > > pm_runtime_get_sync fails.
> > >
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Is this stable material?

No, it cannot happen anyway.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
