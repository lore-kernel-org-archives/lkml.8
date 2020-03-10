Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5FEC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5041E21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCJTlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:41:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50040 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:41:48 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 686A329196A;
        Tue, 10 Mar 2020 19:41:46 +0000 (GMT)
Date:   Tue, 10 Mar 2020 20:41:42 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, allison@lohutok.net,
        linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        rfontana@redhat.com, linux-mtd@lists.infradead.org,
        yuehaibing@huawei.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v3 3/4] mtd: rawnand: Add support manufacturer specific
 suspend/resume operation
Message-ID: <20200310204142.540fc7c4@collabora.com>
In-Reply-To: <20200310203930.2b8c0cfb@collabora.com>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
        <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw>
        <20200310203930.2b8c0cfb@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 20:39:30 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Tue,  3 Mar 2020 15:21:23 +0800
> Mason Yang <masonccyang@mxic.com.tw> wrote:
> 
> > Patch nand_suspend() & nand_resume() for manufacturer specific
> > suspend/resume operation.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c | 11 ++++++++---
> >  include/linux/mtd/rawnand.h      |  4 ++++
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index 769be81..b44e460 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -4327,7 +4327,9 @@ static int nand_suspend(struct mtd_info *mtd)
> >  	struct nand_chip *chip = mtd_to_nand(mtd);
> >  
> >  	mutex_lock(&chip->lock);
> > -	chip->suspended = 1;
> > +	if (chip->_suspend)
> > +		if (!chip->_suspend(chip))
> > +			chip->suspended = 1;

Shouldn't you propagate the error to the caller if chip->_suspend()
fails?
