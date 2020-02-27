Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A233DC4BA35
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812812467A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgB0A7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:59:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35592 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgB0A7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:59:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 382E915AE086D;
        Wed, 26 Feb 2020 16:59:32 -0800 (PST)
Date:   Wed, 26 Feb 2020 16:59:31 -0800 (PST)
Message-Id: <20200226.165931.1079328769851545825.davem@davemloft.net>
To:     madhuparnabhowmik10@gmail.com
Cc:     jiri@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, paulmck@kernel.org
Subject: Re: [PATCH] net: core: devlink.c: Use built-in RCU list checking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200225122745.31095-1-madhuparnabhowmik10@gmail.com>
References: <20200225122745.31095-1-madhuparnabhowmik10@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Feb 2020 16:59:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: madhuparnabhowmik10@gmail.com
Date: Tue, 25 Feb 2020 17:57:45 +0530

> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> list_for_each_entry_rcu() has built-in RCU and lock checking.
> 
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled.
> 
> The devlink->lock is held when devlink_dpipe_table_find()
> is called in non RCU read side section. Therefore, pass struct devlink
> to devlink_dpipe_table_find() for lockdep checking.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Applied, thank you.
