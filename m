Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63112C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FCD20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393511AbgFWVdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391365AbgFWVdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:33:14 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C9C061573;
        Tue, 23 Jun 2020 14:33:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C76DA129425B6;
        Tue, 23 Jun 2020 14:33:13 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:33:11 -0700 (PDT)
Message-Id: <20200623.143311.995885759487352025.davem@davemloft.net>
To:     likaige@loongson.cn
Cc:     benve@cisco.com, _govind@gmx.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lixuefeng@loongson.cn,
        yangtiezhu@loongson.cn
Subject: Re: [PATCH RESEND] net/cisco: Fix a sleep-in-atomic-context bug in
 enic_init_affinity_hint()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1592899989-22049-1-git-send-email-likaige@loongson.cn>
References: <1592899989-22049-1-git-send-email-likaige@loongson.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Jun 2020 14:33:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaige Li <likaige@loongson.cn>
Date: Tue, 23 Jun 2020 16:13:09 +0800

> The kernel module may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) are:
> 
> [FUNC] zalloc_cpumask_var(GFP_KERNEL)
> drivers/net/ethernet/cisco/enic/enic_main.c, 125: zalloc_cpumask_var in enic_init_affinity_hint
> drivers/net/ethernet/cisco/enic/enic_main.c, 1918: enic_init_affinity_hint in enic_open
> drivers/net/ethernet/cisco/enic/enic_main.c, 2348: enic_open in enic_reset
> drivers/net/ethernet/cisco/enic/enic_main.c, 2341: spin_lock in enic_reset
> 
> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> Signed-off-by: Kaige Li <likaige@loongson.cn>

Just grepping around for GFP_KERNEL usage in atomic contexts I guess
is fine.

But you really have to look at the bigger picture.

Calling a NIC driver open function from a context holding a spinlock
is very much the real problem, so many operations have to sleep and
in face that ->ndo_open() method is defined as being allowed to sleep
and that's why the core networking never invokes it with spinlocks
held.
