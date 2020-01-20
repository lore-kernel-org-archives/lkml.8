Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51B5C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D06207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgATJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:30:07 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:19761 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgATJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:30:07 -0500
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 00K9SWMX073874;
        Mon, 20 Jan 2020 17:28:32 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 6B1B2630C9CB4D990834;
        Mon, 20 Jan 2020 17:28:33 +0800 (CST)
In-Reply-To: <20200117101346.3611dc0a@xps13>
References: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw> <1571902807-10388-2-git-send-email-masonccyang@mxic.com.tw>
        <20200109172816.6c1d7be7@xps13> <OFECBDB130.03AD44B7-ON482584F2.002B40F2-482584F2.002B720F@mxic.com.tw> <20200117101346.3611dc0a@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add support for Macronix NAND randomizer
MIME-Version: 1.0
X-KeepSent: 1377603E:0BE29BC1-482584F5:00335731;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF1377603E.0BE29BC1-ON482584F5.00335731-482584F5.00340DE4@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 20 Jan 2020 17:28:35 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/01/20 PM 05:28:33,
        Serialize complete at 2020/01/20 PM 05:28:33
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 00K9SWMX073874
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > > > +}
> > > > +
> > > >  static void macronix_nand_onfi_init(struct nand_chip *chip)
> > > >  {
> > > >     struct nand_parameters *p = &chip->parameters;
> > > >     struct nand_onfi_vendor_macronix *mxic;
> > > > +   struct device_node *dn = nand_get_flash_node(chip);
> > > > +   int rand_otp = 0;
> > > > +   int ret;
> > > > 
> > > >     if (!p->onfi)
> > > >        return;
> > > > 
> > > > +   if (of_find_property(dn, "mxic,enable-randomizer-otp", NULL))
> > > > +      rand_otp = 1;
> > > > +
> > > >     mxic = (struct nand_onfi_vendor_macronix *)p->onfi->vendor;
> > > > +   /* Subpage write is prohibited in randomizer operatoin */ 
> > > 
> > >                                        with          operation
> > > 
> > > > +   if (rand_otp && chip->options & NAND_NO_SUBPAGE_WRITE &&
> > > > +       mxic->reliability_func & MACRONIX_RANDOMIZER_BIT) {
> > > > +      if (p->supports_set_get_features) {
> > > > +         bitmap_set(p->set_feature_list,
> > > > +               ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> > > > +         bitmap_set(p->get_feature_list,
> > > > +               ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> > > > +         ret = macronix_nand_randomizer_check_enable(chip);
> > > > +         if (ret < 0)
> > > > +            pr_info("Macronix NAND randomizer failed\n");
> > > > +         else
> > > > +            pr_info("Macronix NAND randomizer enabled\n"); 
> > > 
> > > Maybe we should update the bitmaps only if it succeeds? 
> > 
> > okay, will drop pr_info();
> 
> It's not my point, you can keep the pr_info, I just say that you should
> check ret before updating the bitmap maybe? Otherwise if
> macronix_nand_randomizer_check_enable() fails, you end up without the
> feature but with its bit set in the bitmap.

Driver should set ONFI_FEATURE_ADDR_MXIC_RANDOMIZER in 
p->set/get_feature_list
before calling macronix_nand_randomizer_check_enable() for randomizer 
set/get
feature operation.

I will patch bitmap_clear() if macronix_nand_randomizer_check_enable() 
return fails.

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

