Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB38C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D6F2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NzIkgi+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgE1Apq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 20:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE1Apq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 20:45:46 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF5C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 17:45:46 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id z13so2326194vsn.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOyV+8glbcu6N2O5AHi5Pyxl+TFF1nsMtfV6jrysXBE=;
        b=NzIkgi+C9aoCRXuizHK0IN3/1UWp3rB9C78+Fu8iCfQyXPPu9XSrwtUVI2/k1SFdoJ
         Z/PyPjnt92umAAcqUhTEVYo/6kEitkEWgaMV9ygDT3ySlPshePmyGR0yH1yg2xGGadHw
         YCloRpjKw5pmVGHx8A/9ebL5ofLznvjFJZ3ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOyV+8glbcu6N2O5AHi5Pyxl+TFF1nsMtfV6jrysXBE=;
        b=EcRzsGQe+Hw6LSMzaSmM1znyMUg98HmIgthm/oJTSglcyZbBjIyrAXXuYPJxlzq5Js
         PG0wB5xvCRFkU39EOYT30O+RtpMZmrA719BDdGHybjs8dHq8iael1vaCV9FNSOd+jvmx
         cO8sBc3mAG7HvPHlsOfO+TE0o1+IOI03RxharTo3zDoc11NX0e7Bczj81aDVtxw3+mxu
         5ApPpaFDtXuQSWCb1aRMjaP80bE4/aW54URhM9Lz4TOTY4D9W5BPdOYkjXl9O72QblNq
         hjPyIOkmQ2DLmXVtkyWu+SQC4payENjpS5i5WoszhMtDPxoXQDZjeN2wLscHmbJyBrD6
         VYug==
X-Gm-Message-State: AOAM532uyCFunc+Ccxda/+KuQf90WgF33GT42rAz34I3DKOviu0jiwqh
        R2g+q/bb6T21wS+TdwePrfMMUWOtu0HTKPirqfcIRACzNRg=
X-Google-Smtp-Source: ABdhPJy0rgy7XX2ynNb8BJWONXf8j4cobkfuON7kUlM1eQUrELAc8vQERAxSUCeRIoDrwswXMm5huyE7Rq/8bM863lk=
X-Received: by 2002:a05:6102:242b:: with SMTP id l11mr301820vsi.14.1590626745389;
 Wed, 27 May 2020 17:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200426032410.10425-1-wuxy@bitland.com.cn>
In-Reply-To: <20200426032410.10425-1-wuxy@bitland.com.cn>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 28 May 2020 08:45:34 +0800
Message-ID: <CANMq1KAGtMMC7SW7aeDQuogF+Ux40=AFYO8V-F_JkEMtAa3eUQ@mail.gmail.com>
Subject: Re: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
To:     wuxy@bitland.com.cn
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>,
        wuxy <wuxy@bitland.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First, you need to cc linux-mtd@lists.infradead.org, make sure to use
the get_maintainer.pl script to get the cc list (you're cc-ing mm
people here, but you should cc mtd folks instead).

On Sun, Apr 26, 2020 at 11:24 AM <wuxy@bitland.com.cn> wrote:
>
> From: wuxy <wuxy@bitland.corp-partner.google.com>
>
> Winbond has new 1.8V SPI NOR Flash IDs,we need to use the SPI
> flash ID in kukui series,this patch can support the new flash IDs.
> This patch copied from:https://patchwork.ozlabs.org/patch/1150756/,
> The original patch is invalid,so re-submit a new patch for this.

This is historical stuff, and does not belong in the commit message,
please move that below the ---.

Also, since you're merely rebasing/fixing a patch authored by ST Lin,
I'd keep the original author and signed off:
Signed-off-by: ST Lin <stlin2@winbond.com>

Thanks!

>
> TEST=boot to shell,get the spi information from 'dmesg'.
>
> Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
> ---
>  drivers/mtd/spi-nor/winbond.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 17deabad57e1..cda4f8847bd6 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -61,6 +61,15 @@ static const struct flash_info winbond_parts[] = {
>                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
>                             SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> +       { "w25q64jwxxIM", INFO(0xef8017, 0, 64 * 1024, 128,
> +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> +       { "w25q128jwxxIM", INFO(0xef8018, 0, 64 * 1024, 256,
> +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> +       { "w25q256jwxxIM", INFO(0xef8019, 0, 64 * 1024, 512,
> +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>  };
>
>  /**
> --
> 2.20.1
>
>
>
