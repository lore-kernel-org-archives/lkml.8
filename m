Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1130C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6B224656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="dvGcwYJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgBSMO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:14:27 -0500
Received: from vps.xff.cz ([195.181.215.36]:36372 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgBSMO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582114465; bh=LBA0OH0LGSn5q2o3L6sg17qe8iS+vJij63Yj2IJHsB0=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=dvGcwYJJZLS/xFu1ybo56J0BAjHKnrYfVUk3M+k4oXa0oOJ+vK/r+mmexvgN/O3+7
         V4ZYYZ970DFyi3RfWCLmndM3lhr8HDwymiDHyO/HXJP9xib7xnnjK77E0/9tpT9p1T
         T7QrfHCKnH+F5eHduStJqxSTxzYMELJI1oPd1y24=
Date:   Wed, 19 Feb 2020 13:14:24 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: sunxi-rsb: Return correct data when mixing 16-bit
 and 8-bit reads
Message-ID: <20200219121424.dfvrwfcavupmwbvw@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200219010951.395599-1-megous@megous.com>
 <CAGb2v67BLODmDmQOJH-m-KWVtXS2EGrnPxi9czj6oipHPDTfjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v67BLODmDmQOJH-m-KWVtXS2EGrnPxi9czj6oipHPDTfjw@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:49:18AM +0800, Chen-Yu Tsai wrote:
> On Wed, Feb 19, 2020 at 9:10 AM Ondrej Jirman <megous@megous.com> wrote:
> >
> > When doing a 16-bit read that returns data in the MSB byte, the
> > RSB_DATA register will keep the MSB byte unchanged when doing
> > the following 8-bit read. sunxi_rsb_read() will then return
> > a result that contains high byte from 16-bit read mixed with
> > the 8-bit result.
> >
> > The consequence is that after this happens the PMIC's regmap will
> > look like this: (0x33 is the high byte from the 16-bit read)
> >
> > % cat /sys/kernel/debug/regmap/sunxi-rsb-3a3/registers
> > 00: 33
> > 01: 33
> > 02: 33
> > 03: 33
> > 04: 33
> > 05: 33
> > 06: 33
> > 07: 33
> > 08: 33
> > 09: 33
> > 0a: 33
> > 0b: 33
> > 0c: 33
> > 0d: 33
> > 0e: 33
> > [snip]
> >
> > Fix this by masking the result of the read with the correct mask
> > based on the size of the read. There are no 16-bit users in the
> > mainline kernel, so this doesn't need to get into the stable tree.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> for the fix, however it's not entirely clear to me how the MSB 0x33
> value got into the regmap. Looks like I expected the regmap core to
> handle any overflows, or didn't expect the lingering MSB from 16-bit
> reads, as I didn't have any 16-bit register devices back when I wrote
> this.

Now I feel like I masked some other bug. Though explanation may be quite simple.

For example when AXP core does regmap_read on some values for showing charging
current or battery voltage, because regmap_read works with unsigned int, it
will simply get a number that's too big. And that was the major symptom
I observed. I got readings from sysfs that my tablet is consuming 600A or 200A,
etc. And this value was jumping around based on AC100 activity (as the MSB
byte got changed).

In other places where the driver does regmap_update_bits, I think nothing bad
happened. The write after the read would simply discard the MSB byte.

And for the debugfs/regmap/*/registers, those are printed such:

https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap-debugfs.c#L256

	snprintf(buf + buf_pos, count - buf_pos,
		"%.*x", map->debugfs_val_len, val);
	
This doesn't truncate values, so the larger number gets printed to (for example):

        33fe

But regmap debugfs code truncates this by cutting off the formatted string to
this length:

  https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap-debugfs.c#L189

So in the end, only:

        00: 33

remains, instead of the correct value of:

        00: fe

So in the case of debugfs this is just a cosmetic/formatting issue, that didn't
affect anything else.

I think regmap_bus->reg_read API simply expects the returned value to not exceed
the sensible range.

regards,
	o.


> ChenYu
> 
> 
> > ---
> >  drivers/bus/sunxi-rsb.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> > index b8043b58568ac..8ab6a3865f569 100644
> > --- a/drivers/bus/sunxi-rsb.c
> > +++ b/drivers/bus/sunxi-rsb.c
> > @@ -316,6 +316,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> >  {
> >         u32 cmd;
> >         int ret;
> > +       u32 mask;
> >
> >         if (!buf)
> >                 return -EINVAL;
> > @@ -323,12 +324,15 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> >         switch (len) {
> >         case 1:
> >                 cmd = RSB_CMD_RD8;
> > +               mask = 0xffu;
> >                 break;
> >         case 2:
> >                 cmd = RSB_CMD_RD16;
> > +               mask = 0xffffu;
> >                 break;
> >         case 4:
> >                 cmd = RSB_CMD_RD32;
> > +               mask = 0xffffffffu;
> >                 break;
> >         default:
> >                 dev_err(rsb->dev, "Invalid access width: %zd\n", len);
> > @@ -345,7 +349,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> >         if (ret)
> >                 goto unlock;
> >
> > -       *buf = readl(rsb->regs + RSB_DATA);
> > +       *buf = readl(rsb->regs + RSB_DATA) & mask;
> >
> >  unlock:
> >         mutex_unlock(&rsb->lock);
> > --
> > 2.25.1
> >
