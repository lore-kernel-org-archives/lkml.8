Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8502064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGQRvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:51:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36279 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727101AbgGQRvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:51:39 -0400
Received: (qmail 1157221 invoked by uid 1000); 17 Jul 2020 13:51:38 -0400
Date:   Fri, 17 Jul 2020 13:51:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200717175138.GB1156312@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717174750.GQ12769@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
...
> > +		/* on success, pairs with smp_load_acquire() above and below */
> > +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> 
> Why do we have cmpxchg_release() anyway?  Under what circumstances is
> cmpxchg() useful _without_ having release semantics?

To answer just the last question: cmpxchg() is useful for lock 
acquisition, in which case it needs to have acquire semantics rather 
than release semantics.

Alan Stern

