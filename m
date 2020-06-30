Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05CC20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/R0HvxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgF3VrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:47:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53926 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbgF3VrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593553621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nixTOEgW0Ceg9ragNEY0z/vysduzB+SPEPITIinZzc4=;
        b=a/R0HvxKl8trzdZqLLPqrSNM8wWVDsKhPq1ei/7QihFKNCwNxA+HabkFFnxGvgEY3ytmF0
        0aHvn8+VghMS8kC+VHmR9g4Xpr21WwkP0WcK/nK/4M79jsGxd8y8Y6sE3NLxmZVZNQVUeF
        sEamrywks0qirY5zN7C1iRcLCg0pQk4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-ZP5vjGLGMm2MWeF0i7MGPw-1; Tue, 30 Jun 2020 17:30:12 -0400
X-MC-Unique: ZP5vjGLGMm2MWeF0i7MGPw-1
Received: by mail-qt1-f197.google.com with SMTP id h10so1853009qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nixTOEgW0Ceg9ragNEY0z/vysduzB+SPEPITIinZzc4=;
        b=KwbkAORVjxfbspQ0mMUDnFOEBRIAbhv3uUDAqO6uoNof4AVO1JKz5iDNc5OKHGiNZS
         95wgoVLdUSCZpw5MrwhHwEMd5Gv+nF9vV0e2Ot7TXdawemaih5OgX7wngIsCfOF12YpK
         dvg+ohHVI408L4xFAnU4dzrx+GP46JckpGS3L9kojLmDKaqzhvLQC2y75elemxzjgGaB
         /MMKe3VaJ7t/5ExxziiU6N5OF41p6s/pfA/iyi14LAeKYnWm2anrbiP+zZejkkEldjBI
         TNuqoF3PTDlP2/m0BD6nVnGFEOCDbfZdikBmgtaBMV6jK2ZlMaDNhtiPoGhqV+r6j4h6
         uTxg==
X-Gm-Message-State: AOAM532xQaul3W5WiX1927fzlV/r92DZEmOg6cgPvpe5i7d1jEFt/jWg
        rei+y2j+cVmMVKFau2WhQJMCdT2uPJtGjPXrj4WJC7o1wF5aVdsZeuhXA3IYNLZSDL1M1GnXbkj
        QjXCyv9m1lSEcNHtUEo2nIX2e
X-Received: by 2002:a0c:b520:: with SMTP id d32mr21988724qve.6.1593552611742;
        Tue, 30 Jun 2020 14:30:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr4obTuj/cs4C2lP57Bc/3hny00QnJmyUX9M22AqhyXRRhcvUT43X97TBWfW0aa3cCoD4fGA==
X-Received: by 2002:a0c:b520:: with SMTP id d32mr21988692qve.6.1593552611371;
        Tue, 30 Jun 2020 14:30:11 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t48sm4416862qtb.50.2020.06.30.14.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:30:10 -0700 (PDT)
Date:   Tue, 30 Jun 2020 17:30:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 01/26] mm: Do page fault accounting in handle_mm_fault
Message-ID: <20200630213009.GB40675@xz-x1>
References: <20200630204504.38516-1-peterx@redhat.com>
 <alpine.DEB.2.22.394.2006301401560.1512657@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006301401560.1512657@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David,

On Tue, Jun 30, 2020 at 02:05:24PM -0700, David Rientjes wrote:
> On Tue, 30 Jun 2020, Peter Xu wrote:
> 
> > @@ -4408,6 +4440,34 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> >  			mem_cgroup_oom_synchronize(false);
> >  	}
> >  
> > +	if (ret & (VM_FAULT_RETRY | VM_FAULT_ERROR))
> > +		return ret;
> > +
> > +	/*
> > +	 * Do accounting in the common code, to avoid unnecessary
> > +	 * architecture differences or duplicated code.
> > +	 *
> > +	 * We arbitrarily make the rules be:
> > +	 *
> > +	 *  - Unsuccessful faults do not count (e.g. when the address wasn't
> > +	 *    valid). That includes arch_vma_access_permitted() failing above.
> > +	 *
> > +	 *    So this is expressly not a "this many hardware page faults"
> > +	 *    counter. Use the hw profiling for that.
> > +	 *
> > +	 *  - Incomplete faults do not count (e.g. RETRY).  They will only
> > +	 *    count once completed.
> > +	 *
> > +	 *  - The fault counts as a "major" fault when the final successful
> > +	 *    fault is VM_FAULT_MAJOR, or if it was a retry (which implies that
> > +	 *    we couldn't handle it immediately previously).
> > +	 *
> > +	 *  - If the fault is done for GUP, regs will be NULL and no accounting
> > +	 *    will be done.
> > +	 */
> > +	mm_account_fault(regs, address, (ret & VM_FAULT_MAJOR) ||
> > +			 (flags & FAULT_FLAG_TRIED));
> > +
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(handle_mm_fault);
> 
> Just a nit, likely not important: I wonder if it would be cleaner to pass 
> the vm_fault_t into mm_account_fault() and then do the VM_FAULT_RETRY and
> VM_FAULT_ERROR checks there as well as putting the comment about how 
> accounting is handled in that function.  Your comment is great.

Yes that seems to be cleaner so handle_mm_fault is shorter (btw, I "stole" the
comment block majorly from Linus :).

But this change will also need to touch patch 25 again or it won't apply
cleanly.  So I think I'll see whether Andrew would like me to repost the whole
series then I'll adopt the change when I repost, or another alternative is
maybe we can also do that on top, depending on whether there's further
comments..

Thanks!

-- 
Peter Xu

