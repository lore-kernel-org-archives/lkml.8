Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B128C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ADA20578
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgCLG4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:56:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35913 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbgCLG4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:56:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id b18so1492321edu.3;
        Wed, 11 Mar 2020 23:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kR8J01aQjT+3rTPOnycwD+iqf21URVOWBRJAxtlJ7vg=;
        b=pMn/KjyT+TKASGi00Yy7WmKNfImNsGmSps2oAfqBpNMWFvECtt2fYxHs4FHVdjdjNo
         IkcxKAeB8ETaOKU+MxaT3J85pCrYohcvJLMJGJHf9ja3fnQUj9KhS+x8cQmIxBFxtMWv
         67sPR60Srb33CoK1lf5j+EsF27PiUATpxpQ5dE71PQSvT181xo7/aGPCmegZLfW2vRn8
         w/j98U3vAf7wXGF/bbelCD3VM2agPbaknSwxUHKHIEq1gE4a7XKxof9mnkzgNBT0WAui
         FXf3G1rnSyHUjxJTBhEg3Ch6QwU63DWfI93Nx60Z92JlipPiK/UZ0WJGTCo6OKLRdEYe
         k6QA==
X-Gm-Message-State: ANhLgQ2+ZsuCjmjg9JRCLtjq99I43KuaV37xzS70C9ccmxV+csov+P7V
        gT3FDdqLIFs52Ua2kE6l1kpqe6n5pYM=
X-Google-Smtp-Source: ADFU+vvrhJ5Af/ByjsZZZZIaDYBcvSN1odRTRpRnwBPrbseao+hcpClI5U7f9rMHVaGncGZOqeQrdA==
X-Received: by 2002:aa7:dd4f:: with SMTP id o15mr6453985edw.359.1583996164291;
        Wed, 11 Mar 2020 23:56:04 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id p34sm123384edb.63.2020.03.11.23.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 23:56:04 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id s5so5968772wrg.3;
        Wed, 11 Mar 2020 23:56:03 -0700 (PDT)
X-Received: by 2002:adf:97c1:: with SMTP id t1mr4859136wrb.365.1583996163412;
 Wed, 11 Mar 2020 23:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200309204326.27403-1-thirtythreeforty@gmail.com> <20200309204326.27403-4-thirtythreeforty@gmail.com>
In-Reply-To: <20200309204326.27403-4-thirtythreeforty@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 12 Mar 2020 14:55:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v65LJUT1teBna7deKP7AfboUBcQDmiDgu3hrQY_+UzU0DA@mail.gmail.com>
Message-ID: <CAGb2v65LJUT1teBna7deKP7AfboUBcQDmiDgu3hrQY_+UzU0DA@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/5] musb: sunxi: add support for the suniv MUSB controller
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 4:44 AM George Hilliard
<thirtythreeforty@gmail.com> wrote:
>
> The suniv SoC has a MUSB controller like the one in A33, but with a SRAM
> region to be claimed.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Same thing about the SoB and author.

> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  drivers/usb/musb/sunxi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index f3f76f2ac63f..76806b781844 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -714,14 +714,17 @@ static int sunxi_musb_probe(struct platform_device *pdev)
>         INIT_WORK(&glue->work, sunxi_musb_work);
>         glue->host_nb.notifier_call = sunxi_musb_host_notifier;
>
> -       if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb"))
> +       if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb") ||
> +           of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
>                 set_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags);
> +       }
>
>         if (of_device_is_compatible(np, "allwinner,sun6i-a31-musb"))
>                 set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
>
>         if (of_device_is_compatible(np, "allwinner,sun8i-a33-musb") ||
> -           of_device_is_compatible(np, "allwinner,sun8i-h3-musb")) {
> +           of_device_is_compatible(np, "allwinner,sun8i-h3-musb") ||
> +           of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
>                 set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
>                 set_bit(SUNXI_MUSB_FL_NO_CONFIGDATA, &glue->flags);
>         }
> @@ -814,6 +817,7 @@ static int sunxi_musb_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id sunxi_musb_match[] = {
> +       { .compatible = "allwinner,suniv-f1c100s-musb", },

And same thing about the ordering.

Once resolved,

Acked-by: Chen-Yu Tsai <wens@csie.org>

>         { .compatible = "allwinner,sun4i-a10-musb", },
>         { .compatible = "allwinner,sun6i-a31-musb", },
>         { .compatible = "allwinner,sun8i-a33-musb", },
> --
> 2.25.0
>
