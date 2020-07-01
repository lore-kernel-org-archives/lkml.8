Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E934C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A80620781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593568377;
	bh=2FV1pfYbdVJhWNXtRFZ00aDRwod9Cnfn45PcsuruijI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GReLf68+COhHHkHXX2nGTTJykLR4IvZvP2SOO1KwYL3kp1BKb7HtIkIpLHCbxEHXx
	 phQv1vn44IHTqhai4bN//PZiyaxrGR5OzVLG1RdfONeMf50uqrIxFjwipj3vTpD+TB
	 yGibBxvXsioY4cDPXQqR2QYFodfeaazRVZr6MR2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgGABwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGABwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:52:55 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0615120781;
        Wed,  1 Jul 2020 01:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593568374;
        bh=2FV1pfYbdVJhWNXtRFZ00aDRwod9Cnfn45PcsuruijI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VpCsRt/gRz18Y3MBlX6jhVDJVHYG88vGbQUKl9nTcdc3VU8OjCCencQ5b1kbNLP1U
         rc6C2axZXY779YLQBVjbSMpUbOdhejztENUdViJQbXWd2xc44ywSRF5Qa7NrqLDndV
         e1qzOPLTQ8oisYp8T635SIQ0RrbXhnhbqIZTsysY=
Received: by mail-lj1-f178.google.com with SMTP id f5so9131826ljj.10;
        Tue, 30 Jun 2020 18:52:53 -0700 (PDT)
X-Gm-Message-State: AOAM531T3pWJvb3zh3KStPN0eWlRa1YH+xMaEuVqlbKRVUU+CJ7bJjMQ
        FGJ52lZm5eC8w11Cwk6tGj34dSQY3O4uY8qcngE=
X-Google-Smtp-Source: ABdhPJx1lNuDFMyzipChLwrqnrd9q3q5Nafpa1BTdsxkEn9M+xFVRbpngfomKJnfqDbLAPkuDxrsiwujtC2hMEhUPwg=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr11796638ljp.346.1593568372315;
 Tue, 30 Jun 2020 18:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200630204517.38760-1-peterx@redhat.com>
In-Reply-To: <20200630204517.38760-1-peterx@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 1 Jul 2020 09:52:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQMYdXW6F1MgE56WeM=x=APULtp8sW_2SGqi9Lh_NnpiQ@mail.gmail.com>
Message-ID: <CAJF2gTQMYdXW6F1MgE56WeM=x=APULtp8sW_2SGqi9Lh_NnpiQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/26] mm/csky: Use general page fault accounting
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Jul 1, 2020 at 4:45 AM Peter Xu <peterx@redhat.com> wrote:
>
> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.
>
> CC: Guo Ren <guoren@kernel.org>
> CC: linux-csky@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/csky/mm/fault.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index 7137e2e8dc57..c3f580714ee4 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
>          * the fault.
>          */
>         fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
> -                               NULL);
> +                               regs);
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> @@ -161,16 +161,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
>                         goto bad_area;
>                 BUG();
>         }
> -       if (fault & VM_FAULT_MAJOR) {
> -               tsk->maj_flt++;
> -               perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
> -                             address);
> -       } else {
> -               tsk->min_flt++;
> -               perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
> -                             address);
> -       }
> -
>         mmap_read_unlock(mm);
>         return;
>
> --
> 2.26.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
