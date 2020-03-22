Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2334C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5C220722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584899020;
	bh=T7luwSxaSf3Rr3B3mXA/MQD2uHVmk7/7TFB1cpq5Ymg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nHIB8OFyGn5ymL2FBXr89sNduwUCSKTa4RDUr78YiJSAebOVJUYL1Ca7XWAFzs5Ec
	 Or3etAcHeo/23IIOUYHoWCY3fVwFeydYrp+bwbYzqyyUAT43cmI5j//vjE71q7LBQY
	 Vl4+ZBcrUinqoyLv5NsLX0rn3FdRjvM9gz7hPkss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCVRnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:43:39 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33735 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVRni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 13:43:38 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 02MHhOn6003701
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 02:43:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 02MHhOn6003701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584899005;
        bh=5VWidLyAxVr+JeX12AUe51S3Q/Q1o/QNC542fp0/ac0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lELr3M2T1b2z+PTuaN61NmzZA0ZJpltxAm+qO8LVscXqyGM7PDKOQz1ybEPSrRM9k
         w6AdPPZroYYf9yp/T5jE8nmjVRmNyXGOVQXy8Bz+Zg8gKjCe3t/5e7oebKCavPSBJv
         KjAVX+308yXcIg1uqgblfU8Ap1hIH/xxdyZJ+4hnmf4wRZDdlzwYXenCZUOua1caIN
         xwCHTcYk8fkmF9jGn6KgQhTe/kUhuKsKtj1WoYcnhW7PZIY4D9MQZv4u5sSwWIQN9r
         I1eGP6JR4dlyOvEZetdkQY2/YWZBtmkFVV0PpbLXnFommVUdYxYDb0x3Cl56cmLWiW
         mV6H1D7M8bLQQ==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id q8so3160201vka.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 10:43:25 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2xqvu7g6PRCjO7Ed6eVfvxuIdT2gWd8OTf92N2ACu44bGW9hA3
        U00PCi6JbI/Bbf0NI2tWOnf3igSsAQnSpnjaoS0=
X-Google-Smtp-Source: ADFU+vtXZeP+HF7+ab1Tv1t/7gTA17dXviS4+j9NRUv29wPBxhgZ3QGDxW90tubOYkkoQ6EQEQp2se4/+vSsYfbSd/k=
X-Received: by 2002:a1f:3806:: with SMTP id f6mr4073980vka.12.1584899004183;
 Sun, 22 Mar 2020 10:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200316104307.1891-1-yamada.masahiro@socionext.com>
 <20200320181159.5004099f@xps13> <2d02c851-4249-053c-99e9-69b209bffad2@denx.de>
In-Reply-To: <2d02c851-4249-053c-99e9-69b209bffad2@denx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 Mar 2020 02:42:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5_uCmfmxAduMRxnBNzhtCwNR65OJ__AdZsNz2iiNJWA@mail.gmail.com>
Message-ID: <CAK7LNAR5_uCmfmxAduMRxnBNzhtCwNR65OJ__AdZsNz2iiNJWA@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali: add more delays before latching
 incoming data
To:     Marek Vasut <marex@denx.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 2:15 AM Marek Vasut <marex@denx.de> wrote:
>
> On 3/20/20 6:11 PM, Miquel Raynal wrote:
> > Hi Marek,
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Mon, 16 Mar
> > 2020 19:43:07 +0900:
> >
> >> The Denali IP have several registers to specify how many clock cycles
> >> should be waited between falling/rising signals. You can improve the
> >> NAND access performance by programming these registers with optimized
> >> values.
> >>
> >> Because struct nand_sdr_timings represents the device requirement
> >> in pico seconds, denali_setup_data_interface() computes the register
> >> values by dividing the device timings with the clock period.
> >>
> >> Marek Vasut reported this driver in the latest kernel does not work
> >> on his SOCFPGA board. (The on-board NAND chip is mode 5)
> >>
> >> The suspicious parameter is acc_clks, so this commit relaxes it.
> >>
> >> The Denali NAND Flash Memory Controller User's Guide describes this
> >> register as follows:
> >>
> >>   acc_clks
> >>     signifies the number of bus interface clk_x clock cycles,
> >>     controller should wait from read enable going low to sending
> >>     out a strobe of clk_x for capturing of incoming data.
> >>
> >> Currently, acc_clks is calculated only based on tREA, the delay on the
> >> chip side. This does not include additional delays that come from the
> >> data path on the PCB and in the SoC, load capacity of the pins, etc.
> >>
> >> This relatively becomes a big factor on faster timing modes like mode 5.
> >>
> >> Before supporting the ->setup_data_interface() hook (e.g. Linux 4.12),
> >> the Denali driver hacks acc_clks in a couple of ways [1] [2] to support
> >> the timing mode 5.
> >>
> >> We would not go back to the hard-coded acc_clks, but we need to include
> >> this factor into the delay somehow. Let's say the amount of the additional
> >> delay is 10000 pico sec.
> >>
> >> In the new calculation, acc_clks is determined by timings->tREA_max +
> >> data_setup_on_host.
> >>
> >> Also, prolong the RE# low period to make sure the data hold is met.
> >>
> >> Finally, re-center the data latch timing for extra safety.
> >>
> >> [1] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L276
> >> [2] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L282
> >>
> >> Reported-by: Marek Vasut <marex@denx.de>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> ---
> >
> > Can you please give this patch a try and report the result?
>
> It's on my list, don't worry.


Preferably, please test v2.

Thanks.


-- 
Best Regards
Masahiro Yamada
