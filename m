Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A3C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6386520718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgBQRfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:35:23 -0500
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:53671 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729678AbgBQRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:35:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6B10F837F252;
        Mon, 17 Feb 2020 17:35:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: game24_85b8439dbbd2f
X-Filterd-Recvd-Size: 2604
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Feb 2020 17:35:18 +0000 (UTC)
Message-ID: <e1ec529a1a01bc38513c05308757bc45b53597c3.camel@perches.com>
Subject: Re: [PATCH] usb: host: fhci-hcd: annotate PIPE_CONTROL switch case
 with fallthrough
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Timur Tabi <timur@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        kbuild test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Feb 2020 09:33:58 -0800
In-Reply-To: <4fa8a8e9-934d-2962-1daa-fdeea6017ea1@embeddedor.com>
References: <20200213085401.27862-1-linux@rasmusvillemoes.dk>
         <20200213125659.GB3325929@kroah.com>
         <4fa8a8e9-934d-2962-1daa-fdeea6017ea1@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-17 at 11:12 -0600, Gustavo A. R. Silva wrote:
> 
> On 2/13/20 06:56, Greg Kroah-Hartman wrote:
> > On Thu, Feb 13, 2020 at 09:54:00AM +0100, Rasmus Villemoes wrote:
> > > After this was made buildable for something other than PPC32, kbuild
> > > starts warning
> > > 
> > > drivers/usb/host/fhci-hcd.c:398:8: warning: this statement may fall
> > > through [-Wimplicit-fallthrough=]
> > > 
> > > I don't know this code, but from the construction (initializing size
> > > with 0 and explicitly using "size +=" in the PIPE_BULK case) I assume
> > > that fallthrough is indeed intended.
> > > 
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Fixes: 5a35435ef4e6 (soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE)
> > > Fixes: a035d552a93b (Makefile: Globally enable fall-through warning)
> 
> By the way, the "Fixes" tag above makes no sense. There is nothing wrong about
> that commit. It just enabled the fall-through warning globally. Why would you
> "fix" that?"

There could be some effort made to better specify when "Fixes:"
tags should be used.

Right now the "Fixes:" tag is used far too often for changes
like
whitespace only or trivial typos corrections.

And those changes can get backported.

I believe "Fixes:" should be used only when changes have some
runtime impact.  "Fixes:" should not be used for changes that
just silence compiler warnings using W=<123>.


