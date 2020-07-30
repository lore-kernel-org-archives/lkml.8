Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D49C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B84D206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgG3X4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbgG3Xz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:55:59 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E1CC061574;
        Thu, 30 Jul 2020 16:55:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 48F89126C2B12;
        Thu, 30 Jul 2020 16:39:13 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:55:57 -0700 (PDT)
Message-Id: <20200730.165557.1799719576391347161.davem@davemloft.net>
To:     luwei32@huawei.com
Cc:     kuba@kernel.org, wangyunjian@huawei.com, dan.carpenter@oracle.com,
        andrew@lunn.ch, alex.williams@ni.com, mdf@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: nixge: fix potential memory leak in nixge_probe()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200729035005.89161-1-luwei32@huawei.com>
References: <20200729035005.89161-1-luwei32@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jul 2020 16:39:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Wei <luwei32@huawei.com>
Date: Wed, 29 Jul 2020 11:50:05 +0800

> If some processes in nixge_probe() fail, free_netdev(dev)
> needs to be called to aviod a memory leak.
> 
> Fixes: 87ab207981ec ("net: nixge: Separate ctrl and dma resources")
> Fixes: abcd3d6fc640 ("net: nixge: Fix error path for obtaining mac address")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Lu Wei <luwei32@huawei.com>

Applied, thank you.
