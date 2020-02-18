Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537BEC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA4824125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg/5BVHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBRS4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:56:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42936 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgBRS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582052193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGqjQEwBIAGIH2rlvtx+n4+mjmKd16dlzwe9jbo2/EQ=;
        b=Jg/5BVHFGd7gOa7bV7808Ho1UVKo7JLEYXcxEh1FkjKZW4GpDymVcHR534dp3PTk0po7Zg
        882d/sOiij40duqSe+xSGUZsKZ0jfbxPzHpwbhaa5//FFKvribseI7+xyZmFjz8VofQMKF
        XiYggb7J66KAJLAIyNT4Hy+3rlIJ044=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-WUsHyBmKMyO0YlUQF_9VXQ-1; Tue, 18 Feb 2020 13:56:24 -0500
X-MC-Unique: WUsHyBmKMyO0YlUQF_9VXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01E3BDBA3;
        Tue, 18 Feb 2020 18:56:23 +0000 (UTC)
Received: from mail (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B10A560BE1;
        Tue, 18 Feb 2020 18:56:19 +0000 (UTC)
Date:   Tue, 18 Feb 2020 13:56:18 -0500
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
Message-ID: <20200218185618.GB14027@redhat.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-2-aarcange@redhat.com>
 <20200218113103.GB4151@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218113103.GB4151@dhcp22.suse.cz>
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal!

On Tue, Feb 18, 2020 at 12:31:03PM +0100, Michal Hocko wrote:
> On Mon 03-02-20 15:17:44, Andrea Arcangeli wrote:
> > alpha, ia64, mips, powerpc, sh, sparc are relying on a check on
> > mm->mm_users to know if they can skip some remote TLB flushes for
> > single threaded processes.
> > 
> > Most callers of use_mm() tend to invoke mmget_not_zero() or
> > get_task_mm() before use_mm() to ensure the mm will remain alive in
> > between use_mm() and unuse_mm().
> > 
> > Some callers however don't increase mm_users and they instead rely on
> > serialization in __mmput() to ensure the mm will remain alive in
> > between use_mm() and unuse_mm(). Not increasing mm_users during
> > use_mm() is however unsafe for aforementioned arch TLB flushes
> > optimizations. So either mmget()/mmput() should be added to the
> > problematic callers of use_mm()/unuse_mm() or we can embed them in
> > use_mm()/unuse_mm() which is more robust.
> 
> I would prefer we do not do that because then the real owner of the mm
> cannot really tear down the address space and the life time of it is
> bound to a kernel thread doing the use_mm. This is undesirable I would
> really prefer if the existing few users would use mmget only when they
> really need to access mm.

If the existing few users that don't already do the explicit mmget
will have to start doing it too, the end result will be exactly the
same that you described in your "cons" (lieftime of the mm will still
be up to who did mmget;use_mm and didn't call unuse_mm;mmput yet).

One reason to prefer adding the mmget to the callers to forget it,
would be to avoid an atomic op in use_mm (for those callers that
didn't forget it), but if anybody is doing use_mm in a fast path that
won't be very fast anyway so I didn't think this was worth the
risk. If that microoptimization in a slow path is the reason we should
add mmget to the callers that forgot it that would be fine with me
although I think it's risky because if already happened once and it
could happen again (and when it happens it only bits a few arches if
used with a few drivers).

On a side note the patch 2/2 should be dropped for now, I'm looking if
we can optimize away TLB-i broadcasts from multithreaded apps too.

Thanks,
Andrea

> 
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > ---
> >  mm/mmu_context.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/mmu_context.c b/mm/mmu_context.c
> > index 3e612ae748e9..ced0e1218c0f 100644
> > --- a/mm/mmu_context.c
> > +++ b/mm/mmu_context.c
> > @@ -30,6 +30,7 @@ void use_mm(struct mm_struct *mm)
> >  		mmgrab(mm);
> >  		tsk->active_mm = mm;
> >  	}
> > +	mmget(mm);
> >  	tsk->mm = mm;
> >  	switch_mm(active_mm, mm, tsk);
> >  	task_unlock(tsk);
> > @@ -57,6 +58,7 @@ void unuse_mm(struct mm_struct *mm)
> >  	task_lock(tsk);
> >  	sync_mm_rss(mm);
> >  	tsk->mm = NULL;
> > +	mmput(mm);
> >  	/* active_mm is still 'mm' */
> >  	enter_lazy_tlb(mm, tsk);
> >  	task_unlock(tsk);
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

