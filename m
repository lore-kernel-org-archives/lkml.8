Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44504C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2797320768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392135AbgDNX2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:28:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35884 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbgDNX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:28:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2AE41280C044;
        Tue, 14 Apr 2020 16:28:08 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:27:15 -0700 (PDT)
Message-Id: <20200414.162715.162785138701944842.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix DATA Tx to disable nofrag for UDP on
 AF_INET6 socket
From:   David Miller <davem@davemloft.net>
In-Reply-To: <158678263441.2860393.4171676680352045929.stgit@warthog.procyon.org.uk>
References: <158678263441.2860393.4171676680352045929.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Apr 2020 16:28:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Mon, 13 Apr 2020 13:57:14 +0100

> Fix the DATA packet transmission to disable nofrag for UDPv4 on an AF_INET6
> socket as well as UDPv6 when trying to transmit fragmentably.
> 
> Without this, packets filled to the normal size used by the kernel AFS
> client of 1412 bytes be rejected by udp_sendmsg() with EMSGSIZE
> immediately.  The ->sk_error_report() notification hook is called, but
> rxrpc doesn't generate a trace for it.
> 
> This is a temporary fix; a more permanent solution needs to involve
> changing the size of the packets being filled in accordance with the MTU,
> which isn't currently done in AF_RXRPC.  The reason for not doing so was
> that, barring the last packet in an rx jumbo packet, jumbos can only be
> assembled out of 1412-byte packets - and the plan was to construct jumbos
> on the fly at transmission time.
> 
> Also, there's no point turning on IPV6_MTU_DISCOVER, since IPv6 has to
> engage in this anyway since fragmentation is only done by the sender.  We
> can then condense the switch-statement in rxrpc_send_data_packet().
> 
> Fixes: 75b54cb57ca3 ("rxrpc: Add IPv6 support")
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thanks David.
