Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C1FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C522B3F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHCGxb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:53:31 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55615 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgHCGxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:53:30 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0E2DCC0002;
        Mon,  3 Aug 2020 06:53:27 +0000 (UTC)
Date:   Mon, 3 Aug 2020 08:53:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] bcm963xx_tag.h: fix duplicated word
Message-ID: <20200803085326.099e608d@xps13>
In-Reply-To: <847e3e46-2fc2-daea-67f3-3aaf0f2af4ac@gmail.com>
References: <d30c09a3-fe30-ddf1-3f21-00fc48b16443@infradead.org>
        <847e3e46-2fc2-daea-67f3-3aaf0f2af4ac@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Florian Fainelli <f.fainelli@gmail.com> wrote on Wed, 15 Jul 2020
19:06:36 -0700:

> Le 2020-07-15 à 18:28, Randy Dunlap a écrit :
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Change doubled word "is" to "it is".
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: bcm-kernel-feedback-list@broadcom.com
> > Cc: linux-mips@vger.kernel.org  
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> This should probably be merged via linux-mips or linux-mtd, since we
> have consumers of this header on both trees.

Sorry for the delay, I was away the last weeks. I can take it through
the MTD tree (next release cycle) or let mips folks to do it. It's
just a comment change, so not that impacting.

> 
> > ---
> >  include/linux/bcm963xx_tag.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-next-20200714.orig/include/linux/bcm963xx_tag.h
> > +++ linux-next-20200714/include/linux/bcm963xx_tag.h
> > @@ -84,7 +84,7 @@ struct bcm_tag {
> >  	char flash_layout_ver[FLASHLAYOUTVER_LEN];
> >  	/* 196-199: kernel+rootfs CRC32 */
> >  	__u32 fskernel_crc;
> > -	/* 200-215: Unused except on Alice Gate where is is information */
> > +	/* 200-215: Unused except on Alice Gate where it is information */
> >  	char information2[TAGINFO2_LEN];
> >  	/* 216-219: CRC32 of image less imagetag (kernel for Alice Gate) */
> >  	__u32 image_crc;
> >   
> 
> 

Thanks,
Miquèl
