Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ACC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A34F20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hFMuOS3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHCAfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 20:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHCAfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:35:40 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF84C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 17:35:39 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x7so350886qvi.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 17:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aRX5IBXcTykzNKGXdZYifgU3K0CDFJnL+KBNpK80gYI=;
        b=hFMuOS3ZBNFCJHvj9qV+M1TPMM7FEKwpc2WGGMEsd8OSczt5mGpH50Bqd9p7wPVc/f
         nprXNF+5TpZ/IcsZ6kLpAq3Np8aDR5WB6OZ5J2IPWfLT/PZTQjzbW0Je91KIt3pzUHsh
         E/I7mbaXb7lOu1L89kRYBUvlIg3PFu51zoOQOZgw4PPJdEbbcqrKA7I5LL87pUW+l9iM
         UV+r5Pgyxa68WgFfA6yt+mQdC0uP7fQu/n2pcPIZBDwnSZDXc3sTUfv9pTFmGjTvpJOh
         KdRVFdyKf4UbEdW9gQJ4R5SqY8cWSxyfhEeR6KumcKGshP0HxgJL2CFtcZ3GdJjWDSdu
         t7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aRX5IBXcTykzNKGXdZYifgU3K0CDFJnL+KBNpK80gYI=;
        b=Q5EnhL3RDjvJ/Ii7sGLBaUIVyalMUS10sWRTHggYKbQdi+mme08IdtKhDYccrgj2l1
         XzR/Y33plEMg3ONVJqox1eHGENMJltFFM3uMTh7rCw733qXLjUL9MxAGkjaPe38DzG43
         BDjcILl+u8JSl+Z0T/fKC/8Ouv5BPm3uLmtEwuPAayCdU64cHVqEnlglmXS4I4ANPa1n
         GSjUd0FEJ0RIpYDR+ibvGURoSsh+d1czfvAyve1VXMQg+QbM6wEYhYE6HYNvk+dpVUxR
         /znkmxnnqHQzDqOAr6vE1Er3bIZ3pb8HtpWk7HrbUea0FCj8YS/pKBX0r0aqhx4pz1pU
         3n+g==
X-Gm-Message-State: AOAM533ax1D/7bW8mc5rMP/oNrJyujMJx8Jrrq7Lkyja+y9Z3+hRlsi5
        wqeGW2Rfu7McgEuX7q5n2U3P+Q==
X-Google-Smtp-Source: ABdhPJxSrp+1bSCXjyPDeDa9aI2XiUj8kPJ903XS5/oTyHfs/9dReLh2tkfAmLGGANLWxoKRC67K2Q==
X-Received: by 2002:a0c:b743:: with SMTP id q3mr14227006qve.229.1596414938691;
        Sun, 02 Aug 2020 17:35:38 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c21sm17450693qka.9.2020.08.02.17.35.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 02 Aug 2020 17:35:37 -0700 (PDT)
Date:   Sun, 2 Aug 2020 17:35:23 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] khugepaged: retract_page_tables() remember to test
 exit
In-Reply-To: <20200802214408.patvlf3sghro3nhi@box>
Message-ID: <alpine.LSU.2.11.2008021705240.29126@eggly.anvils>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils> <alpine.LSU.2.11.2008021215400.27773@eggly.anvils> <20200802214408.patvlf3sghro3nhi@box>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020, Kirill A. Shutemov wrote:
> On Sun, Aug 02, 2020 at 12:16:53PM -0700, Hugh Dickins wrote:
> > Only once have I seen this scenario (and forgot even to notice what
> > forced the eventual crash): a sequence of "BUG: Bad page map" alerts
> > from vm_normal_page(), from zap_pte_range() servicing exit_mmap();
> > pmd:00000000, pte values corresponding to data in physical page 0.
> > 
> > The pte mappings being zapped in this case were supposed to be from a
> > huge page of ext4 text (but could as well have been shmem): my belief
> > is that it was racing with collapse_file()'s retract_page_tables(),
> > found *pmd pointing to a page table, locked it, but *pmd had become
> > 0 by the time start_pte was decided.
> > 
> > In most cases, that possibility is excluded by holding mmap lock;
> > but exit_mmap() proceeds without mmap lock.  Most of what's run by
> > khugepaged checks khugepaged_test_exit() after acquiring mmap lock:
> > khugepaged_collapse_pte_mapped_thps() and hugepage_vma_revalidate()
> > do so, for example.  But retract_page_tables() did not: fix that
> > (using an mm variable instead of vma->vm_mm repeatedly).
> 
> Hm. I'm not sure I follow. vma->vm_mm has to be valid as long as we hold
> i_mmap lock, no? Unlinking a VMA requires it.

Ah, my wording is misleading, yes.  That comment
"(using an mm variable instead of vma->vm_mm repeatedly)"
was nothing more than a note, that the patch is bigger than it could be,
because I decided to use an mm variable, instead of vma->vm_mm repeatedly.
But it looks as if I'm saying there used to be a need for READ_ONCE() or
something, and by using the mm variable I was fixing the problem.

No, sorry: delete that line now the point is made: the mm variable is
just a patch detail, it's not important.

The fix (as the subject suggested) is for retract_page_tables() to check
khugepaged_test_exit(), after acquiring mmap lock, before doing anything
to the page table.  Getting the mmap lock serializes with __mmput(),
which briefly takes and drops it in __khugepaged_exit(); then the
khugepaged_test_exit() check on mm_users makes sure we don't touch the
page table once exit_mmap() might reach it, since exit_mmap() will be
proceeding without mmap lock, not expecting anyone to be racing with it.

(I devised that protocol for ksmd, then Andrea adopted it for khugepaged:
back then it was important for these daemons to have a hold on the mm,
without an actual reference to mm_users, because that would prevent the
OOM killer from reaching exit_mmap().  Nowadays with the OOM reaper, it's
probably less crucial to avoid mm_users, but I think still worthwhile.)

Thanks a lot for looking at these patches so quickly,
Hugh
