Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A31C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AC22076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aaf257HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHDBvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHDBvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:51:15 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233DBC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 18:51:14 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j186so20254363vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjddNGXz3YzU7Pvdk0bKn7EGChBBYHNzVV19el9GvN4=;
        b=aaf257HYCPeWHrjBXePaOYS8VFb1Q/czqyneX50WCTw9iwZoobQcG+o1I1MWB7iKJs
         smazrjiW0L6F2JZ72ElWTxCb5NTLzF2eL/KqMeWC9AHOwb9tlBgjdHwOTBLnOa+PAG0y
         GzfieF4oG1m72F66pbXCb9LhKUeoz73OImW5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjddNGXz3YzU7Pvdk0bKn7EGChBBYHNzVV19el9GvN4=;
        b=JZYuRO/bhn6PUpM66cVLOUiqRQ9jEz5l0gF74P/2MR1hxAa4FABe2HNz7x9c/hbthF
         Htm1vDs9kLBsmd8UYioj8MOr7LvYzVVPwjqqazCjU3lUrNde5xHYBq8XqZncJiR/BClG
         Q6KqFTDlAbWmxqM/T50ldHZGNDzbc98QgeXzK5n1dSLnipdoLFF/iqq2ICkv337fDGak
         tSEWJX/ntIMzQfLRrxGjOfOWqaYNbGO01WjArxdlndxMsnDkxUUVer6tBnKa4XsOVVUM
         8PBLZPXctLDfO9Z5OMj/EPjfhKThDcZv8EBwheQgMj5jUqnY0PM2P1YacX+74kdIH8P1
         hCbA==
X-Gm-Message-State: AOAM530867HEIV6kahHEgf0BU2X+00Nk0bExAkRih0USu6LxbAzmgKxo
        LjWmTDZzlP/IFBR/hHM25r/l8f7fKzvoOOZJaYbcZw==
X-Google-Smtp-Source: ABdhPJy1lRFt2xIEK6BlHw92IYkKS9uhFUQMHmq60wCSuWixqVxrgiG9sOnX8EEpNmGgC5HX8UN7Ug7KXZjZv9nKfx8=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr13785000vsn.54.1596505874070;
 Mon, 03 Aug 2020 18:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <1596445047-2975-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1596445047-2975-2-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1596445047-2975-2-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 4 Aug 2020 09:51:03 +0800
Message-ID: <CANMq1KCSiRwCvPcbdA-g4Xwm5Jwk7VLDNpsR-_zoxEOv9ZFHWQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] spmi: Add driver shutdown support
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 4:57 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> Add new shutdown() method.  Use it in the standard driver model style.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/spmi/spmi.c  | 12 ++++++++++++
>  drivers/spmi/spmi.c  | 12 ++++++++++++
>  include/linux/spmi.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
> index c16b60f..5fde024 100644
> --- a/drivers/spmi/spmi.c
> +++ b/drivers/spmi/spmi.c
> @@ -357,6 +357,17 @@ static int spmi_drv_remove(struct device *dev)
>         return 0;
>  }
>
> +static void spmi_drv_shutdown(struct device *dev)
> +{
> +       const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
> +
> +       if (!sdrv)
> +               return;
> +
> +
> +       if (sdrv->shutdown)
> +               sdrv->shutdown(to_spmi_device(dev));

Slight more succinct (assuming sdrv _can_ actually be NULL, I'm not
sure about that)

if (srdv && sdrv->shutdown)

> +}
> +}
> +
>  static int spmi_drv_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>         int ret;
> @@ -373,6 +384,7 @@ static struct bus_type spmi_bus_type = {
> @@ -373,6 +384,7 @@ static struct bus_type spmi_bus_type = {
>         .match          = spmi_device_match,
>         .probe          = spmi_drv_probe,
>         .remove         = spmi_drv_remove,
> +       .shutdown       = spmi_drv_shutdown,
>         .uevent         = spmi_drv_uevent,
>  };
>
> diff --git a/include/linux/spmi.h b/include/linux/spmi.h
> index 394a3f6..729bcbf 100644
> --- a/include/linux/spmi.h
> +++ b/include/linux/spmi.h
> @@ -138,6 +138,7 @@ struct spmi_driver {
>         struct device_driver driver;
>         int     (*probe)(struct spmi_device *sdev);
>         void    (*remove)(struct spmi_device *sdev);
> +       void    (*shutdown)(struct spmi_device *sdev);
>  };
>
>  static inline struct spmi_driver *to_spmi_driver(struct device_driver *d)
> --
> 2.6.4
