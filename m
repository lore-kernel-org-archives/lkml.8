Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03943C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAACA206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHHVZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgHHVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 17:25:20 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0ECC061756;
        Sat,  8 Aug 2020 14:25:19 -0700 (PDT)
Received: from localhost (50-47-102-2.evrt.wa.frontiernet.net [50.47.102.2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EAEF812733530;
        Sat,  8 Aug 2020 14:08:32 -0700 (PDT)
Date:   Sat, 08 Aug 2020 14:25:17 -0700 (PDT)
Message-Id: <20200808.142517.298909034090859573.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuba@kernel.org, pshelar@ovn.org, martin.varghese@nokia.com,
        fw@strlen.de, willemb@google.com, edumazet@google.com,
        dcaratti@redhat.com, steffen.klassert@secunet.com,
        pabeni@redhat.com, shmulik@metanetworks.com,
        kyk.segfault@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] net: Use helper function ip_is_fragment()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1596715038-25429-1-git-send-email-linmiaohe@huawei.com>
References: <1596715038-25429-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 08 Aug 2020 14:08:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Thu, 6 Aug 2020 19:57:18 +0800

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Use helper function ip_is_fragment() to check ip fragment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied.
