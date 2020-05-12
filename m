Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5587BC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD620722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DN2iet1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgELCNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgELCNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:13:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 19:13:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z90so9840307qtd.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 19:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MewUrkMigkKlQmP2yHq/YZSMSKPg5TATAzdJOc9dyuY=;
        b=DN2iet1cBdLkJhx2RMAez/0nP/iPNK0+HdUwv4mgEe7pMCCAYht3u9PGn60rKk5B8F
         3NLsvMmqcz4lBs4bzO+3iGKzke7PsxAmbpWuyif9k4Yrary4bzFEevorUdzRhqbyE07t
         CzcdESn7klx1x9Z/MiBsVcCHRcaNd/UCHXwE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MewUrkMigkKlQmP2yHq/YZSMSKPg5TATAzdJOc9dyuY=;
        b=D7Y8XqC62kXpPF+zNT6KY931cW0DX/a+2hTgy9GaUzc6o2B6ILzmo7pW112XphZvAb
         lbMKL5itwPeqciTMUkGzOE7rKN0RFcZ2lEiR5GZoskbNTrzqehibsVzTObjTvONawcvl
         upd4CspzX+DxA6Gc+GFbdwG8N+jIu0Gopk6v5GjNm6APOqRNBdk9Q7Mi4e2MdXGIhx7R
         i30B43NYP7amu2gnhZtO4cClp+LPI0KN4q4kmfBWUjmAzZ+OWCYd53skTcSjgj42HRlq
         UvtSNrz/HEd+pIcaoLaPB47E5FHo80lhRwZMoZcSObfHgmd6g6dBK0SMvWfZ57ImU+jx
         kbyw==
X-Gm-Message-State: AGi0Pua9mc8yspkcc8Ci52zlwxVZZ1Yo0ZQUXXaTXseLBINqEeOozlmN
        S2azqOLqjbMtu1R1ggyWzjnAV3xEDT0=
X-Google-Smtp-Source: APiQypIFuInau4ChfG+cPw0A+wXE+FBBTF7FlrEm69TgH1hNypoK9S5UgslSyAZ3xpHxx5ZFFduV1g==
X-Received: by 2002:ac8:690c:: with SMTP id e12mr20723789qtr.357.1589249591171;
        Mon, 11 May 2020 19:13:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j90sm10919026qte.20.2020.05.11.19.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 19:13:10 -0700 (PDT)
Date:   Mon, 11 May 2020 22:13:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, vpillai@digitalocean.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort
 out location of litmus test and README
Message-ID: <20200512021309.GA197229@google.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <20200511173348.GX2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511173348.GX2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:33:48AM -0700, Paul E. McKenney wrote:
> On Sun, May 10, 2020 at 04:21:02PM +0900, Akira Yokosawa wrote:
> > On Sat, 9 May 2020 12:43:30 +0900, Akira Yokosawa wrote:
> > > Hi Joel,
> > > 
> > > Sorry for the late response but I've noticed some glitches.
> > >  
> > > On Sun, 22 Mar 2020 21:57:32 -0400, Joel Fernandes (Google) wrote:
> > >> Move MP+onceassign+derefonce to the new Documentation/litmus-tests/rcu/
> > >> directory.
> > > 
> > > MP+onceassign+derefonce.litmus is called out in
> > > tools/memory-model/Documentation/recipes.txt as a representative example
> > > of RCU related litmus test.
> > > 
> > > So I think it should be kept under tools/memory-model/litmus-tests.
> > > 
> > > Further RCU-related litmus tests can be added under Documentation/litmus-tests/.
> > > 
> > > IIUC, this change is not picked up by tip tree yet. So we have time to respin
> > > the series targeting v5.9.
> > > 
> > >>
> > >> More RCU-related litmus tests would be added here.
> > >>
> > >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >>
> > >> ---
> > >> Cc: vpillai@digitalocean.com
> > >>
> > >>  Documentation/litmus-tests/README                        | 9 +++++++++
> > > 
> > > Please note that later patches to add atomic litmus tests under
> > > Documentation/litmus-tests/ by Boqun put README as
> > > Documentation/litums-tests/atomic/README.
> > > 
> > > This patch's location of RCU's README as Documentation/litmus-tests/README
> > > looks asymmetric to me.
> > > 
> > > I'm OK with either merging atomic's README with the top-level one or
> > > moving RCU's README to under Documentation/litmus-tests/rcu.
> > > 
> > > Joel, Boqum, can you sort out the location of README?
> > 
> > So something like this?
> > 
> > Patch 1/3 is an independent typo fix in recipes.txt.
> > Patch 2/3 reverts the MP+onceassign+derefonce relocation.
> > Patch 3/3 merges atomic's README into the top-level one.
> > 
> > This is relative to -rcu's lkmm branch.
> > 
> > Thoughts?
> 
> Looks plausible to me, and thank you for reviewing this.
> 
> Joel, thoughts?

Sorry for the delays (OSPM conference in progress). I'm Ok with moving it
back to tools/memory-model/.

I think on top of this patch, I'd like to add a reference to the to the
litmus test in tools/memory-model/ from Documentation/rcu/.

Just to mention my rationale for Documentation/litmus-tests/rcu/, I was
basically looking for a central place for RCU related litmus tests in the
kernel sources and the idea of this new directory came up.

For Akira's series,
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And could we add the following patch on top of Akira's series so we still
maintain a reference to the moved RCU test?

---8<-----------------------

From 52fdb57551cc769d8bd690f4f2b22de36ddece99 Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Mon, 11 May 2020 22:06:46 -0400
Subject: [PATCH] docs: litmus-tests: Clarify about the RCU pre-initialization
 test

Since this test was moved to tools/memory-model/, make sure that it is
at least referenced from Documentation/litmus-tests/'s README.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/litmus-tests/README | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index ac0b270b456c1..53f09e74734a4 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -11,7 +11,6 @@ tools/memory-model/README.
 
 atomic (/atomic derectory)
 --------------------------
-
 Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
     Test that an atomic RMW followed by a smp_mb__after_atomic() is
     stronger than a normal acquire: both the read and write parts of
@@ -23,8 +22,11 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 
 RCU (/rcu directory)
 --------------------
-
 RCU+sync+read.litmus
 RCU+sync+free.litmus
     Both the above litmus tests demonstrate the RCU grace period guarantee
     that an RCU read-side critical section can never span a grace period.
+
+MP+onceassign+derefonce.litmus (moved to tools/memory-model/litmus-tests/)
+   Demonstrates that rcu_assign_pointer() and rcu_dereference() to
+   ensure that an RCU reader will not see pre-initialization garbage.
-- 
2.26.2.645.ge9eca65c58-goog

