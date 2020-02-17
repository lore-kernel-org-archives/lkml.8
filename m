Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B66C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B502064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgBQJWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:22:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgBQJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:22:36 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0897F28BDB9;
        Mon, 17 Feb 2020 09:22:34 +0000 (GMT)
Date:   Mon, 17 Feb 2020 10:22:30 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     masonccyang@mxic.com.tw, bbrezillon@kernel.org,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific
 lock/unlock operatoin
Message-ID: <20200217102230.5dfd36e3@collabora.com>
In-Reply-To: <20200217100124.6ff71191@xps13>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
        <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
        <20200109203055.2370a358@collabora.com>
        <OF505D0437.0130F15A-ON48258511.002C7F75-48258511.002D4341@mxic.com.tw>
        <20200217100124.6ff71191@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 10:01:24 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Mason,
> 
> masonccyang@mxic.com.tw wrote on Mon, 17 Feb 2020 16:14:23 +0800:
> 
> > Hi Boris,
> >   
> > >     
> > > >  /* Set default functions */
> > > >  static void nand_set_defaults(struct nand_chip *chip)
> > > >  {
> > > > @@ -5782,8 +5810,8 @@ static int nand_scan_tail(struct nand_chip     
> > *chip)  
> > > >     mtd->_read_oob = nand_read_oob;
> > > >     mtd->_write_oob = nand_write_oob;
> > > >     mtd->_sync = nand_sync;
> > > > -   mtd->_lock = NULL;
> > > > -   mtd->_unlock = NULL;
> > > > +   mtd->_lock = nand_lock;
> > > > +   mtd->_unlock = nand_unlock;
> > > >     mtd->_suspend = nand_suspend;
> > > >     mtd->_resume = nand_resume;
> > > >     mtd->_reboot = nand_shutdown;
> > > > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > > > index 4ab9bcc..2430ecd 100644
> > > > --- a/include/linux/mtd/rawnand.h
> > > > +++ b/include/linux/mtd/rawnand.h
> > > > @@ -1136,6 +1136,9 @@ struct nand_chip {
> > > >        const struct nand_manufacturer *desc;
> > > >        void *priv;
> > > >     } manufacturer;
> > > > +
> > > > +   int (*_lock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> > > > +   int (*_unlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);    
> > > 
> > > Please drop this _ prefix.    
> > 
> > Drop _ prefix of _lock will get compile error due to there is already 
> > defined "struct mutex lock" in struct nand_chip.  
> 
> Right!

Or maybe move all hooks to a sub-struct (struct nand_chip_ops ops). I
had planned to do that in my nand_chip_legacy refactor but never did, so
maybe now is a good time.

> 
> > 
> > What about keep this _ prefix or patch it to blocklock/blockunlock,
> > i.e.,
> > int (*blocklock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> > int (*blockunlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);  
> 
> What about lock_area() unlock_area() ? Seems more accurate to me, tell
> me if I'm wrong.

Yep, definitely better.
