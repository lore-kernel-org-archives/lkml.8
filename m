Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F9124677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCJHoL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:44:11 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45555 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:44:11 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 19A5660005;
        Tue, 10 Mar 2020 07:44:05 +0000 (UTC)
Date:   Tue, 10 Mar 2020 08:44:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     allison@lohutok.net, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        rfontana@redhat.com, richard@nod.at, s.hauer@pengutronix.de,
        stefan@agner.ch, tglx@linutronix.de, vigneshr@ti.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH v3 0/4] mtd: rawnand: Add support Macronix Block
 Portection & Deep Power Down mode
Message-ID: <20200310084405.407aaf89@xps13>
In-Reply-To: <OFC31C83BB.5F8F8B14-ON48258527.000B6AF2-48258527.000DBE12@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
        <20200309141403.241e773e@xps13>
        <OFC31C83BB.5F8F8B14-ON48258527.000B6AF2-48258527.000DBE12@mxic.com.tw>
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

masonccyang@mxic.com.tw wrote on Tue, 10 Mar 2020 10:30:09 +0800:

> Hi Miquel,
> 
> > 
> > Mason Yang <masonccyang@mxic.com.tw> wrote on Tue,  3 Mar 2020 15:21:20
> > +0800:
> >   
> > > Hi,
> > > 
> > > Changelog
> > > 
> > > v3:
> > > patch nand_lock_area/nand_unlock_area.
> > > fixed kbuidtest robot warnings and reviewer's comments.  
> > 
> > I know it is painful for the contributor but I really need more details
> > in the changelog. This is something I care about because I can speed-up  
> 
> okay, more changelog as
> 
> 1. Patched the Kdoc for both lock_area/unlock_area and _suspend/_resume
> 2. Created a helper to read default protected value (after device power 
> on)
>         for protection function detection.
> 3. patched the prefix for Macronix deep power down command, 0xB9
> 4. Patched the description of mxic_nand_resume() and add a small sleeping 
> delay.
> 5. Created a helper for deep power down device part number detection.
> 

Way more descriptive! Thanks a lot.


Cheers,
Miquèl
