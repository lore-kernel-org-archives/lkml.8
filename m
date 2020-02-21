Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA5C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006A3208CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgBUDEa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:04:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46444 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgBUDEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:04:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id p14so544791edy.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 19:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=NnuOIkH/k/PEJ/s73MC7n0P8o0WQzooeJ7sSj3zBbiE=;
        b=Q2IFLX+fw1k8xDyTRf2+308ErQEUd/ITsE6kNMzfGbnJBf97p2gRh2IkFmpjZl88s1
         6YDvh1F6lA4X1CpgbIiFMnH+XBJNKluxSpPWtgxweV0IFansE82bLCW95tm/xwFQ62vU
         j6dU9g8O2L0S4BF7U7C+DtwBjzA/aL1FZKSdQDALnJLomSW+ZfuguPkXnH1zK8l73PBc
         r21AFrkYwODjLb3gHIpr4rftjINTb4ms17r0MXFiqBGg22O8nKDsKbliGHLa9RZhnzND
         HfFjXOcApgpqWnYtP0FjBvuURGUEqWb/7jsJWa9AfIcscvD5K2YE1Xdml2iaXgzqqIKV
         WdWw==
X-Gm-Message-State: APjAAAW+pqG0C04SDDRlhJl+2lct2xHS6pjQ9Mm/BWnKRclW4h7TI0+F
        q1Ck8cSy+VoGW9hw651rexRwlGRVVBM=
X-Google-Smtp-Source: APXvYqzG3I4Yrsdt4AJsy6HdZVOeMAUcwplkggF0R8DW4ch9c118IgcQs+DIsisvBVQvh6O+WDrxVg==
X-Received: by 2002:a17:906:1a05:: with SMTP id i5mr31255518ejf.347.1582254266350;
        Thu, 20 Feb 2020 19:04:26 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a10sm155950edt.50.2020.02.20.19.04.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 19:04:25 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id k11so324486wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 19:04:25 -0800 (PST)
X-Received: by 2002:a5d:6805:: with SMTP id w5mr47051708wru.64.1582254264966;
 Thu, 20 Feb 2020 19:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20200219010951.395599-1-megous@megous.com> <CAGb2v67BLODmDmQOJH-m-KWVtXS2EGrnPxi9czj6oipHPDTfjw@mail.gmail.com>
 <20200219121424.dfvrwfcavupmwbvw@core.my.home>
In-Reply-To: <20200219121424.dfvrwfcavupmwbvw@core.my.home>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 21 Feb 2020 11:04:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v64+C1Q8au_cR0PjY=0GJx1c+kk7Tw0=12+fFEhBF_Q-Rg@mail.gmail.com>
Message-ID: <CAGb2v64+C1Q8au_cR0PjY=0GJx1c+kk7Tw0=12+fFEhBF_Q-Rg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] bus: sunxi-rsb: Return correct data
 when mixing 16-bit and 8-bit reads
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 8:14 PM Ondřej Jirman <megous@megous.com> wrote:
>
> On Wed, Feb 19, 2020 at 10:49:18AM +0800, Chen-Yu Tsai wrote:
> > On Wed, Feb 19, 2020 at 9:10 AM Ondrej Jirman <megous@megous.com> wrote:
> > >
> > > When doing a 16-bit read that returns data in the MSB byte, the
> > > RSB_DATA register will keep the MSB byte unchanged when doing
> > > the following 8-bit read. sunxi_rsb_read() will then return
> > > a result that contains high byte from 16-bit read mixed with
> > > the 8-bit result.
> > >
> > > The consequence is that after this happens the PMIC's regmap will
> > > look like this: (0x33 is the high byte from the 16-bit read)
> > >
> > > % cat /sys/kernel/debug/regmap/sunxi-rsb-3a3/registers
> > > 00: 33
> > > 01: 33
> > > 02: 33
> > > 03: 33
> > > 04: 33
> > > 05: 33
> > > 06: 33
> > > 07: 33
> > > 08: 33
> > > 09: 33
> > > 0a: 33
> > > 0b: 33
> > > 0c: 33
> > > 0d: 33
> > > 0e: 33
> > > [snip]
> > >
> > > Fix this by masking the result of the read with the correct mask
> > > based on the size of the read. There are no 16-bit users in the
> > > mainline kernel, so this doesn't need to get into the stable tree.
> > >
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> >
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> >
> > for the fix, however it's not entirely clear to me how the MSB 0x33
> > value got into the regmap. Looks like I expected the regmap core to
> > handle any overflows, or didn't expect the lingering MSB from 16-bit
> > reads, as I didn't have any 16-bit register devices back when I wrote
> > this.
>
> Now I feel like I masked some other bug. Though explanation may be quite simple.
>
> For example when AXP core does regmap_read on some values for showing charging
> current or battery voltage, because regmap_read works with unsigned int, it
> will simply get a number that's too big. And that was the major symptom
> I observed. I got readings from sysfs that my tablet is consuming 600A or 200A,
> etc. And this value was jumping around based on AC100 activity (as the MSB
> byte got changed).
>
> In other places where the driver does regmap_update_bits, I think nothing bad
> happened. The write after the read would simply discard the MSB byte.
>
> And for the debugfs/regmap/*/registers, those are printed such:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap-debugfs.c#L256
>
>         snprintf(buf + buf_pos, count - buf_pos,
>                 "%.*x", map->debugfs_val_len, val);
>
> This doesn't truncate values, so the larger number gets printed to (for example):
>
>         33fe
>
> But regmap debugfs code truncates this by cutting off the formatted string to
> this length:
>
>   https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap-debugfs.c#L189
>
> So in the end, only:
>
>         00: 33
>
> remains, instead of the correct value of:
>
>         00: fe
>
> So in the case of debugfs this is just a cosmetic/formatting issue, that didn't
> affect anything else.
>
> I think regmap_bus->reg_read API simply expects the returned value to not exceed
> the sensible range.

Sounds good. Thanks for digging through this. My ack still stands.

ChenYu

> regards,
>         o.
>
>
> > ChenYu
> >
> >
> > > ---
> > >  drivers/bus/sunxi-rsb.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> > > index b8043b58568ac..8ab6a3865f569 100644
> > > --- a/drivers/bus/sunxi-rsb.c
> > > +++ b/drivers/bus/sunxi-rsb.c
> > > @@ -316,6 +316,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> > >  {
> > >         u32 cmd;
> > >         int ret;
> > > +       u32 mask;
> > >
> > >         if (!buf)
> > >                 return -EINVAL;
> > > @@ -323,12 +324,15 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> > >         switch (len) {
> > >         case 1:
> > >                 cmd = RSB_CMD_RD8;
> > > +               mask = 0xffu;
> > >                 break;
> > >         case 2:
> > >                 cmd = RSB_CMD_RD16;
> > > +               mask = 0xffffu;
> > >                 break;
> > >         case 4:
> > >                 cmd = RSB_CMD_RD32;
> > > +               mask = 0xffffffffu;
> > >                 break;
> > >         default:
> > >                 dev_err(rsb->dev, "Invalid access width: %zd\n", len);
> > > @@ -345,7 +349,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> > >         if (ret)
> > >                 goto unlock;
> > >
> > > -       *buf = readl(rsb->regs + RSB_DATA);
> > > +       *buf = readl(rsb->regs + RSB_DATA) & mask;
> > >
> > >  unlock:
> > >         mutex_unlock(&rsb->lock);
> > > --
> > > 2.25.1
> > >
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200219121424.dfvrwfcavupmwbvw%40core.my.home.
