Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA194C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDFF2051A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBEKBE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:01:04 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43185 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:01:04 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2940D1C000D;
        Wed,  5 Feb 2020 10:01:02 +0000 (UTC)
Date:   Wed, 5 Feb 2020 11:01:01 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: Add comment about Kioxia ID
Message-ID: <20200205110101.3d4e2e6a@xps13>
In-Reply-To: <73dae14b-5bf0-b909-3229-aab3ed232669@kioxia.com>
References: <1580783163-5601-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
        <20200204095214.666c71fc@xps13>
        <73dae14b-5bf0-b909-3229-aab3ed232669@kioxia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Tue, 4 Feb 2020
19:30:04 +0900:

> Dear Miquèl,
> 
> 
> On 2020/02/04 17:52, Miquel Raynal wrote:
> > Hi Yoshio,
> >
> > Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Tue,  4 Feb
> > 2020 11:26:03 +0900:
> >  
> >> Add a comment above NAND_MFR_TOSHIBA and SPINAND_MFR_TOSHIBA definitions
> >> that Toshiba and Kioxia ID are the same.
> >>
> >> Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
> >> ---
> >>   drivers/mtd/nand/raw/internals.h | 1 +
> >>   drivers/mtd/nand/spi/toshiba.c   | 1 +
> >>   2 files changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
> >> index cba6fe7..2918376b 100644
> >> --- a/drivers/mtd/nand/raw/internals.h
> >> +++ b/drivers/mtd/nand/raw/internals.h
> >> @@ -30,6 +30,7 @@
> >>   #define NAND_MFR_SAMSUNG	0xec
> >>   #define NAND_MFR_SANDISK	0x45
> >>   #define NAND_MFR_STMICRO	0x20
> >> +/* Toshiba and Kioxia ID are the same. */
> >>   #define NAND_MFR_TOSHIBA	0x98
> >>   #define NAND_MFR_WINBOND	0xef  
> >>   >> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c  
> >> index 0db5ee4..a92ecc8 100644
> >> --- a/drivers/mtd/nand/spi/toshiba.c
> >> +++ b/drivers/mtd/nand/spi/toshiba.c
> >> @@ -10,6 +10,7 @@
> >>   #include <linux/kernel.h>
> >>   #include <linux/mtd/spinand.h>  
> >>   >> +/* Toshiba and Kioxia ID are the same. */  
> >>   #define SPINAND_MFR_TOSHIBA		0x98
> >>   #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)  
> >>   >  
> > "Are the same" is not very descriptive, what about "Kioxia is the new
> > name of Toshiba"?  
> 
> 
> That's a good idea.
> 
> Actually ,
> 
> Is was changed a company name from Toshiba memory Co to Kioxia Co.     Since became independent from Toshiba group.
> 
> I will update the comment as "Kioxia is new name of Toshiba memory"

Well, in this case I would even recommend something more meaningful:

"Since its independence from Toshiba Group, Toshiba memory Co has become Kioxia Co"

Also, please update the version of your patch to "v3" in the title
"[PATCH v3] ...", this can be done automatically when formatting your
patch with git format-patch with the -v 3 option.

Also the prefix should be "mtd: spinand: toshiba:"

Thanks,
Miquèl
