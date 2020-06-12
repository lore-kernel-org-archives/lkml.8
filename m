Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37913C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 01:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1465F206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 01:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLBSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 21:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLBSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 21:18:49 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360EEC03E96F;
        Thu, 11 Jun 2020 18:18:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EC35A128AE837;
        Thu, 11 Jun 2020 18:18:45 -0700 (PDT)
Date:   Thu, 11 Jun 2020 18:18:42 -0700 (PDT)
Message-Id: <20200611.181842.2083721665296210889.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix race between incoming ACK parser and
 retransmitter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <159190902048.3557242.17524953697020439394.stgit@warthog.procyon.org.uk>
References: <159190902048.3557242.17524953697020439394.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Jun 2020 18:18:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 11 Jun 2020 21:57:00 +0100

> There's a race between the retransmission code and the received ACK parser.
> The problem is that the retransmission loop has to drop the lock under
> which it is iterating through the transmission buffer in order to transmit
> a packet, but whilst the lock is dropped, the ACK parser can crank the Tx
> window round and discard the packets from the buffer.
> 
> The retransmission code then updated the annotations for the wrong packet
> and a later retransmission thought it had to retransmit a packet that
> wasn't there, leading to a NULL pointer dereference.
> 
> Fix this by:
> 
>  (1) Moving the annotation change to before we drop the lock prior to
>      transmission.  This means we can't vary the annotation depending on
>      the outcome of the transmission, but that's fine - we'll retransmit
>      again later if it failed now.
> 
>  (2) Skipping the packet if the skb pointer is NULL.
> 
> The following oops was seen:
> 
> 	BUG: kernel NULL pointer dereference, address: 000000000000002d
> 	Workqueue: krxrpcd rxrpc_process_call
> 	RIP: 0010:rxrpc_get_skb+0x14/0x8a
> 	...
> 	Call Trace:
> 	 rxrpc_resend+0x331/0x41e
> 	 ? get_vtime_delta+0x13/0x20
> 	 rxrpc_process_call+0x3c0/0x4ac
> 	 process_one_work+0x18f/0x27f
> 	 worker_thread+0x1a3/0x247
> 	 ? create_worker+0x17d/0x17d
> 	 kthread+0xe6/0xeb
> 	 ? kthread_delayed_work_timer_fn+0x83/0x83
> 	 ret_from_fork+0x1f/0x30
> 
> Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thanks.
