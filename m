Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9360AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735F020672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TkNiPKMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbgF3MZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbgF3MZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:25:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:25:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so19861650wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DKp9Nig/j/7keZ9L6sA0WoP4aqa2toVj2wDOC+5WIA8=;
        b=TkNiPKMZKSQij63jXXSo1yraoN+I7fpF5Kox95iPN+LtbBZ6DhFHKSiCRbeXwLtuMN
         02dj/nPJtU9uMmZhmZ2DMnPWHLprmJieARM0boueH30dW0b/jfZSYoGlbCFE/XBzQTZm
         Gx1L55p6c+3kPEkXPXV7/rVe2AnU9EgX1EUt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKp9Nig/j/7keZ9L6sA0WoP4aqa2toVj2wDOC+5WIA8=;
        b=WPyPYKhKzNDZcyae2N+wdigcbhUZPxu+g10D7yJTJZ+k8b0yzo1+C3tbSwwKARi+Qt
         uhx7+RLpN+ZgU2pw+JKvBon7wfThtAyl/NR+9xfI3GHH2SUXQ1phLBb3v7N7/I/Hv7lT
         PRbv54Cgo3Dvm6s3eI2UA2Ipo1deGGkBu3l9XQoGlyrszYXYWvTkuuBHiIPU/AbImctG
         Z4EiVvajPZoO+OC+fQJ3ZIcFl3hWNv3qS6TTSiv/BfHxE6uU2XsDo2hFSbRRg7/eZmPn
         5Kc2OK0UtBezYbXctyqvrN8eEpN1JTlko+coeoftO4noLrtxgFREwcd1jufkqzrRm+k+
         LSrQ==
X-Gm-Message-State: AOAM533n3ODXkP2gVrNfSCrNXy0odnPMZb3S1k3YEaBkJks7NsBRVmoo
        9LmzMvjKEqwdjhJx18SSnbkxqlVOuBGli9y/UBEzCQ==
X-Google-Smtp-Source: ABdhPJwBRO0RaFXe4pmI1aoc68TeIq0rkX6/UbgE7jgcWx0uiJzy9YLgKqI9zbqBs3S9N/NewWqnC9j3pJHAUMzoihw=
X-Received: by 2002:a5d:4002:: with SMTP id n2mr22955538wrp.255.1593519938980;
 Tue, 30 Jun 2020 05:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200630091615.4020059-1-yuhsuan@chromium.org> <20200630104047.GD5272@sirena.org.uk>
In-Reply-To: <20200630104047.GD5272@sirena.org.uk>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Tue, 30 Jun 2020 20:25:28 +0800
Message-ID: <CAGvk5PqqMKikj46yfvNYdiQ=3cWoHVLBgQKGOPs5iuoFWUBs=Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rockchip: add format and rate constraints on rk3399
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Jun 30, 2020 at 05:16:15PM +0800, Yu-Hsuan Hsu wrote:
> > S8 and S24 formats does not work on this machine driver so force to use
> > S16_LE instead.
>
> > In addition, add constraint to limit the max value of rate because the
> > rate higher than 96000(172000, 192000) is not stable either.
>
> What is the source of these restrictions - are they due to the component
> devices?  If they are then the component devices ought to be setting
> suitable constraints themselves.

I'm not sure why it happened. But I guess it is not the issues on those
components because they work normally on other machine drivers.
Because this driver is old and lacks maintenance, I think we can just
filter some unstable formats. Actually, those formats are very rarely
used as well.
