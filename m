Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCDCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3376620707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD5XCCCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbgFYImI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgFYImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:42:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67355C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:42:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so2711096pfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GU/dRkgQDpr9iw62AixUC1kVf/kYhjdwq8ObET+oNC8=;
        b=aD5XCCCYMBYfnYftEvzlMtdYLSuRDmX+CPFGMUNSvAjujtddg8Ko2Qh1hZScr8E3hC
         VUHdOwGax68Ruo/XnH8rLV3FHrcWpdIyaXTb/D1GlN4PabQQiPVmxHEwyGWUWyIwhyiO
         EZu9nREZ9b3ij2dBfLrcwxDWPHcFPW31Q+6+0tpuuZes+OkKGgCPmo7HUbp3N0GgMyxr
         r/S0B68REb0nkWf2WnfsHjMymYrGw/GpCryE6uFFO7fGlDRX6PRGVYfYv5M3Xe46bccJ
         iFUbPmqgvwJHOu8oohOOo/XAIsE+IBM+PiRAMiAMbTwRMcFIircqvwnklKTJMUHPeJBf
         iBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU/dRkgQDpr9iw62AixUC1kVf/kYhjdwq8ObET+oNC8=;
        b=VgRMKrj6PYc9O9DWqjJ9jC7J/roTAGlt2ix8IS8UsHpo3801bp8JR1gtbiuNAd3HfD
         Fa15KMpX0TQgzNeQbstYBo9xrD6vsSpk1R7X6Uh5lg065Z67wkn43PydNh09MQyAlFay
         QHQrFDHFanec1oWHh33Z0PsjgGVMOBxIVtasWrrP9SsygmGykxJdVmPbS6LsYlXzrqe6
         CLEjd4cYdzPTBf4l4pNnBvENRli0esItKxJig/GLTXJuDnqHC7rpfXo+53eiQQMfmmwM
         qLmsrvBwsKmlcpBbxFJOqnoRJ71nlVyiRjF8hj/S1s5b3sEZYIYzP30VWpiJOa7a/8qM
         Fagw==
X-Gm-Message-State: AOAM530VSC809TVUd8RSP6voXDMD6hQL0fwXIzkAaxv0WrQVako4B6NV
        2MnBAPld1+3H4JTIWeTbQS1XBhAwXmL56oJjeJo=
X-Google-Smtp-Source: ABdhPJwF0Hl8GGRnPxFLftmdeC1miOVc1ZdvpotybNbXAyxg4QkjTMyM9o8rj7A1t8eWmkzECLsfKekYfiyFWAyAwxM=
X-Received: by 2002:a63:924b:: with SMTP id s11mr24565556pgn.74.1593074526947;
 Thu, 25 Jun 2020 01:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200624114127.3016-1-a.hajda@samsung.com> <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-4-a.hajda@samsung.com> <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
 <CAHp75VfpP1cGK3FvTL0hBudRY2N_7GpXYRuUHUCipz7X2sMLmQ@mail.gmail.com>
 <be755825-b413-e5c1-7ea4-06506b20d1f0@arm.com> <20200624150434.GH5472@sirena.org.uk>
 <381de683-df5e-4112-5690-13dd9272ae22@arm.com> <70b61b75-c68b-ad89-5f6a-f1d681b9f5d0@samsung.com>
In-Reply-To: <70b61b75-c68b-ad89-5f6a-f1d681b9f5d0@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jun 2020 11:41:54 +0300
Message-ID: <CAHp75VfQdwHotuGWMUGUvEWNcZNkm+VkdmNuVJDS_T6hbcTqsg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:40 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 24.06.2020 17:16, Robin Murphy wrote:

...

> I have proposed such thing in my previous iteration[1], except it was
> macro because of variadic arguments.

You may have a function with variadic arguments. Macros are beasts and
make in some cases more harm than help.

-- 
With Best Regards,
Andy Shevchenko
