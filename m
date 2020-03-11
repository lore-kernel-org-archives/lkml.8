Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DAEC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF3021D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583931146;
	bh=qKa9nNQ1MofSahdaXqzA+xpTPWxW3MYh12rIeqGd2m4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=CxErRHE/ZRJVIeZVgjUNRQegKdKnxKHr90sUo99FIEIx2k66w/2Ug00w10ZfVwtNA
	 7KYHCZxSGDSafMohDUjWFwEaDAiuDbeos/vuBO2OMIFXYDWwUPWTiry5J7qOCITTj1
	 OBdOEeeZVadGHHZpl7v6gmswXaJ3FOI2UWxNFx9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgCKMwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgCKMwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:52:25 -0400
Received: from vulkan (unknown [170.249.165.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9CB2146E;
        Wed, 11 Mar 2020 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583931144;
        bh=qKa9nNQ1MofSahdaXqzA+xpTPWxW3MYh12rIeqGd2m4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ElYwNHGgCBYXMvyK9CJH91A3qCD4rIvTtGPf5KNjEQnsCurhyBhexzoIyhog3W7pk
         U5ygdQHa73kHaWGaFuajrmT+Dkv0eiripQMO01Djf/qo2aCfGaQAP6XV7NQmDkihzA
         8OFXcTpnTbK07YeIrfMdnNmpF35o4BYkIZ1f50VI=
Message-ID: <9ff6eee403d293dd069935ca6979f72131fe5217.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     yangerkun <yangerkun@huawei.com>, NeilBrown <neilb@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 11 Mar 2020 07:52:23 -0500
In-Reply-To: <f9db707f-74ef-9439-1aec-e1ce8234888e@huawei.com>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
         <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
         <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
         <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
         <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
         <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
         <878sk7vs8q.fsf@notabene.neil.brown.name>
         <f9db707f-74ef-9439-1aec-e1ce8234888e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 09:57 +0800, yangerkun wrote:

[snip]

> 
> On 2020/3/11 5:01, NeilBrown wrote:
> > 
> > I think this patch contains an assumption which is not justified.  It
> > assumes that if a wait_event completes without error, then the wake_up()
> > must have happened.  I don't think that is correct.
> > 
> > In the patch that caused the recent regression, the race described
> > involved a signal arriving just as __locks_wake_up_blocks() was being
> > called on another thread.
> > So the waiting process was woken by a signal *after* ->fl_blocker was set
> > to NULL, and *before* the wake_up().  If wait_event_interruptible()
> > finds that the condition is true, it will report success whether there
> > was a signal or not.
> Neil and Jeff, Hi,
> 
> But after this, like in flock_lock_inode_wait, we will go another 
> flock_lock_inode. And the flock_lock_inode it may return 
> -ENOMEM/-ENOENT/-EAGAIN/0.
> 
> - 0: If there is a try lock, it means that we have call 
> locks_move_blocks, and fl->fl_blocked_requests will be NULL, no need to 
> wake up at all. If there is a unlock, no one call wait for me, no need 
> to wake up too.
> 
> - ENOENT: means we are doing unlock, no one will wait for me, no need to 
> wake up.
> 
> - ENOMEM: since last time we go through flock_lock_inode someone may 
> wait for me, so for this error, we need to wake up them.
> 
> - EAGAIN: since we has go through flock_lock_inode before, these may 
> never happen because FL_SLEEP will not lose.
> 
> So the assumption may be ok and for some error case we need to wake up 
> someone may wait for me before(the reason for the patch "cifs: call 
> locks_delete_block for all error case in cifs_posix_lock_set"). If I am 
> wrong, please point out!
> 
> 

That's the basic dilemma. We need to know whether we'll need to delete
the block before taking the blocked_lock_lock.

Your most recent patch used the return code from the wait to determine
this, but that's not 100% reliable (as Neil pointed out). Could we try
to do this by doing the delete only when we get certain error codes?
Maybe, but that's a bit fragile-sounding.

Neil's most recent patch used presence on the fl_blocked_requests list
to determine whether to take the lock, but that relied on some very
subtle memory ordering. We could of course do that, but that's a bit
brittle too.

That's the main reason I'm leaning toward the patch Neil sent
originally and that uses the fl_wait.lock. The existing alternate lock
managers (nfsd and lockd) don't use fl_wait at all, so I don't think
doing that will cause any issues.

-- 
Jeff Layton <jlayton@kernel.org>

