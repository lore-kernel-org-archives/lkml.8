Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BC8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA252065C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/H600jZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHLHgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLHgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:36:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158BEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:36:16 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g19so1549185ioh.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoWosUMrqCTx2zIWiSt1q8d4gJ7znnfRYJ6dzYZoqvo=;
        b=V/H600jZakKgVsyPX9ZxQa2CDFO10d91q7X5Cq4QBY6fulJ64VjnevknnUV6o60y4x
         RYRLIpFnyWmqAbVdMt/Q7aOY7jvqs6I9MA2yunpCWT0Ri5ILmVX6oIjyUjBFtSFfXW7W
         Jg+MHT8iK6CV1xZSca30sFDX0+gaYSh+//qaw0Mzpd8HcuR2FvxUuTb36YQm/4MYSM9n
         Uof6PhBTLUADHgnWJOSqOviZ+WqfWpkg8LC4Rjtmgh+uISRNPkd0IILVUg3yU6XQmlmG
         gZTF9tqlaAzLJMzrrwTELEiZv/LSBqSASZZASDO/jv5oI4XPUak123wBUOrknSDNodT2
         cq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoWosUMrqCTx2zIWiSt1q8d4gJ7znnfRYJ6dzYZoqvo=;
        b=e+581BpuvOq2fg8BO26dEOPn0zpS21ByRtXdCKhatfoum/nF67lLCxYn+z41eXoW1v
         378OVZV1RHyBiXkiBRzbiQ74iD2D59iPjeu5ZVTI5StQCWAxhmS4pnQ8iwJDmGtmEpKI
         /ZZfPTzxJxIcz7H1OVC0d5dYXDRYm4QIj7/syvK11Z2z5/oHybgaLgarO7IW+QccfoGE
         zMGe6ioT2jIlgiw9mloMyceSIwuazc1E+IEp6Y7nYUjW23xMtbzDSweemY/WDCMF4iNx
         xYin4pbwxZKgtLGJzNlZxH/T2g2pRsEAnpxA8sWUhu00MyhHbuAl9SHPZ8Q066QxWq1I
         cRRQ==
X-Gm-Message-State: AOAM533s+uKFLHfuR4GH0npmjJCBdDmPXGgH5OpK40ir9/6y0kK5jhQu
        hxAHEBqGuKfNLzWDjRZM/GN7DpD6tux1ec071ns=
X-Google-Smtp-Source: ABdhPJySVLks5s4aT32oocarxaPUHfObJpAW5xAtQsRFmCR8/2B0N8OotSgLFT03V2Ez7/10+yFWNdZ8P/DPrrZ6pnw=
X-Received: by 2002:a05:6602:15d3:: with SMTP id f19mr25983960iow.91.1597217774586;
 Wed, 12 Aug 2020 00:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <1594388491-15129-1-git-send-email-simhavcs@gmail.com>
 <1594388491-15129-2-git-send-email-simhavcs@gmail.com> <CAGWqDJ4P9dKzGngkiEtL_X1HRjjtU17WqNFM-qiv16tXwQNZTg@mail.gmail.com>
 <CAGWqDJ4s3x5M7dGMTxYMpDbM4NBS7kfTb6-+7Fdx8Pe=CE58fA@mail.gmail.com>
 <20200808213022.GW6186@pendragon.ideasonboard.com> <20200810175440.GC292825@ravnborg.org>
 <20200811101942.GB6054@pendragon.ideasonboard.com> <20200811191704.GA524675@ravnborg.org>
 <CAGWqDJ7bAjDyEr03UT-mfyOuD+xkbo9BG4GyWxbiK_c74eESYw@mail.gmail.com>
In-Reply-To: <CAGWqDJ7bAjDyEr03UT-mfyOuD+xkbo9BG4GyWxbiK_c74eESYw@mail.gmail.com>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Wed, 12 Aug 2020 13:06:02 +0530
Message-ID: <CAGWqDJ6O-EdCVeaCdRBtUTmNUFpPQErQzn1ihtVhXmFjPhnr5g@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] display/drm/bridge: TC358775 DSI/LVDS driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sam/laurent,

[PATCH] drm/bridge/tc358775: Fixes bus formats read

is on top of drm-misc-next.


On Wed, Aug 12, 2020 at 7:50 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
>
> Sam,
>
> I will look into this and send the patch ASAP.
>
> On Wed, Aug 12, 2020 at 12:47 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> Hi Vinay.
>>
>> > >
>> > > If Laurent or others identify further things to improve we can take
>> > > it in-tree.
>> >
>> > Just one thing, please see below.
>> >
>> > > > > >> +       d2l_write(tc->i2c, VTIM1, vtime1);
>> > > > > >> +       d2l_write(tc->i2c, HTIM2, htime2);
>> > > > > >> +       d2l_write(tc->i2c, VTIM2, vtime2);
>> > > > > >> +
>> > > > > >> +       d2l_write(tc->i2c, VFUEN, VFUEN_EN);
>> > > > > >> +       d2l_write(tc->i2c, SYSRST, SYS_RST_LCD);
>> > > > > >> +       d2l_write(tc->i2c, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
>> > > > > >> +
>> > > > > >> +       dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
>> > > > > >> +               connector->display_info.bus_formats[0],
>> > > > > >> +               tc->bpc);
>> > > > > >> +       /*
>> > > > > >> +        * Default hardware register settings of tc358775 configured
>> > > > > >> +        * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
>> > > > > >> +        */
>> > > > > >> +       if (connector->display_info.bus_formats[0] ==
>> > > > > >> +               MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
>> >
>> > This shouldn't come from the connector, but from the
>> > drm_bridge_state.output_bus_cfg.format. The drm_bridge_funcs
>> > .atomic_get_input_bus_fmts() operation likely needs to be implemented.
>>
>> I trust you will look into this and submit a patch on top of
>> drm-misc-next.
>> Please add a proper "Fixes:" tag identifying the commit that introduced
>> this bug - in this case the commit introducing the driver.
>>
>> Do not hesitate to reply to all if you have any questions.
>> We will help you if we can.
>>
>>         Sam
>
>
>
> --
> regards,
> vinaysimha



-- 
regards,
vinaysimha
