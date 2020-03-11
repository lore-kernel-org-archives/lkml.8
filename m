Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1292C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7343220873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgCKIBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:01:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgCKIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:01:06 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4C6DA28FD50;
        Wed, 11 Mar 2020 08:01:04 +0000 (GMT)
Date:   Wed, 11 Mar 2020 09:01:01 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     allison@lohutok.net, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, rfontana@redhat.com, richard@nod.at,
        s.hauer@pengutronix.de, stefan@agner.ch, tglx@linutronix.de,
        vigneshr@ti.com, yuehaibing@huawei.com
Subject: Re: [PATCH v3 3/4] mtd: rawnand: Add support manufacturer specific
 suspend/resume operation
Message-ID: <20200311090101.5ac66997@collabora.com>
In-Reply-To: <OF4AD2D1A1.2B35FBFA-ON48258528.0021AD65-48258528.00223C9B@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
        <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw>
        <20200310203930.2b8c0cfb@collabora.com>
        <20200310204142.540fc7c4@collabora.com>
        <OF4AD2D1A1.2B35FBFA-ON48258528.0021AD65-48258528.00223C9B@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 14:13:57 +0800
masonccyang@mxic.com.tw wrote:

> Hi Boris,
> 
> > > > ---
> > > >  drivers/mtd/nand/raw/nand_base.c | 11 ++++++++---
> > > >  include/linux/mtd/rawnand.h      |  4 ++++
> > > >  2 files changed, 12 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/mtd/nand/raw/nand_base.c   
> b/drivers/mtd/nand/raw/nand_base.c
> > > > index 769be81..b44e460 100644
> > > > --- a/drivers/mtd/nand/raw/nand_base.c
> > > > +++ b/drivers/mtd/nand/raw/nand_base.c
> > > > @@ -4327,7 +4327,9 @@ static int nand_suspend(struct mtd_info *mtd)
> > > >     struct nand_chip *chip = mtd_to_nand(mtd);
> > > > 
> > > >     mutex_lock(&chip->lock);
> > > > -   chip->suspended = 1;
> > > > +   if (chip->_suspend)
> > > > +      if (!chip->_suspend(chip))
> > > > +         chip->suspended = 1;  
> > 
> > Shouldn't you propagate the error to the caller if chip->_suspend()
> > fails?  
> 
> Currently, chip->suspend() just do sending command to nand chip and
> I think caller could check chip->suspend = 1 or 0 to know the status
> of nand chip.

No, it can't. The caller (AKA the MTD layer) has no idea about this
chip->suspend field, actually it doesn't even know about the nand_chip
struct. The mtd->_suspend() hook is here to abstract HW details, so
it's the raw NAND framework responsibility to propagate the error code
returned by chip->suspend().
