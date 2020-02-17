Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D5BC2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241422064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgBQIF0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:05:26 -0500
Received: from twhmllg4.macronix.com ([211.75.127.132]:23339 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgBQIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:05:25 -0500
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 01H85KGV065118;
        Mon, 17 Feb 2020 16:05:20 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 9F2C7D893E53A71B2A1F;
        Mon, 17 Feb 2020 16:05:20 +0800 (CST)
In-Reply-To: <20200109174159.1737067f@xps13>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>  <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw> <20200109174159.1737067f@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific lock/unlock
 operatoin
MIME-Version: 1.0
X-KeepSent: EFE7D559:94EF04D5-48258511:002C29D3;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFEFE7D559.94EF04D5-ON48258511.002C29D3-48258511.002C6EEC@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 17 Feb 2020 16:05:19 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/02/17 PM 04:05:20,
        Serialize complete at 2020/02/17 PM 04:05:20
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG4.macronix.com 01H85KGV065118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,


> >  /* Set default functions */
> >  static void nand_set_defaults(struct nand_chip *chip)
> >  {
> > @@ -5782,8 +5810,8 @@ static int nand_scan_tail(struct nand_chip 
*chip)
> >     mtd->_read_oob = nand_read_oob;
> >     mtd->_write_oob = nand_write_oob;
> >     mtd->_sync = nand_sync;
> > -   mtd->_lock = NULL;
> > -   mtd->_unlock = NULL;
> > +   mtd->_lock = nand_lock;
> > +   mtd->_unlock = nand_unlock;
> >     mtd->_suspend = nand_suspend;
> >     mtd->_resume = nand_resume;
> >     mtd->_reboot = nand_shutdown;
> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > index 4ab9bcc..2430ecd 100644
> > --- a/include/linux/mtd/rawnand.h
> > +++ b/include/linux/mtd/rawnand.h
> > @@ -1136,6 +1136,9 @@ struct nand_chip {
> >        const struct nand_manufacturer *desc;
> >        void *priv;
> >     } manufacturer;
> > +
> > +   int (*_lock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> > +   int (*_unlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> 
> Kernel documentation is missing here.
> 
> Also please fix kbuildtest robot warnings.

okay, will fix both !

> 
> With all this done, please add my:
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Thanks,
> Miquèl

thanks for your time & comments.
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

