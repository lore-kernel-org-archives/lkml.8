Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F3C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA8B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgAQJNy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:13:54 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52479 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgAQJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:13:51 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0B6A9FF80F;
        Fri, 17 Jan 2020 09:13:46 +0000 (UTC)
Date:   Fri, 17 Jan 2020 10:13:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add support for Macronix NAND
 randomizer
Message-ID: <20200117101346.3611dc0a@xps13>
In-Reply-To: <OFECBDB130.03AD44B7-ON482584F2.002B40F2-482584F2.002B720F@mxic.com.tw>
References: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw>
        <1571902807-10388-2-git-send-email-masonccyang@mxic.com.tw>
        <20200109172816.6c1d7be7@xps13>
        <OFECBDB130.03AD44B7-ON482584F2.002B40F2-482584F2.002B720F@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

> > > +}
> > > +
> > >  static void macronix_nand_onfi_init(struct nand_chip *chip)
> > >  {
> > >     struct nand_parameters *p = &chip->parameters;
> > >     struct nand_onfi_vendor_macronix *mxic;
> > > +   struct device_node *dn = nand_get_flash_node(chip);
> > > +   int rand_otp = 0;
> > > +   int ret;
> > > 
> > >     if (!p->onfi)
> > >        return;
> > > 
> > > +   if (of_find_property(dn, "mxic,enable-randomizer-otp", NULL))
> > > +      rand_otp = 1;
> > > +
> > >     mxic = (struct nand_onfi_vendor_macronix *)p->onfi->vendor;
> > > +   /* Subpage write is prohibited in randomizer operatoin */  
> > 
> >                                        with          operation
> >   
> > > +   if (rand_otp && chip->options & NAND_NO_SUBPAGE_WRITE &&
> > > +       mxic->reliability_func & MACRONIX_RANDOMIZER_BIT) {
> > > +      if (p->supports_set_get_features) {
> > > +         bitmap_set(p->set_feature_list,
> > > +               ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> > > +         bitmap_set(p->get_feature_list,
> > > +               ONFI_FEATURE_ADDR_MXIC_RANDOMIZER, 1);
> > > +         ret = macronix_nand_randomizer_check_enable(chip);
> > > +         if (ret < 0)
> > > +            pr_info("Macronix NAND randomizer failed\n");
> > > +         else
> > > +            pr_info("Macronix NAND randomizer enabled\n");  
> > 
> > Maybe we should update the bitmaps only if it succeeds?  
> 
> okay, will drop pr_info();

It's not my point, you can keep the pr_info, I just say that you should
check ret before updating the bitmap maybe? Otherwise if
macronix_nand_randomizer_check_enable() fails, you end up without the
feature but with its bit set in the bitmap.

Thanks,
Miquèl
