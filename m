Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC38C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE06C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgCKGOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:14:02 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:28047 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgCKGOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:14:02 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 02B6DuBs031825;
        Wed, 11 Mar 2020 14:13:56 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 2D98922659A6E991C6EA;
        Wed, 11 Mar 2020 14:13:57 +0800 (CST)
In-Reply-To: <20200310204142.540fc7c4@collabora.com>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw> <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw>
        <20200310203930.2b8c0cfb@collabora.com> <20200310204142.540fc7c4@collabora.com>
To:     "Boris Brezillon" <boris.brezillon@collabora.com>
Cc:     allison@lohutok.net, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, rfontana@redhat.com, richard@nod.at,
        s.hauer@pengutronix.de, stefan@agner.ch, tglx@linutronix.de,
        vigneshr@ti.com, yuehaibing@huawei.com
Subject: Re: [PATCH v3 3/4] mtd: rawnand: Add support manufacturer specific suspend/resume
 operation
MIME-Version: 1.0
X-KeepSent: 4AD2D1A1:2B35FBFA-48258528:0021AD65;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF4AD2D1A1.2B35FBFA-ON48258528.0021AD65-48258528.00223C9B@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 11 Mar 2020 14:13:57 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/03/11 PM 02:13:57,
        Serialize complete at 2020/03/11 PM 02:13:57
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 02B6DuBs031825
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

> > > ---
> > >  drivers/mtd/nand/raw/nand_base.c | 11 ++++++++---
> > >  include/linux/mtd/rawnand.h      |  4 ++++
> > >  2 files changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/nand_base.c 
b/drivers/mtd/nand/raw/nand_base.c
> > > index 769be81..b44e460 100644
> > > --- a/drivers/mtd/nand/raw/nand_base.c
> > > +++ b/drivers/mtd/nand/raw/nand_base.c
> > > @@ -4327,7 +4327,9 @@ static int nand_suspend(struct mtd_info *mtd)
> > >     struct nand_chip *chip = mtd_to_nand(mtd);
> > > 
> > >     mutex_lock(&chip->lock);
> > > -   chip->suspended = 1;
> > > +   if (chip->_suspend)
> > > +      if (!chip->_suspend(chip))
> > > +         chip->suspended = 1;
> 
> Shouldn't you propagate the error to the caller if chip->_suspend()
> fails?

Currently, chip->suspend() just do sending command to nand chip and
I think caller could check chip->suspend = 1 or 0 to know the status
of nand chip.

thanks & best regards,
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

