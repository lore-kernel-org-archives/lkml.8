Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BDCC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8818E2087C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qHldnjF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgHBVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgHBVoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:44:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D243C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 14:44:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so7762233ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W+JW9/qURXxdJHu00PKJzuTat8D6D0UTqBo2IDM73ms=;
        b=qHldnjF7bttAYl+4vR9WYNVBGhIodj7vux22J4S0paJxxX4KkZ8N7egol8vHxfmd64
         +LfdWqs02/fD0tJQPYV22bCXkE0X+YPL0YYg94IIMKswYYYk9BT7gbliSYgxd+o5jw8e
         fvyu/cs/74qRenHzx5R1FClEPRSomH5g9rkAkzX5KIV3dXLGPVRCdkr39kWDlMmcAdKD
         xBjBvkL0ssDx62oO2dY5J0as+hohy1WhRtiyfh6Ur4Mnulur072oiwX2i3qw1gz9B/S8
         +jg+danNDHtYnULYSj3ptjL+x1ALX/jSyBwV/8gWL1T7JlXCEpXrH/5oj0zu83cisNLZ
         FYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W+JW9/qURXxdJHu00PKJzuTat8D6D0UTqBo2IDM73ms=;
        b=U1aKtpjyMvt92r2DMBLUsHvf7rosZ8qRnRQaoEWsvgeYVaSSaIDv6U1MnzS4oucyOC
         mtgFvadh5VSKilnvLdJWZLnrCGwD361Iw/ZJwCvnh3UPABN8Xh5qiAW+6LkWe9R+YV5N
         wB6xgJ0c9SHcPH2wbkCSdLPGFTuG2MU3/MNfpN5L+h9KPIHYPNe75VIe7r/P/6ePgtVa
         a125XbWq4x1/C0jjGKZ0PA8JO0pze9eCTA2dlBYCp7CxQyBJqUgVjrW7vkZqSmFjXcf5
         M8MmbtbTqTEEJ7qsKjVYoWA1wGRrwWk+HBZZ5YLtiBpED6ZNHId4Q0RcBonODHrzy3AK
         Xx6g==
X-Gm-Message-State: AOAM532wYfIJpsgjzAQcFBeMlgSVVWonLNvu781BIkJlpq4fLveItpDF
        naa8VZLDp8xrXvTI/qZoZlNA/A==
X-Google-Smtp-Source: ABdhPJyvaMeTwdlHiWWUa3QZPEsnvfODeHluEuNvzw9qeydsh8K0hkI9EM4bXVwrQx8q87PK2vlwaA==
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr6859667ljo.164.1596404641969;
        Sun, 02 Aug 2020 14:44:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a19sm3989856lff.25.2020.08.02.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 14:44:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0AEBC102BA1; Mon,  3 Aug 2020 00:44:08 +0300 (+03)
Date:   Mon, 3 Aug 2020 00:44:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] khugepaged: retract_page_tables() remember to test exit
Message-ID: <20200802214408.patvlf3sghro3nhi@box>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
 <alpine.LSU.2.11.2008021215400.27773@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008021215400.27773@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 12:16:53PM -0700, Hugh Dickins wrote:
> Only once have I seen this scenario (and forgot even to notice what
> forced the eventual crash): a sequence of "BUG: Bad page map" alerts
> from vm_normal_page(), from zap_pte_range() servicing exit_mmap();
> pmd:00000000, pte values corresponding to data in physical page 0.
> 
> The pte mappings being zapped in this case were supposed to be from a
> huge page of ext4 text (but could as well have been shmem): my belief
> is that it was racing with collapse_file()'s retract_page_tables(),
> found *pmd pointing to a page table, locked it, but *pmd had become
> 0 by the time start_pte was decided.
> 
> In most cases, that possibility is excluded by holding mmap lock;
> but exit_mmap() proceeds without mmap lock.  Most of what's run by
> khugepaged checks khugepaged_test_exit() after acquiring mmap lock:
> khugepaged_collapse_pte_mapped_thps() and hugepage_vma_revalidate()
> do so, for example.  But retract_page_tables() did not: fix that
> (using an mm variable instead of vma->vm_mm repeatedly).

Hm. I'm not sure I follow. vma->vm_mm has to be valid as long as we hold
i_mmap lock, no? Unlinking a VMA requires it.

-- 
 Kirill A. Shutemov
