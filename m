Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E461C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F04724655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBSCte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:49:34 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33001 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgBSCtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:49:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so27341866edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YO1Y1VDHcP44ZD0tS0W7OVzzWFpRpsczECwzMV+qhw=;
        b=CrBOaYK+8ZFUbKAjS+HBKCOj9fgPjewapiaTXGOH9d/STNXon++xluzfqNnhY4BxQe
         PsZz3lmyrz0PBV8wmwpPgvQDg1M/YS7Jx6KH3i3kKVGXKd58Gf6vbnO4I/UdNpXzihjL
         av0eoo5+nxADlidddr7cb/wFMKp4eX7TL3HKa+jbM5AxXCE8BQQNCBL/d35+bhqlX2x2
         eKAjIfWLc/nUmGZ0K74dBTKL0YQ8DZUSOPKpbT3wvyvfDwG60LRuEETnb26GNQ7j+KjI
         SJMyEvYVnGhIM2VzcCG2z+0dLAerB2lGZ58fjQQiGW2J0WhMd06knY4DhkQYlPGHxwqL
         nBcg==
X-Gm-Message-State: APjAAAWMyiiIlEhgDOZebXm6eBCUhOcMjTtW8yfNe58BWxbwEDGIJ5E7
        B6NCKJGISL1QjX5K2kcSjhnzi7pzucA=
X-Google-Smtp-Source: APXvYqw2WT63fvCw4qLur5lo3KnAvvKIS4jNQb/FjUFwfp3YRbVXcbR+hLwI1egOjLHzl9ABOkcKYw==
X-Received: by 2002:a17:906:f14e:: with SMTP id gw14mr834201ejb.217.1582080571088;
        Tue, 18 Feb 2020 18:49:31 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id d8sm24849edn.52.2020.02.18.18.49.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 18:49:30 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id y11so26363948wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:49:30 -0800 (PST)
X-Received: by 2002:a5d:640d:: with SMTP id z13mr31363099wru.181.1582080570098;
 Tue, 18 Feb 2020 18:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20200219010951.395599-1-megous@megous.com>
In-Reply-To: <20200219010951.395599-1-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 19 Feb 2020 10:49:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v67BLODmDmQOJH-m-KWVtXS2EGrnPxi9czj6oipHPDTfjw@mail.gmail.com>
Message-ID: <CAGb2v67BLODmDmQOJH-m-KWVtXS2EGrnPxi9czj6oipHPDTfjw@mail.gmail.com>
Subject: Re: [PATCH] bus: sunxi-rsb: Return correct data when mixing 16-bit
 and 8-bit reads
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 9:10 AM Ondrej Jirman <megous@megous.com> wrote:
>
> When doing a 16-bit read that returns data in the MSB byte, the
> RSB_DATA register will keep the MSB byte unchanged when doing
> the following 8-bit read. sunxi_rsb_read() will then return
> a result that contains high byte from 16-bit read mixed with
> the 8-bit result.
>
> The consequence is that after this happens the PMIC's regmap will
> look like this: (0x33 is the high byte from the 16-bit read)
>
> % cat /sys/kernel/debug/regmap/sunxi-rsb-3a3/registers
> 00: 33
> 01: 33
> 02: 33
> 03: 33
> 04: 33
> 05: 33
> 06: 33
> 07: 33
> 08: 33
> 09: 33
> 0a: 33
> 0b: 33
> 0c: 33
> 0d: 33
> 0e: 33
> [snip]
>
> Fix this by masking the result of the read with the correct mask
> based on the size of the read. There are no 16-bit users in the
> mainline kernel, so this doesn't need to get into the stable tree.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

for the fix, however it's not entirely clear to me how the MSB 0x33
value got into the regmap. Looks like I expected the regmap core to
handle any overflows, or didn't expect the lingering MSB from 16-bit
reads, as I didn't have any 16-bit register devices back when I wrote
this.

ChenYu


> ---
>  drivers/bus/sunxi-rsb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index b8043b58568ac..8ab6a3865f569 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -316,6 +316,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
>  {
>         u32 cmd;
>         int ret;
> +       u32 mask;
>
>         if (!buf)
>                 return -EINVAL;
> @@ -323,12 +324,15 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
>         switch (len) {
>         case 1:
>                 cmd = RSB_CMD_RD8;
> +               mask = 0xffu;
>                 break;
>         case 2:
>                 cmd = RSB_CMD_RD16;
> +               mask = 0xffffu;
>                 break;
>         case 4:
>                 cmd = RSB_CMD_RD32;
> +               mask = 0xffffffffu;
>                 break;
>         default:
>                 dev_err(rsb->dev, "Invalid access width: %zd\n", len);
> @@ -345,7 +349,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
>         if (ret)
>                 goto unlock;
>
> -       *buf = readl(rsb->regs + RSB_DATA);
> +       *buf = readl(rsb->regs + RSB_DATA) & mask;
>
>  unlock:
>         mutex_unlock(&rsb->lock);
> --
> 2.25.1
>
