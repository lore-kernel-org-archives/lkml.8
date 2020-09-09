Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F46C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB3C21941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIIDSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIIDSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:18:40 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE56C061573;
        Tue,  8 Sep 2020 20:18:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E211D11E3E4C3;
        Tue,  8 Sep 2020 20:01:51 -0700 (PDT)
Date:   Tue, 08 Sep 2020 20:18:38 -0700 (PDT)
Message-Id: <20200908.201838.1474174755046579625.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] rxrpc: Allow more calls to same peer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <159959825107.645007.502549394334535916.stgit@warthog.procyon.org.uk>
References: <159959825107.645007.502549394334535916.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Tue, 08 Sep 2020 20:01:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Tue, 08 Sep 2020 21:50:51 +0100

> Here are some development patches for AF_RXRPC that allow more simultaneous
> calls to be made to the same peer with the same security parameters.  The
> current code allows a maximum of 4 simultaneous calls, which limits the afs
> filesystem to that many simultaneous threads.  This increases the limit to
> 16.
> 
> To make this work, the way client connections are limited has to be changed
> (incoming call/connection limits are unaffected) as the current code
> depends on queuing calls on a connection and then pushing the connection
> through a queue.  The limit is on the number of available connections.
> 
> This is changed such that there's a limit[*] on the total number of calls
> systemwide across all namespaces, but the limit on the number of client
> connections is removed.
> 
> Once a call is allowed to proceed, it finds a bundle of connections and
> tries to grab a call slot.  If there's a spare call slot, fine, otherwise
> it will wait.  If there's already a waiter, it will try to create another
> connection in the bundle, unless the limit of 4 is reached (4 calls per
> connection, giving 16).
> 
> A number of things throttle someone trying to set up endless connections:
> 
>  - Calls that fail immediately have their conns deleted immediately,
> 
>  - Calls that don't fail immediately have to wait for a timeout,
> 
>  - Connections normally get automatically reaped if they haven't been used
>    for 2m, but this is sped up to 2s if the number of connections rises
>    over 900.  This number is tunable by sysctl.
> 
> 
> [*] Technically two limits - kernel sockets and userspace rxrpc sockets are
>     accounted separately.
> 
> The patches are tagged here:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 	rxrpc-next-20200908

Pulled, thanks David.
