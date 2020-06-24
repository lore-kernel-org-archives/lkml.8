Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE287C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9927820836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593025359;
	bh=c0DVHKpqNywsBivnUUrd6P+QBrfaSnwkyVEyEHCow4s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=C2R0o05I+GIaJyMZl6hQvBi1jyHs0BtvvC27RLirlVPmeYwLWUnwarfa7HvqNKECX
	 /NmJtX9YMJHrHwqc84DSgvN6lKkQugOQD0lmAxsLqQtAVEBlSjUXPX9z7YlqS2ieZA
	 G4J3oPNTqsCMvNiyxqler7AN6qyC0Qyz8+2jYXOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404744AbgFXTCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404055AbgFXTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:02:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4F52082F;
        Wed, 24 Jun 2020 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593025357;
        bh=c0DVHKpqNywsBivnUUrd6P+QBrfaSnwkyVEyEHCow4s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KczMdtn4UKd+mwp/0aySL/T3AfyrNAkwL0BQqd0BQKMnytBRjujy/RzXG6I5AogVB
         +P2GmMXEVqdDysIt/Jm7mgZCiaG7nAUuCpmjyiuJaKk+EnGiSbWDvfTmNMutHRFCd0
         sIiaIKl1c8iWKbE8idwEFNZ7+TlJ5adxuD2Osp9I=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C04CF35228BC; Wed, 24 Jun 2020 12:02:36 -0700 (PDT)
Date:   Wed, 24 Jun 2020 12:02:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: Re: [PATCH kcsan 0/10] KCSAN updates for v5.9
Message-ID: <20200624190236.GA6603@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200623004310.GA26995@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623004310.GA26995@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 05:43:10PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series provides KCSAN updates:

And three more, so that GCC can join Clang in the KCSAN fun.

> 1.	Annotate a data race in vm_area_dup(), courtesy of Qian Cai.
> 
> 2.	x86/mm/pat: Mark an intentional data race, courtesy of Qian Cai.
> 
> 3.	Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu().
> 
> 4.	Add test suite, courtesy of Marco Elver.
> 
> 5.	locking/osq_lock: Annotate a data race in osq_lock.
> 
> 6.	Prefer '__no_kcsan inline' in test, courtesy of Marco Elver.
> 
> 7.	Silence -Wmissing-prototypes warning with W=1, courtesy of Qian Cai.
> 
> 8.	Rename test.c to selftest.c, courtesy of Marco Elver.
> 
> 9.	Remove existing special atomic rules, courtesy of Marco Elver.
> 
> 10.	Add jiffies test to test suite, courtesy of Marco Elver.

11.	Re-add GCC as a supported compiler.

12.	Simplify compiler flags.

13.	Disable branch tracing in core runtime.

Please note that using GCC for KCSAN requires building your own compiler
from recent mainline.

							Thanx, Paul

------------------------------------------------------------------------
The added three (#11-#13) only:
------------------------------------------------------------------------

 Documentation/dev-tools/kcsan.rst |    3 ++-
 kernel/kcsan/Makefile             |    6 +++---
 lib/Kconfig.kcsan                 |    3 ++-
 scripts/Makefile.kcsan            |    2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)
