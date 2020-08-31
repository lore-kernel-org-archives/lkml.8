Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F840C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D5D20782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmF2xLSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHaGHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaGHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:07:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04405C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:07:05 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y6so74853oie.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ztuJ7lCE7kvEopSezi/ervbTmQwS2BBYgYbiSUHWDXw=;
        b=cmF2xLSOc0U8iPN/z0M/2KlwqgwRrp6zq9MwpiRV27UnbWuS7mGffAS2K5qX6wGZDA
         vKV3JN+iiDvuhHUrUpKdss5ebLyYtzRN8/X6y16byabkAS2Nyq0e/ZjqlVt+h7dHjzAS
         2+/a8PNuK2ZUVeGks4uD5ObjruiD14v/ThBq/Mb2pru7WMFg0ZkunMkPWRsdWw+d9xwh
         RLNt+mr1jdeBPF6KYi/e1cYn/Gbn+24t9EoWZgX7LTiPH8ccaSYYeTkNq0kAVW5A7TSN
         pz91sXm5kCQ8WCklfAXzQHteSKQsJjFIR3w7sUTaXaVWPcqay+RgSPuaiDr1sa+X689+
         uXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ztuJ7lCE7kvEopSezi/ervbTmQwS2BBYgYbiSUHWDXw=;
        b=LTBeZP7eGaoHiTFT0Uc2a21AT8O67ATI4A+mCVDoiOSYg+1KEFlkYkFHMpGDQvz0MA
         i0IRZMTFflF6P7+ugre1D0sdjBY+vG3k5CCx3U1VmpJJWRtcqhtwYRkFU+y0HVgVPc7m
         2jouR95vbGUC4qxYeX1YKPhZyTa7S2oVANH2oytLkF4T3++NbB/kypCHWhpIdQEjS8RB
         63rTv8L+t9DV7T6JBmnzZaJw1o1h5FwCga/ZD1tDWnuhFl8eFjlQuKjuAWERjRzPTpxP
         2pwzU93Rz8phdfJEi/E4XNzievGHqKPI5Exo6/di86PnOBA+Z432UmsSqnfyE/O0yapx
         0d8A==
X-Gm-Message-State: AOAM533vo0guMvKv4mqruty8waMrCxBkoIdY/DKTl0EC4pkQYHIKBZds
        qhg2Mpr0XGFUlTYq6LuFKJc/lw==
X-Google-Smtp-Source: ABdhPJz/zU/QKQdg3JGY2l0l+MAtlTVJhSk3I1VuspUkRP/wEWRSujcUG5/U0enSatTYPzam6ne/kQ==
X-Received: by 2002:aca:cd93:: with SMTP id d141mr14485oig.33.1598854024866;
        Sun, 30 Aug 2020 23:07:04 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 126sm597160oof.28.2020.08.30.23.07.02
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 23:07:03 -0700 (PDT)
Date:   Sun, 30 Aug 2020 23:06:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jann Horn <jannh@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 7/7] mm: Remove the now-unnecessary mmget_still_valid()
 hack
In-Reply-To: <20200827114932.3572699-8-jannh@google.com>
Message-ID: <alpine.LSU.2.11.2008302225510.1934@eggly.anvils>
References: <20200827114932.3572699-1-jannh@google.com> <20200827114932.3572699-8-jannh@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020, Jann Horn wrote:

> The preceding patches have ensured that core dumping properly takes the
> mmap_lock. Thanks to that, we can now remove mmget_still_valid() and all
> its users.

Hi Jann, while the only tears to be shed over losing mmget_still_valid()
will be tears of joy, I think you need to explain why you believe it's
safe to remove the instance in mm/khugepaged.c: which you'll have found
I moved just recently, to cover an extra case (sorry for not Cc'ing you).

> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -431,7 +431,7 @@ static void insert_to_mm_slots_hash(struct mm_struct *mm,
>  
>  static inline int khugepaged_test_exit(struct mm_struct *mm)
>  {
> -	return atomic_read(&mm->mm_users) == 0 || !mmget_still_valid(mm);
> +	return atomic_read(&mm->mm_users) == 0;
>  }
>  
>  static bool hugepage_vma_check(struct vm_area_struct *vma,

The movement (which you have correctly followed) was in
bbe98f9cadff ("khugepaged: khugepaged_test_exit() check mmget_still_valid()")
but the "pmd .. physical page 0" issue is explained better in its parent
18e77600f7a1 ("khugepaged: retract_page_tables() remember to test exit")

I think your core dumping is still reading the page tables without
holding mmap_lock, so still vulnerable to that extra issue.  It won't
be as satisfying as removing all traces of mmget_still_valid(), but
right now I think you should add an mm->core_state check there instead.

(I do have a better solution in use, but it's a much larger patch, that
will take a lot more effort to get in: checks in pte_offset_map_lock(),
perhaps returning NULL when pmd is transitioning, requiring retry.)

Or maybe it's me who has missed what you're doing instead.

Hugh
