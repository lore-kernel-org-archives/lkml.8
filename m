Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D228C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE48208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgCKHZ2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:25:28 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:43931 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgCKHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:25:27 -0400
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DA407100006;
        Wed, 11 Mar 2020 07:25:23 +0000 (UTC)
Date:   Wed, 11 Mar 2020 08:25:22 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        allison@lohutok.net, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        rfontana@redhat.com, richard@nod.at, s.hauer@pengutronix.de,
        stefan@agner.ch, tglx@linutronix.de, vigneshr@ti.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH v3 1/4] mtd: rawnand: Add support manufacturer specific
 lock/unlock operation
Message-ID: <20200311082522.53313163@xps13>
In-Reply-To: <OFCDE22522.001A7410-ON48258528.000E260F-48258528.000EA7E7@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
        <1583220084-10890-2-git-send-email-masonccyang@mxic.com.tw>
        <20200310202723.16b48f4b@collabora.com>
        <OFCDE22522.001A7410-ON48258528.000E260F-48258528.000EA7E7@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason, Boris,

masonccyang@mxic.com.tw wrote on Wed, 11 Mar 2020 10:40:04 +0800:

> Hi Boris,
> 
> > > Add nand_lock() & nand_unlock() for manufacturer specific lock &   
> unlock
> > > operation while the device supports Block Portection function.
> > > 
> > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > > Reported-by: kbuild test robot <lkp@intel.com>  
> > 
> > Reported-by on something that's not a fix doesn't make sense. I know
> > the 0day bot asked you to add this tag, but that should only be done if
> > you submit a separate patch, ideally with a Fixes tag. If the offending
> > patch has not been merged yet, you should just fix the commit and ignore
> > the Reported-by tag (you can mention who reported the problem in the
> > changelog though).

Yesterday when applying all the NAND patches my personal IP address got
flagged as spam by mistake (~500 mails in ~10s) so I could not answer
manually as I wished.

Indeed, this Reported-by tag was not needed and I dropped it manually
when applying. This tag is meant to show an error that was existing
*before* your series and that you are fixing with your series. This is
not something you should add when a robot tells you something is wrong
in your series.

Also, I rewrote several paragraphs and I prefixed two of them with "mtd:
rawnand: macronix:".

Thanks,
Miquèl
