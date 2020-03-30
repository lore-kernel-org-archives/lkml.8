Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D07CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A3F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgC3EwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:52:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33118 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3EwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 00:52:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3867415C54872;
        Sun, 29 Mar 2020 21:52:24 -0700 (PDT)
Date:   Sun, 29 Mar 2020 21:52:23 -0700 (PDT)
Message-Id: <20200329.215223.1631308723332593306.davem@davemloft.net>
To:     cai@lca.pw
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        eric.dumazet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ipv4: fix a RCU-list lock in fib_triestat_seq_show
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200325220100.7863-1-cai@lca.pw>
References: <20200325220100.7863-1-cai@lca.pw>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Mar 2020 21:52:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>
Date: Wed, 25 Mar 2020 18:01:00 -0400

> fib_triestat_seq_show() calls hlist_for_each_entry_rcu(tb, head,
> tb_hlist) without rcu_read_lock() will trigger a warning,
> 
>  net/ipv4/fib_trie.c:2579 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  1 lock held by proc01/115277:
>   #0: c0000014507acf00 (&p->lock){+.+.}-{3:3}, at: seq_read+0x58/0x670
> 
>  Call Trace:
>   dump_stack+0xf4/0x164 (unreliable)
>   lockdep_rcu_suspicious+0x140/0x164
>   fib_triestat_seq_show+0x750/0x880
>   seq_read+0x1a0/0x670
>   proc_reg_read+0x10c/0x1b0
>   __vfs_read+0x3c/0x70
>   vfs_read+0xac/0x170
>   ksys_read+0x7c/0x140
>   system_call+0x5c/0x68
> 
> Fix it by adding a pair of rcu_read_lock/unlock() and use
> cond_resched_rcu() to avoid the situation where walking of a large
> number of items  may prevent scheduling for a long time.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied and queued up for -stable, thanks.
