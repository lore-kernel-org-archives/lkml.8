Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E4920767
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbgFXDX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgFXDX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:23:26 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C44BC061573;
        Tue, 23 Jun 2020 20:23:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5033A1298361E;
        Tue, 23 Jun 2020 20:23:25 -0700 (PDT)
Date:   Tue, 23 Jun 2020 20:23:24 -0700 (PDT)
Message-Id: <20200623.202324.442008830004872069.davem@davemloft.net>
To:     likaige@loongson.cn
Cc:     benve@cisco.com, _govind@gmx.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lixuefeng@loongson.cn,
        yangtiezhu@loongson.cn
Subject: Re: [PATCH RESEND] net/cisco: Fix a sleep-in-atomic-context bug in
 enic_init_affinity_hint()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <7533075e-0e8e-2fde-c8fa-72e2ea222176@loongson.cn>
References: <20200623.143311.995885759487352025.davem@davemloft.net>
        <20200623.152626.2206118203643133195.davem@davemloft.net>
        <7533075e-0e8e-2fde-c8fa-72e2ea222176@loongson.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Jun 2020 20:23:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaige Li <likaige@loongson.cn>
Date: Wed, 24 Jun 2020 09:56:47 +0800

> 
> On 06/24/2020 06:26 AM, David Miller wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Tue, 23 Jun 2020 14:33:11 -0700 (PDT)
>>
>>> Calling a NIC driver open function from a context holding a spinlock
>>> is very much the real problem, so many operations have to sleep and
>>> in face that ->ndo_open() method is defined as being allowed to sleep
>>> and that's why the core networking never invokes it with spinlocks
>>                                                        ^^^^
>>
>> I mean "without" of course. :-)
>>
>>> held.
> 
> Did you mean that open function should be out of spinlock? If so, I
> will
> send V2 patch.

Yes, but only if that is safe.

You have to analyze the locking done by this driver and fix it properly.
I anticipate it is not just a matter of changing where the spinlock
is held, you will have to rearchitect things a bit.
