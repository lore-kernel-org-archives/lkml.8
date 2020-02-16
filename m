Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E0C7619B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 23:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2E72086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 23:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgBPXck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 18:32:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:45010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgBPXcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 18:32:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F9DAAECA;
        Sun, 16 Feb 2020 23:32:37 +0000 (UTC)
Date:   Sun, 16 Feb 2020 23:32:33 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] mm, numa: fix bad pmd by atomically check for
 pmd_trans_huge when marking page tables prot_numa
Message-ID: <20200216233232.GZ3420@suse.de>
References: <20200216191800.22423-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200216191800.22423-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 02:18:00PM -0500, Rafael Aquini wrote:
> From: Mel Gorman <mgorman@techsingularity.net>
>   A user reported a bug against a distribution kernel while running
>   a proprietary workload described as "memory intensive that is not
>   swapping" that is expected to apply to mainline kernels. The workload
>   is read/write/modifying ranges of memory and checking the contents. They
>   reported that within a few hours that a bad PMD would be reported followed
>   by a memory corruption where expected data was all zeros.  A partial report
>   of the bad PMD looked like
> 
>   [ 5195.338482] ../mm/pgtable-generic.c:33: bad pmd ffff8888157ba008(000002e0396009e2)
>   [ 5195.341184] ------------[ cut here ]------------
>   [ 5195.356880] kernel BUG at ../mm/pgtable-generic.c:35!
>   ....
>   [ 5195.410033] Call Trace:
>   [ 5195.410471]  [<ffffffff811bc75d>] change_protection_range+0x7dd/0x930
>   [ 5195.410716]  [<ffffffff811d4be8>] change_prot_numa+0x18/0x30
>   [ 5195.410918]  [<ffffffff810adefe>] task_numa_work+0x1fe/0x310
>   [ 5195.411200]  [<ffffffff81098322>] task_work_run+0x72/0x90
>   [ 5195.411246]  [<ffffffff81077139>] exit_to_usermode_loop+0x91/0xc2
>   [ 5195.411494]  [<ffffffff81003a51>] prepare_exit_to_usermode+0x31/0x40
>   [ 5195.411739]  [<ffffffff815e56af>] retint_user+0x8/0x10
> 
>   Decoding revealed that the PMD was a valid prot_numa PMD and the bad PMD
>   was a false detection. The bug does not trigger if automatic NUMA balancing
>   or transparent huge pages is disabled.
> 
>   The bug is due a race in change_pmd_range between a pmd_trans_huge and
>   pmd_nond_or_clear_bad check without any locks held. During the pmd_trans_huge
>   check, a parallel protection update under lock can have cleared the PMD
>   and filled it with a prot_numa entry between the transhuge check and the
>   pmd_none_or_clear_bad check.
> 
>   While this could be fixed with heavy locking, it's only necessary to
>   make a copy of the PMD on the stack during change_pmd_range and avoid
>   races. A new helper is created for this as the check if quite subtle and the
>   existing similar helpful is not suitable. This passed 154 hours of testing
>   (usually triggers between 20 minutes and 24 hours) without detecting bad
>   PMDs or corruption. A basic test of an autonuma-intensive workload showed
>   no significant change in behaviour.
> 
> Although Mel withdrew the patch on the face of LKML comment https://lkml.org/lkml/2017/4/10/922
> the race window aforementioned is still open, and we have reports of Linpack test reporting bad
> residuals after the bad PMD warning is observed. In addition to that, bad rss-counter and
> non-zero pgtables assertions are triggered on mm teardown for the task hitting the bad PMD.
> 
>  host kernel: mm/pgtable-generic.c:40: bad pmd 00000000b3152f68(8000000d2d2008e7)
>  ....
>  host kernel: BUG: Bad rss-counter state mm:00000000b583043d idx:1 val:512
>  host kernel: BUG: non-zero pgtables_bytes on freeing mm: 4096
> 
> The issue is observed on a v4.18-based distribution kernel, but the race window is
> expected to be applicable to mainline kernels, as well.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

It's curious that it took so long for this to be caught again.
Unfortunately I cannot find exactly what it's racing against but maybe
it's not worth chasing down and the patch is simply the safer option :(

-- 
Mel Gorman
SUSE Labs
