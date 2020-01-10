Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4888BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6232082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgAJWiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:38:11 -0500
Received: from krieglstein.org ([188.68.35.71]:51270 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgAJWiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:38:11 -0500
Received: from hydra.localnet (p57B137CD.dip0.t-ipconnect.de [87.177.55.205])
        by krieglstein.org (Postfix) with ESMTPSA id 3E0B14021A;
        Fri, 10 Jan 2020 23:38:08 +0100 (CET)
From:   Tim Sander <tim@krieglstein.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtd raw nand denali.c broken for Intel/Altera Cyclone V
Date:   Fri, 10 Jan 2020 23:38:07 +0100
Message-ID: <2585494.6OhLyxUeiZ@hydra>
In-Reply-To: <CAK7LNAQOCoJC0RzOhTEofHdR+zU5sQTxV-t4nERBExW1ddW5hw@mail.gmail.com>
References: <5143724.5TqzkYX0oI@dabox> <2827587.laNcgWlGab@dabox> <CAK7LNAQOCoJC0RzOhTEofHdR+zU5sQTxV-t4nERBExW1ddW5hw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Am Freitag, 10. Januar 2020, 20:05:20 CET schrieb Masahiro Yamada:
> On Sat, Jan 11, 2020 at 1:47 AM Tim Sander <tim@krieglstein.org> wrote:
> > Hi Masahiro Yamada
> > 
> > Sorry for the large delay. I have seen the patches at
> > https://lists.infradead.org/pipermail/linux-mtd/2019-December/092852.html
> > Seem to resolve the question about the spare_area_skip_bytes register.
> > 
> > I have now set the register to 2 which seems to be the right choice on an
> > Intel SocFPGA. But still i am out of luck trying to boot 5.4.5-rt3 or
> > 5.5-rc5. I get the following messages during bootup booting:
> > [    1.825590] denali-nand-dt ff900000.nand: timeout while waiting for irq
> > 0x1000 [    1.832936] denali-nand-dt: probe of ff900000.nand failed with
> > error -5
> > 
> > But the commit c19e31d0a32dd 2017-06-13 22:45:38 predates the 4.19 kernel
> > release (Mon Oct 22 07:37:37 2018). So it seems there is not an obvious
> > commit which is causing the problem. Looking at the changes it might be
> > that the timing calculations in the driver changed which might also lead
> > to a similar error.
> > 
> > I am booting via NFS the bootloader is placed in NOR flash.  The
> > corresponding> 
> > nand dts entry is updated to the new format and looks like this:
> >                 nand@ff900000 {
> >                 
> >                         #address-cells = <0x1>;
> >                         #size-cells = <0x0>;
> >                         compatible = "altr,socfpga-denali-nand";
> >                         reg = <0xff900000 0x100000 0xffb80000 0x10000>;
> >                         reg-names = "nand_data", "denali_reg";
> >                         interrupts = <0x0 0x90 0x4>;
> >                         clocks = <0x2d 0x1e 0x2e>;
> >                         clock-names = "nand", "nand_x", "ecc";
> >                         resets = <0x6 0x24>;
> >                         status = "okay";
> >                         nand@0 {
> >                         
> >                                 reg = <0x0>;
> >                                 #address-cells = <0x1>;
> >                                 #size-cells = <0x1>;
> >                                 partition@0 {
> >                                 
> >                                         label = "work";
> >                                         reg = <0x0 0x10000000>;
> >                                 
> >                                 };
> >                         
> >                         };
> >                 
> >                 };
> > 
> > The last kernel i am able to boot is 4.19.10. I have tried booting:
> > 5.1.21, 5.2.9, 5.3-rc8, 5.4.5-rt3 and 5.5-rc5. They all failed.
> > Unfortunately the range is quite large for bisecting the problem. It also
> > occurred to me that all the platforms with Intel Cyclone V in mainline
> > are development boards which boot from SD-card not exhibiting this
> > problem on their default boot path.
> What will happen if you apply all of these:
> 
> http://patchwork.ozlabs.org/project/linux-mtd/list/?series=149821
I have applied this patch set but it does not help completely. The timings are 
wrong. I don't have access to the hardware now but one thing i tested before i
left (the HW) was to write the NAND timings from the bootloader into the 
denali controller after the driver configured the timings in denali_init. 
After that the driver worked again for me. 

> on top of the mainline kernel,
> and then, hack denali->clk_rate and denali->clk_x_rate as follows?
> 
> 
> -       denali->clk_rate = clk_get_rate(dt->clk);
> -       denali->clk_x_rate = clk_get_rate(dt->clk_x);
> +       denali->clk_rate = 50000000;
> +       denali->clk_x_rate = 200000000;
> 
> If it still fails, what about this?
> 
>        denali->clk_rate = 0;
>        denali->clk_x_rate = 0;
Will try the above next week. Skimming over the socfpga.dtsi it seems as if 
on the Intel SocFPGA the OSC1 has a value of 25000000 set in 
socfpga_cyclone5.dtsi (I am currently not sure about the clock tree with all 
the plls and i am missing the value of osc2?). Also right now it seems i am to 
tired to parse denali_setup_data_interface...
 
> > PS: Here is some snippet from an older mail i didn't sent to the list yet
> > which might be superseded by now:
> > To get into this matter i started reading the "Intel Cyclone V HPS TRM"
> > Section 13-20 Preserving Bad Block Markers:
> > "You can configure the NAND flash controller to skip over a specified
> > number of bytes when it writes the last sector in a page to the spare
> > area. This option write the desired offset to the spare_area_skip_bytes
> > register in the config group. For example, if the device page size is 2
> > KB, and the device area, set the spare_area_skip_bytes register to 2.
> > When the flash controller writes the last sector of the page that
> > overlaps with the spare area, it spare_area_skip_bytes must be an even
> > number. For example, if the bad block marker is a single byte, set
> > spare_area_skip_bytes to 2."
> 
> I did not know this documentation.
> 
> It says "For example" (twice),
> it sounds uncertain to me, though.
> 
> Anyway, an intel engineer checked the boot ROM code.
> SPARE_AREA_SKIP_BYTES=2 is correct, he said.
As far as i understand the documentation it must be a multiple of 2. The most 
nand flashes i know need one byte for bad block marking so 2 seems to be a 
pretty sane value. The explanation why default value of 
spare_area_skip_bytes=0 of the boot rom is a little unfortunate is also in the 
documentation: The fact that the ECC values might spill into the spare area 
where the bad block marker of the nand is located.

Best regards
Tim





