Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B42C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22762075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgELNoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:44:24 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49521 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726891AbgELNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:44:24 -0400
Received: (qmail 22763 invoked by uid 500); 12 May 2020 09:44:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2020 09:44:22 -0400
Date:   Tue, 12 May 2020 09:44:22 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>, <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort
 out location of litmus test and README
In-Reply-To: <20200512021309.GA197229@google.com>
Message-ID: <Pine.LNX.4.44L0.2005120942100.21033-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020, Joel Fernandes wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Mon, 11 May 2020 22:06:46 -0400
> Subject: [PATCH] docs: litmus-tests: Clarify about the RCU pre-initialization
>  test
> 
> Since this test was moved to tools/memory-model/, make sure that it is
> at least referenced from Documentation/litmus-tests/'s README.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/litmus-tests/README | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> index ac0b270b456c1..53f09e74734a4 100644
> --- a/Documentation/litmus-tests/README
> +++ b/Documentation/litmus-tests/README
> @@ -11,7 +11,6 @@ tools/memory-model/README.
>  
>  atomic (/atomic derectory)
>  --------------------------
> -
>  Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>      Test that an atomic RMW followed by a smp_mb__after_atomic() is
>      stronger than a normal acquire: both the read and write parts of
> @@ -23,8 +22,11 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  
>  RCU (/rcu directory)
>  --------------------
> -
>  RCU+sync+read.litmus
>  RCU+sync+free.litmus
>      Both the above litmus tests demonstrate the RCU grace period guarantee
>      that an RCU read-side critical section can never span a grace period.
> +
> +MP+onceassign+derefonce.litmus (moved to tools/memory-model/litmus-tests/)
> +   Demonstrates that rcu_assign_pointer() and rcu_dereference() to
> +   ensure that an RCU reader will not see pre-initialization garbage.

The grammar in this sentence is awful.  Should the first "that" be 
changed to "the use of"?

Alan

