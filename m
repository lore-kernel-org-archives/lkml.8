Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8098C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 01:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90FD20768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 01:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgF1BDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 21:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgF1BDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 21:03:40 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DF7C061794;
        Sat, 27 Jun 2020 18:03:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C6E29140AD8DC;
        Sat, 27 Jun 2020 18:03:39 -0700 (PDT)
Date:   Sat, 27 Jun 2020 18:03:38 -0700 (PDT)
Message-Id: <20200627.180338.2167394599747071444.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        dsahern@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: Fix wrong type conversion from hint to rt
 in ip_route_use_hint()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1593244071-28291-1-git-send-email-linmiaohe@huawei.com>
References: <1593244071-28291-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Jun 2020 18:03:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Sat, 27 Jun 2020 15:47:51 +0800

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> We can't cast sk_buff to rtable by (struct rtable *)hint. Use skb_rtable().
> 
> Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Please do not put empty lines between Fixes: and other tags.  All of the
tags belong together in a continuous uninterrupted sequence.

Applied and queued up for -stable, thank you.
