Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF8EC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D85C20709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCTU5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:57:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51187 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726880AbgCTU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:57:00 -0400
Received: (qmail 2866 invoked by uid 500); 20 Mar 2020 16:56:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2020 16:56:59 -0400
Date:   Fri, 20 Mar 2020 16:56:59 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        <linux-arch@vger.kernel.org>, Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where
 reader stores
In-Reply-To: <20200320165948.GB155212@google.com>
Message-ID: <Pine.LNX.4.44L0.2003201643370.31761-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020, Joel Fernandes wrote:

> On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> > On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> > 
> > > This adds an example for the important RCU grace period guarantee, which
> > > shows an RCU reader can never span a grace period.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > 
> > > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > new file mode 100644
> > > index 0000000000000..73557772e2a32
> > > --- /dev/null
> > > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > 
> > Do these new tests really belong here?  I thought we were adding a new 
> > directory under Documentation/ for litmus tests that illustrate parts 
> > of the LKMM or memory-barriers.txt.
> > 
> > By contrast, the tests under tools/memory-model are merely to show 
> > people what litmus tests look like and how they should be written.
> 
> I could add it to tools/memory-model/Documentation/ under a new
> 'examples' directory there. We could also create an 'rcu' directory in
> tools/memory-model/litmus-tests/ and add these there. Thoughts?

What happened was that about a month ago, Boqun Feng added
Documentation/atomic-tests for litmus tests related to handling of
atomic_t types (see
<https://marc.info/?l=linux-kernel&m=158276408609029&w=2>.)  Should we
interpose an extra directory level, making it
Documentation/litmus-tests/atomic?  Or
Documentation/LKMM-litmus-tests/atomic?

Then the new tests added here could go into
Documentation/litmus-tests/rcu, or whatever.

Alan

