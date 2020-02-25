Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF3C35E15
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCF120675
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgBYVmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:42:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39684 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726421AbgBYVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:42:04 -0500
Received: (qmail 6807 invoked by uid 2102); 25 Feb 2020 16:42:03 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2020 16:42:03 -0500
Date:   Tue, 25 Feb 2020 16:42:03 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Luc Maranget <luc.maranget@inria.fr>
cc:     Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: More on reader-writer locks
In-Reply-To: <20200225130102.wsz3bpyhjmcru7os@yquem.inria.fr>
Message-ID: <Pine.LNX.4.44L0.2002251608290.1485-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020, Luc Maranget wrote:

> Hi,
> 
> As far as I can remember I have implemented atomic_add_unless in herd7.

Luc, have you considered whether we can use atomic_add_unless and
cmpxchg to implement reader-writer locks in the LKMM?  I don't think we
can handle them the same way we handle ordinary locks now.

Let's say that a lock variable holds 0 if it is unlocked, -1 if it is 
write-locked, and a positive value if it is read-locked (the value is 
the number of read locks currently in effect).  Then operations like 
write_lock, write_trylock, and so on could all be modeled using 
variants of atomic_add_unless, atomic_dec, and cmpxchg.

But will that work if the reads-from relation is computed by the cat 
code in lock.cat?  I suspect it won't.

How would you approach this problem?

Alan

