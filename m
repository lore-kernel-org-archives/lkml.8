Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49416C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2114F2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgBTSLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:11:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56932 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBTSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:11:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2F3A715AC0C32;
        Thu, 20 Feb 2020 10:11:02 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:11:01 -0800 (PST)
Message-Id: <20200220.101101.1993510182065744262.davem@davemloft.net>
To:     esben@geanix.com
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        michal.simek@xilinx.com, ynezz@true.cz
Subject: Re: [PATCH net 2/4] net: ll_temac: Add more error handling of
 dma_map_single() calls
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87v9o18xqd.fsf@geanix.com>
References: <65907810dd82de3fcaad9869f328ab32800c67ea.1582108989.git.esben@geanix.com>
        <20200219.105954.1568022053134111448.davem@davemloft.net>
        <87v9o18xqd.fsf@geanix.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 20 Feb 2020 10:11:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <esben@geanix.com>
Date: Thu, 20 Feb 2020 09:32:58 +0100

> David Miller <davem@davemloft.net> writes:
> 
>> From: Esben Haabendal <esben@geanix.com>
>> Date: Wed, 19 Feb 2020 11:54:00 +0100
>>
>>> @@ -863,12 +865,13 @@ temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>>  	skb_dma_addr = dma_map_single(ndev->dev.parent, skb->data,
>>>  				      skb_headlen(skb), DMA_TO_DEVICE);
>>>  	cur_p->len = cpu_to_be32(skb_headlen(skb));
>>> +	if (WARN_ON_ONCE(dma_mapping_error(ndev->dev.parent, skb_dma_addr)))
>>> +		return NETDEV_TX_BUSY;
>>
>> The appropriate behavior in this situation is to drop the packet and return
>> NETDEV_TX_OK.
> 
> Ok, and I guess the same goes for the error handling of dma_map_single()
> of one of the fragments later in same function.

Yes.
