Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4926C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE8D24699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je24LAfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1RbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:31:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33176 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:31:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so2717447lfl.0;
        Fri, 28 Feb 2020 09:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDMJgw4k/0TVmBJKgQCKTtnqqdoZnRz+8hLD+C3oQEU=;
        b=Je24LAfsRFRYBbBIONtjE5FMXXLVtAf9UgF8iZMPYyZrH49+egQjYO4heaUEcCrbZo
         RVTrbxjmbH9uLttafjP/cgLGjwXkrELCN93m4FLZkD2+4OD+khynAn+uDUn34/sgqZpa
         UZbRiuoj5gDONEP65txSciDg5HK100J3x50pvGIbXYfABZ5Rab57nN82xhLv5l9eVcZO
         A0YgG5oFjtIly25ZuBwVc7VyUHyRYgsXUdpegASyEDEIhOdAXpgoeHtFRXpJ/AYjGkOL
         J/7FJAuKr4chpaBgx1hg6yv0ItZhwTp+NQQROB4azSfnUb/2TaUyBwzQg+iOAWsNQUp9
         QuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDMJgw4k/0TVmBJKgQCKTtnqqdoZnRz+8hLD+C3oQEU=;
        b=sy8bmbZ4QkZA7ndipa4Gr1SMBAZZRJWiK7FSxPI6syR0mnVza5a8NpOORWleS0Gpx5
         h78KT9eC80h6ToMiMOWDzeS6PqmG/QfhZLuDHTiyVPHQEoqtCwQM/uLm8RmQvbdrYN/P
         MrzTEmnJ3uHdOQVtF05TsDuZHSybjgTn3wq2CMhMpq7OabMIht6QUOrZJP3BdDnAQTvm
         9c/6eyRfLQVlSPOjuMQli7OcExTNLfr9ydaDgk5+1+qHJCsP/qyg4TbVTUWQuxS0r3sK
         JtAN4OWJqfeFGbC6F/h6/mTa6ILyVm7S82Mg2DeqKr+XX/3yNExlCIMzIN7ZJn2suDH9
         sDNQ==
X-Gm-Message-State: ANhLgQ2ckt8hO5mq9UrGvNeHn9SYVpfl6linuLsBcL38cTjo9NFNLKLb
        ZAGhAd6vFnyHMIlaMBav4h9qaiJf97/xoSzwA3M=
X-Google-Smtp-Source: ADFU+vvGH48fioku6g05fhccnwY9e2yjBmAxiKU0CwTO/bF0fEBjjVNtgB4YwJQSZwwVt4LXWJYhaonZXkOqhzLRouA=
X-Received: by 2002:a05:6512:10d4:: with SMTP id k20mr3268284lfg.70.1582911079950;
 Fri, 28 Feb 2020 09:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20200228164126.17517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200228164126.17517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 28 Feb 2020 14:31:08 -0300
Message-ID: <CAOMZO5AP65Upj8v=KaPLzS10DNdwrz20gJGbwbcJfCDqZBx71Q@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5645: Add virtual_channel module parameter
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

On Fri, Feb 28, 2020 at 1:41 PM Lad Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> OV5645 can operate in virtual channel 0-3 in CSI2 interfaces, this patch
> adds support for module parameter virtual_channel to select the required
> channel. By default OV5645 operates in virtual channel 0.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/media/i2c/ov5645.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index a6c17d15d754..0a0671164623 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -54,6 +54,7 @@
>  #define OV5645_TIMING_TC_REG21         0x3821
>  #define                OV5645_SENSOR_MIRROR            BIT(1)
>  #define OV5645_MIPI_CTRL00             0x4800
> +#define OV5645_REG_DEBUG_MODE          0x4814
>  #define OV5645_PRE_ISP_TEST_SETTING_1  0x503d
>  #define                OV5645_TEST_PATTERN_MASK        0x3
>  #define                OV5645_SET_TEST_PATTERN(x)      ((x) & OV5645_TEST_PATTERN_MASK)
> @@ -61,6 +62,11 @@
>  #define OV5645_SDE_SAT_U               0x5583
>  #define OV5645_SDE_SAT_V               0x5584
>
> +static u8 virtual_channel;
> +module_param(virtual_channel, byte, 0644);
> +MODULE_PARM_DESC(virtual_channel,
> +                "MIPI CSI-2 virtual channel (0..3), default 0");

Should this be a device tree property instead?
