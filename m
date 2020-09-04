Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C7BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837A220722
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231057;
	bh=V8Yz+V8W8NYZRo8VeY1JNSeQmYJkrgRoqjg3jR2PUvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w9waG8pJnKkEjuAi1QfHHcYdaOJnNYT1YJ3YjBD8IlWFoF9Ie6DtXB4HefPZxafDY
	 6xD/OqQfMQFeK0CtyzeXul/GwPROOWQBNMBWW6durv5t8opvR21U3vKw1igXuV/z6v
	 5xZPRyTzgswmFMNmseW7l4edhpi7DaP4h0eQ0DCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgIDOuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbgIDOut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:50:49 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4DA2087E;
        Fri,  4 Sep 2020 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231049;
        bh=V8Yz+V8W8NYZRo8VeY1JNSeQmYJkrgRoqjg3jR2PUvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y95wpCM5PSO2ORRxz7Fe2lB1/nleDYKLCXyVJKIPxrzD+Cm2FcpGKTQr4ABNk7WpN
         bs6iwoF36owHKD+TV2gjIM5KxNDth/QiqjlfBQU4nh6VtSPWEcuPgTEmzMxbSHhu4w
         /VXGhZdFqNdK0ZtYbaasyscn4/ZK6pIUXUcs3x9s=
Received: by mail-oi1-f178.google.com with SMTP id x19so6764660oix.3;
        Fri, 04 Sep 2020 07:50:49 -0700 (PDT)
X-Gm-Message-State: AOAM5326DRH+jMrJIqgmOLVok9BbHdB1uUhofYBdHm11nt3E6SS8PZQT
        6U2PoFeErjrTTTePBLf3w6cr5I4UvDuSIdPK+A==
X-Google-Smtp-Source: ABdhPJwwwgfM98sa3ThHsK9hFVILmKXcNAGTT6BvEX3rCBp0yuXzXiuMVee8h3wm41S3eOKWbUIm60zQEIEq/uvqGGE=
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr5643642oia.147.1599231048667;
 Fri, 04 Sep 2020 07:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200831082917.17117-1-jagan@amarulasolutions.com>
 <20200831082917.17117-6-jagan@amarulasolutions.com> <20200903162550.GA2896127@bogus>
 <CAMty3ZCXV9=VzVKiKJ740RcR+uYA7CHUzjrDL0vwQ1NOw9n4FQ@mail.gmail.com>
In-Reply-To: <CAMty3ZCXV9=VzVKiKJ740RcR+uYA7CHUzjrDL0vwQ1NOw9n4FQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Sep 2020 08:50:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJUOO5Ou+BAS6AC4dfZ4kv5sncq_PGG+1+sHhpWByCWhA@mail.gmail.com>
Message-ID: <CAL_JsqJUOO5Ou+BAS6AC4dfZ4kv5sncq_PGG+1+sHhpWByCWhA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core
 C.TOUCH 2.0
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 10:47 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Sep 3, 2020 at 9:55 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, 31 Aug 2020 13:59:15 +0530, Jagan Teki wrote:
> > > PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> > >
> > > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > > touch interface support.
> > >
> > > PX30.Core needs to mount on top of this Carrier board for creating
> > > complete PX30.Core C.TOUCH 2.0 board.
> > >
> > > Add bindings for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - none
> > > Changes for v2:
> > > - new patch
> > >
> > >  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> >
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
>
> Yes, it's on purpose. The previous binding was about C.TOUCH with LVDS
> board and this one is C.TOUCH carrier only. ie the main reason I have
> not included. I did mention in the cover-letter saying previous one
> dropped and the C.TOUCH carrier added.

The changelog here says no changes...

Anyways,

Acked-by: Rob Herring <robh@kernel.org>
