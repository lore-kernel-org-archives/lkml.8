Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D341C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225BA2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgG1Py5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:54:57 -0400
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:33018 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730679AbgG1Py5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:54:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 18151181D396A;
        Tue, 28 Jul 2020 15:54:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seed58_631747d26f6b
X-Filterd-Recvd-Size: 3298
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 15:54:51 +0000 (UTC)
Message-ID: <4299fe666c93018a9a047575e5d68a0bb4dd269f.camel@perches.com>
Subject: Re: [PATCH net-next] liquidio: Remove unneeded cast from memory
 allocation
From:   Joe Perches <joe@perches.com>
To:     "wanghai (M)" <wanghai38@huawei.com>, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Jul 2020 08:54:48 -0700
In-Reply-To: <2996569e-5e1a-db02-2c78-0ee0d572706d@huawei.com>
References: <20200724130001.71528-1-wanghai38@huawei.com>
         <2cdef8d442bb5da39aed17bf994a800e768942f7.camel@perches.com>
         <ac99bed4-dabc-a003-374f-206753f937cb@huawei.com>
         <bffcc7d513e186734d224bda6afdd55033b451de.camel@perches.com>
         <2996569e-5e1a-db02-2c78-0ee0d572706d@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 21:38 +0800, wanghai (M) wrote:
> Thanks for your explanation. I got it.
> 
> Can it be modified like this?
[]
> +++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
> @@ -1152,11 +1152,8 @@ octeon_register_dispatch_fn(struct octeon_device 
> *oct,
> 
>                  dev_dbg(&oct->pci_dev->dev,
>                          "Adding opcode to dispatch list linked list\n");
> -               dispatch = (struct octeon_dispatch *)
> -                          vmalloc(sizeof(struct octeon_dispatch));
> +               dispatch = kmalloc(sizeof(struct octeon_dispatch), 
> GFP_KERNEL);
>                  if (!dispatch) {
> -                       dev_err(&oct->pci_dev->dev,
> -                               "No memory to add dispatch function\n");
>                          return 1;
>                  }
>                  dispatch->opcode = combined_opcode;

Yes, but the free also needs to be changed.

I think it's:
---
 drivers/net/ethernet/cavium/liquidio/octeon_device.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
index 934115d18488..4ee4cb946e1d 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
@@ -1056,7 +1056,7 @@ void octeon_delete_dispatch_list(struct octeon_device *oct)
 
 	list_for_each_safe(temp, tmp2, &freelist) {
 		list_del(temp);
-		vfree(temp);
+		kfree(temp);
 	}
 }
 
@@ -1152,13 +1152,10 @@ octeon_register_dispatch_fn(struct octeon_device *oct,
 
 		dev_dbg(&oct->pci_dev->dev,
 			"Adding opcode to dispatch list linked list\n");
-		dispatch = (struct octeon_dispatch *)
-			   vmalloc(sizeof(struct octeon_dispatch));
-		if (!dispatch) {
-			dev_err(&oct->pci_dev->dev,
-				"No memory to add dispatch function\n");
+		dispatch = kmalloc(sizeof(struct octeon_dispatch), GFP_KERNEL);
+		if (!dispatch)
 			return 1;
-		}
+
 		dispatch->opcode = combined_opcode;
 		dispatch->dispatch_fn = fn;
 		dispatch->arg = fn_arg;


