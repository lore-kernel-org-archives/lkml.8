Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F7AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5514206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7R3C+Pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgFOGNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgFOGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:13:20 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA0C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:13:20 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w18so16551353iom.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6JLd6VBkcDkATEVOSxJhkAGOZIDXqhoY8AZkpcmZ1I=;
        b=P7R3C+Pv5AStNTdmtByWH8kFJIAdbrKj63kPRxtluqt+798Vb3IuRi3kpqZPiUP1q2
         OO+3rEvIlkJUteKFWcqNGD+jYemiXli3MSM+4vuAj5aY15kAT9AldFavTYhW9RXxbKpD
         AKCVbPTgC1KEMgA5CWro19tnhyF/rRH99ptqhqMgnPpjgP3cCAqRZX2NfV4xcVTLh5xW
         TzIt/P8c6t85pSeeMOXu30H9ferniSHjmQdrwEFhDVEDMQTB//lHgNSSvbuoj0i5qtAP
         AxGPl/3neip1F+ady4JB+Y53uLG4zp2Ni8/jqOsQXbFMqbegxmv2rC2llztVNX6NtTbH
         d0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6JLd6VBkcDkATEVOSxJhkAGOZIDXqhoY8AZkpcmZ1I=;
        b=LxuhNJcNFCqwONBHXaLOWMjfSqM/ORvbNJ12s0rpX7OC8dqpiLimRK+YGgNegGmE2V
         5B9MZCwY0rAShxtaycsw/t8ojAd6EZcNJK2loknFLz7dvPFrxgpEXpm/v3se6Vh0yHnP
         P3w0g4ueCBFqwXi0XsvedtJtat5UUld6v+V1KZSF80W8oRzMK5FrrnYzsRR5wJ0m14nj
         +G48XG24w6jx5wY88uwdMnAPUwBKuNjDvcgAi0mrfhoXbE1BXvKFffF/RtHEdPHLbGOK
         rDvR8Tqdl0OLdY/tEEEp3hH7lV7Sg6+G0AsxBnUImeBL2jLHipuTE9JKmgEGYOe7Zzaf
         8NiQ==
X-Gm-Message-State: AOAM533f3RvqWFi1GTyILZqbc6+Sui5ns3yQ1fTZ6AQ+zKsKqAPLk8Bm
        +p8ExQ692BZl8lKa8yGrCVxKHEVq+wgm4nmRqNENiL9jOgo=
X-Google-Smtp-Source: ABdhPJxFXpC6yxoyS/q+VFmv3UDEL3AF9AGZcAzbg95oAGdfyGUv7KDldyeXnqrxKmupmPQJdhjCt6Ym7GydEAwH5dc=
X-Received: by 2002:a6b:39d7:: with SMTP id g206mr26366722ioa.31.1592201599906;
 Sun, 14 Jun 2020 23:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200614064601.7872-1-navid.emamdoost@gmail.com> <CAHp75VcLR2w9Ym0YOqUT9G8xT9qWrdD1-wP4UA-1wtuwCNxqSA@mail.gmail.com>
In-Reply-To: <CAHp75VcLR2w9Ym0YOqUT9G8xT9qWrdD1-wP4UA-1wtuwCNxqSA@mail.gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 15 Jun 2020 01:13:09 -0500
Message-ID: <CAEkB2EQmtRh4HjhykCdKtw8SPaQWgLHgDc7VQ3=H0ssz=m1Y-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: fix ref count leak via pm_runtime_get_sync
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
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

On Sun, Jun 14, 2020 at 4:48 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jun 14, 2020 at 9:48 AM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
>
> ...
>
> > +               if (ret < 0) {
>
> > +                       pm_runtime_put(gpu->dev);
>
> Please, in all your patches fix this to be _put_noidle(). We wouldn't
> bear the flag day of fixing these parts again.
> Yes, I know that *now* behaviour is the same, but calling put here is
> slightly inconsistent.

v2 is sent.

>
> ...
>
> > +               pm_runtime_put(gpu->dev);
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
Navid.
