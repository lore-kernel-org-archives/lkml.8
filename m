Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD52C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C33B20747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgDGHRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:17:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46920 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGHRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:17:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id 111so686020oth.13;
        Tue, 07 Apr 2020 00:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5xikFbGzKAB1v4tOO+dSzm/t4TIX3m1tvCf8H29tf4=;
        b=oGfvh4iRqDWzXiWxilwTYAWAV3EJI/4ElnQj/oDAcTLgxVU0bmjOWVsfv4xdDl8c0e
         q8sQrLmUn945WOkne+K2r8Hl68XSkMgD62YWYJYoF2S9L6kVf36hrkljzGCrkCmKQfs1
         0fQECV/hMQt8gWZfDSrYrZ1czu3DlMLwBL7LVj/bWeuCqFn0ahS1Dpb6dw/qjpwKtym4
         CSKuQLfL0BMFBf5Pi97WcWuWyJbJQPyo0X4bYUAytQRn/28KXVMW3vD7uRr8adjOfUZh
         haWJrZWN4ooLc5Ck+cnyI9FjTth/AMjGFs183WL8KfagdCSjYLX8Y5lTSuamILX1ti9c
         UxBA==
X-Gm-Message-State: AGi0PuaYFPUhaSE9UgiMGUYYbPE0zSfFLxjf3wbFumr5oT+/drfjIJR0
        1RbL5sJ4d9yo0tM9psqWFsGJ10cCJZKkVk/L2OE=
X-Google-Smtp-Source: APiQypJP8g3xsKxDPZaxH+T8RAbLqRK/iXSCL5Pslbnj35O4awJBo1POCr17AHqI64KksRj2Tzx+fDqkrn/Qx9erX9g=
X-Received: by 2002:a05:6830:15c2:: with SMTP id j2mr439913otr.107.1586243827132;
 Tue, 07 Apr 2020 00:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <1586191361-16598-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1586191361-16598-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1586191361-16598-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Apr 2020 09:16:55 +0200
Message-ID: <CAMuHMdWiVLt23a0JBDX6ZiKDiru9-ecgt3XF4Y5qzVOWXhLcCw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] media: i2c: ov5645: Drop reading clock-frequency dt-property
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Apr 6, 2020 at 6:43 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Modes in the driver are based on xvclk frequency fixed to 24MHz, but where
> as the OV5645 sensor can support the xvclk frequency ranging from 6MHz to
> 24MHz. So instead making clock-frequency as dt-property just let the
> driver enforce the required clock frequency.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, still wondering about the "xvclk" name above and in the definition
below.  Is this the naming from the datasheet?
The DT bindings nor the driver use the "xvclk" naming.

> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -61,6 +61,8 @@
>  #define OV5645_SDE_SAT_U               0x5583
>  #define OV5645_SDE_SAT_V               0x5584
>
> +#define OV5645_XVCLK_FREQ              24000000
> +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
