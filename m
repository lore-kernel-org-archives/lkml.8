Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6642E207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDvGe73f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHSTwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHSTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:52:19 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D4C061384
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:52:18 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 93so20063378otx.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20eRCPt9U7XROuUscJl4o9bl5XBe7/+hwEOIYHyciSM=;
        b=TDvGe73fi0mYFcu8gy0zyv7nAwTvj7LZXmceDEUKPP8XfBtwIw8eDnhZKXXW/8lOST
         i3mwXYbXDDRyFBEBUEFYWxYynj8XahsSAx/k6lpaNmRyovcJDE7Y/1Us5/lAXLoB+fny
         MXwugodqdfXUpnDdV+YqwtDPcrU39IcwaELeeOIEfQVGHH8qMEJzhHrmfsPm50dMtK8D
         E2hgWNg9hTGAkp/gDSRS2/SFCteSIRgMdFhm92/90JvBoxi1tgk0nM350xbrUY9djJu/
         Vayz78+1GIbV3JXLHBbEvqxWVmcLvT6HCup7VhLEysHQgvZVLA6bXvrYb7L+4t8Mxya5
         O2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20eRCPt9U7XROuUscJl4o9bl5XBe7/+hwEOIYHyciSM=;
        b=XtaKq5obZrvgLqrprD38TVjAky77OGCb7bOqh4bWswtDXYw0rm8+HwfLGFcWVIlG9h
         FsxDGTQHCnuwKBK3OTos5a80WtEBv3rR4VgIMi7drdZjmz7XRHzW6P2PlZO/WktqBMPC
         NHlOVvHsnQQnpi9ih7GS6M4+AXzoixaObtuAqESGsx6j6iTr3iPI8sKQF/wRN+sAM01X
         xzG7cw1qVMFUdeQ0bBXk1+3MUvM9EIhYciw3TmUlx7rvqZANDxHtgajyc6FqGldoCob0
         Hqw5KeB1ApWwaF7TVS3TFkZoGlR3kkJkiGDs4LlOQk/7yOytabSE5k+Ii+KGIrTU0hzI
         IhJw==
X-Gm-Message-State: AOAM5308OCDzWY2bSpK042temubwrTVqAAwVaICod813PY6PG1pGPSNZ
        2JVyaGUAOqcGOtF2fu78Za1LR8U8QNVg3sfv5XGBVQ==
X-Google-Smtp-Source: ABdhPJziBBPPuDZCBcZoysAn7wtSqkMtfGL35ZZB/FJ/a7yXT1Ut5k0YtYAU8hIkSuF0vuVhhtyHAco3tq76syVzuqI=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr18795170otq.221.1597866737290;
 Wed, 19 Aug 2020 12:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
 <20200819152120.GA106437@ravnborg.org> <20200819153045.GA18469@pendragon.ideasonboard.com>
In-Reply-To: <20200819153045.GA18469@pendragon.ideasonboard.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Aug 2020 12:52:06 -0700
Message-ID: <CALAqxLUXnPRec3UYbMKge8yNKBagLOatOeRCagF=JEyPEfWeKA@mail.gmail.com>
Subject: Re: [PATCH 00/49] DRM driver for Hikey 970
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        linuxarm@huawei.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Liwei Cai <cailiwei@hisilicon.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Rob Herring <robh+dt@kernel.org>,
        mauro.chehab@huawei.com, Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Liuyao An <anliuyao@huawei.com>,
        Network Development <netdev@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 8:31 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Aug 19, 2020 at 05:21:20PM +0200, Sam Ravnborg wrote:
> > On Wed, Aug 19, 2020 at 01:45:28PM +0200, Mauro Carvalho Chehab wrote:
> > > This patch series port the out-of-tree driver for Hikey 970 (which
> > > should also support Hikey 960) from the official 96boards tree:
> > >
> > >    https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> > >
> > > Based on his history, this driver seems to be originally written
> > > for Kernel 4.4, and was later ported to Kernel 4.9. The original
> > > driver used to depend on ION (from Kernel 4.4) and had its own
> > > implementation for FB dev API.
> > >
> > > As I need to preserve the original history (with has patches from
> > > both HiSilicon and from Linaro),  I'm starting from the original
> > > patch applied there. The remaining patches are incremental,
> > > and port this driver to work with upstream Kernel.
> > >
...
> > > - Due to legal reasons, I need to preserve the authorship of
> > >   each one responsbile for each patch. So, I need to start from
> > >   the original patch from Kernel 4.4;
...
> > I do acknowledge you need to preserve history and all -
> > but this patchset is not easy to review.
>
> Why do we need to preserve history ? Adding relevant Signed-off-by and
> Co-developed-by should be enough, shouldn't it ? Having a public branch
> that contains the history is useful if anyone is interested, but I don't
> think it's required in mainline.

Yea. I concur with Laurent here. I'm not sure what legal reasoning you
have on this but preserving the "absolute" history here is actively
detrimental for review and understanding of the patch set.

Preserving Authorship, Signed-off-by lines and adding Co-developed-by
lines should be sufficient to provide both atribution credit and DCO
history.

thanks
-john
