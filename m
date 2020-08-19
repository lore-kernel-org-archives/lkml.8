Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E41C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE918207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPWQgnUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgHSVNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHSVNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:13:16 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9C0C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:13:16 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e11so20244015otk.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGE8dPFSXYEZY67KuvOacTrjS0cJR2sJ8jZigtxvT7c=;
        b=mPWQgnUIx5fMgmgXzJ6jrT9sIN00Yf+GClMAKr4ClWAdjAA4w+lviTX3XWr3wm1Goo
         rQjFG51Cdr4YPxAjK35duJTf30LCb6lQNPlTl84h1Epcxt6XdCsf8986cWbmYtNepgvc
         3xI2HuhFK4CCHgXDgidlZ8WcN6oJg3gLBiQgcpZJxjBCQwneojRxl8lBHm37DZAkSyAY
         g9kxWUPJqF9KeU0bVW5EUFWEw20lL33GC/9G3DsQSorao8D9u4hE2yYGbpjgm3r2RjUY
         gg62Gkv18dQ59EXr8xIM7C8mhKafsKXPDWPqhOLmItPb9PP2bDwfwborj/3f029qfjzf
         aC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGE8dPFSXYEZY67KuvOacTrjS0cJR2sJ8jZigtxvT7c=;
        b=KHZu0g+shBEgo4EP/9k4v4kkak4lvxySTgdC2No7QsdvBS2AOnYIANbYu2KqqOzf4X
         FSZQ6vpfNsKvnkLonCiGv2Soh3C2ItXE4ENr1h5HT3xgvK2O54BsICrxpKzx/SLgQnWf
         aQHjqqTx2ysMD833l3SDVK1PKU3ugQbghiyx09Lt2CXdGILyLhUKsdARAjEg0LjTVYDK
         mIU59H9rksuIbhHrmS+cYZgnVpsR9aH5DCuONk1sRJ9+JYdhutLwKSzS5c8KgzRgwuaJ
         oOpQvWFMSK0rywRanUswy9ogWCSdmS7Mlxiw+ND294vItTdrAGkN6mEmn9sZa04yOdLr
         8hQw==
X-Gm-Message-State: AOAM530fNAPQUBYnMJANUxxVb/5FkROZb31/QmdN8DWHPItki9MKxMQ0
        1gqZXfSCuc1ctAsoZaZUOSns0qMi9gDL5tYEnDglSQ==
X-Google-Smtp-Source: ABdhPJxhdrorTIm+ix91I8dYTcsNujAlZfMSdVgeY/HYKUOyGno6SluKmoa8UI5RQOyUlsJyf0LVh3NyFOVKbkbzMl4=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr18983475otq.221.1597871595940;
 Wed, 19 Aug 2020 14:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Aug 2020 14:13:05 -0700
Message-ID: <CALAqxLVRsPKv-xmxQfBFaBa9XOmSfrFj3w9_zyfzNJk8+Kfjug@mail.gmail.com>
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
> Yet, I'm submitting it via staging due to the following reasons:
>
> - It depends on the LDO3 power supply, which is provided by
>   a regulator driver that it is currently on staging;
> - Due to legal reasons, I need to preserve the authorship of
>   each one responsbile for each patch. So, I need to start from
>   the original patch from Kernel 4.4;
> - There are still some problems I need to figure out how to solve:
>    - The adv7535 can't get EDID data. Maybe it is a timing issue,
>      but it requires more research to be sure about how to solve it;

I've seen this on the HiKey960 as well. There is a patch to the
adv7533 driver I have to add a mdelay that seems to consistently
resolve the timing problem.  At some point I mentioned it to one of
the maintainers who seems open to having it added, but it seemed silly
to submit it until there was a upstream driver that needed such a
change.  So I think that patch can be submitted as a follow on to this
(hopefully cleaned up) series.

>    - The driver only accept resolutions on a defined list, as there's
>      a known bug that this driver may have troubles with random
>      resolutions. Probably due to a bug at the pixel clock settings;

So, yes, the SoC clks can't generate proper signals for HDMI
frequencies (apparently it's not an issue for panels). There is a
fixed set that we can get "close enough" that most monitors will work,
but its always a bit iffy (some monitors are strict in what they
take).

On the kirin driver, we were able to do a calculation to figure out if
the generated frequency would be close enough:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c#n615

I suspect we could do something similar for the hikey960/70, but I've
not really had time to dig in deeply there.

Personally, I don't see the allow-list as a problematic short term
solution, and again, not sure its worth pushing to staging for.

>    - Sometimes (at least with 1080p), it generates LDI underflow
>      errors, which in turn causes the DRM to stop working. That
>      happens for example when using gdm on Wayland and
>      gnome on X11;

Interestingly, I've not seen this on HiKey960 (at least with
Android/Surfaceflinger). The original HiKey board does have the
trouble where at 1080p the screen sometimes comes up horizontally
offset due to the LDI underflow, but the patches to address it have
been worse then the problem, so we reverted those.

>    - Probably related to the previous issue, when the monitor
>      suspends due to DPMS, it doesn't return back to life.
>

I don't believe I see this on HiKey960. But if it's the LDI issue on
the 970 that may explain it.


> So, IMO, the best is to keep it on staging for a while, until those
> remaining bugs gets solved.

I'm not sure I see all of these as compelling for pushing it in via
staging. And I suspect in the process of submitting the patches for
review folks may find the cause of some of the problems you list here.


> I added this series, together with the regulator driver and
> a few other patches (including a hack to fix a Kernel 5.8
> regression at WiFi ) at:
>
>         https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master
>
>
> Chen Feng (1):
>   staging: hikey9xx: Add hisilicon DRM driver for hikey960/970
>
> John Stultz (1):
>   staging: hikey9xx/gpu: port it to work with Kernel v4.9

Nit: This is a display driver and has little to do with the GPU (other
then it will eventually live in drivers/gpu/drm/...), so I might
suggest using more conventional subject prefix,  "drm: hisilicon:"

thanks
-john
