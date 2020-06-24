Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8452EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6400D20C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIFyo4x4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391074AbgFXNpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390774AbgFXNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:45:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FDAC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:45:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so1453350pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKjWMjcOxALjROxn2da3zX/d0T2J4uaTbhVPfw/r1PQ=;
        b=YIFyo4x4txxZ4nqaQk75rQY5jHXt9ta7pLR6PGdDvI67aadyE5+L92CGN3HuHa8b+g
         /KTEzvOMJiyWfzC5nmOmK2F0CPWndgpgNbrk06imhGjhX/AlLealSi4h16f7ItYYqWQp
         PyZvzUIf94K7W8x7/Vl2YmhadvQ3VEME3M2psh7wm0Fkrr9QD1YDVNRRvkyw6X2OMVSL
         hXol1Mu8YovpfH7i6TRTMswRYxs1F8ULc3UF8BNVCr1iagu258KvU0qjmHvnlEvjDS1f
         RksFsoVidEsI7eEByIHnnjSMYNZHnDX09NvrqCF6AHCGSk0FIp/At/kgaov9Jdg+Ewna
         KzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKjWMjcOxALjROxn2da3zX/d0T2J4uaTbhVPfw/r1PQ=;
        b=MoulDFm5tQFZo7jflLQlH5PAII+4gy4qNRKGbsNm037T5HEMRcO8jKCFjJbZLSOPta
         q2MiegZbDNPUuBynOz3n19J4BRQbJELJTMN14xLk7IQ1jpA1SAhNvd3AWvaeLxFgORfB
         tP9jFIedAU44taF7pUxMO5QRKHgmOFal7/kaDbhiaysuTuCTsyo7G7kLoBeDVmozbldH
         Dk4i3f/I3uK0ZJDFIEtEFiEtfIHoyjDRVLpizXhnKt+MeKtmPMQdopfXMucioGVFlQwM
         WMrKqrrwDciu4BAaxG5c45+L225Bw14a2q/QA8XNzl0uwWdE9kMJKQ+9wAb8/gj8aFm2
         X/aQ==
X-Gm-Message-State: AOAM532SSDYIRBpyn2Q+FlRoesmUZ/4Vbsl6Br5n1f+m5vVh7n7Kcf0P
        5811XPy7RDSOC2J6ECctPAGXVlQIC+lUNpUnXGc=
X-Google-Smtp-Source: ABdhPJzP96rHQVTbJaOF8adE4hygUklHj5+XAKX0WUXTgJf5HCnXbbYR24k5yfeYfOhMoH40Y1T+Uziyt/t5umR+CAw=
X-Received: by 2002:a62:5284:: with SMTP id g126mr30364100pfb.36.1593006340755;
 Wed, 24 Jun 2020 06:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200624114127.3016-1-a.hajda@samsung.com> <CGME20200624114135eucas1p26e2e4683d60cebdce7acd55177013992@eucas1p2.samsung.com>
 <20200624114127.3016-2-a.hajda@samsung.com> <20200624132714.GD5472@sirena.org.uk>
In-Reply-To: <20200624132714.GD5472@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Jun 2020 16:45:28 +0300
Message-ID: <CAHp75Ve9V1Vyxe3bEeHJ9H2J900wUXHMmXFJt-dn9sO5OMejHA@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 1/5] driver core: add probe_err log helper
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
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

On Wed, Jun 24, 2020 at 4:27 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 24, 2020 at 01:41:23PM +0200, Andrzej Hajda wrote:
> > During probe every time driver gets resource it should usually check for error
> > printk some message if it is not -EPROBE_DEFER and return the error. This
>
> As I said down the thread that's not a great pattern since it means that
> probe deferral errors never get displayed and users have a hard time
> figuring out why their driver isn't instantiating.

Don't we have a file in the debugfs to list deferred drivers?

In the case of deferred probes the errors out of it makes users more
miserable in order to look through tons of spam and lose really useful
data in the logs.

-- 
With Best Regards,
Andy Shevchenko
