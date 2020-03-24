Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5E2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCE2208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585067241;
	bh=OvenVnHl0wduNQ7fLdM6lGKydIJWaN8/+ujyCQPdt68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aoy6p/CDTSbBTDvbHKWxIR6TCAonja1hH9GIBaK/+akR/BytUg9eftmh7LWwG4ghZ
	 NWdiUHG9zuEtL1tP17RM+EQlTinzIkfNavU+eTNkFKm8Yq4VFu7FZSEz9t3walcL7R
	 0zuRbDqJ40LKcxs61TRzHEdPDKXhc/c0meMv5Ma0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgCXQ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728796AbgCXQ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:27:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A90F20788;
        Tue, 24 Mar 2020 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585067236;
        bh=OvenVnHl0wduNQ7fLdM6lGKydIJWaN8/+ujyCQPdt68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GG3F8Z3DamEsezlqe5uUwSYKhHoSBCsOH1CvReBCyrJbdVmzoBSEaoPv/egxHTmqw
         u4L57AFmtNusYvewOS2xMoZfz66EPnA9ADi25j1dMOKR7so8/uyDD8dVvPn0VitWNE
         ItM72v4be6Kah5eRtkAqfyO66ZXiUl5G+bnYHRHM=
Date:   Tue, 24 Mar 2020 17:27:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 01/21] list: Remove hlist_unhashed_lockless()
Message-ID: <20200324162714.GB2518046@kroah.com>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-2-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:23PM +0000, Will Deacon wrote:
> Commit c54a2744497d ("list: Add hlist_unhashed_lockless()") added a
> "lockless" variant of hlist_unhashed() that uses READ_ONCE() to access
> the 'pprev' pointer of the 'hlist_node', the intention being that this
> could be used by 'timer_pending()' to silence a KCSAN warning. As well
> as forgetting to add the caller, the patch also sprinkles
> {READ,WRITE}_ONCE() invocations over the standard (i.e. non-RCU) hlist
> code, which is undesirable for a number of reasons:
> 
>   1. It gives the misleading impression that the non-RCU hlist code is
>      in some way lock-free (despite the notable absence of any memory
>      barriers!) and silences KCSAN in such cases.
> 
>   2. It unnecessarily penalises code generation for non-RCU hlist users
> 
>   3. It makes it difficult to introduce list integrity checks because
>      of the possibility of concurrent callers.
> 
> Retain the {READ,WRITE}_ONCE() invocations for the RCU hlist code, but
> remove them from the non-RCU implementation. Remove the unused
> 'hlist_unhashed_lockless()' function entirely and add the READ_ONCE()
> to hlist_unhashed(), as we do already for hlist_empty() already.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/list.h | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
