Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15B0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA7C221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2q1p0JO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHFWjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHFWjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:39:46 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54B0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 15:39:46 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v13so142232oiv.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYyChGMYepRNLD8UKgj7thBgwQob2Oa7/EK/gPsMnyo=;
        b=E2q1p0JO2XvfW4MMncIYFDARtHPyS+Dcb3O71GCXktM+fV9+klnIKIxDdRHgU8QHRr
         l7X7JmWn9GB+naSfiniANoD7LR6lGKLMk5kpKOJWxfeJQffooRC0T6skmfrGEC1AMHne
         yKbq2NmQL6q9ywbDwSPKDUz/etM/TXSWury+bF/GcssilJLmAiftBdZFjsPbW9rUAfP+
         /X3iDgd1HOlYlLaINt0FDbT3U2C2Nks5KEEvO3bLUtsyWVHpvQfouOR9Zj9RrV5LhyCL
         Ghy+AmHJ2iZQF63/YcvknmUTlSDTrBqwC41c7/rEggVDsauU9MQ+kT+MyOWnLhLqZ+EL
         IwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYyChGMYepRNLD8UKgj7thBgwQob2Oa7/EK/gPsMnyo=;
        b=JIaFu6PLJ11IfXy7aPOZjY84BazIAM6cobX7qCt4qmDLAC7dMMVFLm41x60V1nU1Zk
         L4Jh2ugBFvqbtlmTQWigUzuBzNj8LLzM4NcqhCG5x/ulvQWsccXqHp9KGgrgqkL0d7Mh
         gOA5F/Qdxjsf0ztVRVY6dm9+TA+uPpPQpmRKJXidiAMumI6eIyZsZtm4EOVDJrGbl1oj
         3C7yQCOi+ywpjVEXfjBJE8W1zmcAN8BNXqbRfUxyQicfCqNQmOVZOgzVq0nPoRwr0zv4
         PvWeCIvrTKKbV+L2xxW0aIftgRueNylynMgTkLfyjPhzieATuEPivAU4I8P2HV30tauu
         ZkVA==
X-Gm-Message-State: AOAM530p1+tLfI7e1ZhhNhjizOIJe82bB3Gho+kiQ5NJYGsL5AU8pcba
        1vaqqiTe5k3sM6KKvi15xIGfnuO8ubzZBlEEl1Y=
X-Google-Smtp-Source: ABdhPJxgRVHE+w66qKr8NvAura05izXsDohZP4qj6OUjgNalYTkqSJnvf7KROxLkFiU/XGIePEi/yKZRmmb+OQ1qMho=
X-Received: by 2002:a54:4512:: with SMTP id l18mr8807675oil.148.1596753585500;
 Thu, 06 Aug 2020 15:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200730205112.2099429-1-ndesaulniers@google.com> <20200730205112.2099429-4-ndesaulniers@google.com>
In-Reply-To: <20200730205112.2099429-4-ndesaulniers@google.com>
From:   Nathan Huckleberry <nhuck15@gmail.com>
Date:   Thu, 6 Aug 2020 17:39:33 -0500
Message-ID: <CAN=-RxstJBjJUcOf9iuAxEcxYUhJTdF9JhPVWwQuefnE+3s52w@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: backtrace-clang: give labels more descriptive names
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        clang-built-linux@googlegroups.com,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Lvqiang Huang <lvqiang.huang@unisoc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The style cleanup looks great. I just have one extra thing that
can probably be thrown into this patch.

On Thu, Jul 30, 2020 at 3:51 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Removes the 1004 label; it was neither a control flow target, nor an
> instruction we expect to produce a fault.
>
> Gives the labels slightly more readable names. The `b` suffixes are
> handy to disambiguate between labels of the same identifier when there's
> more than one. Since these labels are unique, let's just give them
> names.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/lib/backtrace-clang.S | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
> index 40eb2215eaf4..7dad2a6843a5 100644
> --- a/arch/arm/lib/backtrace-clang.S
> +++ b/arch/arm/lib/backtrace-clang.S
> @@ -121,8 +121,8 @@ for_each_frame:     tst     frame, mask             @ Check for address exceptions
>   * start. This value gets updated to be the function start later if it is
>   * possible.
>   */
> -1001:          ldr     sv_pc, [frame, #4]      @ get saved 'pc'
> -1002:          ldr     sv_fp, [frame, #0]      @ get saved fp
> +load_pc:       ldr     sv_pc, [frame, #4]      @ get saved 'pc'
> +load_fp:       ldr     sv_fp, [frame, #0]      @ get saved fp
>
>                 teq     sv_fp, mask             @ make sure next frame exists
>                 beq     no_frame
> @@ -142,7 +142,7 @@ for_each_frame:     tst     frame, mask             @ Check for address exceptions
>   * registers for the current function, but the stacktrace is still printed
>   * properly.
>   */
> -1003:          ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
> +load_lr:       ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
>
>                 tst     sv_lr, #0               @ If there's no previous lr,
>                 beq     finished_setup          @ we're done.
> @@ -166,8 +166,7 @@ finished_setup:
>  /*
>   * Print the function (sv_pc) and where it was called from (sv_lr).
>   */
> -1004:          mov     r0, sv_pc
> -
> +               mov     r0, sv_pc
>                 mov     r1, sv_lr
>                 mov     r2, frame
>                 bic     r1, r1, mask            @ mask PC/LR for the mode
> @@ -182,7 +181,7 @@ finished_setup:
>   * pointer the comparison will fail and no registers will print. Unwinding will
>   * continue as if there had been no registers stored in this frame.
>   */
> -1005:          ldr     r1, [sv_pc, #0]         @ if stmfd sp!, {..., fp, lr}
> +load_stmfd:    ldr     r1, [sv_pc, #0]         @ if stmfd sp!, {..., fp, lr}
>                 ldr     r3, .Lopcode            @ instruction exists,
>                 teq     r3, r1, lsr #11
>                 ldr     r0, [frame]             @ locals are stored in
> @@ -201,7 +200,7 @@ finished_setup:
>                 mov     frame, sv_fp            @ above the current frame
>                 bhi     for_each_frame
>
> -1006:          adr     r0, .Lbad
> +bad_frame:     adr     r0, .Lbad
>                 mov     r1, loglvl
>                 mov     r2, frame
>                 bl      printk
> @@ -216,11 +215,10 @@ bad_lr:           mov     sv_fp, #0
>  ENDPROC(c_backtrace)
>                 .pushsection __ex_table,"a"
>                 .align  3
> -               .long   1001b, 1006b
> -               .long   1002b, 1006b
> -               .long   1003b, 1006b
> -               .long   1004b, 1006b
> -               .long   1005b, 1006b
> +               .long   load_pc, bad_frame
> +               .long   load_fp, bad_frame
> +               .long   load_lr, bad_frame
> +               .long   load_stmfd, bad_frame

Load_stmfd should get its own fixup
handler since it should emit errors about a bad
pc, not a bad frame pointer.

>                 .long   prev_call, bad_lr
>                 .popsection
>
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
