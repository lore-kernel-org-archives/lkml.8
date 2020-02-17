Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C3BC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85E820718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgBQJBb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:01:31 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41611 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgBQJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:01:31 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E71E8FF80E;
        Mon, 17 Feb 2020 09:01:24 +0000 (UTC)
Date:   Mon, 17 Feb 2020 10:01:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific
 lock/unlock operatoin
Message-ID: <20200217100124.6ff71191@xps13>
In-Reply-To: <OF505D0437.0130F15A-ON48258511.002C7F75-48258511.002D4341@mxic.com.tw>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
        <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
        <20200109203055.2370a358@collabora.com>
        <OF505D0437.0130F15A-ON48258511.002C7F75-48258511.002D4341@mxic.com.tw>
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

masonccyang@mxic.com.tw wrote on Mon, 17 Feb 2020 16:14:23 +0800:

> Hi Boris,
> 
> >   
> > >  /* Set default functions */
> > >  static void nand_set_defaults(struct nand_chip *chip)
> > >  {
> > > @@ -5782,8 +5810,8 @@ static int nand_scan_tail(struct nand_chip   
> *chip)
> > >     mtd->_read_oob = nand_read_oob;
> > >     mtd->_write_oob = nand_write_oob;
> > >     mtd->_sync = nand_sync;
> > > -   mtd->_lock = NULL;
> > > -   mtd->_unlock = NULL;
> > > +   mtd->_lock = nand_lock;
> > > +   mtd->_unlock = nand_unlock;
> > >     mtd->_suspend = nand_suspend;
> > >     mtd->_resume = nand_resume;
> > >     mtd->_reboot = nand_shutdown;
> > > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > > index 4ab9bcc..2430ecd 100644
> > > --- a/include/linux/mtd/rawnand.h
> > > +++ b/include/linux/mtd/rawnand.h
> > > @@ -1136,6 +1136,9 @@ struct nand_chip {
> > >        const struct nand_manufacturer *desc;
> > >        void *priv;
> > >     } manufacturer;
> > > +
> > > +   int (*_lock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> > > +   int (*_unlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);  
> > 
> > Please drop this _ prefix.  
> 
> Drop _ prefix of _lock will get compile error due to there is already 
> defined "struct mutex lock" in struct nand_chip.

Right!

> 
> What about keep this _ prefix or patch it to blocklock/blockunlock,
> i.e.,
> int (*blocklock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> int (*blockunlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);

What about lock_area() unlock_area() ? Seems more accurate to me, tell
me if I'm wrong.

>  
> 
> thanks for your time & comments.
> Mason

Thanks,
Miquèl
