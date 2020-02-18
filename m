Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF6C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97369214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBRDNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:13:55 -0500
Received: from twhmllg4.macronix.com ([122.147.135.202]:53060 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgBRDNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:13:54 -0500
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 01I3Dk5L004086;
        Tue, 18 Feb 2020 11:13:46 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id C236F781A13725FAE6CD;
        Tue, 18 Feb 2020 11:13:46 +0800 (CST)
In-Reply-To: <20200217100124.6ff71191@xps13>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>  <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
        <20200109203055.2370a358@collabora.com> <OF505D0437.0130F15A-ON48258511.002C7F75-48258511.002D4341@mxic.com.tw> <20200217100124.6ff71191@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific lock/unlock
 operatoin
MIME-Version: 1.0
X-KeepSent: 888BBBE2:74456DA3-48258512:0011688B;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF888BBBE2.74456DA3-ON48258512.0011688B-48258512.0011BE25@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 18 Feb 2020 11:13:47 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/02/18 AM 11:13:46,
        Serialize complete at 2020/02/18 AM 11:13:46
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com 01I3Dk5L004086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,


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
> > > > diff --git a/include/linux/mtd/rawnand.h 
b/include/linux/mtd/rawnand.h
> > > > index 4ab9bcc..2430ecd 100644
> > > > --- a/include/linux/mtd/rawnand.h
> > > > +++ b/include/linux/mtd/rawnand.h
> > > > @@ -1136,6 +1136,9 @@ struct nand_chip {
> > > >        const struct nand_manufacturer *desc;
> > > >        void *priv;
> > > >     } manufacturer;
> > > > +
> > > > +   int (*_lock)(struct nand_chip *chip, loff_t ofs, uint64_t 
len);
> > > > +   int (*_unlock)(struct nand_chip *chip, loff_t ofs, uint64_t 
len); 
> > > 
> > > Please drop this _ prefix. 
> > 
> > Drop _ prefix of _lock will get compile error due to there is already 
> > defined "struct mutex lock" in struct nand_chip.
> 
> Right!
> 
> > 
> > What about keep this _ prefix or patch it to blocklock/blockunlock,
> > i.e.,
> > int (*blocklock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> > int (*blockunlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> 
> What about lock_area() unlock_area() ? Seems more accurate to me, tell
> me if I'm wrong.

yup, you are right!

Using lock/unlock_area is better, will patch it.

thanks for your comments.
Mason



CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

