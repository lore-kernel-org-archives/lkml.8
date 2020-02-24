Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC158C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81FC21556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXVCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:02:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38290 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBXVCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:02:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 721A012199AC5;
        Mon, 24 Feb 2020 13:02:35 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:02:32 -0800 (PST)
Message-Id: <20200224.130232.525260099054528171.davem@davemloft.net>
To:     frextrite@gmail.com
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com,
        paulmck@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] tcp, ulp: Pass lockdep expression to RCU lists
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200221151537.12334-1-frextrite@gmail.com>
References: <20200221151537.12334-1-frextrite@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Feb 2020 13:02:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>
Date: Fri, 21 Feb 2020 20:45:38 +0530

> tcp_ulp_list is traversed using list_for_each_entry_rcu
> outside an RCU read-side critical section but under the protection
> of tcp_ulp_list_lock.
> 
> Hence, add corresponding lockdep expression to silence false-positive
> warnings, and harden RCU lists.t
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Applied.
