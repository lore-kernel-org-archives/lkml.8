Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D2C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8686D24673
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgBZJql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:46:41 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45547 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728008AbgBZJqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:46:39 -0500
From:   Luc Maranget <luc.maranget@inria.fr>
X-IronPort-AV: E=Sophos;i="5.70,487,1574118000"; 
   d="scan'208";a="437707730"
Received: from yquem.paris.inria.fr (HELO yquem.inria.fr) ([128.93.101.33])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2020 10:46:37 +0100
Received: by yquem.inria.fr (Postfix, from userid 18041)
        id 9DB44E1AAB; Wed, 26 Feb 2020 10:46:37 +0100 (CET)
Date:   Wed, 26 Feb 2020 10:46:37 +0100
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: More on reader-writer locks
Message-ID: <20200226094637.rhli3jjuiim2noke@yquem.inria.fr>
References: <20200225130102.wsz3bpyhjmcru7os@yquem.inria.fr>
 <Pine.LNX.4.44L0.2002251608290.1485-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.2002251608290.1485-100000@iolanthe.rowland.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As far as I understand there is a contradiction between having a "platonic"
implementation of locks (à la lock.cat) and a concrete one (for ordinary locks
lock -> load acquire, unlock -> store release, + loop [difficult for herd]
or filter clause).

So if reader/writer locks are catified in a platonic way, we cannot
use various atomic primitives. Instead, we give them an abstract semantics
based upon some axiomatisation of their semantics, using cat means.
Such an axionatisation  does not seem straightforward because,
by constrast with locks, there is an integer count
hiddden, and not a simple boolean as for ordinary locks

Some idea would be first to partition reader crtical sections,
and then for each such partition, order elements of the partition and
writer critical section. For one such choice there are still many possible
rf relations...

--Luc

rf relation 
> On Tue, 25 Feb 2020, Luc Maranget wrote:
> 
> > Hi,
> > 
> > As far as I can remember I have implemented atomic_add_unless in herd7.
> 
> Luc, have you considered whether we can use atomic_add_unless and
> cmpxchg to implement reader-writer locks in the LKMM?  I don't think we
> can handle them the same way we handle ordinary locks now.
> 
> Let's say that a lock variable holds 0 if it is unlocked, -1 if it is 
> write-locked, and a positive value if it is read-locked (the value is 
> the number of read locks currently in effect).  Then operations like 
> write_lock, write_trylock, and so on could all be modeled using 
> variants of atomic_add_unless, atomic_dec, and cmpxchg.
> 
> But will that work if the reads-from relation is computed by the cat 
> code in lock.cat?  I suspect it won't.
> 
> How would you approach this problem?
> 
> Alan
