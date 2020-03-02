Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9252C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904FB24686
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgCBTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:41:29 -0500
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:58237 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbgCBTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:41:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8FB63180A813D;
        Mon,  2 Mar 2020 19:41:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fear94_c98062e1a951
X-Filterd-Recvd-Size: 2203
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Mar 2020 19:41:26 +0000 (UTC)
Message-ID: <ff833cf6a9a489ff446910c85e2a56ff1c11ccb4.camel@perches.com>
Subject: Re: [PATCH 2/7] parport: Use more comon logging styles
From:   Joe Perches <joe@perches.com>
To:     Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 11:39:53 -0800
In-Reply-To: <b4a4f5a8-9ff0-e3d3-93c9-260a11cdb439@gmx.de>
References: <cover.1582878393.git.joe@perches.com>
         <1da80f696e3602cc2533988b20f9a47cd42db1c4.1582878394.git.joe@perches.com>
         <b4a4f5a8-9ff0-e3d3-93c9-260a11cdb439@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 20:29 +0100, Helge Deller wrote:
> On 28.02.20 09:32, Joe Perches wrote:
> > Some of the logging can be poorly formatted because of unexpected
> > line breaks given printks without KERN_CONT that should be pr_cont.
[]
> > diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
[]
> > @@ -238,14 +238,14 @@ struct parport *parport_gsc_probe_port(unsigned long base,
> > 
> >  	priv = kzalloc (sizeof (struct parport_gsc_private), GFP_KERNEL);
> >  	if (!priv) {
> > -		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
> > +		printk(KERN_DEBUG "parport (0x%lx): no memory!\n", base);
> 
> pr_warn() instead?

For all of your remarks, the intent here is to keep the
same output.

Logging level changes and printk(KERN_DEBUG -> pr_debug(
conversions cause the dmesg output to be different.

	printk(KERN_DEBUG...)

is always emitted when the console level allows but

	pr_debug(...)

is not normally compiled in at all.

So it's possible for all printk(KERN_DEBUG to be pr_debug
but that causes no logging at all to be emitted when
DEBUG is not defined or CONFIG_DYNAMIC_DEBUG not enabled.


