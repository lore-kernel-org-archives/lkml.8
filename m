Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DDCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44552068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgFOHWY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:22:24 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49875 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgFOHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:22:24 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 49AE41C000B;
        Mon, 15 Jun 2020 07:22:22 +0000 (UTC)
Date:   Mon, 15 Jun 2020 09:22:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] mtd: set master partition panic write flag
Message-ID: <20200615092221.7f269810@xps13>
In-Reply-To: <CB182F6C-EB9E-4E90-BF6E-115C925FCFFE@gmail.com>
References: <20200504235403.13504-1-kdasu.kdev@gmail.com>
        <CB182F6C-EB9E-4E90-BF6E-115C925FCFFE@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Sat, 13 Jun 2020 02:49:31
-0400:

> Can you please accept this if there are no objections.
> 
> Kamal
> 
> > On May 4, 2020, at 7:54 PM, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> > 
> > ﻿Check and set master panic write flag so that low level drivers
> > can use it to take required action to ensure oops data gets written
> > to assigned mtdoops device partition.
> > 
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> > drivers/mtd/mtdcore.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index 2916674208b3..7e37ed2f38ea 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -1235,8 +1235,8 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
> >        return -EROFS;
> >    if (!len)
> >        return 0;
> > -    if (!mtd->oops_panic_write)
> > -        mtd->oops_panic_write = true;
> > +    if (!master->oops_panic_write)
> > +        master->oops_panic_write = true;
> > 
> >    return master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
> >                    retlen, buf);
> > -- 
> > 2.17.1
> >   

I thing we missed it. However, shouldn't we have a Cc:/Fixes: pair of
tags here? We could send it as part of a fixes PR then.

Thanks,
Miquèl
