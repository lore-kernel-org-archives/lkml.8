Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC7EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B97A20709
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBNyr78r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIBJEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgIBJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:04:00 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1B4C061249
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:03:59 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s62so317974vsc.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itlRbbBGemMZj6RC0w5yK0m6b8wHA0Bm1ChisOFrb20=;
        b=yBNyr78rhsjgGIM6THzbWs8HNIWZJ3x9mSBKPQCKbhJk3Z50mWkfvV36AeniWzm6Qe
         aV0O3gIzUSf2TBtCm8WiZfgTVOWDl5LrvDeSwdxS3af72jZ/nJ+ADWDAiInBepByAp1e
         PL7ZPKwuNQeUZHw8De3+ZvVR+Ey0sVdeRLxMKBdV4K67r0wUlexb75TREUjIyXlGg7is
         PihY0GAo6MCkNFPdUGtP5slwKjLpJZs9K1Q6/AlqFWGkvARIzhXvAXjseCwYU9TutPp2
         noJqeDASqYPwPcHT+7ZIoQciA7tsbb9NCIxdulFry0shP9Iscn23Cvo1dpeWNkQmxHu6
         0eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itlRbbBGemMZj6RC0w5yK0m6b8wHA0Bm1ChisOFrb20=;
        b=bWFaRD67qmhychfIGx3v62pe/7I7OYfOYhjqURH8pPhCeaRjC1ME4AVW+N62GjbegL
         AFQHol9c+vvkQvShHnPRr9rxgr3C/N8LSlUQC8BYX4pdZ1wertCqoj7VkaloF46CbOGa
         R912s2t3Y1h+Eb8ryxtR6w/FCZRXRHRPN9HtdX4lDkJe6GcsAHt3fKy7oXR6jUr7Sbnq
         opt2rexW4d3JycbK9gC5VMVIzFGC1xhPfsFFzvA8MIUe5MYlvSuakOX0a/UutiXrX7e+
         vJ1qcgU0Vwq0lg2UJbAznv6gZZZUELgGL9CBNsSr9v3WL0sR041QFVRjZkXJVuCFy8mc
         Isog==
X-Gm-Message-State: AOAM532OTS3vMw9FiZrSp6+zrmUau4P54QBgD6c1PNDFLOo3zjCDFeQJ
        rcWeb4iRmwRXh5vgtDLweuHZFm5+v+q8MFL2DRzDYw==
X-Google-Smtp-Source: ABdhPJxjEM29jRCiVuNOJSS+uxtsMkMIs0ZX0+YfZ9Sew8Mzc1PTjMp9+B4YulTDlW5/psJ9L3xHp7zU+/tu3AYfYyg=
X-Received: by 2002:a67:7c4e:: with SMTP id x75mr4509007vsc.60.1599037439148;
 Wed, 02 Sep 2020 02:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:23 +0200
Message-ID: <CAPDyKFrC62rLOQraHvh=8APWDk84YYo5YEg=uoUsgAeMx19G=Q@mail.gmail.com>
Subject: Re: [PATCH mmc-next v4 1/2] dt-bindings: mmc: document alias support
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 10:50, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> As for I2C and SPI, it now is possible to reserve a fixed index for
> mmc/mmcblk devices.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v4: moved alias documentation from example to description
>
> v3: new patch
>
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index b96da0c7f819..f928f66fc59a 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -14,6 +14,10 @@ description: |
>    that requires the respective functionality should implement them using
>    these definitions.
>
> +  It is possible to assign a fixed index mmcN to an MMC host controller
> +  (and the corresponding mmcblkN devices) by defining an alias in the
> +  /aliases device tree node.
> +
>  properties:
>    $nodename:
>      pattern: "^mmc(@.*)?$"
> --
> 2.17.1
>
