Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66EF20781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="is0Z0ODH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390742AbgFXMkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbgFXMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:40:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4C4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:40:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g18so2148448wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czN3cUkpv1kQMmkdRcQEF5/Tglr7qZIFUxQDipDH7uQ=;
        b=is0Z0ODH/O+1Z8kGKxdQpfE/eHMOamZ8WM08/XUTs5fTahr1lRWMbYNhrSx36JEx80
         jm0SXM7lP7FJ6urZbI0ZeedHteSfUrKXctd4Z0u4EhEwVVG0DUNLXTfgnDKfdrqXB9Ok
         IxHbspUT7ImzGzKy8sGYElGZiW8WRf+uGr1YDGfpL83/FeNEzdTk8qofPuTOm9ocnmVR
         Z+MjcK6Y6qa7sBYxHRlf7+Ki2HjJYs+nuQ1FHfFBb+Vg8ac51Vnf6v25ARlO+WxZWnk1
         gFACYtSzNFbiEqF05aJEIEdM84r2Ut7VuWGakTD1x9Fng6RsLGO4TTO3vX14r1QrrXoW
         6U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czN3cUkpv1kQMmkdRcQEF5/Tglr7qZIFUxQDipDH7uQ=;
        b=JPc/mRy0W7vftGXQ5GqRlcUcQxJQzNsWUH9niSojE+kYhXGyY26iCI9bAr4MlKFDtd
         jFuWj7GBRP5BWicAm9gZ+DRZE5hSUJZpeO99forIBH4mjLqfS6WQNhmrPbFwX1UttQ0v
         9KKHeRmSfoAvUaKGw5h+EJJ+rTG9nFFd5I7aL5lOMOG7Qy6HAOfbcmnYRM59PrRpEZyh
         khn0vAgVaJ23MS3tfACZ7gvetja3kh+PaFjZ6lVjmaqVc5Y9KiWVYczOGERKMAfsvaxt
         1n72MG+ImUW3xdxflL1ZE3GNedeKW3RShRdiouUa+fg2nbi0ts5MWkrgdkSglq4pCpeK
         ykKw==
X-Gm-Message-State: AOAM5317TR42U8rTod8okD9CMH1hgqlGMMiGAzl1BYp5kmWb3Hz0wv0l
        qYZBj0qxces21P+m/FpLgMySuZ9uCCnni6b72BAMuQ==
X-Google-Smtp-Source: ABdhPJxiHs8qC0MdyilZ/rFdbQ/99kxjF7AUJ3DV0kzlDEUC72lAGx/Ou3kmkDtmsJQ13jfoLnylFsg8pzdKioVquDk=
X-Received: by 2002:adf:81c8:: with SMTP id 66mr26492530wra.348.1593002437120;
 Wed, 24 Jun 2020 05:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200622100520.143622-1-darekm@google.com> <ca796f62-7d1f-3391-0373-ec9b98b1c47a@xs4all.nl>
In-Reply-To: <ca796f62-7d1f-3391-0373-ec9b98b1c47a@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Wed, 24 Jun 2020 14:40:25 +0200
Message-ID: <CALFZZQHuqx+H=7pd9t=XYWqKppMzze0XsXwRVA5kLZfwWYLmKQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] media: cros-ec-cec: do not bail on
 device_init_wakeup failure
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dariusz Marcinkiewicz <darekm@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I realized that I sent the previous answer using HTML, and as a
consequence it was blocked from mailing lists. Sending it again
(apologies for double posting).

On Mon, Jun 22, 2020 at 12:23 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 22/06/2020 12:05, Dariusz Marcinkiewicz wrote:
> > Do not fail probing when device_init_wakeup fails.
> >
> > device_init_wakeup fails when the device is already enabled as wakeup
> > device. Hence, the driver fails to probe the device if:
> > - The device has already been enabled for wakeup (via e.g. sysfs)
> > - The driver has been unloaded and is being loaded again.
> >
> > This goal of the patch is to fix the above cases.
> >
> > Overwhelming majority of the drivers do not check device_init_wakeup
> > return value.
> >
> > Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
>
> This can be CCed to stable, I guess?
>

That issue is not a recent regression but has been in there since the
very beginning.  So it might be argued that is it not severe enough to
warrant cc'ing stable. Happy to do that anyways if you think
otherwise.

> Can you provide a Fixes: tag as well?
>

Done, submitted v2 with that a couple of days ago.

Thank you and best regards.
