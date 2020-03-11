Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AEAC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5054121D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgCKHnL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:43:11 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50665 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCKHnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:43:10 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D9B991BF20B;
        Wed, 11 Mar 2020 07:43:04 +0000 (UTC)
Date:   Wed, 11 Mar 2020 08:43:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        allison@lohutok.net, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        rfontana@redhat.com, richard@nod.at, s.hauer@pengutronix.de,
        stefan@agner.ch, tglx@linutronix.de, vigneshr@ti.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH v3 3/4] mtd: rawnand: Add support manufacturer specific
 suspend/resume operation
Message-ID: <20200311084304.580bec79@xps13>
In-Reply-To: <OF5C883176.AD73134D-ON48258528.000F5185-48258528.001F3544@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
        <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw>
        <20200310203310.5fe74c57@collabora.com>
        <OF5C883176.AD73134D-ON48258528.000F5185-48258528.001F3544@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Wed, 11 Mar 2020 13:40:52 +0800:

> Hi Boris,
> 
> > > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > > index bc2fa3c..c0055ed 100644
> > > --- a/include/linux/mtd/rawnand.h
> > > +++ b/include/linux/mtd/rawnand.h
> > > @@ -1064,6 +1064,8 @@ struct nand_legacy {
> > >   * @lock:      lock protecting the suspended field. Also used to
> > >   *         serialize accesses to the NAND device.
> > >   * @suspended:      set to 1 when the device is suspended, 0 when   
> it's not.
> > > + * @_suspend:      [REPLACEABLE] specific NAND device suspend   
> operation
> > > + * @_resume:      [REPLACEABLE] specific NAND device resume operation
> > >   * @bbt:      [INTERN] bad block table pointer
> > >   * @bbt_td:      [REPLACEABLE] bad block table descriptor for flash
> > >   *         lookup.
> > > @@ -1119,6 +1121,8 @@ struct nand_chip {
> > > 
> > >     struct mutex lock;
> > >     unsigned int suspended : 1;
> > > +   int (*_suspend)(struct nand_chip *chip);
> > > +   void (*_resume)(struct nand_chip *chip);  
> > 
> > I thought we agreed on not prefixing new hooks with _ ?  
> 
> For [PATCH v2] series, you mentioned to drop the _ prefix 
> of _lock/_unlock only and we finally patched to lock_area/unlock_area.
> 

I missed this _, this is not something we want to add.

Also, when applying your patches I had several issues because they
where not base on the last -rc1.

Finally, I think I forgot a line when patching manually so it produces
a warning now.

I am dropping patch 3 and 4, I keep patch 1 and 2 which seem fine.

Please send a rebased and edited v4 for these, don't forget to drop the
kbuildtest robot tag and please also follow these slightly edited
commit logs:

2/4

    mtd: rawnand: Add support for manufacturer specific suspend/resume operation
    
    Patch nand_suspend() & nand_resume() to let manufacturers overwrite
    suspend/resume operations.

3/4

    mtd: rawnand: macronix: Add support for deep power down mode
    
    Macronix AD series support deep power down mode for a minimum
    power consumption state.
    
    Overlaod nand_suspend() & nand_resume() in Macronix specific code to
    support deep power down mode.

Thanks,
Miquèl
