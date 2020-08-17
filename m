Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84039C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C0220674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgHQWIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbgHQWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:08:06 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21925C061389;
        Mon, 17 Aug 2020 15:08:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AC72215D679FC;
        Mon, 17 Aug 2020 14:51:18 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:08:03 -0700 (PDT)
Message-Id: <20200817.150803.1838250925233891556.davem@davemloft.net>
To:     dzagorui@cisco.com
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        "ikhoronz@cisco.com--cc=xe-linux-external"@cisco.com,
        xiyou.wangcong@gmail.com, ap420073@gmail.com,
        richardcochran@gmail.com, f.fainelli@gmail.com, andrew@lunn.ch,
        mkubecek@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: core: SIOCADDMULTI/SIOCDELMULTI distinguish
 between uc and mc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200817175224.49608-1-dzagorui@cisco.com>
References: <20200817175224.49608-1-dzagorui@cisco.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Aug 2020 14:51:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Zagorui <dzagorui@cisco.com>
Date: Mon, 17 Aug 2020 10:52:24 -0700

> SIOCADDMULTI API allows adding multicast/unicast mac addresses but
> doesn't deferentiate them so if someone tries to add secondary
> unicast mac addr it will be added to multicast netdev list which is
> confusing. There is at least one user that allows adding secondary
> unicast through this API.
> (2f41f3358672 i40e/i40evf: fix unicast mac address add)

This doesn't seem appropriate at all.  If anything UC addresses
should be blocked and the Intel driver change reverted.  We have
a well defined way to add secondary UC addresses and the MC interfaces
are not it.

Furthermore, even if this was appropriate, "fixing" this only for
ethernet is definitely not appropriate.  The fix would need to be able
to handle any address type.  Having a generic interface work
inconsistently for one link type vs. another is a non-starter.

Thanks.
