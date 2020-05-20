Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223D1206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXX6s9y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETIZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:25:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C47C061A0E;
        Wed, 20 May 2020 01:25:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so1022093plt.5;
        Wed, 20 May 2020 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tPbVuaH7x667YVa0PZC3b01wZjFLoZdc5JLgowHHXdw=;
        b=PXX6s9y0kgsB4aqBrX2gscU4z7zvBt7G1fpjhw6QL0dH6b0sdSEbeSF7QO0IqUjMMZ
         NB+AL08jfWWk3oTLND1Mm2caht88GPxY4azNEseTWqwM9KvCxIZCGdZAHeGkLqwJaoB7
         2sdbNLhQZxwE3WCeezm9c0fK2GYArvtF6GatKIxDJKNM2GvbCbKFA7S/FCyhsuwuKMFt
         SJDHO3JuEQwEZDeRat+cgKlVTfkLXjEBenCzLOGl/EeEnzdlMNzch9pzu1bOWbjT48Ly
         e2dAGnonPQn1xciXIjCpVL/INmGy1tqyX5dso2eTELTdMukDeodexvMZNnx2iUORAM7o
         gs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tPbVuaH7x667YVa0PZC3b01wZjFLoZdc5JLgowHHXdw=;
        b=K5a4mvbzNAtBfSfIy3+1Zcf2Vol+cgQBvLW640/tfoHdpUyV9FR3wHqjyjWqDrC8BW
         FCIULxGp5Mqh9oZmDauUN+uJHhwCNX/0cBX07ir+Cnlg44nMhnQao7Cloo3z5scox4kz
         YOjrx9mw89O+pPdghp2yfKeRvpgIMJYxJq0WhoSCu/Myi69S8MU7j3zKQJ7o6Mevhbxq
         2v9eISi2/bTdmX+FAN4bKzvjc+FoPrN7QjjbdRgG4JXYQ8lJXrDoNn3EH4EbhOOGnyeN
         59stHo1cuuI+bmZqFtLVNKo066AthHP33N/uPOiHltIoKS/xWkkDgOo0xVxs5LabJCrM
         EJZg==
X-Gm-Message-State: AOAM530ltMgLsMa3HG8/Hg7jKrCISloxebBqf4KnFuE4HrKcCFNTxpcc
        Ix52JCu9mMupyomGADywTm8SbZ3dJCpJwaVwFVJ9Npz6/Dk=
X-Google-Smtp-Source: ABdhPJyO1vIWZyn5n/r3vSM7qCla8Q5/y3HTPDtC5j4zvK8ufAn555KE53C/E4R51ACSHPHVhegdvfAJ5IsLzM2fFwo=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr3908858pjd.181.1589963131670;
 Wed, 20 May 2020 01:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200516122740.30665-1-grandmaster@al2klimov.de>
 <CAHp75VevnkT5BohzWxtvdsP__sD0PmsaymXKB8c1cm9JHjw50w@mail.gmail.com> <0b2f391c-9796-0620-a7d6-7844d4ba3449@al2klimov.de>
In-Reply-To: <0b2f391c-9796-0620-a7d6-7844d4ba3449@al2klimov.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 May 2020 11:25:20 +0300
Message-ID: <CAHp75Vfnp2X7O+mE5OJwWHXGMcQXML42nCVN-JrqPRG75vbGfg@mail.gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Awesome, thanks!

On Wed, May 20, 2020 at 1:04 AM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
>
>
> Am 19.05.20 um 22:49 schrieb Andy Shevchenko:
> > On Sat, May 16, 2020 at 3:31 PM Alexander A. Klimov
> > <grandmaster@al2klimov.de> wrote:
> >>
> >> ... for security reasons.
> >>
> >> No breaking changes as either the HTTP vhost redirects to HTTPS
> >> or both vhosts redirect to the same location
> >> or both serve the same content.
> >
> > I wonder how you tested that all changed URLs continue working after th=
is.
> > I met some sites where https://, alas, doesn't work as expected.
> >
> 1) As I've written in the commit message, I checked vhosts, *not* whole
> URLs. 2) Jonathan already complained about that. (And *now* =E2=80=93 pat=
ch
> coming soon =E2=80=93 I'm actually checking whole URLs, automated.)



--=20
With Best Regards,
Andy Shevchenko
