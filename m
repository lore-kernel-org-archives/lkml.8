Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE5C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B97520829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgG1JLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:11:30 -0400
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:40664 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728467AbgG1JL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:11:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id ACEFC180A7FD6;
        Tue, 28 Jul 2020 09:11:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coat93_1c0ebe426f68
X-Filterd-Recvd-Size: 2656
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 09:11:27 +0000 (UTC)
Message-ID: <bffcc7d513e186734d224bda6afdd55033b451de.camel@perches.com>
Subject: Re: [PATCH net-next] liquidio: Remove unneeded cast from memory
 allocation
From:   Joe Perches <joe@perches.com>
To:     "wanghai (M)" <wanghai38@huawei.com>, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Jul 2020 02:11:26 -0700
In-Reply-To: <ac99bed4-dabc-a003-374f-206753f937cb@huawei.com>
References: <20200724130001.71528-1-wanghai38@huawei.com>
         <2cdef8d442bb5da39aed17bf994a800e768942f7.camel@perches.com>
         <ac99bed4-dabc-a003-374f-206753f937cb@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 16:42 +0800, wanghai (M) wrote:
> 在 2020/7/25 5:29, Joe Perches 写道:
> > On Fri, 2020-07-24 at 21:00 +0800, Wang Hai wrote:
> > > Remove casting the values returned by memory allocation function.
> > > 
> > > Coccinelle emits WARNING:
> > > 
> > > ./drivers/net/ethernet/cavium/liquidio/octeon_device.c:1155:14-36: WARNING:
> > >   casting value returned by memory allocation function to (struct octeon_dispatch *) is useless.
> > []
> > > diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
> > []
> > > @@ -1152,8 +1152,7 @@ octeon_register_dispatch_fn(struct octeon_device *oct,
> > >   
> > >   		dev_dbg(&oct->pci_dev->dev,
> > >   			"Adding opcode to dispatch list linked list\n");
> > > -		dispatch = (struct octeon_dispatch *)
> > > -			   vmalloc(sizeof(struct octeon_dispatch));
> > > +		dispatch = vmalloc(sizeof(struct octeon_dispatch));
> > More the question is why this is vmalloc at all
> > as the structure size is very small.
> > 
> > Likely this should just be kmalloc.
> > 
> > 
> Thanks for your advice.  It is indeed best to use kmalloc here.
> > >   		if (!dispatch) {
> > >   			dev_err(&oct->pci_dev->dev,
> > >   				"No memory to add dispatch function\n");
> > And this dev_err is unnecessary.
> > 
> > 
> I don't understand why dev_err is not needed here. We can easily know 
> that an error has occurred here through dev_err

Memory allocation failures without __GFP_NOWARN. already
do a dump_stack to show the location of the code that
could not successfully allocate memory.


