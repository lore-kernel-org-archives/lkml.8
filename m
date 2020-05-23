Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E350C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 05:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178552067B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 05:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbgEWFld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 01:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbgEWFlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 01:41:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE5FC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 22:41:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jcMuL-00DvEc-Av; Sat, 23 May 2020 05:41:17 +0000
Date:   Sat, 23 May 2020 06:41:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     wu000273@umn.edu
Cc:     hubcap@omnibond.com, martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu
Subject: Re: [PATCH 2/2] orangefs: fix double-unlock issue in
 service_operation().
Message-ID: <20200523054117.GY23230@ZenIV.linux.org.uk>
References: <20200523043551.9756-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523043551.9756-1-wu000273@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 11:35:51PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> spin_unlock(&op->lock) is called before calling wake_up_interruptible().
> But spin_unlock() was called again after a call of the function
> "wait_for_matching_downcall" failed.

Yes, it was.

> Fix this issue by remove
> the second spin_unlock().

Why is that a bug?  That's not an idle question - you could demonstrate
that if you had reproduced an unbalanced unlock experimentally, or you
could've proven it possible by analysis of the source.

The former ought to be clearly reported; the latter... AFAICS, your
reasoning is
	1) at the time of wait_for_matching_downcall() call the spinlock
is not being held, since we'd unlocked it upstream of that call and had
done nothing that could have reacquired it.
	2) after the return from that function we are doing unlock.
That is a bug, because one should not unlock a spinlock that is not
locked.

The gap in that proof is the unverified assumption that the locking
conditions upon return from wait_for_matching_downcall() are the same
as upon its call.  IF that assumption holds, there is, indeed a bug.
Now, a look at the function in question shows
	* a comment right before it claiming that it
" * Returns with op->lock taken.".  Which might or might not be correct.
	* one of the wait_for_completion...() called; that clearly
indicates that no spinlocks should be held upon the entry.
	* unconditional spin_lock(&op->lock); right after that.
	* several predicates checked, apparently some debugging
output possibly produced and a value returned.  The predicates
(op_state_service(), op_state_purged()) are clearly locking-neutral -
grep shows
fs/orangefs/orangefs-kernel.h:154:#define op_state_serviced(op)    ((op)->op_state & OP_VFS_STATE_SERVICED)
fs/orangefs/orangefs-kernel.h:155:#define op_state_purged(op)      ((op)->op_state & OP_VFS_STATE_PURGED)
so it's plain arithmetics.  The same, of course, applies to
comparisons.

In other words, the function *does* acquire that spinlock and
does not release it, regardless of the value it returns.  Which
means that your patch would very likely to cause deadlocks.
