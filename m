Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D695C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D00A208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEGKZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:25:05 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50055 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:25:05 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 831E6240014;
        Thu,  7 May 2020 10:21:11 +0000 (UTC)
Date:   Thu, 7 May 2020 12:21:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vincenzo Aliberti <vincenzo.aliberti@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Fontana <rfontana@redhat.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mtd: lpddr: fix excessive stack usage with clang
Message-ID: <20200507122110.50ccce48@xps13>
In-Reply-To: <20200506023828.GA415100@ubuntu-s3-xlarge-x86>
References: <20200505140136.263461-1-arnd@arndb.de>
        <20200506023828.GA415100@ubuntu-s3-xlarge-x86>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan Chancellor <natechancellor@gmail.com> wrote on Tue, 5 May 2020
19:38:28 -0700:

> On Tue, May 05, 2020 at 04:01:16PM +0200, Arnd Bergmann wrote:
> > Building lpddr2_nvm with clang can result in a giant stack usage
> > in one function:
> > 
> > drivers/mtd/lpddr/lpddr2_nvm.c:399:12: error: stack frame size of 1144 bytes in function 'lpddr2_nvm_probe' [-Werror,-Wframe-larger-than=]
> > 
> > The problem is that clang decides to build a copy of the mtd_info
> > structure on the stack and then do a memcpy() into the actual version. It
> > shouldn't really do it that way, but it's not strictly a bug either.
> > 
> > As a workaround, use a static const version of the structure to assign
> > most of the members upfront and then only set the few members that
> > require runtime knowledge at probe time.
> > 
> > Fixes: 96ba9dd65788 ("mtd: lpddr: add driver for LPDDR2-NVM PCM memories")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

> 
> > ---
> >  drivers/mtd/lpddr/lpddr2_nvm.c | 35 ++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/mtd/lpddr/lpddr2_nvm.c b/drivers/mtd/lpddr/lpddr2_nvm.c
> > index 0f1547f09d08..72f5c7b30079 100644
> > --- a/drivers/mtd/lpddr/lpddr2_nvm.c
> > +++ b/drivers/mtd/lpddr/lpddr2_nvm.c
> > @@ -393,6 +393,17 @@ static int lpddr2_nvm_lock(struct mtd_info *mtd, loff_t start_add,
> >  	return lpddr2_nvm_do_block_op(mtd, start_add, len, LPDDR2_NVM_LOCK);
> >  }
> >  
> > +static const struct mtd_info lpddr2_nvm_mtd_info = {
> > +	.type		= MTD_RAM,
> > +	.writesize	= 1,
> > +	.flags		= (MTD_CAP_NVRAM | MTD_POWERUP_LOCK),
> > +	._read		= lpddr2_nvm_read,
> > +	._write		= lpddr2_nvm_write,
> > +	._erase		= lpddr2_nvm_erase,
> > +	._unlock	= lpddr2_nvm_unlock,
> > +	._lock		= lpddr2_nvm_lock,
> > +};
> > +
> >  /*
> >   * lpddr2_nvm driver probe method
> >   */
> > @@ -433,6 +444,7 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
> >  		.pfow_base	= OW_BASE_ADDRESS,
> >  		.fldrv_priv	= pcm_data,
> >  	};
> > +
> >  	if (IS_ERR(map->virt))
> >  		return PTR_ERR(map->virt);
> >  
> > @@ -444,22 +456,13 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
> >  		return PTR_ERR(pcm_data->ctl_regs);
> >  
> >  	/* Populate mtd_info data structure */
> > -	*mtd = (struct mtd_info) {
> > -		.dev		= { .parent = &pdev->dev },
> > -		.name		= pdev->dev.init_name,
> > -		.type		= MTD_RAM,
> > -		.priv		= map,
> > -		.size		= resource_size(add_range),
> > -		.erasesize	= ERASE_BLOCKSIZE * pcm_data->bus_width,
> > -		.writesize	= 1,
> > -		.writebufsize	= WRITE_BUFFSIZE * pcm_data->bus_width,
> > -		.flags		= (MTD_CAP_NVRAM | MTD_POWERUP_LOCK),
> > -		._read		= lpddr2_nvm_read,
> > -		._write		= lpddr2_nvm_write,
> > -		._erase		= lpddr2_nvm_erase,
> > -		._unlock	= lpddr2_nvm_unlock,
> > -		._lock		= lpddr2_nvm_lock,
> > -	};
> > +	*mtd = lpddr2_nvm_mtd_info;
> > +	mtd->dev.parent		= &pdev->dev;
> > +	mtd->name		= pdev->dev.init_name;
> > +	mtd->priv		= map;
> > +	mtd->size		= resource_size(add_range);
> > +	mtd->erasesize		= ERASE_BLOCKSIZE * pcm_data->bus_width;
> > +	mtd->writebufsize	= WRITE_BUFFSIZE * pcm_data->bus_width;
> >  
> >  	/* Verify the presence of the device looking for PFOW string */
> >  	if (!lpddr2_nvm_pfow_present(map)) {
> > -- 
> > 2.26.0
> >   
