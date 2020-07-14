Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0BF225A9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgGNTWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:22:11 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:34252 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727930AbgGNTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:22:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0685B181D337B;
        Tue, 14 Jul 2020 19:22:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: turn41_0b16cbc26ef3
X-Filterd-Recvd-Size: 4228
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Jul 2020 19:22:06 +0000 (UTC)
Message-ID: <ce637b26b496dd99be8f272e6ec82333338321dc.camel@perches.com>
Subject: Re: [PATCH 6/6] staging: qlge: qlge_ethtool: Remove one byte memset.
From:   Joe Perches <joe@perches.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2020 12:22:05 -0700
In-Reply-To: <20200714190602.GA14742@blackclown>
References: <cover.1594642213.git.usuraj35@gmail.com>
         <b5eb87576cef4bf1b968481d6341013e6c7e9650.1594642213.git.usuraj35@gmail.com>
         <20200713141749.GU2549@kadam>
         <a323c1e47e8de871ff7bb72289740cb0bc2d27f8.camel@perches.com>
         <20200714190602.GA14742@blackclown>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 00:36 +0530, Suraj Upadhyay wrote:
> On Tue, Jul 14, 2020 at 11:57:23AM -0700, Joe Perches wrote:
> > On Mon, 2020-07-13 at 17:17 +0300, Dan Carpenter wrote:
> > > On Mon, Jul 13, 2020 at 05:52:22PM +0530, Suraj Upadhyay wrote:
> > > > Use direct assignment instead of using memset with just one byte as an
> > > > argument.
> > > > Issue found by checkpatch.pl.
> > > > 
> > > > Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> > > > ---
> > > > Hii Maintainers,
> > > > 	Please correct me if I am wrong here.
> > > > ---
> > > > 
> > > >  drivers/staging/qlge/qlge_ethtool.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/qlge/qlge_ethtool.c b/drivers/staging/qlge/qlge_ethtool.c
> > > > index 16fcdefa9687..d44b2dae9213 100644
> > > > --- a/drivers/staging/qlge/qlge_ethtool.c
> > > > +++ b/drivers/staging/qlge/qlge_ethtool.c
> > > > @@ -516,8 +516,8 @@ static void ql_create_lb_frame(struct sk_buff *skb,
> > > >  	memset(skb->data, 0xFF, frame_size);
> > > >  	frame_size &= ~1;
> > > >  	memset(&skb->data[frame_size / 2], 0xAA, frame_size / 2 - 1);
> > > > -	memset(&skb->data[frame_size / 2 + 10], 0xBE, 1);
> > > > -	memset(&skb->data[frame_size / 2 + 12], 0xAF, 1);
> > > > +	skb->data[frame_size / 2 + 10] = (unsigned char)0xBE;
> > > > +	skb->data[frame_size / 2 + 12] = (unsigned char)0xAF;
> > > 
> > > Remove the casting.
> > > 
> > > I guess this is better than the original because now it looks like
> > > ql_check_lb_frame().  It's still really weird looking though.
> > 
> > There are several of these in the intel drivers too:
> > 
> > drivers/net/ethernet/intel/e1000/e1000_ethtool.c:       memset(&skb->data[frame_size / 2 + 10], 0xBE, 1);
> > drivers/net/ethernet/intel/e1000/e1000_ethtool.c:       memset(&skb->data[frame_size / 2 + 12], 0xAF, 1);
> > drivers/net/ethernet/intel/e1000e/ethtool.c:    memset(&skb->data[frame_size / 2 + 10], 0xBE, 1);
> > drivers/net/ethernet/intel/e1000e/ethtool.c:    memset(&skb->data[frame_size / 2 + 12], 0xAF, 1);
> > drivers/net/ethernet/intel/igb/igb_ethtool.c:   memset(&skb->data[frame_size + 10], 0xBE, 1);
> > drivers/net/ethernet/intel/igb/igb_ethtool.c:   memset(&skb->data[frame_size + 12], 0xAF, 1);
> > drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:       memset(&skb->data[frame_size + 10], 0xBE, 1);
> > drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:       memset(&skb->data[frame_size + 12], 0xAF, 1);
> > drivers/staging/qlge/qlge_ethtool.c:    memset(&skb->data[frame_size / 2 + 10], 0xBE, 1);
> > drivers/staging/qlge/qlge_ethtool.c:    memset(&skb->data[frame_size / 2 + 12], 0xAF, 1);
> 
> Thanks to point this out,
> 	I will be sending a patchset for that soon.


It _might_ be useful to create and use a standard
mechanism for the loopback functions:

	<foo>create_lbtest_frame
and
	<foo>check_lbtest_frame

Maybe use something like:

	ether_loopback_frame_create
and
	ether_loopback_frame_check


