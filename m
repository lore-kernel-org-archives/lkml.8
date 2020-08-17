Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691DEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3337E2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkTdLRrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHQUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHQUum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:50:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8CDC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 13:50:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so19418023ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDaNvWkqzm6caaEe1B0qA/ONFIO+S2PQpkxNU8y5rjQ=;
        b=pkTdLRrXB+5YlBJUBPXrnBVMqqkA6coVYHzqF7833j3SefWK1EvleeXK55563+dCQa
         1ZNBfEYKZDIQ0/tRMrexHUxizXDoSz6CuNx6552lrC8hAdM89Eh4ZCjrvATuDaPjmXff
         lqr9FkMeb8lz+8k4CsB9w9h64/sxCMXvAI6Dwl6qNSOSCe37JMM3H0hYrGoiEkzLaPeX
         Rj7PAMabnr5uhtWhoIyCFOEvW/QZ0XmYeUmbHfwqVTDVRSl+xlRbszeV+PKV2ABz0xqV
         3DwYzc+lhdRU+yUof/Ir9MmtQlK2k5YbqiyOsvaDuYfedLucyVe+WMImhIrTvb0pHvEX
         UuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDaNvWkqzm6caaEe1B0qA/ONFIO+S2PQpkxNU8y5rjQ=;
        b=birCjS7vHpXCZvU5xwYnBHftYwiktO9cSWtBroGKmkMymQmu0Dtwsbyr7Bz+EBul6Z
         EClpd2mGhe5Q3Ldlpusoxjo80aQXekCEHjAPZk92r0CVXVUeRmvVhzZ+ZR4MJ9RAB5SF
         Hr3homYQZvqi4TXmPC3U3+7jr9saU8gKN5QTmo0tGZf7829tzbMxEpk6IJg/7Zq4x99C
         dQYdrnj93GXqgzEwa6p8OBStUhs5XEALOT7lrWOwibeIHRRTOmYHMxvcgrOCPz0CmKbG
         2mPbzsP1+Iz9k4ZcJnE7MPI6sDhonbnRB3VGs8tdpJMPhrDe64dE8VcQLKDaz+d4xLpN
         uceQ==
X-Gm-Message-State: AOAM532VVV95oQcEVd9rvOHEFSHFk9L0zF9jt5LbbvGYFKRkKhXDJkT3
        oeOtYKd0vSNUZqVCW0xpi2HpF4BggZarthbl2PU=
X-Google-Smtp-Source: ABdhPJx1hSJ30Z0sQOaUwQm4gXEa3jjwt7xV3r8pvg6Ms4N7JILuO9372UQj+2GENKsdtRKY60jwe357xwqokZcE/W4=
X-Received: by 2002:a17:906:3616:: with SMTP id q22mr17771581ejb.79.1597697440475;
 Mon, 17 Aug 2020 13:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
 <alpine.LSU.2.11.2008021217020.27773@eggly.anvils> <alpine.LSU.2.11.2008141503370.18085@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008141503370.18085@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 17 Aug 2020 13:50:28 -0700
Message-ID: <CAHbLzkpYWxGiXqyaF167dj_qFo1apchryGHv_RG4UKQgY5-jOQ@mail.gmail.com>
Subject: Re: [PATCH] khugepaged: adjust VM_BUG_ON_MM() in __khugepaged_enter()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Eric Dumazet <edumazet@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 3:13 PM Hugh Dickins <hughd@google.com> wrote:
>
> syzbot crashes on the VM_BUG_ON_MM(khugepaged_test_exit(mm), mm) in
> __khugepaged_enter(): yes, when one thread is about to dump core, has set
> core_state, and is waiting for others, another might do something calling
> __khugepaged_enter(), which now crashes because I lumped the core_state
> test (known as "mmget_still_valid") into khugepaged_test_exit().  I still
> think it's best to lump them together, so just in this exceptional case,
> check mm->mm_users directly instead of khugepaged_test_exit().
>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: bbe98f9cadff ("khugepaged: khugepaged_test_exit() check mmget_still_valid()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v4.8+

Acked-by: Yang Shi <shy828301@gmail.com>

> ---
>
>  mm/khugepaged.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- v5.9-rc/mm/khugepaged.c     2020-08-12 19:46:50.867196579 -0700
> +++ linux/mm/khugepaged.c       2020-08-14 14:24:32.739457309 -0700
> @@ -466,7 +466,7 @@ int __khugepaged_enter(struct mm_struct
>                 return -ENOMEM;
>
>         /* __khugepaged_exit() must not run from under us */
> -       VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
> +       VM_BUG_ON_MM(atomic_read(&mm->mm_users) == 0, mm);
>         if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags))) {
>                 free_mm_slot(mm_slot);
>                 return 0;
>
