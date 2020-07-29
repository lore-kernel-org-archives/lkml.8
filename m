Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02EA2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbgG2AYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgG2AYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:24:49 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2805BC061794;
        Tue, 28 Jul 2020 17:24:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C1E0128D35D5;
        Tue, 28 Jul 2020 17:08:03 -0700 (PDT)
Date:   Tue, 28 Jul 2020 17:24:47 -0700 (PDT)
Message-Id: <20200728.172447.1925120854282970312.davem@davemloft.net>
To:     xiyuyang19@fudan.edu.cn
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tanxin.ctf@gmail.com
Subject: Re: [PATCH] ipv6: Fix nexthop refcnt leak when creating ipv6 route
 info
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1595664139-40703-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1595664139-40703-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 28 Jul 2020 17:08:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Date: Sat, 25 Jul 2020 16:02:18 +0800

> ip6_route_info_create() invokes nexthop_get(), which increases the
> refcount of the "nh".
> 
> When ip6_route_info_create() returns, local variable "nh" becomes
> invalid, so the refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in one exception handling path of
> ip6_route_info_create(). When nexthops can not be used with source
> routing, the function forgets to decrease the refcnt increased by
> nexthop_get(), causing a refcnt leak.
> 
> Fix this issue by pulling up the error source routing handling when
> nexthops can not be used with source routing.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Applied and queued up for -stable, thanks.
