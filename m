Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C1AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0AA20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnosIQ6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgFZVxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:53:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23767 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725803AbgFZVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593208432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FV8Bsjn54kOoJliJlKrbcRPo+jc1JY+WRfUoqlGGQhU=;
        b=LnosIQ6ZSA/O6f2itGGEN5Ien24a0SHb4iSatUJB4Ct4MBY4QOtJzIHAWyMyragbpKojuz
        vGYMuIwxJijAOpipsFyd+o3DZyuHIs5WoZy7QW/tCp4oLGE6B+hFrI1gmhUyJjJcFtTu/G
        aVbnqajyBjEzT6Hn/Q/azRxw7+aldFM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-H7YqQVZnPmmNQzLlK81uXw-1; Fri, 26 Jun 2020 17:53:50 -0400
X-MC-Unique: H7YqQVZnPmmNQzLlK81uXw-1
Received: by mail-qv1-f72.google.com with SMTP id j18so7330703qvk.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FV8Bsjn54kOoJliJlKrbcRPo+jc1JY+WRfUoqlGGQhU=;
        b=S4/n/9ZxBDAPIfJHtOnyf9Rhjoo/3aKHJLB5eClVp6YY1/8vITgqu3a0oiSstfTdDH
         xo0HuqD3C+mGM6CqTdiakzf6BI/46d8KzknT/HTed/z9o2OP4Lu2mIxm99v0f08jR0qj
         Er/0g6eIIkffRGX3jRgVxAJvCI8Bz+YwryDx44aP/vR/Z1RU15qI59GtecRuCgy3s3tL
         GmlZWrQ2ReJVgU3QltiA7TxaB0tEAmoU/gY98MiBnzuZE2PaOcqsDysm0EOyVkfET3LT
         vmB3FsynxLMBMKNfzimTHLib6e4e7yjzfHNTxlY4xFmIAboCQS3ovoXGXjO1iSBQvywr
         I87A==
X-Gm-Message-State: AOAM533DQbnsfcbbIFk9jmB0Ej4zxwC+tdEMMMG2ppGeURoUdbqeqhRQ
        LMOjgUR7jgM7dSJjtyPIiSUWodkhmbR4Vli7tOuA/Xly7RvXDbdCMa5BJ8y+Ym91Zu5Xeo8FYs4
        sRz9QKMj/ZNG5gJNS+gUdzbs8
X-Received: by 2002:a05:620a:2050:: with SMTP id d16mr5094863qka.215.1593208429870;
        Fri, 26 Jun 2020 14:53:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkOQYx4uI8uZYLEy+pRDdcczh+I4pfBIpILOimX9az7o45fXQBXY+UDqXHB+0u+UMO7CpWOA==
X-Received: by 2002:a05:620a:2050:: with SMTP id d16mr5094832qka.215.1593208429427;
        Fri, 26 Jun 2020 14:53:49 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g16sm11470330qko.5.2020.06.26.14.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:53:48 -0700 (PDT)
Date:   Fri, 26 Jun 2020 17:53:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/26] mm: Do page fault accounting in handle_mm_fault
Message-ID: <20200626215346.GE175520@xz-x1>
References: <20200619160538.8641-1-peterx@redhat.com>
 <20200619160538.8641-2-peterx@redhat.com>
 <20200624204903.097a5a58@thinkpad>
 <20200624203412.GB64004@xz-x1>
 <20200626215424.581d6077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200626215424.581d6077@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:54:24PM +0200, Gerald Schaefer wrote:
> On Wed, 24 Jun 2020 16:34:12 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Jun 24, 2020 at 08:49:03PM +0200, Gerald Schaefer wrote:
> > > On Fri, 19 Jun 2020 12:05:13 -0400
> > > Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > [...]
> > > 
> > > > @@ -4393,6 +4425,38 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> > > >  			mem_cgroup_oom_synchronize(false);
> > > >  	}
> > > > 
> > > > +	if (ret & VM_FAULT_RETRY)
> > > > +		return ret;
> > > 
> > > I'm wondering if this also needs a check and exit for VM_FAULT_ERROR.
> > > In arch code (s390 and all others I briefly checked), the accounting
> > > was skipped for VM_FAULT_ERROR case.
> > 
> > Yes. I didn't explicitly add the check because I thought it's still OK to count
> > the error cases, especially after we've discussed about
> > PERF_COUNT_SW_PAGE_FAULTS in v1.  So far, the major reason (iiuc) to have
> > PERF_COUNT_SW_PAGE_FAULTS still in per-arch handlers is to also cover these
> > corner cases like VM_FAULT_ERROR.  So to me it makes sense too to also count
> > them in here.  But I agree it changes the old counting on most archs.
> 
> Having PERF_COUNT_SW_PAGE_FAULTS count everything including VM_FAULT_ERROR
> is OK. Just major/minor accounting should be only about successes, IIRC from
> v1 discussion.
> 
> The "new rules" also say
> 
> +	 *  - faults that never even got here (because the address
> +	 *    wasn't valid). That includes arch_vma_access_permitted()
> +	 *    failing above.
> 
> VM_FAULT_ERROR, and also the arch-specific VM_FAULT_BADxxx, qualify
> as "address wasn't valid" I think, so they should not be counted as
> major/minor.
> 
> IIRC from v1, and we want to only count success as major/minor, maybe
> the rule could also be made more clear about that, e.g. like
> 
> +	 *  - unsuccessful faults (because the address wasn't valid)
> +	 *    do not count. That includes arch_vma_access_permitted()
> +	 *    failing above.

Sure.

> 
> > 
> > Again, I don't have strong opinion either on this, just like the same to
> > PERF_COUNT_SW_PAGE_FAULTS...  But if no one disagree, I will change this to:
> > 
> >   if (ret & (VM_FAULT_RETRY | VM_FAULT_ERROR))
> >       return ret;
> > 
> > So we try our best to follow the past.
> 
> Sounds good to me, and VM_FAULT_BADxxx should never show up here.
> 
> > 
> > Btw, note that there will still be some even more special corner cases. E.g.,
> > for ARM64 it's also not accounted for some ARM64 specific fault errors
> > (VM_FAULT_BADMAP, VM_FAULT_BADACCESS).  So even if we don't count
> > VM_FAULT_ERROR, we might still count these for ARM64.  We can try to redefine
> > VM_FAULT_ERROR in ARM64 to cover all the arch-specific errors, however that
> > seems an overkill to me sololy for fault accountings, so hopefully I can ignore
> > that difference.
> 
> Hmm, arm64 already does not count the VM_FAULT_BADxxx, but also does not
> call handle_mm_fault() for those, so no change with this patch. arm (and
> also unicore32) do count those, but also not call handle_mm_fault(), so
> there would be the change that they lose accounting, IIUC.

Oh you are right...  I just noticed that VM_FAULT_BADMAP and VM_FAULT_BADACCESS
can never returned in handle_mm_fault() itself.

> 
> I agree that this probably can be ignored. The code in arm64 also looks
> more recent, so it's probably just a left-over in arm/unicore32 code.

Anyway, glad to know that we've reached consensus so that we can accept these
differences.

Since this patch seems to be the only one that needs a new post so far, I'll
repost this patch only by replying to itself with v2.1.  Hopefully that can
avoid some unecessary mail bombs.

Thanks for the very detailed review!

-- 
Peter Xu

