Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C50C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0E220663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osttgXnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCLONI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:13:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53761 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:13:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 25so6272713wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZQgburGOOGmv4RWs5U4M1z5J1veDULphtrYnQJdpvA=;
        b=osttgXnp9s3DzDGznRj8yQb8aW3xDZxQnv2vruUMSqZNUkQC2lQ8Z6gsnIzcju7Cx5
         scoUOxawMh/xbpeLsyuBqQeBBaQzir9kT5UOcU2D8is3tCcL4ezdxasIDfpiNHbz1g7H
         BYGj5vRlVK2FvebuA5SrRbp0YY2OdbDPDARxhV4xPEFthGcagjVfdd5mxz37kC6fuMgn
         LZXHfBiK/Eddc9OdDWsoEqioyg5Ij0zrDC47MISa5m6NhyalMgc081BMTFbLenasgnCI
         oVbgwESoHl5nqNwkHSXZRTMOMb5VFOd13j3oSvyCOblicmTgLYP0o70RLAHOnZtJvrpY
         vlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZQgburGOOGmv4RWs5U4M1z5J1veDULphtrYnQJdpvA=;
        b=dfPTSkNPGamebirTiUSR2nFK1fjc1k6lNv0ynjvr2/HUl+A8j17Cft3v4PDVpMZbRQ
         is//6OhGKZVY56ksmS8AluBhpXwP8l8onYyUPIfIrILmRB5b/xeOJGTIdLS9iII1dxec
         rJb14O7D3xAfRlXNz3nLt7xK4gboYHpj496alg2ryfO+CvRcyJzATkiLba8fZdgQZZRM
         88N7uW65goT7bOsxetgxTFSdL/YCtcBB7v1g0LCxW76SmwHLr4SLWVRdh1kKIz8VyDKf
         iU8ktgt590WnEggKBTSU7CdfuOacghZ1YXrjjhUC1hhQkq8VSIbe7lIgGJsoMq/TjpcK
         /Qfw==
X-Gm-Message-State: ANhLgQ0Eq8BmJwtUsZh6rGH0XYTHo1mBfarZzimfdpC9T4iQGrqICXJk
        DkN0t8X+U2uNl1Ozob6NXvd5iuX6wCCeZ8rxLwIwdg==
X-Google-Smtp-Source: ADFU+vtwVpkNC3AQTYUUgAKILzm0mOEzte8veCiEEVhf4jfVA0AQoiWrcFwV86WhV2txz+JGeINE8PlDAa3AL1STTsM=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr5121813wmb.73.1584022385024;
 Thu, 12 Mar 2020 07:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com> <3cfc40c8f750abc672d6a60418fe220cb663a0f5.1583896349.git.joe@perches.com>
 <12c75b17-1d0e-6cc4-4ed1-a6f5003772ae@amd.com> <3fc2c61e4c1c25d847fd7f284c818b664b64441c.camel@perches.com>
In-Reply-To: <3fc2c61e4c1c25d847fd7f284c818b664b64441c.camel@perches.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Mar 2020 10:12:53 -0400
Message-ID: <CADnq5_N5Ssc3rjY9m20t7UExkP5oBjQBpxj9wY6RVsqyuYwR0A@mail.gmail.com>
Subject: Re: [PATCH -next 023/491] AMD KFD: Use fallthrough;
To:     Joe Perches <joe@perches.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks.  Link fixed locally.

Alex


On Wed, Mar 11, 2020 at 6:11 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-03-11 at 17:50 -0400, Felix Kuehling wrote:
> > On 2020-03-11 12:51 a.m., Joe Perches wrote:
> > > Convert the various uses of fallthrough comments to fallthrough;
> > >
> > > Done via script
> > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> >
> > The link seems to be broken. This one works:
> > https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
>
> Thanks.
>
> I neglected to use a backslash on the generating script.
> In the script in 0/491,
>
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
>
> likely should have been:
>
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe\@perches.com/
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
