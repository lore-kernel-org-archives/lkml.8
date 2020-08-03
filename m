Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB652086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgHCW7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgHCW7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:59:51 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37236C06174A;
        Mon,  3 Aug 2020 15:59:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CACAA1277916C;
        Mon,  3 Aug 2020 15:43:04 -0700 (PDT)
Date:   Mon, 03 Aug 2020 15:59:49 -0700 (PDT)
Message-Id: <20200803.155949.39743839019093809.davem@davemloft.net>
To:     baijiaju@tsinghua.edu.cn
Cc:     doshir@vmware.com, pv-drivers@vmware.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: vmxnet3: avoid accessing the data mapped to
 streaming DMA
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200802131107.15857-1-baijiaju@tsinghua.edu.cn>
References: <20200802131107.15857-1-baijiaju@tsinghua.edu.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 15:43:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
Date: Sun,  2 Aug 2020 21:11:07 +0800

> In vmxnet3_probe_device(), "adapter" is mapped to streaming DMA:
>   adapter->adapter_pa = dma_map_single(..., adapter, ...);
> 
> Then "adapter" is accessed at many places in this function.
> 
> Theses accesses may cause data inconsistency between CPU cache and 
> hardware.
> 
> To fix this problem, dma_map_single() is called after these accesses.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>

'adapter' is accessed everywhere, in the entire driver, not just here
in the probe function.
