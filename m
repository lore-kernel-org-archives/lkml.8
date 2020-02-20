Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1195FC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2687208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="DfB4M8Vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBTIdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:33:02 -0500
Received: from first.geanix.com ([116.203.34.67]:43076 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTIdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:33:02 -0500
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 6FDECABE2F;
        Thu, 20 Feb 2020 08:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1582187579; bh=7fJH91fFHjiUXtmwG2jBMWpcDq/boOo9eUL36++h+i8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=DfB4M8VqU8kTqcfghs5TeBFdORfpRU2MDPkS4nqrSVC+bK9H/MDeqQCulS33Xia+7
         MOWvLr3lrd1qYlx9j0HYK23jj3Amgql5uoTKeXJmtgFPScxp8ESrVrPWG2dCo6BPmF
         5r9SYM2A2lp58eeDqi9klcaLempfjO2NA34g6wcn6KZxPCZ9Llis8ycRNmfFxNctPj
         VMKf8Nmm5ZaKCcBGOel6f+ZoIUXrEFpS+NwJl4XOFh1jHtnF7X8lPzZssLPPVUVeAG
         CRJdqmHokbuMIaT8EBYFQ+Ov+jAHFg9SuOQPWzoFR/JN25DmNE0o1lzlEP0gAfEQFK
         7Ty11hZcZZxiA==
From:   Esben Haabendal <esben@geanix.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        michal.simek@xilinx.com, ynezz@true.cz
Subject: Re: [PATCH net 2/4] net: ll_temac: Add more error handling of dma_map_single() calls
References: <cover.1582108989.git.esben@geanix.com>
        <65907810dd82de3fcaad9869f328ab32800c67ea.1582108989.git.esben@geanix.com>
        <20200219.105954.1568022053134111448.davem@davemloft.net>
Date:   Thu, 20 Feb 2020 09:32:58 +0100
In-Reply-To: <20200219.105954.1568022053134111448.davem@davemloft.net> (David
        Miller's message of "Wed, 19 Feb 2020 10:59:54 -0800 (PST)")
Message-ID: <87v9o18xqd.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> From: Esben Haabendal <esben@geanix.com>
> Date: Wed, 19 Feb 2020 11:54:00 +0100
>
>> @@ -863,12 +865,13 @@ temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>  	skb_dma_addr = dma_map_single(ndev->dev.parent, skb->data,
>>  				      skb_headlen(skb), DMA_TO_DEVICE);
>>  	cur_p->len = cpu_to_be32(skb_headlen(skb));
>> +	if (WARN_ON_ONCE(dma_mapping_error(ndev->dev.parent, skb_dma_addr)))
>> +		return NETDEV_TX_BUSY;
>
> The appropriate behavior in this situation is to drop the packet and return
> NETDEV_TX_OK.

Ok, and I guess the same goes for the error handling of dma_map_single()
of one of the fragments later in same function.

/Esben
