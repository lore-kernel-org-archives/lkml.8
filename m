Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BADEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5480F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PX2ZjUaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgGUDZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUDZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:25:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:25:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so11299689pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcNol1/FAOyFHA2Q0+vtk8HafcKXm8QqfR2Cf5173a0=;
        b=PX2ZjUaWYHYgdZFx7EGRO2USo2FwvuDdhVNvQfavJY7R2OcRfZArzbIptVbacNtV8q
         5fcCZBM8FWhHgl7Wb1L/uIxolOOmHIm+B9ogiUlr7/KFWOi2B8hMYm3I9sLGP9rwrsCq
         jJMa10dbqmabsOnjjac+/okOOnPnXwFVnI51DE6uMfdwmdu/Yy391VJE2+3dPSxfbJ9Y
         Kdo4TycHPV1AK4vLyt79Mc7iYNgy+QRe1WV0yS0ozcbUG6MC9PYLLmPDvQYJECRc5bsP
         WIYo2xnwZSjewZXR0vD51cCmvOgqRX2b3MGkNOAFuGJPZERu6I7THmndLfIJGCfl09ZN
         vuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcNol1/FAOyFHA2Q0+vtk8HafcKXm8QqfR2Cf5173a0=;
        b=qlopc0hsNSxy3Y1FzcnZluT/wwYLl+25pg/uMrQvGoFDSiHwDxJDu3OV0a4Fy45DLK
         wlGhy6WaK2QQ0ThlxBo/BZ6HyZCcm17vRCuQLno1udoJtTOZ0UaTTWbVALQyc3FdH77w
         ou+xnq9f6skbSg/k+rIXWbXe6ZeOls/qYK6eZxw99MEKEQpb1/f5s8XI5aTG6+PsUKdP
         iyaI8oJcOEQ61lYT4wG3EkJW8V+JeEfkEtwz8+WJWZTU3wysXIUxFfjuNz3Ww5QdCKgK
         rWTCi7bd6B9MOjLEWNy/FWQFGDZCFc6R6cZlB7vHxQexG6gi+KYL5dmvee0M62EpKHnq
         pmLw==
X-Gm-Message-State: AOAM530jbDV2I03HTxwEcm1I6RH6YiZlbVqtddz8WBXLNtRSyT050Bif
        XeoFq/+sEdcpi3NR0+amxYCdS/Q4Fwvf7pQWYKH7GQ==
X-Google-Smtp-Source: ABdhPJwIBAxwW31MIBloBFPAUJgCinlAUnyqR/tT0rVfGWwhXsd8ZZmREvA9cA+7LCbdOOKW+ffcJhqKVHNpTZFkpJ4=
X-Received: by 2002:a05:6a00:15c7:: with SMTP id o7mr21665218pfu.51.1595301935722;
 Mon, 20 Jul 2020 20:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200716042053.1927676-1-saravanak@google.com>
 <20200716042053.1927676-5-saravanak@google.com> <20200720143533.GG4601@sirena.org.uk>
In-Reply-To: <20200720143533.GG4601@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 20 Jul 2020 20:24:59 -0700
Message-ID: <CAGETcx89xBoLiqe2392_vFuoMytKMxbeM5n0vdL9dJvAF25+Qg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] regulator: core: Add voltage support for
 sync_state() callbacks
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 7:35 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jul 15, 2020 at 09:20:53PM -0700, Saravana Kannan wrote:
>
> > -     if (!handoff)
> > +     if (!handoff) {
> >               regulator_disable(rdev->boot_limits);
> > -     else
> > +             regulator_set_voltage(rdev->boot_limits, 0, INT_MAX);
> > +     } else {
> >               rdev->use_count--;
> > +     }
> >       destroy_regulator(rdev->boot_limits);
>
> These sets should be completely redundant since they will go away when
> the regulator is destroyed, if there's an issue with that we should fix
> it rather than bodging around it.

Yeah, I was aware of this, but I thought it was clearer to have an
explicit unwinding. Since you prefer the other way around, I can drop
the set voltage.

Btw, going a tangent, why is regulator_set_voltage() not dependent on
a consumer's regulator enable request? If they don't care if the
regulator goes off, do they really care if the voltage goes lower?
What's the reason behind not tying voltage request with the enable
request?

-Saravana
