Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BAC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF7C20726
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BslnAMPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBIMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:43:34 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39924 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgBIMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:43:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id w15so3856444qkf.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HDQIjj7/RoJLWTQe7Qn8xLRJWwhFZyZPFpixKZQtWc=;
        b=BslnAMPTFediwpaZFlp2heXASRgX8v8aUXs4aofs/vN0jqnkG+BxIvOnq4/ykzx/Eg
         OdYffEnc4QvF6RVCf74NmtRvLiqEzhYLuHxnSt160Yttiji8URM9DSLodTvmsws37OyT
         MzdF80b/1Gayu2vTVYQisVu6xLheXWBHCKEf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HDQIjj7/RoJLWTQe7Qn8xLRJWwhFZyZPFpixKZQtWc=;
        b=mvr9wvkPaIciz2vlNTCBMbK/0CLVg7YSjJJ54jDAXkBkAtIAtvsoHIX/jS0TpQsnd0
         SHnXPVmKo6a/vJuRiWuGkfyBGcrSt14ZCDRmRtn/Mb/JX8fhww4j78mXhuI7z1kdVYcx
         BzPLOUgQvLThZM2paL5R43y1rXUvKfK+zfm0LSX1lFY9P4m3MNOGtY97L3O/kxAfOvKh
         aRfvRc9bK9l/MiW+Ur44pw8XAzUNCUZjrP0Ve2Zj0j5IO2JfQFfpcjFnyGfObqymN3sT
         FXX+JYO4ToJm9gfg526LByOd/107rjS3e+m4Q1N3oLfJsjsGlAVct4cc3YA5YUrnMJFq
         H6YQ==
X-Gm-Message-State: APjAAAWho9dUDAOYzMsXDDlSGlDapTZvBC4X6HETItoe02oeJWh0JICC
        ZNvf64BGA5yWgWEZwIKf5ny0/DrLy6//GSftkgUTbA==
X-Google-Smtp-Source: APXvYqxdIXhbGu82ZxdIZ0YX8kCfAxINMhvxHUzLab5jgw1p7s+PzJ92K93PdTlaojIxuAyxA6VD+5BjPwjbjN0wh1U=
X-Received: by 2002:a05:620a:1656:: with SMTP id c22mr6969362qko.144.1581252213254;
 Sun, 09 Feb 2020 04:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-6-drinkcat@chromium.org> <20200207135251.GA2952@kevin>
In-Reply-To: <20200207135251.GA2952@kevin>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sun, 9 Feb 2020 20:43:35 +0800
Message-ID: <CANMq1KBKmOzaF_JcCMz_zWvDdO=ipnr3sv-PvpUZinheKSX8FA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] drm/panfrost: Add support for multiple power domains
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 9:52 PM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> > +     for (i = 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
> > +             if (!pfdev->pm_domain_devs[i])
> > +                     break;

(next time, please provide a tiny bit more context when quoting, I had
to look up to see where this comes from)
So this comes from panfrost_pm_domain_fini.

> I'm not totally familiar with this code, but should this be a break or
> just a continue?

Check how the domains are initialized in panfrost_pm_domain_init, they
are guaranteed to be "packed" at the beginning of the array, so there
can't be any holes, so break is safe.
