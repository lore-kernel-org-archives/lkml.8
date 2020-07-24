Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6A8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4D620714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595584163;
	bh=u2Z7X+uJYDoLzGxGwVX9jVBtloIF61nU1olnIGylT/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SiSc0imwvoMgNswntkClYdaqRxvCK/KWBUfGzKJdIGarxXQhl6e1lgl6QgdO84sEh
	 Zvzlgr8YJgRKhJ3mRvvZvd9g9/EHvJOaFooAEkCCcHMg46lN7BxYmyOlz2y5A2r4uN
	 QdbLyVgdXBZ8w54G25QdP1czD2LkibhXgLLWi1Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGXJtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXJtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:49:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF992070B;
        Fri, 24 Jul 2020 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595584161;
        bh=u2Z7X+uJYDoLzGxGwVX9jVBtloIF61nU1olnIGylT/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyHr6C7KJNYR4r9xXQvha79XDXnXoB5mmnEjnSI5V2i5W+Cq59mym8ouCaNcJDbWM
         otg1Qh7zK91EEI2YUu276lTBvKNdaE7fZPX+q3tULNg3BnlIoNmFkMZv+Jq7n5lv1Z
         0ljBP2j7c0i5Uzep1Y4JqkYVNBPEGxdgRQL00z+s=
Date:   Fri, 24 Jul 2020 11:49:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aviraj CJ <acj@cisco.com>
Cc:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        davem@davemloft.net, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH stable v4.19] tipc: clean up skb list lock handling on
 send path
Message-ID: <20200724094922.GA122698@kroah.com>
References: <20200722174157.34361-1-acj@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722174157.34361-1-acj@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:41:57AM -0700, Aviraj CJ wrote:
> From: Jon Maloy <jon.maloy@ericsson.com>
> 
> upstream e654f9f53b45fde3fcc8051830b212c7a8f36148 commit
> 
> The policy for handling the skb list locks on the send and receive paths
> is simple.
> 
> - On the send path we never need to grab the lock on the 'xmitq' list
>   when the destination is an exernal node.
> 
> - On the receive path we always need to grab the lock on the 'inputq'
>   list, irrespective of source node.
> 
> However, when transmitting node local messages those will eventually
> end up on the receive path of a local socket, meaning that the argument
> 'xmitq' in tipc_node_xmit() will become the 'ínputq' argument in  the
> function tipc_sk_rcv(). This has been handled by always initializing
> the spinlock of the 'xmitq' list at message creation, just in case it
> may end up on the receive path later, and despite knowing that the lock
> in most cases never will be used.
> 
> This approach is inaccurate and confusing, and has also concealed the
> fact that the stated 'no lock grabbing' policy for the send path is
> violated in some cases.
> 
> We now clean up this by never initializing the lock at message creation,
> instead doing this at the moment we find that the message actually will
> enter the receive path. At the same time we fix the four locations
> where we incorrectly access the spinlock on the send/error path.
> 
> This patch also reverts commit d12cffe9329f ("tipc: ensure head->lock
> is initialised") which has now become redundant.
> 
> Additional comment:
> Below crash was seen while accessing uninitialized spinlock in skb_dequeue.
> 
> [ 282.961198] general protection fault: 0000 1 SMP PTI
> [ 282.961204] CPU: 0 PID: 9 Comm: ksoftirqd/0 Kdump: loaded : G O 4.19.106 #1
> [ 282.961218] Hardware name: Insyde Grangeville/Type2 - Board Product Name1, BIOS 05.05.15.0026 06/23/2016
> [ 282.961233] RIP: 0010:queued_spin_lock_slowpath+0x14c/0x190
> [ 282.961239] Code: ff ff 83 e8 01 75 eb e9 14 ff ff ff c1 e9 12 83 e0 03 83 e9 01 48 c1 e0 04 48 63 c9 48 05 00 ed 01 00 48 03 04 cd 80 c4 83 87 <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 02
> [ 282.961248] RSP: 0018:ffffa2510008b988 EFLAGS: 00010006
> [ 282.961254] RAX: 0065646f6d615d9f RBX: 0000000000000202 RCX: 0000000000003ffe
> [ 282.961259] RDX: ffff9a2b77c1ed00 RSI: 0000000000040000 RDI: ffffa2510008ba5c
> [ 282.961264] RBP: ffffa2510008ba48 R08: 00000000ffffffff R09: 0000000000000550
> [ 282.961271] R10: ffff9a2b54bb9050 R11: 0000000000000001 R12: ffffa2510008ba5c
> [ 282.961277] R13: ffff9a2b5fc1e800 R14: ffff9a2b5fc1e808 R15: 000000000000058c
> [ 282.961283] FS: 0000000000000000(0000) GS:ffff9a2b77c00000(0000) knlGS:0000000000000000
> [ 282.961288] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 282.961292] CR2: 00007f3f1321d2ac CR3: 00000001f0c0a002 CR4: 00000000003606f0
> [ 282.961297] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 282.961301] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 282.961307] Call Trace:
> [ 282.961321] _raw_spin_lock_irqsave+0x24/0x30
> [ 282.961331] skb_dequeue+0x18/0x60
> [ 282.961339] skb_queue_purge+0x1b/0x30
> [ 282.961359] tipc_node_xmit+0x155/0x170 [tipc]
> [ 282.961376] ? tipc_msg_init+0x2c/0xa0 [tipc]
> [ 282.961390] tipc_named_node_up+0x1d6/0x210 [tipc]
> [ 282.961406] tipc_node_write_unlock+0xf0/0x100 [tipc]
> [ 282.961421] tipc_rcv+0x54c/0xc90 [tipc]
> [ 282.961431] ? br_handle_frame_finish+0x3e0/0x3e0
> [ 282.961439] ? br_handle_frame_finish+0x3e0/0x3e0
> [ 282.961450] tipc_l2_rcv_msg+0x4a/0x70 [tipc]
> [ 282.961458] __netif_receive_skb_one_core+0x52/0x70
> [ 282.961465] netif_receive_skb_internal+0x39/0xb0
> [ 282.961472] br_pass_frame_up+0xe8/0xf0
> [ 282.961478] ? fdb_find_rcu+0xcd/0x130
> [ 282.961485] br_handle_frame_finish+0x27a/0x3e0
> [ 282.961493] br_handle_frame+0x191/0x2e0
> [ 282.961499] ? br_pass_frame_up+0xf0/0xf0
> [ 282.961506] __netif_receive_skb_core+0x1da/0xa70
> 
> CC: Eric Dumazet <edumazet@google.com>
> Reported-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Ying Xue <ying.xue@windriver.com>
> Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
> Reviewed-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [acj: backport v4.19 -stable
> - adjust context
> - skipped the hunk modifying non-existent function tipc_mcast_send_sync
> - additional comment ]

Now queued up, thanks.

greg k-h
