Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F8DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36E8206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbgFTDPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732429AbgFTDPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:15:05 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D259C06174E;
        Fri, 19 Jun 2020 20:15:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3303E127853B9;
        Fri, 19 Jun 2020 20:15:05 -0700 (PDT)
Date:   Fri, 19 Jun 2020 20:15:04 -0700 (PDT)
Message-Id: <20200619.201504.540882827677086606.davem@davemloft.net>
To:     zhengbin13@huawei.com
Cc:     kuba@kernel.org, michael-dev@fami-braun.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next] macvlan: Fix memleak in
 macvlan_changelink_sources
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200618132629.659977-1-zhengbin13@huawei.com>
References: <20200618132629.659977-1-zhengbin13@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Jun 2020 20:15:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Bin <zhengbin13@huawei.com>
Date: Thu, 18 Jun 2020 21:26:29 +0800

> macvlan_changelink_sources
>   if (addr)
>     ret = macvlan_hash_add_source(vlan, addr)
>   nla_for_each_attr(nla, head, len, rem)
>     ret = macvlan_hash_add_source(vlan, addr)
>     -->If fail, need to free previous malloc memory
> 
> Fixes: 79cf79abce71 ("macvlan: add source mode")
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

Bug fixes should never be submitted against net-next.

They should instead be submitted against 'net'.

Thank you.
