Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A2C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8793D2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584149501;
	bh=hJwyPIvd2ZUJsqiZqnhUbplLGWikush9KMDaDbjWR8Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=ZbxyTvPt4yIyiBe8xu6zp9OkSK+CyUqZ760+ccFOT4UUSGgvPmX4imSocNWb8psnv
	 kUvmytJf1ZHja7xD973Cw6c6ZvMi0+k3ks15C3M40HuNRYxsVCRo21B6fhFVkVmTM8
	 ricJ3k/NhDBOTJZMNwy3KkRZlKKHDstRXJQZrNx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgCNBbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 21:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgCNBbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:31:39 -0400
Received: from vulkan (unknown [170.249.165.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56502074B;
        Sat, 14 Mar 2020 01:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584149498;
        bh=hJwyPIvd2ZUJsqiZqnhUbplLGWikush9KMDaDbjWR8Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UBa7NdareUhiW2HFF+N2f47mKVFH7Rnoi+b8Y/F8UriSPIFxe95DQDkwdCkTbyTfl
         0foyXMZ3R7kwX7DbERZZg6BQGHoerUFdMWbja5+22/op+ZWcEB9MrWLPamozEg36i9
         0ExpVOm0cS4C4IdC9kjiei8NqvkO70Wf9vThE1t0=
Message-ID: <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        NeilBrown <neilb@suse.de>
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 13 Mar 2020 20:31:36 -0500
In-Reply-To: <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
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
         <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
         <875zfbvrbm.fsf@notabene.neil.brown.name>
         <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
         <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
         <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
         <87v9nattul.fsf@notabene.neil.brown.name>
         <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
         <87o8t2tc9s.fsf@notabene.neil.brown.name>
         <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-12 at 09:07 -0700, Linus Torvalds wrote:
> On Wed, Mar 11, 2020 at 9:42 PM NeilBrown <neilb@suse.de> wrote:
> > It seems that test_and_set_bit_lock() is the preferred way to handle
> > flags when memory ordering is important
> 
> That looks better.
> 
> The _preferred_ way is actually the one I already posted: do a
> "smp_store_release()" to store the flag (like a NULL pointer), and a
> smp_load_acquire() to load it.
> 
> That's basically optimal on most architectures (all modern ones -
> there are bad architectures from before people figured out that
> release/acquire is better than separate memory barriers), not needing
> any atomics and only minimal memory ordering.
> 
> I wonder if a special flags value (keeping it "unsigned int" to avoid
> the issue Jeff pointed out) might be acceptable?
> 
> IOW, could we do just
> 
>         smp_store_release(&waiter->fl_flags, FL_RELEASED);
> 
> to say that we're done with the lock? Or do people still look at and
> depend on the flag values at that point?

I think nlmsvc_grant_block does. We could probably work around it
there, but we'd need to couple this change with some clear
documentation to make it clear that you can't rely on fl_flags after
locks_delete_block returns.

If avoiding new locks is preferred here (and I'm fine with that), then
maybe we should just go with the patch you sent originally (along with
changing the waiters to wait on fl_blocked_member going empty instead
of the fl_blocker going NULL)?

-- 
Jeff Layton <jlayton@kernel.org>

