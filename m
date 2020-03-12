Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9841CC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDEA20578
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgCLGvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:51:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46725 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbgCLGvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:51:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id ca19so6016072edb.13;
        Wed, 11 Mar 2020 23:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/AmsGV7LUDr4BsaTsFXwX7ju70UH4Ld8vfQPaaQh44=;
        b=Lv3bb+4YG3uudt3hZAOhibk8NTUjT0ZsgUty/fw697C7snis1NKI+t/B2ptJPRACx8
         zK2SQIo7CfePtfpz4ecw7q1EIOoBUap1dccho8RRyzctCDz03YAennV43Gs53SxnO+Qw
         0snXFyGWaz5c9YKHTHubl9D/IDGozpgPD7KrfoOrnDyYt16h+mha1DxXoyVvF//gpZLQ
         CCxs5aw/ADmsAt3jiHphgAkBYaJz32SlK21Pe6EHPJBo1P6PJOBzkUAq7eo2TKw+bc18
         SEpM27cZH2MVnIaXxpkPr/S5dHVFcf01gEkPy7W6oH1W/EXyub8TWeeBykClGG26n2c1
         YHqg==
X-Gm-Message-State: ANhLgQ3lWmqRqN3UefRO399PQ90MdUfJCEgXITT0tlArWOSUBuRkJ24J
        BQCr1pBLzFLbudsKbQfMQcMG8zX/I20=
X-Google-Smtp-Source: ADFU+vu0trWF0i4Rscpcb5zy09U/+vvDlhKuP2Uo5Fip1sP9R3Jxt1QaYDKNDr2oEDgcyZJjctjMEA==
X-Received: by 2002:a17:906:5e42:: with SMTP id b2mr90324eju.266.1583995904234;
        Wed, 11 Mar 2020 23:51:44 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id m6sm308257edv.27.2020.03.11.23.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 23:51:43 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id n15so5888177wrw.13;
        Wed, 11 Mar 2020 23:51:43 -0700 (PDT)
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr9282438wrp.104.1583995902900;
 Wed, 11 Mar 2020 23:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200309204326.27403-1-thirtythreeforty@gmail.com> <20200309204326.27403-3-thirtythreeforty@gmail.com>
In-Reply-To: <20200309204326.27403-3-thirtythreeforty@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 12 Mar 2020 14:51:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v64_cWagG54iMmzmOwtUmv91xJchtzKW25M=y9DbfFDzkQ@mail.gmail.com>
Message-ID: <CAGb2v64_cWagG54iMmzmOwtUmv91xJchtzKW25M=y9DbfFDzkQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/5] phy: sun4i-usb: add support for the USB PHY on
 suniv SoC
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

On Tue, Mar 10, 2020 at 4:43 AM George Hilliard
<thirtythreeforty@gmail.com> wrote:
>
> The suniv SoC has one USB OTG port connected to a MUSB controller.
>
> Add support for its USB PHY.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Not sure why Icenowy's SoB is here. If she was the original author, you
are supposed to keep her name as the author.

> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 856927382248..5fb0c42fe8fd 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -98,6 +98,7 @@
>  #define POLL_TIME                      msecs_to_jiffies(250)
>
>  enum sun4i_usb_phy_type {
> +       suniv_f1c100s_phy,
>         sun4i_a10_phy,
>         sun6i_a31_phy,
>         sun8i_a33_phy,
> @@ -859,6 +860,14 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> +static const struct sun4i_usb_phy_cfg suniv_f1c100s_cfg = {
> +       .num_phys = 1,
> +       .type = suniv_f1c100s_phy,
> +       .disc_thresh = 3,
> +       .phyctl_offset = REG_PHYCTL_A10,
> +       .dedicated_clocks = true,
> +};
> +
>  static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
>         .num_phys = 3,
>         .type = sun4i_a10_phy,
> @@ -973,6 +982,8 @@ static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
>  };
>
>  static const struct of_device_id sun4i_usb_phy_of_match[] = {
> +       { .compatible = "allwinner,suniv-f1c100s-usb-phy",
> +         .data = &suniv_f1c100s_cfg },
>         { .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },

Please use the same style (and ignore checkpatch.pl on this one).

ChenYu

>         { .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
>         { .compatible = "allwinner,sun6i-a31-usb-phy", .data = &sun6i_a31_cfg },
> --
> 2.25.0
>
