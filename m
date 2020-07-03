Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7006C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928132073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJtjmx5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgGCAxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:53:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32527 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbgGCAxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593737580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CULJFp+mODjg6iHDkj5D4GeB51UD2IHVmmu+m4v/Di4=;
        b=fJtjmx5dYNHTJiFx0Tr26pgI15ciNshqFU8r5FwDsQ3RWufZN/QisnYOss7O5gBBQ+VABy
        cno6bxKAYZz9zyDO0CrWLtjrpY8S5crZGF/p7G3WHgmofIscDJ0w6qXelZt3+bK8evBK0j
        hMgQL0kWWty8jGFZTcED7vy/gqHTNFU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-CoHJ-_jGMyOBu-MUTq2h_Q-1; Thu, 02 Jul 2020 20:52:58 -0400
X-MC-Unique: CoHJ-_jGMyOBu-MUTq2h_Q-1
Received: by mail-qt1-f197.google.com with SMTP id o11so20575385qti.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CULJFp+mODjg6iHDkj5D4GeB51UD2IHVmmu+m4v/Di4=;
        b=dbwSLG4gM4Y7szQl2+XIGuo7/1GT0433LiTuMPt2YAxZgj8DKv+Zb1OR/TfYMD3nQ5
         bb+2NsmdZvL4miBCnaEy1grkhXOO+6cnYccs4SoKBRwtv7hbGiD34iIXENccS6VYXQV/
         bSB8V3XNf4q7hxBmRUD2dp1IVbBqgz+lWPLVSLNY0c6dN2G+xbbkIoKJMrYkdc0tn9Re
         c5WeQ+P0EPJ/8cND9vodnBNyWoFNqQyXDPPyDhHmC0k+b9kbllx2jMfN3ntnI3bjRzbe
         bFu/jImbKskzZR9i+8AtBffSvORhIkVO4xjmQsXjtkjry3iSIUvyZRu0be/tcQPijwxv
         PzJQ==
X-Gm-Message-State: AOAM530mJeJv0N2FQM5nWeEtVMrQYxczX2f+FWE8cndcXj+tayW3gYJQ
        TUbCjK5yTS6gR4SYg9z9ORdmtNLaAi4/8dAtsMcNwnIVF0KuWt4JXWQx2hxHiUtAH70zojh11d9
        ggEFtjnJJ10VjyFDpOeCp0Cog
X-Received: by 2002:a0c:fb47:: with SMTP id b7mr22636074qvq.129.1593737578213;
        Thu, 02 Jul 2020 17:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP1HYu8QJN62LP6dFLsqmw311h2Hp3lgkh95q++LJEn0WZi0TPW5UqaXSPu8EngNu1OXf2/g==
X-Received: by 2002:a0c:fb47:: with SMTP id b7mr22636058qvq.129.1593737577992;
        Thu, 02 Jul 2020 17:52:57 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j9sm9602885qtr.60.2020.07.02.17.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 17:52:57 -0700 (PDT)
Date:   Thu, 2 Jul 2020 20:52:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 26/26] mm/gup: Remove task_struct pointer for all gup
 code
Message-ID: <20200703005255.GB6677@xz-x1>
References: <20200630204609.39736-1-peterx@redhat.com>
 <a5b6caba-28bf-4869-d1c9-984136f9f77b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5b6caba-28bf-4869-d1c9-984136f9f77b@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 02:55:40PM -0700, John Hubbard wrote:
> On 2020-06-30 13:46, Peter Xu wrote:
> > After the cleanup of page fault accounting, gup does not need to pass
> > task_struct around any more.  Remove that parameter in the whole gup stack.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   arch/arc/kernel/process.c                   |  2 +-
> >   arch/s390/kvm/interrupt.c                   |  2 +-
> >   arch/s390/kvm/kvm-s390.c                    |  2 +-
> >   arch/s390/kvm/priv.c                        |  8 +-
> >   arch/s390/mm/gmap.c                         |  4 +-
> >   drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  2 +-
> >   drivers/infiniband/core/umem_odp.c          |  2 +-
> >   drivers/vfio/vfio_iommu_type1.c             |  4 +-
> >   fs/exec.c                                   |  2 +-
> >   include/linux/mm.h                          |  9 +-
> >   kernel/events/uprobes.c                     |  6 +-
> >   kernel/futex.c                              |  2 +-
> >   mm/gup.c                                    | 92 +++++++++------------
> >   mm/memory.c                                 |  2 +-
> >   mm/process_vm_access.c                      |  2 +-
> >   security/tomoyo/domain.c                    |  2 +-
> >   virt/kvm/async_pf.c                         |  2 +-
> >   virt/kvm/kvm_main.c                         |  2 +-
> >   18 files changed, 65 insertions(+), 82 deletions(-)
> > 
> 
> Looks good:
> 
>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> One minor refinement: in gup.c, if you add the following hunk on top of your
> changes, that will eradicate the last reference to struct task, in that file:
> 
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 8ddc48022d74..75c4b305828b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1902,10 +1902,9 @@ static long __get_user_pages_remote(struct mm_struct *mm,
>   *              Or NULL if the caller does not require them.
>   *
>   * This is the same as get_user_pages_remote(), just with a
> - * less-flexible calling convention where we assume that the task
> - * and mm being operated on are the current task's and don't allow
> - * passing of a locked parameter.  We also obviously don't pass
> - * FOLL_REMOTE in here.
> + * less-flexible calling convention where we assume that the mm being operated
> + * on belongs to the current task, and doesn't allow passing of a locked
> + * parameter. We also obviously don't pass FOLL_REMOTE in here.
>   */
>  long get_user_pages(unsigned long start, unsigned long nr_pages,
>                 unsigned int gup_flags, struct page **pages,

Right.  Fixed it up, and with the r-b kept.  Thanks!

-- 
Peter Xu

