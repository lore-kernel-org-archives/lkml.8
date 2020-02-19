Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F579C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B1E207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIKZHYu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgBSUEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:04:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbgBSUEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582142684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79VaVLaMvILH9sVhxkEy97vEIOv8ZIgozZ9v2HZt0g4=;
        b=OIKZHYu5fM32qztQ9S1waz/8p38z6QkkZcXA6slnDI457J/vixBhm4cDQoqdMxv96AKG2s
        xzs0D3k/UBc4qmvlFAMh39aRK+0bOSkSiUcK/Kt1tjSaJpN9kevYXobdKyZ1W7ffYi5RXY
        PVKuDOqX1YQoD1gaf/6AfgoF8tFgM0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-E5XDV-lONAGSLR6zykbLtw-1; Wed, 19 Feb 2020 15:04:40 -0500
X-MC-Unique: E5XDV-lONAGSLR6zykbLtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11A4E13EA;
        Wed, 19 Feb 2020 20:04:38 +0000 (UTC)
Received: from mail (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F49F5C557;
        Wed, 19 Feb 2020 20:04:34 +0000 (UTC)
Date:   Wed, 19 Feb 2020 15:04:33 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] mm: use_mm: fix for arches checking mm_users to
 optimize TLB flushes
Message-ID: <20200219200433.GB5402@redhat.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-2-aarcange@redhat.com>
 <20200218113103.GB4151@dhcp22.suse.cz>
 <20200218185618.GB14027@redhat.com>
 <20200219115855.GR4151@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219115855.GR4151@dhcp22.suse.cz>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:58:55PM +0100, Michal Hocko wrote:
> On Tue 18-02-20 13:56:18, Andrea Arcangeli wrote:
> > Hi Michal!
> > 
> > On Tue, Feb 18, 2020 at 12:31:03PM +0100, Michal Hocko wrote:
> > > On Mon 03-02-20 15:17:44, Andrea Arcangeli wrote:
> > > > alpha, ia64, mips, powerpc, sh, sparc are relying on a check on
> > > > mm->mm_users to know if they can skip some remote TLB flushes for
> > > > single threaded processes.
> > > > 
> > > > Most callers of use_mm() tend to invoke mmget_not_zero() or
> > > > get_task_mm() before use_mm() to ensure the mm will remain alive in
> > > > between use_mm() and unuse_mm().
> > > > 
> > > > Some callers however don't increase mm_users and they instead rely on
> > > > serialization in __mmput() to ensure the mm will remain alive in
> > > > between use_mm() and unuse_mm(). Not increasing mm_users during
> > > > use_mm() is however unsafe for aforementioned arch TLB flushes
> > > > optimizations. So either mmget()/mmput() should be added to the
> > > > problematic callers of use_mm()/unuse_mm() or we can embed them in
> > > > use_mm()/unuse_mm() which is more robust.
> > > 
> > > I would prefer we do not do that because then the real owner of the mm
> > > cannot really tear down the address space and the life time of it is
> > > bound to a kernel thread doing the use_mm. This is undesirable I would
> > > really prefer if the existing few users would use mmget only when they
> > > really need to access mm.
> > 
> > If the existing few users that don't already do the explicit mmget
> > will have to start doing it too, the end result will be exactly the
> > same that you described in your "cons" (lieftime of the mm will still
> > be up to who did mmget;use_mm and didn't call unuse_mm;mmput yet).
> 
> Well, they should use mmget only for moments when they access the
> address space.

I don't think so because mmget is a pure atomic_inc. How can you serialize
that against a tlb flush that just does an atomic_read() on mm_users?

At the very least you will have to invent something new slower than
mmget that adds some serialization against the TLB flush code and the
common code would need to learn to use that. And the question is how
much faster that can be than switch_mm() that use_mm already invokes.

It doesn't need to block but it needs a smp_mb() on both sides.

i.e. after atomic_inc(&mm_users) you need a smp_mb() and a
test_and_clear_bit and conditional local tlb flush. In the TLB flush
code you need to set the bit, smp_mb() and then atomic_read(&mm_users).

As things are now (no new mmget_local_tlb_flush() call in common code)
the mmget has to happen regardless before use_mm() so there's a slight
chance to serialize it in switch_mm arch code. Note I did put a
smp_mb() myself in the switch_mm path to make it safe in 2/2.

With your solution it'd be already possible to call mmput at any time
after using the mm and before calling unuse_mm. But then you'd have to
still call unuse_mm; mmget;use_mm again before you can use the mm
again so why not to call unuse_mm immediately instead of only mmput?

> > One reason to prefer adding the mmget to the callers to forget it,
> > would be to avoid an atomic op in use_mm (for those callers that
> > didn't forget it), but if anybody is doing use_mm in a fast path that
> > won't be very fast anyway so I didn't think this was worth the
> > risk. If that microoptimization in a slow path is the reason we should
> > add mmget to the callers that forgot it that would be fine with me
> > although I think it's risky because if already happened once and it
> > could happen again (and when it happens it only bits a few arches if
> > used with a few drivers).
> 
> The primary concern really is that use_mm is usually not bound in time
> and we do not want to pin the address space for such a long time without
> any binding to a killable process.

Almost all use_mm already do mmget before use_mm and mmput after
unuse_mm, or perhaps I wouldn't have to find about this by source
review only. So the cons you describe already affects the vast
majority of use_mm cases (the non buggy ones).

I see you concern for adding a "cons" to the minority of remaining
cases, but it's still better to introduce that "cons" than corrupting
userland memory.

Thanks,
Andrea

