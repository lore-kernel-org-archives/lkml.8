Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89D62089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592423876;
	bh=6EOWrWAPKgFLB8ZGNw/bkhy+Y9laihybAO1W8FLLgE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fQ+PXWKvRgYPno1Zjx3tMGasOPxSq0Rp9t8D9hcbChm0M7aw2rNLYgP/qsggqcrcL
	 FpPZ5QRYq/8JMFhmILuhbolv0lVYOeqSDLYU54T9slv//zBp42/E1TlHBRGTd+dUVE
	 m+cIuXn/C+U3cosGW9OM/GOhXTO85mgMLDWay8yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQT5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQT5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:57:53 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B5E2089D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592423872;
        bh=6EOWrWAPKgFLB8ZGNw/bkhy+Y9laihybAO1W8FLLgE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xaFHz/iozgWgycs5vkKMyLQhywn8LIE3m4thJ9lGfq/ft4mvHZp8Zw5f5pCL9xn6y
         OItViZbot/baWh8iOwsng7TD4RkNT/wrwtmxpkuvcb4ss3L9Bhxhi5Sbnz/RSCxTze
         1EUmCWL24KfJLS2lOEh6Vtau7NF1OyGZ4zODcKlU=
Received: by mail-ot1-f47.google.com with SMTP id g5so2662208otg.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:57:52 -0700 (PDT)
X-Gm-Message-State: AOAM5326R5Z6UHhxwC5u1UNjREyMHp7pk/nQq134kwAIemMhtJTc8Zfx
        ks6bTePkj0JKX4FekXygUGADZI1Vs3lqykfSJQ==
X-Google-Smtp-Source: ABdhPJxYGD7ydPNempaQlxGwlY6okLDhzODVF+rKdYIQX8opUjKSSSQ82BnNVzZIgHkIo8WpU9K2CdFtcuufRw2uHTk=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr598307ots.192.1592423871739;
 Wed, 17 Jun 2020 12:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200527200544.7849-1-krzk@kernel.org> <20200527204334.GA15485@kevin>
 <20200617141547.GA30516@kozik-lap> <b41bfead-7b73-be78-c63f-79a0a7e23b2a@arm.com>
In-Reply-To: <b41bfead-7b73-be78-c63f-79a0a7e23b2a@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 17 Jun 2020 13:57:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLrFFOVQVR0dWbru6bJvz7sXs8v6Op-hiNgdMwH3N=2Fw@mail.gmail.com>
Message-ID: <CAL_JsqLrFFOVQVR0dWbru6bJvz7sXs8v6Op-hiNgdMwH3N=2Fw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panfrost: Reduce the amount of logs on deferred probe
To:     Steven Price <steven.price@arm.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 8:36 AM Steven Price <steven.price@arm.com> wrote:
>
> On 17/06/2020 15:15, Krzysztof Kozlowski wrote:
> > On Wed, May 27, 2020 at 04:43:34PM -0400, Alyssa Rosenzweig wrote:
> >> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> >>
> >> On Wed, May 27, 2020 at 10:05:44PM +0200, Krzysztof Kozlowski wrote:
> >>> There is no point to print deferred probe (and its failures to get
> >>> resources) as an error.  Also there is no need to print regulator errors
> >>> twice.
> >>>
> >>> In case of multiple probe tries this would pollute the dmesg.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>> Reviewed-by: Steven Price <steven.price@arm.com>
> >>>
> >>> ---
> >>>
> >>> Changes since v2:
> >>> 1. Rebase
> >>> 2. Add Steven's review
> >>>
> >>> Changes since v1:
> >>> 1. Remove second error message from calling panfrost_regulator_init()
> >>> ---
> >>>   drivers/gpu/drm/panfrost/panfrost_device.c | 8 ++++----
> >>>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >
> > Hi Rob, Tomeu and Steven,
> >
> > You're listed as maintainers for panfrost. Is anyone going to pick this
> > up?
>
> I'm only a reviewer so I've been leaving it for Rob or Tomeu, but I can
> pick it up if Rob/Tomeu are happy for me to do that.
>
> > Maybe I sent it to wrong mailing list or forgot about anything?
>
> No, there's actually a few Panfrost commits waiting, it was on my todo
> list to ask if Rob/Tomeu needed some help with merging patches.

Please do, I haven't had the cycles for panfrost lately.

Rob
