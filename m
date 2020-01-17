Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1895DC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D312073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgAQIE5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:04:57 -0500
Received: from twhmllg4.macronix.com ([122.147.135.202]:58499 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAQIE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:04:56 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 03:04:56 EST
Received: from TWHMLLG4.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG4.macronix.com with ESMTP id 00H7tiBl090299
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 15:55:44 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 00H7sWnD089113;
        Fri, 17 Jan 2020 15:54:32 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 09849F090BB977A1CEE9;
        Fri, 17 Jan 2020 15:54:33 +0800 (CST)
In-Reply-To: <20200109172816.6c1d7be7@xps13>
References: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw> <1571902807-10388-2-git-send-email-masonccyang@mxic.com.tw> <20200109172816.6c1d7be7@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add support for Macronix NAND randomizer
MIME-Version: 1.0
X-KeepSent: ECBDB130:03AD44B7-482584F2:002B40F2;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFECBDB130.03AD44B7-ON482584F2.002B40F2-482584F2.002B720F@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 17 Jan 2020 15:54:33 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/01/17 PM 03:54:33,
        Serialize complete at 2020/01/17 PM 03:54:33
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG4.macronix.com 00H7sWnD089113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

 
> > +static int macronix_nand_randomizer_check_enable(struct nand_chip 
*chip)
> > +{
> > +   u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
> > +   int ret;
> > +
> > +   ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> > +            feature);
> > +   if (ret < 0)
> > +      return ret;
> > +
> > +   if (feature[0])
> > +      return feature[0];
> > +
> > +   feature[0] = MACRONIX_RANDOMIZER_MODE_ENTER;
> > +   ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> > +            feature);
> > +   if (ret < 0)
> > +      return ret;
> > +
> > +   /* RANDEN and RANDOPT OTP bits are programmed */
> > +   feature[0] = 0x0;
> > +   ret = nand_prog_page_op(chip, 0, 0, feature, 1);
> > +   if (ret < 0)
> > +      return ret;
> > +
> > +   ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> > +            feature);
> > +   if (ret < 0)
> > +      return ret;
> > +
> > +   feature[0] &= MACRONIX_RANDOMIZER_MODE_EXIT;
> > +   ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
> > +            feature);
> > +   if (ret < 0)
> > +      return ret;
> > +
> > +   return feature[0];
> 
> Can feature[0] be != 0 ? I don't think so, in this case I prefer a:
> return 0;
> 

okay, will fix it.

> > +}
> > +
> >  static void macronix_nand_onfi_init(struct nand_chip *chip)
> >  {
> >     struct nand_parameters *p = &chip->parameters;
> >     struct nand_onfi_vendor_macronix *mxic;
> > +   struct device_node *dn = nand_get_flash_node(chip);
> > +   int rand_otp = 0;
> > +   int ret;
> > 
> >     if (!p->onfi)
> >        return;
> > 
> > +   if (of_find_property(dn, "mxic,enable-randomizer-otp", NULL))
> > +      rand_otp = 1;
> > +
> >     mxic = (struct nand_onfi_vendor_macronix *)p->onfi->vendor;
> > +   /* Subpage write is prohibited in randomizer operatoin */
> 
>                                        with          operation
> 
> > +   if (rand_otp && chip->options & NAND_NO_SUBPAGE_WRITE &&
> > +       mxic->reliability_func & MACRONIX_RANDOMIZER_BIT) {
> > +      if (p->supports_set_get_features) {
> > +         bitmap_set(p->set_feature_list,
> > +               ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> > +         bitmap_set(p->get_feature_list,
> > +               ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> > +         ret = macronix_nand_randomizer_check_enable(chip);
> > +         if (ret < 0)
> > +            pr_info("Macronix NAND randomizer failed\n");
> > +         else
> > +            pr_info("Macronix NAND randomizer enabled\n");
> 
> Maybe we should update the bitmaps only if it succeeds?

okay, will drop pr_info();

> 
> > +      }
> > +   }
> > +
> >     if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
> >        return;
> > 
> 
> With the above fixed,
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

