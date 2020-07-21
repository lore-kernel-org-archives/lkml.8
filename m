Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62F6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DD920771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgGUWmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUWmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:42:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F9C061794;
        Tue, 21 Jul 2020 15:42:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 97ADB11E45906;
        Tue, 21 Jul 2020 15:25:52 -0700 (PDT)
Date:   Tue, 21 Jul 2020 15:42:36 -0700 (PDT)
Message-Id: <20200721.154236.1466030648919683295.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        wangchen@cn.fujitsu.com, herbert@gondor.apana.org.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: udp: Fix wrong clean up for IS_UDPLITE macro
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1595322704-31548-1-git-send-email-linmiaohe@huawei.com>
References: <1595322704-31548-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jul 2020 15:25:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Tue, 21 Jul 2020 17:11:44 +0800

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> We can't use IS_UDPLITE to replace udp_sk->pcflag when UDPLITE_RECV_CC is
> checked.
> 
> Fixes: b2bf1e2659b1 ("[UDP]: Clean up for IS_UDPLITE macro")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied and queued up for -stable, thanks.
