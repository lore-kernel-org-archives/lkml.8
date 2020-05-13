Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BF1CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C028204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbgEMNpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:45:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35911 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:45:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id x7so20539831oic.3;
        Wed, 13 May 2020 06:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xp2IqGP2Mbz3cUUpa596hqcAdNywAgOxy/wkkTIouTg=;
        b=LiIltCoq47JiOnxD0ShmFYyGPstSVWGVyLqihPYSAVlw62Dh1hvyuIemKqxFwU+rhw
         P7uy6biHyKTeFI9hpVJAmYkBIeWC56dnbF74YsQVKMfbHRnOMKWH0hjWYpaWA54a1Kzm
         zYutM6y9JBcgoly+aYTlPS2vIqBWEX0d6F747laMPKpcog+9XARdNZLeO0oPJn7lubva
         A0h3L5fCojpR/AJz/Oyu2T3rrDfqJhSNeCk9OmXgxqp0C42ynx79adjPNC8HCB3zy3h1
         aaCgr5OMze2frVJUp8oHeW4/sI1UjTTqXSqkAJDAGxmCMdWSdW5YiUkQqg8Bwm1j9IZh
         Npfg==
X-Gm-Message-State: AGi0PuY6gTFdCVPlBuxtxLTvcdk6QqihiTIlebb33l6zsMArlsnXI2bu
        8mBX768KZ9Y2ndxfMlh8ikA1Cv26X5DkEHDFVSE=
X-Google-Smtp-Source: APiQypIkVm7LXX8qk0ws4kqaeeBcVvSSkhrRjsfESas1+/iQAxJtbMOedEgPmzmOblcvF9BI9+5orflFlvsnP8NbL+g=
X-Received: by 2002:aca:cd93:: with SMTP id d141mr4645429oig.148.1589377552343;
 Wed, 13 May 2020 06:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <1589370694-14327-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589370694-14327-1-git-send-email-alencar.fmce@imbel.gov.br>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 May 2020 15:45:41 +0200
Message-ID: <CAMuHMdX5-cYdK0UrNYj+wRuUu3whADaq607OuBjALnnKWi5FCQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: ssd1307fb: Added support to Column offset
To:     Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alencar.fmce@imbel.gov.br,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC dt

On Wed, May 13, 2020 at 1:52 PM Rodrigo Rolim Mendes de Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.
>
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
>  drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> index 27333b9551b3..a9b51fd724a9 100644
> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> @@ -19,6 +19,7 @@ Optional properties:
>    - vbat-supply: The supply for VBAT
>    - solomon,segment-no-remap: Display needs normal (non-inverted) data column
>                                to segment mapping
> +  - solomon,col-offset: Offset of columns (SEG) that the screen is mapped to.
>    - solomon,com-seq: Display uses sequential COM pin configuration
>    - solomon,com-lrremap: Display uses left-right COM pin remap
>    - solomon,com-invdir: Display uses inverted COM pin scan direction
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index 8e06ba912d60..0241585bfbcc 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -74,6 +74,7 @@ struct ssd1307fb_par {
>         struct fb_info *info;
>         u8 lookup_table[4];
>         u32 page_offset;
> +       u32 col_offset;
>         u32 prechargep1;
>         u32 prechargep2;
>         struct pwm_device *pwm;
> @@ -458,11 +459,11 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>         if (ret < 0)
>                 return ret;
>
> -       ret = ssd1307fb_write_cmd(par->client, 0x0);
> +       ret = ssd1307fb_write_cmd(par->client, par->col_offset);
>         if (ret < 0)
>                 return ret;
>
> -       ret = ssd1307fb_write_cmd(par->client, par->width - 1);
> +       ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
>         if (ret < 0)
>                 return ret;
>
> @@ -626,6 +627,9 @@ static int ssd1307fb_probe(struct i2c_client *client)
>         if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
>                 par->page_offset = 1;
>
> +       if (of_property_read_u32(node, "solomon,col-offset", &par->col_offset))
> +               par->col_offset = 0;
> +
>         if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
>                 par->com_offset = 0;
