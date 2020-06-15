Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73313C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD37206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oR0SekK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgFOIQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgFOIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:16:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26316C05BD1E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:16:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v79so14887439qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ks2k3rFOx4dlXObGXJhZwTdC2QELUN8WUaqANCpIqu0=;
        b=oR0SekK0lTaOSzhQhm3NVzAkhfa0SpTMN6fEILfsLxFaBYWpSetDd7sPHZPUqFseTt
         +djNWxLvdiqI7s5zK45K0gBO/eWabDbDou3csHCVptKlBrXFFQFVHk4fEiukWvr9CP91
         /FUC9cqYx7Vpq3NqWQa8U9pQVNwCJxzVBmt3nEWsQYCY63e0PdScNBok6/pNLMzTEDFT
         30gRH/C7UO4xbWv7NlvtzutoF5xAkAebZmo3otmBf29Kp0NhgkVfT3vNzeYRVCr5cQWe
         Ibrvy8kXQRsiep5lMwRUp/BBI3x9Ei0QqhbTYemZ8MS9Z8xlBP3Ua4ooIUT+Au1sLiBY
         gfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ks2k3rFOx4dlXObGXJhZwTdC2QELUN8WUaqANCpIqu0=;
        b=MVi3mqwaEd9v1rbgxMMrKPnIH4k0aCaShO/ynIsTaVKuMuszWyZu2mudoBGhw9lJr+
         6kms+1tUD9bk8C9eB3/i0Q2XVIdohixlrkv/P5FAIeFBbFe8zntrs1aOT05ZI4Lr/P6g
         rLQLaKEANL0pWOIeJjtQJArOsOXXWd3pr1dAaHwByTPPsnNQsuHS0XN2DGq2PzHGjiVw
         8CyAlaOD3BioCCU3VeP0jCF5oqGuLn5rbyrR4yKcrZoF8xOtHz74/BIWPqif94L6ci80
         2ayNX11dEXkDDmrYyRMmkfFNkV15tbp0bs7y5VipqvFRPikjR72r/8wCSXUEzMtfjsvo
         +CwA==
X-Gm-Message-State: AOAM532Xm9rv8pcd9Re1d0EO+scwy4YeAg6preVPPZw+IrOdZYBEyIiK
        tF5lXOIA2vP0Et5m84Z1ZfHGM2k8XQ+HkVWooIJbjg==
X-Google-Smtp-Source: ABdhPJwFBN98NMpqmvYRdwb//kMKIs//wi3K/6j6KcI/70oz0Y0XgSq3+DgIBu966lDGXREPemn0TX9xNdPBs0sd2M0=
X-Received: by 2002:a37:4f52:: with SMTP id d79mr14333922qkb.330.1592208971419;
 Mon, 15 Jun 2020 01:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com> <20200609124610.3445662-4-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20200609124610.3445662-4-kieran.bingham+renesas@ideasonboard.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 15 Jun 2020 10:16:00 +0200
Message-ID: <CAMpxmJXboB0qkG637eoAabj1_KBe2inNgWG3aMagSar94UuaXQ@mail.gmail.com>
Subject: Re: [PATCH 03/17] drivers: gpio: Fix trivial spelling
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 9 cze 2020 o 14:46 Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> napisa=C5=82(a):
>
> The word 'descriptor' is misspelled throughout the tree.
>
> Fix it up accordingly:
>     decriptors -> descriptors
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/gpio/TODO | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
> index b989c9352da2..e560e45e84f8 100644
> --- a/drivers/gpio/TODO
> +++ b/drivers/gpio/TODO
> @@ -5,7 +5,7 @@ subsystem.
>  GPIO descriptors
>
>  Starting with commit 79a9becda894 the GPIO subsystem embarked on a journ=
ey
> -to move away from the global GPIO numberspace and toward a decriptor-bas=
ed
> +to move away from the global GPIO numberspace and toward a descriptor-ba=
sed
>  approach. This means that GPIO consumers, drivers and machine descriptio=
ns
>  ideally have no use or idea of the global GPIO numberspace that has/was
>  used in the inception of the GPIO subsystem.
> --
> 2.25.1
>

Patch applied, thanks!

Bartosz
