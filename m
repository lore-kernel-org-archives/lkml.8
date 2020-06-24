Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E26AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8D620663
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brEAxIh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbgFXMxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbgFXMxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:53:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9F4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:53:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so1139398pje.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7wgB1PLA24/IElEtiiyYyshpHq9ZAt0FgHZBp4YNRQ=;
        b=brEAxIh+ao1RY2mgzrJutnplvrsHDpRbP3JhBHzSEdr4RyP5HviwcRvnP644j4rjcg
         wljCRJoJl92CPuu8MnHazReBoQ2GdWcIgWLwbrzdHwhr42klN2VXc/z5GBYnOLZQkOSa
         KVjl0/zO1XSvGdQQSCMkhwoSPpnZYlvHpHhQqTFu8WvOpE8mg8gopIQN2uWrLCW1Nj1G
         0bitoBcn6UGo0kiwb98U1Ls155VX1UjmPdYrBWuVcsgHDR46a5GIV80kYnwpTCv8MzJK
         /SuCiTVZtPPk1OuyZFkt5XBLs7vV16SMROdz4YZ4rRuXqyLhAlSvpMycjnv3LKod4VET
         ioBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7wgB1PLA24/IElEtiiyYyshpHq9ZAt0FgHZBp4YNRQ=;
        b=l+hBjGNcPk06pbpTAZmJkPa7HAvg5GSvZufYKSrPN0QC+UxOu370bB9NzNm68EJgp0
         7BFaIgqz76xgpF7gSW7nWkn9+JQ7PGvlLZj/yRC8Cw/gd5tSjDc49T1UbPz12x6PxlPQ
         j185pjVQqAcdUP1xgou2G3lWrCnP4V4Ud9dAPHjFwdz6ojswhGoAGzSZTYSD8rzotgMk
         R5GoieWckYsC92NxCPBl7KEhWQ1DrXyJ5JorWG6a1ResVEnkZU9VIzBnDE0A5NN34dL+
         6qeRvescQGPJpHFt61fAGecQ2eSv5czlm0qxt/Roqe/HMyG9zDoUKWjdQ+4y/MmMn4X3
         JhOw==
X-Gm-Message-State: AOAM5333xlOkym0QJXjy1pAFnmqFd+m+/DFRSxBapM3BCXdQnBIdK3jf
        y3UMZ4DIQDS7JOCopk4d46I9qYHXuG2yVJFvrIsQ/EIC
X-Google-Smtp-Source: ABdhPJzJfCnbi1xKsAAERCO6LFHCk7Xz11vkKfP638Hz4Ds2VN3Eb6sOFD6YGrqubiigSoUFs9NPhdtsxb0pxcqm6LM=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr29721947pje.129.1593003199402;
 Wed, 24 Jun 2020 05:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-1-a.hajda@samsung.com> <20200624114127.3016-4-a.hajda@samsung.com>
In-Reply-To: <20200624114127.3016-4-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Jun 2020 15:53:06 +0300
Message-ID: <CAHp75Vf5ANVRb8ghzdWa1F5U3JaRv9J2mVF8AQ+WwBahQM9Y5A@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 2:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> Many resource acquisition functions return error value encapsulated in
> pointer instead of integer value. To simplify coding we can use macro
> which will accept both types of error.
> With this patch user can use:
>         probe_err(dev, ptr, ...)
> instead of:
>         probe_err(dev, PTR_ERR(ptr), ...)
> Without loosing old functionality:
>         probe_err(dev, err, ...)

...

> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
> + * later by reading devices_deferred debugfs attribute.
> + * It replaces code sequence:
> + *     if (err != -EPROBE_DEFER)
> + *             dev_err(dev, ...);

Btw, we have now %pe. Can you consider to use it?

> + *     return err;
> + * with
> + *     return probe_err(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +#define probe_err(dev, err, args...) __probe_err(dev, (long)(err), args)

Can't we use PTR_ERR() here?

-- 
With Best Regards,
Andy Shevchenko
