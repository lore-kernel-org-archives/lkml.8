Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333ADC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9AE2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="L1FDdB/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHCI7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgHCI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:59:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0848C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 01:59:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so8944958ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s62jzPsCEGTZMn+EVXZ348Lh5mNmexxLfib8yggDGZY=;
        b=L1FDdB/0UqpzkcKNpYDJVjyF4usUUoLQ9Drdr0r4FA16I7tt5Gck5JK9DJELrVhPgV
         Z+v1Qgov2vk3+I6CgWjMnOEOoYMwn4SYAqyCpd2Bk6fINlIDPDLMtlm7Rmys6swsPdJO
         jdeAhrOvxCRUOCxM6BjOglxgCekVCoZfWosyFwneK/JRVXdafL4uZd6I8Z1w6kTe5Y3T
         GwDZeMLFUBrWcOb/5pxpSwb503V1otUtIHppqPV62O9y8Ph/ST/xglKZljBGSdFq1V18
         ullpest44r03RztYM5f+WCcy8RHOPq+XvFWqM2M4i69Gg1CWw/3dzB7Oc8jeYz+6m2Hu
         Xjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s62jzPsCEGTZMn+EVXZ348Lh5mNmexxLfib8yggDGZY=;
        b=A4Q44fprAgJjMYEpkGa2SAslDLJFo8a6E7nP3fCgSsbJHI+tNvpqYu57LL9aKy7AjZ
         ZUVYmcvzNQgc/QKxFmb+5Ng79T/vu5QyIC2YWorakif4g3tNprwSmWwKUFQH1hUOUD14
         nEFNU2sUBJvltsf3eINJ+oFtod4En2kXobl83BFbVvPsfRMSdSYJwsxE94Ag7jsP+X35
         P1LCYB3XetlN0lzfO2cLiHqaFZyp2orZpH6zFO65Az2+aG61QXKB92JS6kXBZSdoq0Nn
         i74Fg4OJxcnAbLFVNeDwFKo+L7w/zQPRBkAs2Ne1qxbz4cLUiK6SP2AzIkRTMvrisGWU
         2Xdw==
X-Gm-Message-State: AOAM532LGk1k2mqk+CW9OqWWoFw20uQckZl/SIbOg2eY/YLWoVF3hnsa
        WimP78S7jpiriGWcNwclPbljAw==
X-Google-Smtp-Source: ABdhPJznseuQLxd1dYSrIbwJyxLxvs0jDy38WoloUNa56AdoKBRMbWb9iGAmccZv9gf8nH/1c8HB5g==
X-Received: by 2002:a2e:b0c9:: with SMTP id g9mr1807998ljl.65.1596445168995;
        Mon, 03 Aug 2020 01:59:28 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n3sm3987391ljj.39.2020.08.03.01.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 01:59:28 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 138AF101674; Mon,  3 Aug 2020 11:59:35 +0300 (+03)
Date:   Mon, 3 Aug 2020 11:59:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] khugepaged: retract_page_tables() remember to test exit
Message-ID: <20200803085935.aama54aie77pq47b@box>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
 <alpine.LSU.2.11.2008021215400.27773@eggly.anvils>
 <20200802214408.patvlf3sghro3nhi@box>
 <alpine.LSU.2.11.2008021705240.29126@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008021705240.29126@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 05:35:23PM -0700, Hugh Dickins wrote:
> On Mon, 3 Aug 2020, Kirill A. Shutemov wrote:
> > On Sun, Aug 02, 2020 at 12:16:53PM -0700, Hugh Dickins wrote:
> > > Only once have I seen this scenario (and forgot even to notice what
> > > forced the eventual crash): a sequence of "BUG: Bad page map" alerts
> > > from vm_normal_page(), from zap_pte_range() servicing exit_mmap();
> > > pmd:00000000, pte values corresponding to data in physical page 0.
> > > 
> > > The pte mappings being zapped in this case were supposed to be from a
> > > huge page of ext4 text (but could as well have been shmem): my belief
> > > is that it was racing with collapse_file()'s retract_page_tables(),
> > > found *pmd pointing to a page table, locked it, but *pmd had become
> > > 0 by the time start_pte was decided.
> > > 
> > > In most cases, that possibility is excluded by holding mmap lock;
> > > but exit_mmap() proceeds without mmap lock.  Most of what's run by
> > > khugepaged checks khugepaged_test_exit() after acquiring mmap lock:
> > > khugepaged_collapse_pte_mapped_thps() and hugepage_vma_revalidate()
> > > do so, for example.  But retract_page_tables() did not: fix that
> > > (using an mm variable instead of vma->vm_mm repeatedly).
> > 
> > Hm. I'm not sure I follow. vma->vm_mm has to be valid as long as we hold
> > i_mmap lock, no? Unlinking a VMA requires it.
> 
> Ah, my wording is misleading, yes.  That comment
> "(using an mm variable instead of vma->vm_mm repeatedly)"
> was nothing more than a note, that the patch is bigger than it could be,
> because I decided to use an mm variable, instead of vma->vm_mm repeatedly.
> But it looks as if I'm saying there used to be a need for READ_ONCE() or
> something, and by using the mm variable I was fixing the problem.
> 
> No, sorry: delete that line now the point is made: the mm variable is
> just a patch detail, it's not important.
> 
> The fix (as the subject suggested) is for retract_page_tables() to check
> khugepaged_test_exit(), after acquiring mmap lock, before doing anything
> to the page table.  Getting the mmap lock serializes with __mmput(),
> which briefly takes and drops it in __khugepaged_exit(); then the
> khugepaged_test_exit() check on mm_users makes sure we don't touch the
> page table once exit_mmap() might reach it, since exit_mmap() will be
> proceeding without mmap lock, not expecting anyone to be racing with it.

Okay, makes sense.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
