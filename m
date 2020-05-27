Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C92C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED92320787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="QS/DeL/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbgE0Qy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgE0Qy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:54:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EADFC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:54:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z6so29758246ljm.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHmWtQ2TkLP6OGqb3OSxb7myh0DpkLphjU9/234BIPw=;
        b=QS/DeL/4agLgqn43tz2d+1Pv+Wcw+zCxwuarjwcFOqdidEhljsODcljY+PQD4MZcez
         6mcT5xo+Glj6Ozfyadq8H8umAzoBhXKuPdW8HcoZ043jES7AoSHHYu2QJvNfDbke8WKE
         Sd1361f4h8VU3lrRB8HNQrWQJqedcEnX0V0GYfKC+d5yU8R52r3f8aEWrcwoJJo1Lrm1
         rrlOSWgksgreXzlsXtCWma7ALPvRuCLrWDRnRqvsvYq0cqxGjb/3xHPbS33yS/6CjUiS
         7Vbd2apZUjCw2NVUJTdQpNzUFRkW7nKRLrAvi1n05Ykl31i8DWeWBLHOOz7xf4ILLl7/
         7SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHmWtQ2TkLP6OGqb3OSxb7myh0DpkLphjU9/234BIPw=;
        b=h8QCnEPnhfEVhFxFbE+1kKqHdPIum/l/k4Qtcl/ou7iSq+kTzrQ9O7hoNskokNluNw
         6IwanixO0rzLCX1d6Sb1vYj8uPzN0qFgexFyPurbO7Wvmzb4dq63x2YNQGszzGGSLMnD
         +bOlwMsfAqFvavWYsxeQvxRz9HdQYoElF+DvTPC6prV5xdkpzv5326B2aOG2hDpn+71f
         NFwObQch6/1Wv/RJ5rg6jq7fUVWNDri7hYqjouIC01RW+1NZi5e6P4V18C4qfhU1qgmR
         Q1ZLqaKYiedJo8JURF9kMWYCA2scyhMHj0pwEjTZLfe1rsHz1OpdkU9vnvIMoTd+RjQ5
         9coA==
X-Gm-Message-State: AOAM531sX9CTagoq7feMGlBx8fuZ+oMRPcCFqaW8T+lIJIIjdSQdmrK1
        G/lPhgBh4oB8fMZ+jzQC/QSzwY4xL0u1jmP5G174JQ==
X-Google-Smtp-Source: ABdhPJzmJpMkCosVV6yjOyPlOezLCCBsNT9bqO2Vj1q1MAS7G8wJ94i7BKM7SJjLa8tONQ+EvxtbGKO7THS1xmZmk4Q=
X-Received: by 2002:a2e:8186:: with SMTP id e6mr3672178ljg.252.1590598495776;
 Wed, 27 May 2020 09:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <d2c1850e38e14f3def4c0307240e6826e296c14b.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <d2c1850e38e14f3def4c0307240e6826e296c14b.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 09:54:44 -0700
Message-ID: <CADaigPU7c=1u47R9GzvGCH_Z2fywY1foGYEy=KbBikjUQpwUFg@mail.gmail.com>
Subject: Re: [PATCH v3 032/105] drm/vc4: crtc: Enable and disable the PV in
 atomic_enable / disable
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> The VIDEN bit in the pixelvalve currently being used to enable or disable
> the pixelvalve seems to not be enough in some situations, which whill end
> up with the pixelvalve stalling.
>
> In such a case, even re-enabling VIDEN doesn't bring it back and we need to
> clear the FIFO. This can only be done if the pixelvalve is disabled though.
>
> In order to overcome this, we can configure the pixelvalve during
> mode_set_no_fb, but only enable it in atomic_enable and flush the FIFO
> there, and in atomic_disable disable the pixelvalve again.

What displays has this been tested with?  Getting this sequencing
right is so painful, and things like DSI are tricky to get to light
up.
