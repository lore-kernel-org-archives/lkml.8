Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1974C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9001F2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ta+g1ZgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHSVhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHSVhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:37:05 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D111C061384
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:37:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v21so20263187otj.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CS+1467DMyFTqT+L2iSQMSr95xvUjx22mgQhPk7Fd0U=;
        b=Ta+g1ZgTNyWRyOadjtYmnLrqkRKTp1Yqu3v85C1PlgWit/t/GfBuyJrf7KkLtWIp5c
         obzIbdbmc69nlF0yFwItQxDewv3hhDIcu4hovzlskeqJwIK5mpzk6z3aUtqJgZ+DSflY
         89K5nsJMI1E2px6cL3lCPAuXNqy6alXpd5Y8B86lVTMT5axCkRcmg1r9PnfhQ5ysxkGw
         xuEboslpGgpoBK6kcsX6zimi7fbM/InmxLfMxBl2sylTbbrjYVKKzRv0miXc9y+CbO46
         JPua5bOPXgPoLuzKVJq2PfJRU09D5n/WRI+3dX0QohzqYTWhWbS5DQscx/5yGjUDXe5V
         X2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CS+1467DMyFTqT+L2iSQMSr95xvUjx22mgQhPk7Fd0U=;
        b=V7s6ejno5dNv+wfn5n/wkKtZFivj9csmCWg6Ge+bCN42WI4FAYjRS6FFpU+8z1e7IY
         GqahCRs062C0zFuyv9CvQA428TJ8Pu3K4dBoEER5I1ItwxvR4iSYTV920C6Vbzqz2KhO
         DnVx2XPR7+gBVDQB3g6+aeOZg3mxqQkgM1L6SdanVGW9DcGL/CRRzttVyXRFMNgw/yIV
         9nVmvEslqvTl1nYe8RbcZjqMjb+PP7uhcFiIsqG0sNeSMTzrLQZsfc3+N7Vh8bSNEwzj
         cDAulmWekxDRS64Ql/Hx7US0NwUeVLZCuK72J9+B8tnMxlVp91sF8nyHxknq/tRzm97j
         kQtA==
X-Gm-Message-State: AOAM530xC7zMuj0C7Q4krvq4uZA8GcdevgixYZKeroz1zCuIsu5QJBYt
        88tc6cpGWWUZrlxlN+2lGuXPLJ298YIXyKrrN0l37A==
X-Google-Smtp-Source: ABdhPJxpl82rAqK2FHLd0zX7VnPn8+94l8zujbb1JUnY5F6i+DaLJ+lsZzhjUgUndjPKQh1QUFVxfaVx/wGs30VKOyU=
X-Received: by 2002:a05:6830:3196:: with SMTP id p22mr21167646ots.102.1597873024596;
 Wed, 19 Aug 2020 14:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Aug 2020 14:36:52 -0700
Message-ID: <CALAqxLU3bt6fT4nGHZFSnzyQq4xJo2On=c_Oa9ONED9-jhaFgw@mail.gmail.com>
Subject: Re: [PATCH 00/49] DRM driver for Hikey 970
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        linux-media <linux-media@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Liuyao An <anliuyao@huawei.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Wei Xu <xuwei5@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Network Development <netdev@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 4:46 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
> So, IMO, the best is to keep it on staging for a while, until those
> remaining bugs gets solved.
>
> I added this series, together with the regulator driver and
> a few other patches (including a hack to fix a Kernel 5.8
> regression at WiFi ) at:
>
>         https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master

Sorry, one more small request: Could you create a branch that only has
the DRM driver changes in it?

The reason I ask, is that since the HiKey960 isn't affected by the
majority of the problems you listed as motivation for going through
staging. So if we can validate that your tree works fine on HiKey960,
the series can be cleaned up and submitted properly upstream to enable
that SoC, and the outstanding 970 issues can be worked out afterwards
against mainline.

thanks
-john
