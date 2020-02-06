Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F9BC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2693217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBFM72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:59:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59182 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:59:27 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 30A2914C6027B;
        Thu,  6 Feb 2020 04:59:26 -0800 (PST)
Date:   Thu, 06 Feb 2020 13:59:24 +0100 (CET)
Message-Id: <20200206.135924.1302030268583776261.davem@davemloft.net>
To:     cai@lca.pw
Cc:     kuba@kernel.org, elver@google.com, eric.dumazet@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] skbuff: fix a data race in skb_queue_len()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1580841629-7102-1-git-send-email-cai@lca.pw>
References: <1580841629-7102-1-git-send-email-cai@lca.pw>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 06 Feb 2020 04:59:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>
Date: Tue,  4 Feb 2020 13:40:29 -0500

> sk_buff.qlen can be accessed concurrently as noticed by KCSAN,
> 
>  BUG: KCSAN: data-race in __skb_try_recv_from_queue / unix_dgram_sendmsg
> 
>  read to 0xffff8a1b1d8a81c0 of 4 bytes by task 5371 on cpu 96:
>   unix_dgram_sendmsg+0x9a9/0xb70 include/linux/skbuff.h:1821
> 				 net/unix/af_unix.c:1761
>   ____sys_sendmsg+0x33e/0x370
>   ___sys_sendmsg+0xa6/0xf0
>   __sys_sendmsg+0x69/0xf0
>   __x64_sys_sendmsg+0x51/0x70
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  write to 0xffff8a1b1d8a81c0 of 4 bytes by task 1 on cpu 99:
>   __skb_try_recv_from_queue+0x327/0x410 include/linux/skbuff.h:2029
>   __skb_try_recv_datagram+0xbe/0x220
>   unix_dgram_recvmsg+0xee/0x850
>   ____sys_recvmsg+0x1fb/0x210
>   ___sys_recvmsg+0xa2/0xf0
>   __sys_recvmsg+0x66/0xf0
>   __x64_sys_recvmsg+0x51/0x70
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Since only the read is operating as lockless, it could introduce a logic
> bug in unix_recvq_full() due to the load tearing. Fix it by adding
> a lockless variant of skb_queue_len() and unix_recvq_full() where
> READ_ONCE() is on the read while WRITE_ONCE() is on the write similar to
> the commit d7d16a89350a ("net: add skb_queue_empty_lockless()").
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied, thank you.
