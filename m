Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1372074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgGaAlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbgGaAlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:41:25 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C69C061574;
        Thu, 30 Jul 2020 17:41:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 53C2E126C48CE;
        Thu, 30 Jul 2020 17:24:39 -0700 (PDT)
Date:   Thu, 30 Jul 2020 17:41:24 -0700 (PDT)
Message-Id: <20200730.174124.1077558881160047416.davem@davemloft.net>
To:     liheng40@huawei.com
Cc:     michael.chan@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] bnxt_en: Remove superfluous memset()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1596091430-19486-1-git-send-email-liheng40@huawei.com>
References: <1596091430-19486-1-git-send-email-liheng40@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jul 2020 17:24:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Heng <liheng40@huawei.com>
Date: Thu, 30 Jul 2020 14:43:50 +0800

> Fixes coccicheck warning:
> 
> ./drivers/net/ethernet/broadcom/bnxt/bnxt.c:3730:19-37: WARNING:
> dma_alloc_coherent use in stats -> hw_stats already zeroes out
> memory,  so memset is not needed
> 
> dma_alloc_coherent use in status already zeroes out memory,
> so memset is not needed
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Heng <liheng40@huawei.com>

Applied.
