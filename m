Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E75C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784F8206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGXV3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:29:44 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:42774 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgGXV3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:29:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9DAC2362A;
        Fri, 24 Jul 2020 21:29:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: way24_3e0938d26f4a
X-Filterd-Recvd-Size: 3199
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 Jul 2020 21:29:41 +0000 (UTC)
Message-ID: <2cdef8d442bb5da39aed17bf994a800e768942f7.camel@perches.com>
Subject: Re: [PATCH net-next] liquidio: Remove unneeded cast from memory
 allocation
From:   Joe Perches <joe@perches.com>
To:     Wang Hai <wanghai38@huawei.com>, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:29:39 -0700
In-Reply-To: <20200724130001.71528-1-wanghai38@huawei.com>
References: <20200724130001.71528-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-24 at 21:00 +0800, Wang Hai wrote:
> Remove casting the values returned by memory allocation function.
> 
> Coccinelle emits WARNING:
> 
> ./drivers/net/ethernet/cavium/liquidio/octeon_device.c:1155:14-36: WARNING:
>  casting value returned by memory allocation function to (struct octeon_dispatch *) is useless.
[]
> diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
[]
> @@ -1152,8 +1152,7 @@ octeon_register_dispatch_fn(struct octeon_device *oct,
>  
>  		dev_dbg(&oct->pci_dev->dev,
>  			"Adding opcode to dispatch list linked list\n");
> -		dispatch = (struct octeon_dispatch *)
> -			   vmalloc(sizeof(struct octeon_dispatch));
> +		dispatch = vmalloc(sizeof(struct octeon_dispatch));

More the question is why this is vmalloc at all
as the structure size is very small.

Likely this should just be kmalloc.

drivers/net/ethernet/cavium/liquidio/octeon_device.h:struct octeon_dispatch {
drivers/net/ethernet/cavium/liquidio/octeon_device.h-   /** List head for this entry */
drivers/net/ethernet/cavium/liquidio/octeon_device.h-   struct list_head list;
drivers/net/ethernet/cavium/liquidio/octeon_device.h-
drivers/net/ethernet/cavium/liquidio/octeon_device.h-   /** The opcode for which the dispatch function & arg should be used */
drivers/net/ethernet/cavium/liquidio/octeon_device.h-   u16 opcode;
drivers/net/ethernet/cavium/liquidio/octeon_device.h-
drivers/net/ethernet/cavium/liquidio/octeon_device.h-   /** The function to be called for a packet received by the driver */
drivers/net/ethernet/cavium/liquidio/octeon_device.h-   octeon_dispatch_fn_t dispatch_fn;
drivers/net/ethernet/cavium/liquidio/octeon_device.h-
drivers/net/ethernet/cavium/liquidio/octeon_device.h-   /* The application specified argument to be passed to the above
drivers/net/ethernet/cavium/liquidio/octeon_device.h-    * function along with the received packet
drivers/net/ethernet/cavium/liquidio/octeon_device.h-    */
drivers/net/ethernet/cavium/liquidio/octeon_device.h-   void *arg;
drivers/net/ethernet/cavium/liquidio/octeon_device.h-}

>  		if (!dispatch) {
>  			dev_err(&oct->pci_dev->dev,
>  				"No memory to add dispatch function\n");

And this dev_err is unnecessary.


