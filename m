Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9915DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4A5206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgFOHT3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:19:29 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37361 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgFOHT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:19:29 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3BDC51C0015;
        Mon, 15 Jun 2020 07:19:25 +0000 (UTC)
Date:   Mon, 15 Jun 2020 09:19:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: rawnand: brcmnand: Ecc error handling on EDU
 transfers
Message-ID: <20200615091923.0c3c7aa7@xps13>
In-Reply-To: <CAC=U0a1oLPs_=SgUTxYPxiW8JpQXOpz-RbL2KrgzDjutt1v0mQ@mail.gmail.com>
References: <20200611054454.2547-1-kdasu.kdev@gmail.com>
        <20200611054454.2547-2-kdasu.kdev@gmail.com>
        <20200611092707.75da8c6a@xps13>
        <CAC=U0a3RXScu12LkU+hCv_5Lp_he92ExRFSgqLkwx40D6Xtrag@mail.gmail.com>
        <20200612090728.043b6baf@xps13>
        <CAC=U0a1oLPs_=SgUTxYPxiW8JpQXOpz-RbL2KrgzDjutt1v0mQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Fri, 12 Jun 2020 12:34:22
-0400:

> On Fri, Jun 12, 2020 at 3:07 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Kamal,
> >
> > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 12:04:29
> > -0400:
> >  
> > > On Thu, Jun 11, 2020 at 3:27 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > > >
> > > > Hi Kamal,
> > > >
> > > > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44:54
> > > > -0400:
> > > >  
> > > > > Implemented ECC correctable and uncorrectable error handling for EDU  
> > > >
> > > > Implement?
> > > >  
> > > > > reads. If ECC correctable bitflips are encountered  on EDU transfer,  
> > > >
> > > > extra space                                         ^
> > > >  
> > > > > read page again using pio, This is needed due to a controller lmitation  
> > > >
> > > > s/pio/PIO/
> > > >  
> > > > > where read and corrected data is not transferred to the DMA buffer on ECC
> > > > > errors. This holds true for ECC correctable errors beyond set threshold.  
> > > >
> > > > error.
> > > >
> > > > Not sure what the last sentence means?
> > > >  
> > >
> > > NAND controller allows for setting a correctable  ECC threshold number
> > > of bits beyond which it will actually report the error to the driver.
> > > e.g. for BCH-4 the threshold is 3, so 3-bit and 4-bit errors will
> > > generate correctable ECC interrupt however 1-bit and 2-bit errors will
> > > be corrected silently.
> > > From the above example EDU hardware will not transfer corrected data
> > > to the DMA buffer for 3-bit and 4-bit errors that get reported. So
> > > once we detect
> > > the error duing EDU we read the page again using pio.  
> >
> > Ok I see what you mean, can't you fake the threshold instead? The NAND
> > controller in Linux is not supposed to handle this threshold, the NAND
> > core is in charge. So what the controller driver should do is just:
> > increase the number of bitflips + return the maximum number or bitflip
> > or increase the failure counter. Is this already the case?
> >  
> /* threshold = ceil(BCH-level * 0.75) */
> brcmnand_wr_corr_thresh(host, DIV_ROUND_UP(chip->ecc.strength * 3, 4));
> This how the threshold is set, all it means is that for high BCH
> levels don't interrupt on low number (less than threshold) of
> bit_flips. Yes the controller driver only increments correctable ECC
> count. But due the EDU design an EDU operation is disrupted when the
> controller interrupts on correctable ECC errors during subpage ECC
> calculations. Hence the driver needs to read the page again with PIO
> to transfer corrected data.

IIUC, you are doing the job twice: you should just return a number of
bitflips or an error to the NAND core. So that's why I'm telling that
you should get rid of this threshold. It would avoid the need for the
PIO transfer too.

You also say that the controller "only increments correctable ECC
count", what do you mean exactly? The controller does not report errors
when the number of bitflips happens to be above the BCH threshold? This
would be the only case where what is currently done would be actually
needed though.

Thanks,
Miquèl
