Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BEDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC15D2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029293;
	bh=5VMnJWMtE5isWf+Zw3fFeVBkUtPM9jnG1y56l1rB6r8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Pn6Tgda48m6aHaRUYvu9Dibo/smhsQqSqzEE7BbRnHcOoCR4E//FJCAbezAS3tBmu
	 FVRN1PQVL0AGHzPG+jbC08eByWCg+ZW0mXtVNhTC9aDAzPfmdmaNm+wr7e2wWHPLGq
	 jXD6XICo0IhA/On9PdkInTQMa9TaYmFsmizggdy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406296AbgFXUIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406231AbgFXUIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:08:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AE92081A;
        Wed, 24 Jun 2020 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029290;
        bh=5VMnJWMtE5isWf+Zw3fFeVBkUtPM9jnG1y56l1rB6r8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UXDlpgROI12F5NDqgoOzG0SobMYX9Nk3wVTaoZZ18QP+SHsTUfrQ0DTWyUg4X1gxy
         vODil8B8gvJCr4EEF3WDH7s/Ded0qAtOHW3XkT7WGBJEvEk2GyOBQTzGl8VXHiZFAf
         FuYx353wTI5ZuzKO9SpomxDWj0U1uIiRGkZJiCDs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4EEEC35228BC; Wed, 24 Jun 2020 13:08:10 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:08:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: Re: [PATCH kcsan 0/10] KCSAN updates for v5.9
Message-ID: <20200624200810.GA20999@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200623004310.GA26995@paulmck-ThinkPad-P72>
 <20200624190236.GA6603@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624190236.GA6603@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:02:36PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 22, 2020 at 05:43:10PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series provides KCSAN updates:
> 
> And three more, so that GCC can join Clang in the KCSAN fun.
> 
> > 1.	Annotate a data race in vm_area_dup(), courtesy of Qian Cai.
> > 
> > 2.	x86/mm/pat: Mark an intentional data race, courtesy of Qian Cai.
> > 
> > 3.	Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu().
> > 
> > 4.	Add test suite, courtesy of Marco Elver.
> > 
> > 5.	locking/osq_lock: Annotate a data race in osq_lock.
> > 
> > 6.	Prefer '__no_kcsan inline' in test, courtesy of Marco Elver.
> > 
> > 7.	Silence -Wmissing-prototypes warning with W=1, courtesy of Qian Cai.
> > 
> > 8.	Rename test.c to selftest.c, courtesy of Marco Elver.
> > 
> > 9.	Remove existing special atomic rules, courtesy of Marco Elver.
> > 
> > 10.	Add jiffies test to test suite, courtesy of Marco Elver.
> 
> 11.	Re-add GCC as a supported compiler.
> 
> 12.	Simplify compiler flags.
> 
> 13.	Disable branch tracing in core runtime.

All three of which, I should hasten to add, are courtesy of Marco Elver.

> Please note that using GCC for KCSAN requires building your own compiler
> from recent mainline.

							Thanx, Paul

> ------------------------------------------------------------------------
> The added three (#11-#13) only:
> ------------------------------------------------------------------------
> 
>  Documentation/dev-tools/kcsan.rst |    3 ++-
>  kernel/kcsan/Makefile             |    6 +++---
>  lib/Kconfig.kcsan                 |    3 ++-
>  scripts/Makefile.kcsan            |    2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)
