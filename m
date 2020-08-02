Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC09FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC35320722
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mOGaWHhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHBVXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHBVXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:23:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD70C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 14:23:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so27906092ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yt8bNBaIV64wySDW8cExaLb5AaApyS2IQgoQTTkg7Wc=;
        b=mOGaWHhSC6DO4nHRpEGHE3IJE4pMn1OOjX3eZnuwo+AHNpAo6cCfemxXPo97kfSSJF
         skOBWc0X42eMmEmbgIB4A7d8dUaf+M6th9osCgyeYrkySdR1Vimyt6QkzNVcTq7AcqGK
         4tuk6ccgg5rAsTaCiV8GBGwzKXEosg5gnZYSPL7UuLbgHW7rY1rlH3y8IzGjtmlGsVsF
         CgA2HC3L0Mm3fhLH81OjhjjV129uCW3IZACReJRhxph8zZE4Po4WVhNk1g12UZrTw1eq
         iOwZviLBlks9TFG4MvayPCjknaWyYbfmxqiqoh55q9BK6KScRk+jpQ+0Mua6AQazj/Sw
         K6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yt8bNBaIV64wySDW8cExaLb5AaApyS2IQgoQTTkg7Wc=;
        b=oGdsf5IBNsw6B0VPxCABcY097i3Ew9S4DxkBCrx61zKyl8qqXkxQv7Hv/LvbY90bgl
         U2h+f2Vb1BNu4wMJyOZ6D265eN4tucmvDaHpTlfF3TCRH9jOer4qu1CzjZJze32x7AN+
         iGtfrbD2KhR6tVamN55fu6QxhoCwIxW/OmG+6N0LqiRofUJqKqDizVcsh4+AVc7N/VGu
         7mnshHAsV/yTYD8vzEYtGgbQeyp79gEOxY5TLv8p/7lIZDUrxwSX4/RmjTI/aaSxOZ2Z
         Z/fked/LoSFPqmQ//+Y9A617Mf3BeD96sJrSNb/MpJhSe0fzVHt0uasDD7GCALEIcstT
         NVDg==
X-Gm-Message-State: AOAM532eoUys7eLtMWswvrhBWyalNWWgjgyawRS0HixNfBTPtTxlN7Rc
        kWArQ9jmU/WQI/DYQ3ZFuk7eIw==
X-Google-Smtp-Source: ABdhPJzYZUGb5crX8VP+jUu19mNBnhyU1n5wahbbxCE/Ng1+paudZ3/5UI40mk5qXU2MhVoQim587Q==
X-Received: by 2002:a2e:9557:: with SMTP id t23mr6008411ljh.193.1596403396630;
        Sun, 02 Aug 2020 14:23:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 29sm3995750ljv.72.2020.08.02.14.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 14:23:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 87E15102BA1; Mon,  3 Aug 2020 00:23:22 +0300 (+03)
Date:   Mon, 3 Aug 2020 00:23:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] khugepaged: collapse_pte_mapped_thp() protect the pmd
 lock
Message-ID: <20200802212322.o6jk3slvjvwxn7ja@box>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
 <alpine.LSU.2.11.2008021213070.27773@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008021213070.27773@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 12:15:24PM -0700, Hugh Dickins wrote:
> When retract_page_tables() removes a page table to make way for a huge
> pmd, it holds huge page lock, i_mmap_lock_write, mmap_write_trylock and
> pmd lock; but when collapse_pte_mapped_thp() does the same (to handle
> the case when the original mmap_write_trylock had failed), only
> mmap_write_trylock and pmd lock are held.
> 
> That's not enough.  One machine has twice crashed under load, with
> "BUG: spinlock bad magic" and GPF on 6b6b6b6b6b6b6b6b.  Examining the
> second crash, page_vma_mapped_walk_done()'s spin_unlock of pvmw->ptl
> (serving page_referenced() on a file THP, that had found a page table
> at *pmd) discovers that the page table page and its lock have already
> been freed by the time it comes to unlock.
> 
> Follow the example of retract_page_tables(), but we only need one of
> huge page lock or i_mmap_lock_write to secure against this: because it's
> the narrower lock, and because it simplifies collapse_pte_mapped_thp()
> to know the hpage earlier, choose to rely on huge page lock here.
> 
> Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v5.4+

We could avoid the page cache lookup by locking the page on the first
valid PTE and recheck page->mapping, but this way is cleaner.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
