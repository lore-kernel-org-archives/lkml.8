Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB29C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4652468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgB0UwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:52:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42596 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0UwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:52:17 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 07DD42964E6;
        Thu, 27 Feb 2020 20:52:16 +0000 (GMT)
Date:   Thu, 27 Feb 2020 21:52:13 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/5] mtd: spinand: micron: Add new Micron
 SPI NAND devices
Message-ID: <20200227215213.01fd760b@collabora.com>
In-Reply-To: <MN2PR08MB639762D89F85C2556F51D48EB8EB0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
        <20200206202206.14770-3-sshivamurthy@micron.com>
        <20200227192247.52f84723@collabora.com>
        <MN2PR08MB6397477172BAC14986175E6DB8EB0@MN2PR08MB6397.namprd08.prod.outlook.com>
        <20200227211759.7ba02273@collabora.com>
        <MN2PR08MB639762D89F85C2556F51D48EB8EB0@MN2PR08MB6397.namprd08.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 20:24:22 +0000
"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:

> Hi Boris,
> 
> > 
> > On Thu, 27 Feb 2020 20:16:46 +0000
> > "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:
> >   
> > > Hi Boris,
> > >
> > > Thanks for the review.
> > >  
> > > >
> > > > On Thu,  6 Feb 2020 21:22:03 +0100
> > > > shiva.linuxworks@gmail.com wrote:
> > > >  
> > > > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > > >
> > > > > Add device table for M79A and M78A series Micron SPI NAND devices.
> > > > >
> > > > > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > > > ---
> > > > >  drivers/mtd/nand/spi/micron.c | 31  
> > > > +++++++++++++++++++++++++++++++  
> > > > >  1 file changed, 31 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mtd/nand/spi/micron.c  
> > > > b/drivers/mtd/nand/spi/micron.c  
> > > > > index c028d0d7e236..5fd1f921ef12 100644
> > > > > --- a/drivers/mtd/nand/spi/micron.c
> > > > > +++ b/drivers/mtd/nand/spi/micron.c
> > > > > @@ -91,6 +91,7 @@ static int micron_8_ecc_get_status(struct  
> > > > spinand_device *spinand,  
> > > > >  }
> > > > >
> > > > >  static const struct spinand_info micron_spinand_table[] = {
> > > > > +	/* M79A 2Gb 3.3V */  
> > > >
> > > > Should be added in a separate patch.  
> > >
> > > Okay, I will create separate patch for each device.  
> > 
> > No, I meant just for this line.  
> 
> How about including this line with 1st Patch?

It's even worse if you move it to patch 1. Let's keep it like that.
