Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F9F20717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGROyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:54:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42670 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:54:40 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jwoEW-005m00-3M; Sat, 18 Jul 2020 16:54:36 +0200
Date:   Sat, 18 Jul 2020 16:54:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mark Einon <mark.einon@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: et131x: Remove redundant register read
Message-ID: <20200718145436.GB1375379@lunn.ch>
References: <20200717132135.361267-1-mark.einon@gmail.com>
 <20200717134008.GB1336433@lunn.ch>
 <de7ace0ba7a8efb775ddf841b17564744cb83cff.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7ace0ba7a8efb775ddf841b17564744cb83cff.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 04:21:51PM +0100, Mark Einon wrote:
> On Fri, 2020-07-17 at 15:40 +0200, Andrew Lunn wrote:
> > On Fri, Jul 17, 2020 at 02:21:35PM +0100, Mark Einon wrote:
> > > Following the removal of an unused variable assignment (remove
> > > unused variable 'pm_csr') the associated register read can also go,
> > > as the read also occurs in the subsequent 
> > > call.
> > 
> > Hi Mark
> > 
> > Do you have any hardware documentation which indicates these read are
> > not required? Have you looked back through the git history to see if
> > there are any comments about these read?
> > 
> > Hardware reads which appear pointless are sometimes very important to
> > actually make the hardware work.
> > 
> > 	 Andrew
> 
> Hi Andrew,
> 
> Yes - I'm aware of such effects. In the original vendor driver (
> https://gitlab.com/einonm/Legacy-et131x) the read of this register ( 
> pm_phy_sw_coma) is not wrapped in a function call and is always called
> once when needed.
> 
> Also in the current kernel driver et1310_in_phy_coma() is called a few
> other times without the removed read being made.
> 
> The datasheet I have for a similar device (et1011) doesn't say anything
> other than the register should be read/write.
> 
> So I think this is a safe thing to do. 

Hi Mark

It is good to include this sort of information in the commit
message. It makes it clear you have considered this, and it stops
people like me asking...

	 Andrew
