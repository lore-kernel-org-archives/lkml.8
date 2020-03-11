Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FC5C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AF7205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgCKFlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:41:02 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:35152 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgCKFlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:41:02 -0400
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 02B5eqqO017241;
        Wed, 11 Mar 2020 13:40:52 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 5E352C261D4C595B36D3;
        Wed, 11 Mar 2020 13:40:52 +0800 (CST)
In-Reply-To: <20200310203310.5fe74c57@collabora.com>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw> <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw> <20200310203310.5fe74c57@collabora.com>
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
X-KeepSent: 5C883176:AD73134D-48258528:000F5185;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF5C883176.AD73134D-ON48258528.000F5185-48258528.001F3544@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 11 Mar 2020 13:40:52 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/03/11 PM 01:40:52,
        Serialize complete at 2020/03/11 PM 01:40:52
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com 02B5eqqO017241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > index bc2fa3c..c0055ed 100644
> > --- a/include/linux/mtd/rawnand.h
> > +++ b/include/linux/mtd/rawnand.h
> > @@ -1064,6 +1064,8 @@ struct nand_legacy {
> >   * @lock:      lock protecting the suspended field. Also used to
> >   *         serialize accesses to the NAND device.
> >   * @suspended:      set to 1 when the device is suspended, 0 when 
it's not.
> > + * @_suspend:      [REPLACEABLE] specific NAND device suspend 
operation
> > + * @_resume:      [REPLACEABLE] specific NAND device resume operation
> >   * @bbt:      [INTERN] bad block table pointer
> >   * @bbt_td:      [REPLACEABLE] bad block table descriptor for flash
> >   *         lookup.
> > @@ -1119,6 +1121,8 @@ struct nand_chip {
> > 
> >     struct mutex lock;
> >     unsigned int suspended : 1;
> > +   int (*_suspend)(struct nand_chip *chip);
> > +   void (*_resume)(struct nand_chip *chip);
> 
> I thought we agreed on not prefixing new hooks with _ ?

For [PATCH v2] series, you mentioned to drop the _ prefix 
of _lock/_unlock only and we finally patched to lock_area/unlock_area.

thanks for your time & review.
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

