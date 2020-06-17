Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA0E208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592377505;
	bh=gkttGyLrInlz6myUYDIzkf8FXlc2lP1JZu/R5Kw13SQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XYq90jJsvNnk2ZQu0V58s/ZdzQSisfI6R85V+TIuuMXi5I8QAX9ImRpbajg8++zIS
	 MJJ+jlQMSFw+lX7/HGg0vjpHQlwHjZe8lToxaESQ1AfIm2yHoSj7OZtiR76O5Rgy4h
	 aEckJt56WQj5EeZaawlcOueYQE2TuNqp93bfZ1NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFQHFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgFQHFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:05:03 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7F3208C3;
        Wed, 17 Jun 2020 07:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592377503;
        bh=gkttGyLrInlz6myUYDIzkf8FXlc2lP1JZu/R5Kw13SQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N22s7N5fp472q7EBrdWJZbCWi84HssNEFBV7nnFp7S9DNd5lW33xyRbY/yBIJIU1F
         MH0RQ0/Zl8rRqvPFmZlVUFcMNcno2NKL7KvdgPY6nJNKq6aOpYpIvex/pL++iilk82
         Al9P9hbxVXRnscjP3q4soto9ecLclBdGvdT0KIVA=
Received: by mail-lj1-f179.google.com with SMTP id a9so1528691ljn.6;
        Wed, 17 Jun 2020 00:05:02 -0700 (PDT)
X-Gm-Message-State: AOAM531Lg3kQHwML888SAyHLdYTLEz8iNAoaJADQaoKmz3cGCFb4qWf6
        2bqsHjBJpBrZqANKaSR7eWqphd+H50fj5EWABdE=
X-Google-Smtp-Source: ABdhPJwC+ca4iZ2zH9nZe/NH6/XlagoLZC1t2O53ojSH8lWGQB1c584yp3gXuVBka480nIZXz6hjo5ocYeneaFllueY=
X-Received: by 2002:a2e:2a42:: with SMTP id q63mr3430507ljq.265.1592377500946;
 Wed, 17 Jun 2020 00:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-8-peterx@redhat.com>
In-Reply-To: <20200615221607.7764-8-peterx@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 17 Jun 2020 15:04:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
Message-ID: <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Jun 16, 2020 at 6:16 AM Peter Xu <peterx@redhat.com> wrote:
>
> Use the new mm_fault_accounting() helper for page fault accounting.
> Also, move the accounting to be after release of mmap_sem.
>
> CC: Guo Ren <guoren@kernel.org>
> CC: linux-csky@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/csky/mm/fault.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index 4e6dc68f3258..8f8d34d27eca 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -111,8 +111,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
>                 return;
>         }
>  #endif
> -
> -       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>         /*
>          * If we're in an interrupt or have no user
>          * context, we must not take the fault..
> @@ -160,17 +158,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
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
>         up_read(&mm->mmap_sem);
> +       mm_fault_accounting(tsk, regs, address, fault & VM_FAULT_MAJOR);
>         return;
>
>         /*
> --
> 2.26.2
>
I notice that you move it out of mm->mmap_sem's area, all archs should
follow the rule ? Can you give me a clarification and put it into de
commit log ?
Thx
-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
