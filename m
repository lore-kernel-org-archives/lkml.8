Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC27C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A33220CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBXVTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:19:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38564 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXVTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:19:42 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B142A121A82C6;
        Mon, 24 Feb 2020 13:19:41 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:19:41 -0800 (PST)
Message-Id: <20200224.131941.1864899496346758786.davem@davemloft.net>
To:     frextrite@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com,
        paulmck@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] ip6mr: Fix RCU list debugging warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200222165726.9330-1-frextrite@gmail.com>
References: <20200222165726.9330-1-frextrite@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Feb 2020 13:19:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>
Date: Sat, 22 Feb 2020 22:27:27 +0530

> ip6mr_for_each_table() macro uses list_for_each_entry_rcu()
> for traversing outside an RCU read side critical section
> but under the protection of rtnl_mutex. Hence add the
> corresponding lockdep expression to silence the following
> false-positive warnings:
> 
> [    4.319479] =============================
> [    4.319480] WARNING: suspicious RCU usage
> [    4.319482] 5.5.4-stable #17 Tainted: G            E
> [    4.319483] -----------------------------
> [    4.319485] net/ipv6/ip6mr.c:1243 RCU-list traversed in non-reader section!!
> 
> [    4.456831] =============================
> [    4.456832] WARNING: suspicious RCU usage
> [    4.456834] 5.5.4-stable #17 Tainted: G            E
> [    4.456835] -----------------------------
> [    4.456837] net/ipv6/ip6mr.c:1582 RCU-list traversed in non-reader section!!
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Applied, thanks.
