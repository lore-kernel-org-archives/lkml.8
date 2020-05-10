Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD299C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8EC2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgEJMbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:31:14 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36721 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgEJMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:31:13 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B31C9240003;
        Sun, 10 May 2020 12:31:10 +0000 (UTC)
Date:   Sun, 10 May 2020 14:31:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] MAINTAINERS: Remove Piotr Sroka and mark Cadence
 NFC as orphaned
Message-ID: <20200510143109.750b7ec0@xps13>
In-Reply-To: <0bb52429f245717698a2600da094a00977859c79.camel@perches.com>
References: <20200510122430.19105-1-miquel.raynal@bootlin.com>
        <0bb52429f245717698a2600da094a00977859c79.camel@perches.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joe Perches <joe@perches.com> wrote on Sun, 10 May 2020 05:30:02 -0700:

> On Sun, 2020-05-10 at 14:24 +0200, Miquel Raynal wrote:
> > Piotr's address is bouncing, remove him from MAINTAINERS and mark the
> > driver he was maintaining, Cadence's, as orphaned.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1f2c83ead00b..fdd6e96a689b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3749,9 +3749,8 @@ F:	Documentation/devicetree/bindings/media/cdns,*.txt
> >  F:	drivers/media/platform/cadence/cdns-csi2*
> >  
> >  CADENCE NAND DRIVER
> > -M:	Piotr Sroka <piotrs@cadence.com>
> > +S:	Orphan
> >  L:	linux-mtd@lists.infradead.org
> > -S:	Maintained
> >  F:	Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> >  F:	drivers/mtd/nand/raw/cadence-nand-controller.c  
> 
> Please don't change the relative locations.
> L should still comes first, then S
> 

Ok
