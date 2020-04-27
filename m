Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE594C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C199920775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgD0TPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:15:07 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:42114 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgD0TPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:15:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8DCD1181D302B;
        Mon, 27 Apr 2020 19:15:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hope22_839d3c6f86007
X-Filterd-Recvd-Size: 2356
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 19:15:04 +0000 (UTC)
Message-ID: <c324eed2e6c76fd0157969c69e463e7e7b9ba144.camel@perches.com>
Subject: Re: [PATCH 2/3] mtd: lpddr: Replace printk with pr_notice
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Date:   Mon, 27 Apr 2020 12:15:02 -0700
In-Reply-To: <67c4b34d-019d-e4c9-ebd2-3a8477470048@embeddedor.com>
References: <cover.1588013366.git.gustavo@embeddedor.com>
         <c9684a22b661fdeff9efcd5b18be01653911fc89.1588013366.git.gustavo@embeddedor.com>
         <d036dbad02241fdeb0a6400896f73ff11e98e53b.camel@perches.com>
         <67c4b34d-019d-e4c9-ebd2-3a8477470048@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 14:10 -0500, Gustavo A. R. Silva wrote:
> 
> On 4/27/20 14:01, Joe Perches wrote:
> > On Mon, 2020-04-27 at 14:03 -0500, Gustavo A. R. Silva wrote:
> > > pr_notice is preferred over printk.
> > 
> > So is coalescing formats
> > 
> > ? diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
> > []
> > > @@ -127,31 +127,31 @@ static inline void print_drs_error(unsigned dsr)
> > >  	int prog_status = (dsr & DSR_RPS) >> 8;
> > >  
> > >  	if (!(dsr & DSR_AVAILABLE))
> > > -		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
> > > +		pr_notice("DSR.15: (0) Device not Available\n");
> > >  	if ((prog_status & 0x03) == 0x03)
> > > -		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
> > > +		pr_notice("DSR.9,8: (11) Attempt to program invalid "
> > >  						"half with 41h command\n");
> > 
> > 		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
> > 
> 
> I didn't want to mess with the rest of format, because some maintainers
> don't like that. If Miquel is OK with that, I can fix that up, too.

He should.  Coalescing is part of coding-style.

"never break user-visible strings such as printk messages"

cheers, Joe

