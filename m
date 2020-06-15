Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83469C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FAC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZpP7pmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgFOFuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgFOFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:50:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBCDC061A0E;
        Sun, 14 Jun 2020 22:50:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so16547739ioo.4;
        Sun, 14 Jun 2020 22:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EfP5hZSQNzjQqMkWc9LoRXc1AAXxZHM8N9PyJWorKz4=;
        b=OZpP7pmFsGmdxfS3l7uamNicZ8uQ9Nf8MR0kC6l/Pylv2f33o6F24h0bpzGfnyXBFW
         5WWD5ZdB4FbEP6XgNmVN/I/lu5Po/R06+vSXGDdATGWAASgmjZwTL7BjbDf8xSkX4bLn
         NvXWEBf0YYdsh5NZACwjgmMVIxKlBjvbArIrI7x81zZEP9jcjTPCwI+rYqtQKHnMkpd/
         PLUN7P2RBZQ+ofxirAEShpREIO9P2aOlf7/3c1iZ5/MK9NJ2OLO1XrpiNrA1SLuQTndi
         3mA9KZYkXv6PV/m0QxLN3Nz1rJsCxRpY0lRvU0xbHuXq00+yKGSdmyDRWY0GXXflXEf7
         xlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EfP5hZSQNzjQqMkWc9LoRXc1AAXxZHM8N9PyJWorKz4=;
        b=B4GD6tEdys3+C4ZiPPlgR8oiUY7BYp4I3MBfyIJOuVrOXetz3EBxCSKWsDWskrndE7
         F/s4guOJwGOCwDLmx1GrbZse7isqIQtQthW7/QVyHabiEhdaXROCq50ZvazDLRvVq+gn
         wCGSRgOlUGjDAIWWsPA7z9jNfW/GR6/T1t/X7ufR+SvtNk5dgg5piI++vG3RZQEsxCpE
         I8PoClf/uSCCdvrNHEjCdzUve/f3umb+wdNzjP/lNl5r2sHzw7Q1rAbalVAbFXSZWJ84
         cVeUpX8fWO9DnP+dRiX21LFXHS8lIh/YA6ApBhBzegNgInNdunWSIWiNyAGa8ZuAo0AG
         0WQg==
X-Gm-Message-State: AOAM530VulZzXzX9yHWy189J3rac9CSzuuODU0CoNJteGiUcN+5ri4hq
        L0BRG+wHZYYG1I7b5WCxFUnZugpMwSUyawXya7E=
X-Google-Smtp-Source: ABdhPJxz5YVDWt61fjYvqGw81By3kuArLbE5XdDIQNJvf/HKkZgzu8y6e9oqRac/mywKrTNKpTfgNMjzA98j5esPH4I=
X-Received: by 2002:a02:c9c5:: with SMTP id c5mr20110262jap.5.1592200235543;
 Sun, 14 Jun 2020 22:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200614062349epcas1p1e285479c1e6483708b62f93e70a453a4@epcas1p1.samsung.com>
 <20200614062339.87374-1-navid.emamdoost@gmail.com> <027d9eb5-a1c1-c329-72c3-a555b71f8677@samsung.com>
In-Reply-To: <027d9eb5-a1c1-c329-72c3-a555b71f8677@samsung.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 15 Jun 2020 00:50:24 -0500
Message-ID: <CAEkB2ESuG7omgvdEnfQ+hV_uWa1mhK=22VnN++TaFqOycaTc_A@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fix ref count leak in mic_pre_enable
To:     Inki Dae <inki.dae@samsung.com>
Cc:     Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 7:47 PM Inki Dae <inki.dae@samsung.com> wrote:
>
> Hi,
>
> 20. 6. 14. =EC=98=A4=ED=9B=84 3:23=EC=97=90 Navid Emamdoost =EC=9D=B4(=EA=
=B0=80) =EC=93=B4 =EA=B8=80:
> > in mic_pre_enable, pm_runtime_get_sync is called which
> > increments the counter even in case of failure, leading to incorrect
> > ref count. In case of failure, decrement the ref count before returning=
.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_mic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/=
exynos/exynos_drm_mic.c
> > index a86abc173605..69ff74c2ceb5 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
> > @@ -270,7 +270,7 @@ static void mic_pre_enable(struct drm_bridge *bridg=
e)
> >
> >       ret =3D pm_runtime_get_sync(mic->dev);
> >       if (ret < 0)
> > -             goto unlock;
> > +             goto turn_off;
>
> How about just calling pm_runtime_put_noidle()?
>
> if (ret < 0) {
>         pm_runtime_put_noidle(mic->dev);
>         goto unlock;
> }
>
v2 was sent.

> Thanks,
> Inki Dae
>
> >
> >       mic_set_path(mic, 1);
> >
> >



--=20
Navid.
