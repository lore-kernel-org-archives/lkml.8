Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F23C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B75206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbgE1NRm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:17:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390140AbgE1NRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:17:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4519ADD3;
        Thu, 28 May 2020 13:17:34 +0000 (UTC)
Date:   Thu, 28 May 2020 15:17:33 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Enable autoneg bypass for
 1000BaseX/2500BaseX ports
Message-Id: <20200528151733.f1bc2fcdcb312b19b2919be9@suse.de>
In-Reply-To: <20200528130738.GT1551@shell.armlinux.org.uk>
References: <20200528121121.125189-1-tbogendoerfer@suse.de>
        <20200528130738.GT1551@shell.armlinux.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 14:07:38 +0100
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> On Thu, May 28, 2020 at 02:11:21PM +0200, Thomas Bogendoerfer wrote:
> > Commit d14e078f23cc ("net: marvell: mvpp2: only reprogram what is necessary
> >  on mac_config") disabled auto negotiation bypass completely, which breaks
> > platforms enabling bypass via firmware (not the best option, but it worked).
> > Since 1000BaseX/2500BaseX ports neither negotiate speed nor duplex mode
> > we could enable auto negotiation bypass to get back information about link
> > state.
> 
> Thanks, but your commit is missing some useful information.
> 
> Which platforms have broken?

it's an Ambedded MARS-400
 
> Can you describe the situation where you require this bit to be set?

as I have no exact design details I'm just talking about what I can see
on that platform. It looks like the switch connecting the internal nodes
doesn't run autoneg on the internal links. So the link to the internal
nodes will never come up. These links are running 2500BaseX so speed/duplex
is clean and by enabling bypass I'll get a proper link state, too.

> We should not be enabling bypass mode as a matter of course, it exists
> to work around broken setups which do not send the control word.

if you call it a broken setup I'm fine, but this doesn't solve the problem,
which exists now. What would be your solution ?

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 36809 (AG Nürnberg)
Geschäftsführer: Felix Imendörffer
