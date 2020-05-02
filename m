Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDDBC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8152137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VCV6t+Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgEBGAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 02:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726468AbgEBGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 02:00:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0519C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 23:00:40 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g19so4335194otk.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 23:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDF1hXWC/s7Oyy2jCdyRcsT8e8W6WSRCRNbuadBXFl8=;
        b=VCV6t+ImMO4jEWjNslBlWz6cqKNFoWc1JEfu0tDDfCA+eT7hh2yuSCB54TtP6xxjSy
         iA97AiXBxF+nbZJvS1AgfB9CH5pNpqtWcJrDLd0g90OsTa1PMGzV2nQTaOP0hL7Mslua
         NoKFwMCB6ImBjqf82Ewqrdw8Xk2ZM8V+uzpDevZPEcgXEWolO0k2lPMmckoRjtyg28+j
         vxDQG5ZJSnaKapXWPaqHpwArQlqcnzD/ZjyUyf9r5QrbPknlKYmQjV4iGmhm+4rz1w9b
         taVGGvk7nT30weXhFMZWP8YQ4svB1Cs0ZZijIB680tai7aNcKj5Z08OBq0rFT7VZc6TB
         6VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDF1hXWC/s7Oyy2jCdyRcsT8e8W6WSRCRNbuadBXFl8=;
        b=VoXz4pBUDaN6j2irC1+F2doZNnIp8XaP+tSjaFo5J6sAbGH2DUsZ48dC5sEut/C8R9
         RkXnIra/EwJ8upBWxHCnGhZ6vtrIN8GhXN2Z0uZ0y1/ilQDiJ59jxt0srUIu5DEPeFYt
         51/T6FC6YGl7k0iJBZ3GEarMUNvDX0YcEzkxGxygqEy7VtS3C4P/izLOkkgIGhmD8VY5
         IFbeGA6c54SOv85farjiaixApZUwvyzq4SbFonhX+YbeGJo5VHvbWGQTypxAZ113Tmzo
         VuUyowU7EGDTSFe34VEDxP46DiVKYQ0dcFSuJLqHwB9rUtKc77zUAD60UdHs+Aq2Sffv
         IVkQ==
X-Gm-Message-State: AGi0PubSlb2m+4NFlyoP1it5dg9dzPn0Utyp5gANPqDOT6V/FCFYliba
        BFAPnFLVeU97s40NBxoP5azpNOiah+vR3cbb6OYIuA==
X-Google-Smtp-Source: APiQypIM3uXqqJd6aGFJt1RXbZG6aN0mXG2pfDnjyGbJ12cznOlGaf/9vtpuw7ftZRfJpM5fXyH4JyMTw5qWCIwhWJI=
X-Received: by 2002:a9d:7dd8:: with SMTP id k24mr6410161otn.33.1588399240219;
 Fri, 01 May 2020 23:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095325.111441-1-zong.li@sifive.com> <CAOnJCUJBJ3wrY-KY3YgD-qJfr7dsWzdA83fxFYmOTmjsrYgOfA@mail.gmail.com>
In-Reply-To: <CAOnJCUJBJ3wrY-KY3YgD-qJfr7dsWzdA83fxFYmOTmjsrYgOfA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Sat, 2 May 2020 14:00:30 +0800
Message-ID: <CANXhq0qk_GQubgWB9=2uMVDSLSCWaiLtPkBcHQCPLCHyVrtdnA@mail.gmail.com>
Subject: Re: [PATCH] riscv: force __cpu_up_ variables to put in data section
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 2:23 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Apr 30, 2020 at 2:53 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > Put __cpu_up_stack_pointer and __cpu_up_task_pointer in data section.
> > Currently, these two variables are put in bss section, there is a
> > potential risk that secondary harts get the uninitialized value before
> > main hart finishing the bss clearing. In this case, all secondary
> > harts would go through the waiting loop and enable the MMU before
> > main hart set up the page table.
> >
>
> That would be only true if you are using random booting protocol with
> SBI v0.1 implementation.
> With HSM extension in place, all the secondary cores are waiting in
> firmware. The booting core
> will bring them up one by one from cpu_up method.
>
> The HSM extension is already available in OpenSBI v0.7 and Linux
> kernel 5.7-rc1 onwards.

If I understand correctly, the newest kernel still works with earlier
OpenSBI than v0.7 or BBL. It seems to me that we need to consider the
use cases if we don't limit it to up to OpenSBI v0.7.

>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/kernel/cpu_ops.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> > index c4c33bf02369..0ec22354018c 100644
> > --- a/arch/riscv/kernel/cpu_ops.c
> > +++ b/arch/riscv/kernel/cpu_ops.c
> > @@ -15,8 +15,8 @@
> >
> >  const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
> >
> > -void *__cpu_up_stack_pointer[NR_CPUS];
> > -void *__cpu_up_task_pointer[NR_CPUS];
> > +void *__cpu_up_stack_pointer[NR_CPUS] __section(.data);
> > +void *__cpu_up_task_pointer[NR_CPUS] __section(.data);
> >
> >  extern const struct cpu_operations cpu_ops_sbi;
> >  extern const struct cpu_operations cpu_ops_spinwait;
> > --
> > 2.26.1
> >
> >
>
>
> --
> Regards,
> Atish
