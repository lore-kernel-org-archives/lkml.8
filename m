Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DC7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4480320715
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRI5eqJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgE3UeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgE3UeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 16:34:22 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC9C03E969;
        Sat, 30 May 2020 13:34:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h3so5794837ilh.13;
        Sat, 30 May 2020 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQ2eTRzHonhqJF3ZL4HYlMxSElcEqq+WSqbBmVWDUhI=;
        b=tRI5eqJPiHGaD4J0PlwEJbmOeTLTXvBVFiz49/nwb9HvI5FnUEIWpISRg9S6usOTLR
         ffjIu5AyTInmZJSpqk3cYkRMkn2P3lrBCQMiKvQK9WWw9oL1GOJrqjmtVQswiAu/xDMm
         hDx4qaoIjbgzSphtSas9COsc7e2LLqSmpg+k3o96kHelcU4kRlwRrb340EL7oH+vH7JY
         PxVflsJi0fglfmwXzpVLbVAPfgnolwiFXei2OZkWTU+d61+z/hmiHEwkb0T6eoZi1Cm3
         X03Igs/+fdvJU6arMWAXoecFr2s7WzdyRLFl21ZmB/lktpRTGHWuY0GQs5uCk82/RoAy
         f+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQ2eTRzHonhqJF3ZL4HYlMxSElcEqq+WSqbBmVWDUhI=;
        b=kHACXCWxncPIV+UYtnEk+TgEtoMGl8jYDbUn9txU9oCOaSKIUkRprI8wWgR+k4/AEt
         TzE6ucgD+ThhCvimlhHFLrtPyA2jE7JVCvXa110X1sZajpSZKgXmNYMHpHRlVe08rJ5T
         qOg8n+kw1lmwQre+ChKFucW2j1DnUzASxmgLZOJdr/YSSP8Wzb+eSTjnrOhoo13B4gcj
         A+Nali45xSwJPX/LXZCz/rsi2i9QNy5JyTPCQa9XDQot+oC1W/sddba01VHoS5629jWO
         g1LX+dX8/JcBlTZuXOBDhKJfLb7lzhR5X6p2M+t4uc3S8u5JUXb2y30QvnWprL1kao2q
         x4iQ==
X-Gm-Message-State: AOAM530wHLnK+g/0vNg/WDyY38KRlSjtxmJT/4QxlcXPBZ9n1IehZLV7
        StKbeSuAGJLyEKA2RnpA3fxVyEOBc7blY/tiRD0=
X-Google-Smtp-Source: ABdhPJykT3ennuBwiv4teUw8fHN2/mAUZtgeRiRVpY21O+TfXGVZ28jkFKhCCaxyiyHA34VHj2THd7C4qJbb3CjaPz0=
X-Received: by 2002:a92:7104:: with SMTP id m4mr7655023ilc.87.1590870861509;
 Sat, 30 May 2020 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 30 May 2020 15:34:10 -0500
Message-ID: <CABb+yY16FzgafSYRo8DuVMttqUR5JVzXDsaP2rX+UnrNOD6k2A@mail.gmail.com>
Subject: Re: [PATCH v6] support gce on mt6779 platform
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Devicetree List <devicetree@vger.kernel.org>,
        wsd_upstream@mediatek.com, dri-devel@lists.freedesktop.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:05 PM Dennis YC Hsieh
<dennis-yc.hsieh@mediatek.com> wrote:
>
> This patch support gce on mt6779 platform.
>
> Change since v5:
> - spearate address shift code in client helper and mailbox controller
> - separate write_s/write_s_mask and write_s_value/write_s_mask_value so that
>   client can decide use mask or not
> - fix typo in header
>
> Change since v4:
> - do not clear disp event again in drm driver
> - symbolize value 1 to jump relative
>
> [... snip ...]
>
>
>
> Dennis YC Hsieh (16):
>   dt-binding: gce: add gce header file for mt6779
>   mailbox: cmdq: variablize address shift in platform
>   mailbox: cmdq: support mt6779 gce platform definition
>   mailbox: mediatek: cmdq: clear task in channel before shutdown
>   soc: mediatek: cmdq: return send msg error code
>   soc: mediatek: cmdq: add address shift in jump
>   soc: mediatek: cmdq: add assign function
>   soc: mediatek: cmdq: add write_s function
>   soc: mediatek: cmdq: add write_s_mask function
>   soc: mediatek: cmdq: add read_s function
>   soc: mediatek: cmdq: add write_s value function
>   soc: mediatek: cmdq: add write_s_mask value function
>   soc: mediatek: cmdq: export finalize function
>   soc: mediatek: cmdq: add jump function
>   soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
>   soc: mediatek: cmdq: add set event function
>
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |   8 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |   3 +-
>  drivers/mailbox/mtk-cmdq-mailbox.c            | 101 ++++++--
>  drivers/soc/mediatek/mtk-cmdq-helper.c        | 163 ++++++++++++-
>  include/dt-bindings/gce/mt6779-gce.h          | 222 ++++++++++++++++++
>  include/linux/mailbox/mtk-cmdq-mailbox.h      |  10 +-
>  include/linux/soc/mediatek/mtk-cmdq.h         | 125 +++++++++-
>
Please break the patchset into two. The lower mailbox related changes
with soc changes on top.

thanks
