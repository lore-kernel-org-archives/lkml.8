Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D3E2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+HAwEAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGOBB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOBB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:01:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB79C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:01:56 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x83so498802oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMjrBdOlZtOlrxQJblTz347f9wqhxv2y4/d6fAqMOvo=;
        b=D+HAwEAA+6YUuQyV3YTuVOAqodxiScvYI0sXW1JASdOzeCJAICLzKcpqPhLEItyi4r
         7EylnS7jWTeno/LtO8iu+rmRR8q2MX1QPELT1XKECJejL8yJLrzzyaj62WffiBvmlcaF
         HCRSXo6V1LAJ6CHlb/4qZF73E3jTXFr/4dheQvfBjX5UcX4PBILdSM0jnxYznV73/7IF
         CmDVWUphrNblgFrkRiuWjTgz6aLwQ5EOudh+GZ9ZgCqj/I4uw2CfJj2YUTy8HdblPZ3x
         hY53xPDvbUuBCRKGkfP38p3+7DAZEji1GMG2fuGO9R1bjrM9scSdeWyZFz2QG03ZCN6c
         5ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMjrBdOlZtOlrxQJblTz347f9wqhxv2y4/d6fAqMOvo=;
        b=QC325+KBvFyOLN/jzzcznVQz++Lg7F/7JuXMJNVFiBhGH8U2jLtpxoEemnnMrw318c
         8KkFaoISBnF826GBiO05Ku2A0QVnI83IIKDuOszaXyBrd9Cna2xhgWvBrqDwN9H2SmnE
         C8AEefTtwejTpQ6OrM3mKrI8jvMuLxN1z2+UoDaxeUi96c21QFFEs/lZiKSvDa5HqTJr
         pWny3Ler1idyX4l3vO/7iEHAn6v0t0bqFU8+Rq9iQ9ung7wzxVV0/TOIxdAg9x6zVuTO
         g3zswFZIQmU4oHn4QmlXLfGTIkwsTqIi88+jcnRhKlsLqCYtBY8XBR1x6pvO1WJmERsk
         jLsQ==
X-Gm-Message-State: AOAM532sD9ObjOcp9gEtjYoHHBHlYHOiO+J/vdKVDq3QNi2HALPOX0Ad
        DeGzQ6YMU2UAcg/egPI2gGGxFOkBzKfbvfQqryU=
X-Google-Smtp-Source: ABdhPJwOYkykZw/ONGCKTxD0t+RpZ4Uc2oSNkvC3dQpXIGSq/Ls3Qefimh42FXXZW3PnpHY6eA88e7wPjdf4e6SppF0=
X-Received: by 2002:a54:4418:: with SMTP id k24mr5878649oiw.126.1594774914392;
 Tue, 14 Jul 2020 18:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200708045046.135702-1-ravi.bangoria@linux.ibm.com> <20200708045046.135702-2-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200708045046.135702-2-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Wed, 15 Jul 2020 11:01:43 +1000
Message-ID: <CACzsE9oCSRdfFbP0DjJ8M0092BNCKXHa5BzmksNGr6ebmfmzSg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] powerpc/watchpoint: Fix 512 byte boundary limit
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 2:53 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> Milton Miller reported that we are aligning start and end address to
> wrong size SZ_512M. It should be SZ_512. Fix that.
>
> While doing this change I also found a case where ALIGN() comparison
> fails. Within a given aligned range, ALIGN() of two addresses does not
> match when start address is pointing to the first byte and end address
> is pointing to any other byte except the first one. But that's not true
> for ALIGN_DOWN(). ALIGN_DOWN() of any two addresses within that range
> will always point to the first byte. So use ALIGN_DOWN() instead of
> ALIGN().
>
> Fixes: e68ef121c1f4 ("powerpc/watchpoint: Use builtin ALIGN*() macros")
> Reported-by: Milton Miller <miltonm@us.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
I tested this with the ptrace-hwbreak selftest. Can confirm without
also changing to ALIGN_DOWN() then these tests will fail.
Tested-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  arch/powerpc/kernel/hw_breakpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 0000daf0e1da..031e6defc08e 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -419,7 +419,7 @@ static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
>         if (dawr_enabled()) {
>                 max_len = DAWR_MAX_LEN;
>                 /* DAWR region can't cross 512 bytes boundary */
> -               if (ALIGN(start_addr, SZ_512M) != ALIGN(end_addr - 1, SZ_512M))
> +               if (ALIGN_DOWN(start_addr, SZ_512) != ALIGN_DOWN(end_addr - 1, SZ_512))
>                         return -EINVAL;
>         } else if (IS_ENABLED(CONFIG_PPC_8xx)) {
>                 /* 8xx can setup a range without limitation */
> --
> 2.26.2
>
