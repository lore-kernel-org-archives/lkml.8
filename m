Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF2DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CAA21897
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599547374;
	bh=96sp3WmwyYCFUlY6cW+eRDxY6WE1Mn3q/76AW2FR2FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qhOXOk2aFUPUB26TgQZ5AVGRbNBvCjhBzjjwO69/OmzGmReSyi+jQ3vrxHDN+6PK3
	 7Efwx+IeI1RSgoz0fxStZw/s8DVC3T0MZe3om/UxP33AC8U0mlOjtbh6+FAiKNkHzq
	 vhHTiTyHJi6fTp4rnjZjRqekH/PS8DMFGfR9Z2Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgIHGmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgIHGmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:42:52 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2975621532;
        Tue,  8 Sep 2020 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599547371;
        bh=96sp3WmwyYCFUlY6cW+eRDxY6WE1Mn3q/76AW2FR2FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2eCgyA8r7jPkplTBABQK5Y00jq1fwvxQ4LayCz94jKomHbK5in0FChsHs77eB1r0
         PhkB+tctp/lSR71to+m4BxSNKDIoEs8F3LKkU6R5GGeq5d7HMYEu08VJsvKvMMoZWb
         AyRX5nS6Sh+797ZUBTjsdcF8pxTeQc0JFItOBWLc=
Date:   Tue, 8 Sep 2020 09:42:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Mateusz Nosek <mateusznosek0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/mmu_notifier.c: micro-optimization substitute kzalloc
 with kmalloc
Message-ID: <20200908064245.GE1976319@kernel.org>
References: <20200906114321.16493-1-mateusznosek0@gmail.com>
 <20200906142645.GA1976319@kernel.org>
 <39c79454-9a97-2c06-3186-939c1f3a2b27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c79454-9a97-2c06-3186-939c1f3a2b27@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 06:06:39PM +0200, Mateusz Nosek wrote:
> Hi,
> 
> I performed simple benchmarks using custom kernel module with the code
> fragment in question 'copy-pasted' in there in both versions. In case of 1k,
> 10k and 100k iterations the average time for kzalloc version was 5.1 and for
> kmalloc 3.9, for each iterations number.
> The time was measured using 'ktime_get(void)' function and the results given
> here are in ktime_t units.
> The machine I use has 4 core Intel(R) Core(TM) i5-3470 CPU @ 3.20GHz CPU.
> 
> The performance increase happens, but as you wrote it is probably not really
> noticeable.

I don't think that saving a few cylces of memset() in a function that
called only on the initialization path in very particular cases is worth
risking uninitialized variables when somebody will add a new field to
the 'struct mmu_notifier_subscriptions' and will forget to explicitly
set it.

> I have found 3 other places in kernel code with similar kzalloc related
> issues, none of which seems to be 'hot' code.
> I leave the decision if this patch and potential others I would send
> regarding this issue, are worth applying to the community and maintainers.
> 
> Best regards,
> Mateusz Nosek
> 
> On 9/6/2020 4:26 PM, Mike Rapoport wrote:
> > Hi,
> > 
> > On Sun, Sep 06, 2020 at 01:43:21PM +0200, mateusznosek0@gmail.com wrote:
> > > From: Mateusz Nosek <mateusznosek0@gmail.com>
> > > 
> > > Most fields in struct pointed by 'subscriptions' are initialized explicitly
> > > after the allocation. By changing kzalloc to kmalloc the call to memset
> > > is avoided. As the only new code consists of 2 simple memory accesses,
> > > the performance is increased.
> > 
> > Is there a measurable performance increase?
> > 
> > The __mmu_notifier_register() is not used that frequently to trade off
> > robustness of kzalloc() for slight (if visible at all) performance gain.
> > 
> > > Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> > > ---
> > >   mm/mmu_notifier.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > > index 4fc918163dd3..190e198dc5be 100644
> > > --- a/mm/mmu_notifier.c +++ b/mm/mmu_notifier.c @@ -625,7 +625,7
> > > @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
> > > * know that mm->notifier_subscriptions can't change while we *
> > > hold the write side of the mmap_lock.  */
> > > -		subscriptions = kzalloc(
> > > +		subscriptions = kmalloc(
> > >   			sizeof(struct mmu_notifier_subscriptions), GFP_KERNEL);
> > >   		if (!subscriptions)
> > >   			return -ENOMEM;
> > > @@ -636,6 +636,8 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
> > >   		subscriptions->itree = RB_ROOT_CACHED;
> > >   		init_waitqueue_head(&subscriptions->wq);
> > >   		INIT_HLIST_HEAD(&subscriptions->deferred_list);
> > > +		subscriptions->active_invalidate_ranges = 0;
> > > +		subscriptions->has_itree = false;
> > >   	}
> > >   	ret = mm_take_all_locks(mm);
> > > -- 
> > > 2.20.1
> > > 
> > > 
> > 

-- 
Sincerely yours,
Mike.
