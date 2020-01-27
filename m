Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5923DC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6C521569
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgA0J5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:57:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36776 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgA0J5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:57:20 -0500
Received: from localhost (unknown [213.175.37.12])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 762F21504FE7C;
        Mon, 27 Jan 2020 01:57:19 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:57:17 +0100 (CET)
Message-Id: <20200127.105717.1488016004887769192.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix use-after-free in rxrpc_receive_data()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <157990728440.1173687.14473656600696398776.stgit@warthog.procyon.org.uk>
References: <157990728440.1173687.14473656600696398776.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Jan 2020 01:57:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Fri, 24 Jan 2020 23:08:04 +0000

> The subpacket scanning loop in rxrpc_receive_data() references the
> subpacket count in the private data part of the sk_buff in the loop
> termination condition.  However, when the final subpacket is pasted into
> the ring buffer, the function is no longer has a ref on the sk_buff and
> should not be looking at sp->* any more.  This point is actually marked in
> the code when skb is cleared (but sp is not - which is an error).
> 
> Fix this by caching sp->nr_subpackets in a local variable and using that
> instead.
> 
> Also clear 'sp' to catch accesses after that point.
> 
> This can show up as an oops in rxrpc_get_skb() if sp->nr_subpackets gets
> trashed by the sk_buff getting freed and reused in the meantime.
> 
> Fixes: e2de6c404898 ("rxrpc: Use info in skbuff instead of reparsing a jumbo packet")
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied and queued up for -stable, thanks.
