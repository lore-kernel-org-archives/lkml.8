Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF8220716
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsZixNvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCCE2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:28:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgCCE2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583209693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDMIPd7v29HF3qLCK2yjuGYjUXKITzcTwLkju8pHxl0=;
        b=WsZixNvWQsrgG7G/9vOGXdWXeIqXuasGYdIJCu/S9qeaueLi22yfHCiBNGawRQCCp52aSt
        KOp4L6ytwhg/Pazi/Duh8hgTW5KunfMrknfsFvW81Yvl58kyQasTxPic91u0tSnCoAjowu
        l/I8LXNbwOiqepjt8v1L55P3suWg3wM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-BfzygFwcMtmV8FItHabr5g-1; Mon, 02 Mar 2020 23:28:09 -0500
X-MC-Unique: BfzygFwcMtmV8FItHabr5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 317098017CC;
        Tue,  3 Mar 2020 04:28:08 +0000 (UTC)
Received: from t490s (ovpn-116-88.phx2.redhat.com [10.3.116.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9CB68D568;
        Tue,  3 Mar 2020 04:28:06 +0000 (UTC)
Date:   Mon, 2 Mar 2020 23:28:04 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: Re: [PATCH 1/3] mm: use_mm: fix for arches checking mm_users to
 optimize TLB flushes
Message-ID: <20200303042804.GA94763@t490s>
References: <20200223192520.20808-1-aarcange@redhat.com>
 <20200223192520.20808-2-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223192520.20808-2-aarcange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 02:25:18PM -0500, Andrea Arcangeli wrote:
> alpha, ia64, mips, powerpc, sh, sparc are relying on a check on
> mm->mm_users to know if they can skip some remote TLB flushes for
> single threaded processes.
> 
> Most callers of use_mm() tend to invoke mmget_not_zero() or
> get_task_mm() before use_mm() to ensure the mm will remain alive in
> between use_mm() and unuse_mm().
> 
> Some callers however don't increase mm_users and they instead rely on
> serialization in __mmput() to ensure the mm will remain alive in
> between use_mm() and unuse_mm(). Not increasing mm_users during
> use_mm() is however unsafe for aforementioned arch TLB flushes
> optimizations. So either mmget()/mmput() should be added to the
> problematic callers of use_mm()/unuse_mm() or we can embed them in
> use_mm()/unuse_mm() which is more robust.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  mm/mmu_context.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/mmu_context.c b/mm/mmu_context.c
> index 3e612ae748e9..ced0e1218c0f 100644
> --- a/mm/mmu_context.c
> +++ b/mm/mmu_context.c
> @@ -30,6 +30,7 @@ void use_mm(struct mm_struct *mm)
>  		mmgrab(mm);
>  		tsk->active_mm = mm;
>  	}
> +	mmget(mm);
>  	tsk->mm = mm;
>  	switch_mm(active_mm, mm, tsk);
>  	task_unlock(tsk);
> @@ -57,6 +58,7 @@ void unuse_mm(struct mm_struct *mm)
>  	task_lock(tsk);
>  	sync_mm_rss(mm);
>  	tsk->mm = NULL;
> +	mmput(mm);
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
>  	task_unlock(tsk);

Acked-by: Rafael Aquini <aquini@redhat.com>

