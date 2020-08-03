Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D19C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756FC2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgHCWvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgHCWvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:51:45 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A9AC06174A;
        Mon,  3 Aug 2020 15:51:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E7D5312777F37;
        Mon,  3 Aug 2020 15:34:59 -0700 (PDT)
Date:   Mon, 03 Aug 2020 15:51:44 -0700 (PDT)
Message-Id: <20200803.155144.1285440527272961526.davem@davemloft.net>
To:     baijiaju@tsinghua.edu.cn
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: idt77252: avoid accessing the data mapped to
 streaming DMA
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200802093340.3475-1-baijiaju@tsinghua.edu.cn>
References: <20200802093340.3475-1-baijiaju@tsinghua.edu.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 15:35:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
Date: Sun,  2 Aug 2020 17:33:40 +0800

> In queue_skb(), skb->data is mapped to streaming DMA on line 850:
>   dma_map_single(..., skb->data, ...);
> 
> Then skb->data is accessed on lines 862 and 863:
>   tbd->word_4 = (skb->data[0] << 24) | (skb->data[1] << 16) |
>            (skb->data[2] <<  8) | (skb->data[3] <<  0);
> and on lines 893 and 894:
>   tbd->word_4 = (skb->data[0] << 24) | (skb->data[1] << 16) |
>            (skb->data[2] <<  8) | (skb->data[3] <<  0);
> 
> These accesses may cause data inconsistency between CPU cache and
> hardware.
> 
> To fix this problem, the calculation result of skb->data is stored in a
> local variable before DMA mapping, and then the driver accesses this
> local variable instead of skb->data.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>

Applied.
