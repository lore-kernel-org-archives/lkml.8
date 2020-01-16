Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1285C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6DC2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgAPIck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:32:40 -0500
Received: from twhmllg4.macronix.com ([211.75.127.132]:33973 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgAPIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:32:40 -0500
X-Greylist: delayed 1321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 03:32:39 EST
Received: from TWHMLLG4.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG4.macronix.com with ESMTP id 00G8AbNj002958
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 16:10:37 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 00G88t5X001519;
        Thu, 16 Jan 2020 16:08:55 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id C7E8CD0B9083E6CB0B56;
        Thu, 16 Jan 2020 16:08:55 +0800 (CST)
In-Reply-To: <20200109175107.57566c18@xps13>
References: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw> <1571902807-10388-2-git-send-email-masonccyang@mxic.com.tw> <20200109175107.57566c18@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add support for Macronix NAND randomizer
MIME-Version: 1.0
X-KeepSent: 1A1B3ABF:C0D61D76-482584F1:002C75E4;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF1A1B3ABF.C0D61D76-ON482584F1.002C75E4-482584F1.002CC310@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Thu, 16 Jan 2020 16:08:56 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/01/16 PM 04:08:55,
        Serialize complete at 2020/01/16 PM 04:08:55
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com 00G88t5X001519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,


> >  drivers/mtd/nand/raw/nand_macronix.c | 69 
++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_macronix.c 
b/drivers/mtd/nand/raw/
> nand_macronix.c
> > index 58511ae..89101fa 100644
> > --- a/drivers/mtd/nand/raw/nand_macronix.c
> > +++ b/drivers/mtd/nand/raw/nand_macronix.c
> > @@ -11,6 +11,14 @@
> >  #define MACRONIX_READ_RETRY_BIT BIT(0)
> >  #define MACRONIX_NUM_READ_RETRY_MODES 6
> > 
> > +#define MACRONIX_RANDOMIZER_BIT BIT(1)
> > +#define ONFI_FEATURE_ADDR_MXIC_RANDOMIZER 0xB0
> > +#define ENPGM BIT(0)
> > +#define RANDEN BIT(1)
> > +#define RANDOPT BIT(2)
> 
> I forgot: please be consistent with the naming.

okay, will fix them to

#define MACRONIX_RANDOMIZER_ENPGM BIT(0)
#define MACRONIX_RANDOMIZER_RANDEN BIT(1)
#define MACRONIX_RANDOMIZER_RANDOPT BIT(2)

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

