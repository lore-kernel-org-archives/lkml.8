Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E95C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19600206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgD0RdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:33:06 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:53156 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgD0RdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:33:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1D04C1802915B;
        Mon, 27 Apr 2020 17:33:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hot35_721b618e1162e
X-Filterd-Recvd-Size: 4856
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 17:33:04 +0000 (UTC)
Message-ID: <e2c8b5ea654600ac36949f8f0621913ceaf96ddc.camel@perches.com>
Subject: Re: [RFC PATCH] mtd: lpddr: Fix bad logic in print_drs_error
From:   Joe Perches <joe@perches.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Apr 2020 10:33:02 -0700
In-Reply-To: <20200427152913.47a48b46@xps13>
References: <2e19547dcec386b47923211896f43053b60ebc60.camel@perches.com>
         <20200427152913.47a48b46@xps13>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 15:29 +0200, Miquel Raynal wrote:
> Hi Joe,

Hello Miquel.

> Joe Perches <joe@perches.com> wrote on Mon, 30 Mar 2020 12:56:59 -0700:
> 
> > Update logic for broken test.
> > Use a more common logging style.
> > 
> > Miscellanea:
> > 
> > o Coalesce formats
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > Found by inspection of include files using printk.
> > 
> > It appears the logic in this function is broken for the
> > consecutive tests of
> > 
> > 	if (prog_status & 0x3)
> > 		...
> > 	else if (prog_status & 0x2)
> > 		...
> > 	else (prog_status & 0x1)
> > 		...
> > 
> > Likely the first test should be
> > 
> > 	if ((prog_status & 0x3) == 0x3)
> 
> I had a hard time understanding the patch just with the commit log, I
> think the above text is as important.
> 
> In fact, would you mind doing the printk->pr_notice in a first patch,
> and fix the wrong condition in a separate change?
> 
> > And this function is only used in drivers/mtd/lpddr/lpddr_cmds.c
> > perhaps it should be moved there.
> 
> Agreed, do not hesitate to move the function as suggested in a third
> patch.

You are the maintainer here no?

I think you (or perhaps the author Alexey Korolev but he hasn't
been active in a decade) should be doing all this.

I just identified the logic defect.

> >  include/linux/mtd/pfow.h | 31 ++++++++++++++-----------------
> >  1 file changed, 14 insertions(+), 17 deletions(-)
> > 
> > diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
> > index 122f343..1c08e75 100644
> > --- a/include/linux/mtd/pfow.h
> > +++ b/include/linux/mtd/pfow.h
> > @@ -127,31 +127,28 @@ static inline void print_drs_error(unsigned dsr)
> >  	int prog_status = (dsr & DSR_RPS) >> 8;
> >  
> >  	if (!(dsr & DSR_AVAILABLE))
> > -		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
> > -	if (prog_status & 0x03)
> > -		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
> > -						"half with 41h command\n");
> > +		pr_notice("DSR.15: (0) Device not Available\n");
> > +
> > +	if ((prog_status & 0x03) == 0x03)
> > +		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
> >  	else if (prog_status & 0x02)
> > -		printk(KERN_NOTICE"DSR.9,8: (10) Object Mode Program attempt "
> > -					"in region with Control Mode data\n");
> > +		pr_notice("DSR.9,8: (10) Object Mode Program attempt in region with Control Mode data\n");
> >  	else if (prog_status &  0x01)
> > -		printk(KERN_NOTICE"DSR.9,8: (01) Program attempt in region "
> > -						"with Object Mode data\n");
> > +		pr_notice("DSR.9,8: (01) Program attempt in region with Object Mode data\n");
> > +
> >  	if (!(dsr & DSR_READY_STATUS))
> > -		printk(KERN_NOTICE"DSR.7: (0) Device is Busy\n");
> > +		pr_notice("DSR.7: (0) Device is Busy\n");
> >  	if (dsr & DSR_ESS)
> > -		printk(KERN_NOTICE"DSR.6: (1) Erase Suspended\n");
> > +		pr_notice("DSR.6: (1) Erase Suspended\n");
> >  	if (dsr & DSR_ERASE_STATUS)
> > -		printk(KERN_NOTICE"DSR.5: (1) Erase/Blank check error\n");
> > +		pr_notice("DSR.5: (1) Erase/Blank check error\n");
> >  	if (dsr & DSR_PROGRAM_STATUS)
> > -		printk(KERN_NOTICE"DSR.4: (1) Program Error\n");
> > +		pr_notice("DSR.4: (1) Program Error\n");
> >  	if (dsr & DSR_VPPS)
> > -		printk(KERN_NOTICE"DSR.3: (1) Vpp low detect, operation "
> > -					"aborted\n");
> > +		pr_notice("DSR.3: (1) Vpp low detect, operation aborted\n");
> >  	if (dsr & DSR_PSS)
> > -		printk(KERN_NOTICE"DSR.2: (1) Program suspended\n");
> > +		pr_notice("DSR.2: (1) Program suspended\n");
> >  	if (dsr & DSR_DPS)
> > -		printk(KERN_NOTICE"DSR.1: (1) Aborted Erase/Program attempt "
> > -					"on locked block\n");
> > +		pr_notice("DSR.1: (1) Aborted Erase/Program attempt on locked block\n");
> >  }
> >  #endif /* __LINUX_MTD_PFOW_H */
> > 
> > 
> 
> Thanks,
> Miquèl

