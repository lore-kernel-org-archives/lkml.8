Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C0C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CD320719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgCXEAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 00:00:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55878 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgCXEA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 00:00:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F380E15433174;
        Mon, 23 Mar 2020 21:00:27 -0700 (PDT)
Date:   Mon, 23 Mar 2020 21:00:26 -0700 (PDT)
Message-Id: <20200323.210026.2188935498095960390.davem@davemloft.net>
To:     cai@lca.pw
Cc:     alexander.h.duyck@linux.intel.com, kuznet@ms2.inr.ac.ru,
        kuba@kernel.org, yoshfuji@linux-ipv6.org, dsahern@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ipv4: fix a RCU-list lock in inet_dump_fib()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200320025421.9216-1-cai@lca.pw>
References: <20200320025421.9216-1-cai@lca.pw>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Mar 2020 21:00:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>
Date: Thu, 19 Mar 2020 22:54:21 -0400

> There is a place,
> 
> inet_dump_fib()
>   fib_table_dump
>     fn_trie_dump_leaf()
>       hlist_for_each_entry_rcu()
> 
> without rcu_read_lock() will trigger a warning,
> 
>  WARNING: suspicious RCU usage
 ...
> Fixes: 18a8021a7be3 ("net/ipv4: Plumb support for filtering route dumps")
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied and queued up for -stable, thank you.
