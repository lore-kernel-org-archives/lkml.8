Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EBDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F22206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDVCRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:17:43 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:52877 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVCRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:17:42 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 03M2GmYg076103;
        Wed, 22 Apr 2020 10:16:48 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id AE49095BC791A1749798;
        Wed, 22 Apr 2020 10:16:48 +0800 (CST)
In-Reply-To: <3097723.HxHl8gbcWJ@192.168.0.120>
References: <1586163611-4565-1-git-send-email-masonccyang@mxic.com.tw> <1586163611-4565-3-git-send-email-masonccyang@mxic.com.tw> <3097723.HxHl8gbcWJ@192.168.0.120>
To:     <Tudor.Ambarus@microchip.com>
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH 2/2] mtd: spi-nor: macronix: Add mx25u51245g support
MIME-Version: 1.0
X-KeepSent: 415076FF:CD74781E-48258552:000C02E7;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF415076FF.CD74781E-ON48258552.000C02E7-48258552.000C8626@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 22 Apr 2020 10:16:48 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/04/22 AM 10:16:48,
        Serialize complete at 2020/04/22 AM 10:16:48
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 03M2GmYg076103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Tudor,

> On Monday, April 6, 2020 12:00:11 PM EEST Mason Yang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know 
the
> > content is safe
> > 
> > mx25u51245g is a mass production for new design and
> > replace mx66u51235f(phase out).
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  drivers/mtd/spi-nor/macronix.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/macronix.c 
b/drivers/mtd/spi-nor/macronix.c
> > index c864ac8..e685aec 100644
> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -73,6 +73,9 @@
> >         { "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024,
> >                               SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> >                               SPI_NOR_4B_OPCODES) },
> > +       { "mx25u51245g", INFO(0xc2253a, 0, 64 * 1024, 1024,
> 
> Shouldn't the ID be 0xc2953a?

no! 
it's 0xc2253a

please refer to Macronix website
https://www.macronix.com/zh-tw/products/NOR-Flash/Serial-NOR-Flash/Pages/spec.aspx?p=MX25U51245G&m=Serial%20NOR%20Flash&n=PM2244 


> 
> We usually don't add new flashes if they are not tested. Please specify 
in the 
> commit message with which controller you tested the flash. Please do the 
same 
> for the previous patch.

okay.

> 
> The minimal test is a read, erase, read back, write and read back. This 
> sequence should verify if read, erase and pp work fine.

sure.

> 
> Cheers,
> ta
> 

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

