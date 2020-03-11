Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD9C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B811120873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgCKH4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:56:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54778 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCKH4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:56:48 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 94DC628B02D;
        Wed, 11 Mar 2020 07:56:45 +0000 (GMT)
Date:   Wed, 11 Mar 2020 08:56:42 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     masonccyang@mxic.com.tw, allison@lohutok.net,
        bbrezillon@kernel.org, frieder.schrempf@kontron.de,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, rfontana@redhat.com, richard@nod.at,
        s.hauer@pengutronix.de, stefan@agner.ch, tglx@linutronix.de,
        vigneshr@ti.com, yuehaibing@huawei.com
Subject: Re: [PATCH v3 3/4] mtd: rawnand: Add support manufacturer specific
 suspend/resume operation
Message-ID: <20200311085642.36d91673@collabora.com>
In-Reply-To: <20200311084304.580bec79@xps13>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
        <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw>
        <20200310203310.5fe74c57@collabora.com>
        <OF5C883176.AD73134D-ON48258528.000F5185-48258528.001F3544@mxic.com.tw>
        <20200311084304.580bec79@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 08:43:04 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Mason,
> 
> masonccyang@mxic.com.tw wrote on Wed, 11 Mar 2020 13:40:52 +0800:
> 
> > Hi Boris,
> >   
> > > > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > > > index bc2fa3c..c0055ed 100644
> > > > --- a/include/linux/mtd/rawnand.h
> > > > +++ b/include/linux/mtd/rawnand.h
> > > > @@ -1064,6 +1064,8 @@ struct nand_legacy {
> > > >   * @lock:      lock protecting the suspended field. Also used to
> > > >   *         serialize accesses to the NAND device.
> > > >   * @suspended:      set to 1 when the device is suspended, 0 when     
> > it's not.  
> > > > + * @_suspend:      [REPLACEABLE] specific NAND device suspend     
> > operation  
> > > > + * @_resume:      [REPLACEABLE] specific NAND device resume operation
> > > >   * @bbt:      [INTERN] bad block table pointer
> > > >   * @bbt_td:      [REPLACEABLE] bad block table descriptor for flash
> > > >   *         lookup.
> > > > @@ -1119,6 +1121,8 @@ struct nand_chip {
> > > > 
> > > >     struct mutex lock;
> > > >     unsigned int suspended : 1;
> > > > +   int (*_suspend)(struct nand_chip *chip);
> > > > +   void (*_resume)(struct nand_chip *chip);    
> > > 
> > > I thought we agreed on not prefixing new hooks with _ ?    
> > 
> > For [PATCH v2] series, you mentioned to drop the _ prefix 
> > of _lock/_unlock only and we finally patched to lock_area/unlock_area.
> >   
> 
> I missed this _, this is not something we want to add.
> 
> Also, when applying your patches I had several issues because they
> where not base on the last -rc1.
> 
> Finally, I think I forgot a line when patching manually so it produces
> a warning now.
> 
> I am dropping patch 3 and 4, I keep patch 1 and 2 which seem fine.
> 
> Please send a rebased and edited v4 for these, don't forget to drop the
> kbuildtest robot tag and please also follow these slightly edited
> commit logs:
> 
> 2/4
> 
>     mtd: rawnand: Add support for manufacturer specific suspend/resume operation
>     
>     Patch nand_suspend() & nand_resume() to let manufacturers overwrite
>     suspend/resume operations.
> 
> 3/4
> 
>     mtd: rawnand: macronix: Add support for deep power down mode
>     
>     Macronix AD series support deep power down mode for a minimum
>     power consumption state.
>     
>     Overlaod nand_suspend() & nand_resume() in Macronix specific code to
>     support deep power down mode.

And don't forget to propagate the ->suspend() error code to the upper
layer.
