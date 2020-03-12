Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88786C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 01:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A611320739
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 01:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbgCLB5B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 21:57:01 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:61404 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbgCLB5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 21:57:01 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 02C1tnkR070601;
        Thu, 12 Mar 2020 09:55:49 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 4AE79B81C5CC582C2882;
        Thu, 12 Mar 2020 09:55:49 +0800 (CST)
In-Reply-To: <20200311084541.28ff4829@xps13>
References: <1581922600-25461-1-git-send-email-masonccyang@mxic.com.tw> <1581922600-25461-3-git-send-email-masonccyang@mxic.com.tw> <20200311084541.28ff4829@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     allison@lohutok.net, devicetree@vger.kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        mark.rutland@arm.com, richard@nod.at, robh+dt@kernel.org,
        tglx@linutronix.de, vigneshr@ti.com, yuehaibing@huawei.com
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: Document Macronix NAND device bindings
MIME-Version: 1.0
X-KeepSent: E7ABBA9B:10FD1630-48258529:000A8752;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFE7ABBA9B.10FD1630-ON48258529.000A8752-48258529.000A9A80@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Thu, 12 Mar 2020 09:55:49 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/03/12 AM 09:55:49,
        Serialize complete at 2020/03/12 AM 09:55:49
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG4.macronix.com 02C1tnkR070601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,
 
> Mason Yang <masonccyang@mxic.com.tw> wrote on Mon, 17 Feb 2020 14:56:40
> +0800:
> 
> > Document the bindings used by the Macronix NAND device.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/mtd/nand-macronix.txt      | 28 
++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 
Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt 
b/
> Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > new file mode 100644
> > index 0000000..1d7a895
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > @@ -0,0 +1,28 @@
> > +Macronix NANDs Device Tree Bindings
> > +-----------------------------------
> > +
> > +Macronix NANDs support randomizer operation for user data scrambled,
> > +which can be enabled with a SET_FEATURE. The penalty of randomizer 
are
> > +subpage accesses prohibited and more time period is needed in program
> > +operation, i.e., tPROG 300us to 340us(randomizer enabled).
> > +Randomizer enabled is a one time persistent and non reversible 
operatoin.
> > +
> > +For more high-reliability concern, if subpage write not available 
with
> > +hardware ECC and filesystem and then to enable randomizer is 
recommended
> > +by default.
> > +
> > +By adding a new specific property in children nodes to enable
> > +randomizer function.
> 
> I also reworded slightly this text when applying.

ok,sure.

> 
> 
> Thanks,
> Miquèl

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

