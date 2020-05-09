Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F267AC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EF92192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtVsTny7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEIJAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgEIJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:00:21 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC0C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 02:00:21 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id n11so3710897ilj.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7X3HTC7K8g1WZmOtkkq/IVK7kmDqKruVFVXKBk3Gd+Y=;
        b=UtVsTny7Y0l8o3huNoShEZOlm1F3D6kGgvrdni6BMrMyubTTQwJvUqZ3SO8kFH1GTI
         JJGokEBGdp3RE2OJtyO9XDz2fLAJP5t+FQKTayK2Sz54uD50L0BIKLjx9pKezdEewZ1P
         fhLzXlV5LSXjEfrIa/+FXjyWQSUOk2nXAuaoykX8EsE9/YJ65GtT2E/ygUDjq0GkuYV0
         iD/4DVKD7KW0/xDibqtEt0xZlTfZyFmlL1PL/C6h6Y0Hdf2TbrfL78jm1S0ollEp8Vog
         8/Vsmz9fHW2D3xmf4pQNNyfuj9hVbMCMJQgiJUk44K1GEWHb+xwnIlPzzvAsftK2LOfW
         +W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7X3HTC7K8g1WZmOtkkq/IVK7kmDqKruVFVXKBk3Gd+Y=;
        b=WgvSVKw9QIzvXS4YlFMAH8LT51EiiJA3NQ6xrYzCBPgOKFom7DmV1BfOXivjXFo564
         cLU6YQwjiqnEz6MsEApiqrw7a7pOTInS4bp7K/ZohlfA16sFgmesGQ8zS76hqsPOjC4U
         Ez84xG2dgDe2u02PaSUxpZTTuu+8b5D7VcmIpoCubTRrNC5BwWwXkMj7XFLF4kU/hkCM
         buQ+pjoa0FsxnE2djrFR4jIwhcXJU1t4ocTxuP0ziHzyHqaI46Jvirtc754G1MhefKxL
         GqQfozn1XNmjXpmZQ4meq/5hQWiN5xyq/movzoeEr5xbT29MlWpu006nKEdW3ioW5tfA
         egvA==
X-Gm-Message-State: AGi0PuYaQTsEQtCyb4uKxCmt6Sw4s6wXfYnChBArGUWKiu6f1HfVX9lM
        1qbPf1lRnQelrkypZB8J7p6U0cPWCRo9AtOFiVU=
X-Google-Smtp-Source: APiQypKtLkaxnkI2rbrqPKMNwex7CHAX2swC8cYv/6hPYcjXBREdsgKIwsCTzc21ehgLdk7WBZSsZe/RoaNv7CGFI3Q=
X-Received: by 2002:a92:5b05:: with SMTP id p5mr6658556ilb.94.1589014819746;
 Sat, 09 May 2020 02:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134058.272448010@linutronix.de>
In-Reply-To: <20200505134058.272448010@linutronix.de>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sat, 9 May 2020 17:00:08 +0800
Message-ID: <CAJhGHyA1FNtZM9SM=yR9YqUpju81NkeW0jN-UJ9fMNhTjsQhVQ@mail.gmail.com>
Subject: Re: [patch V4 part 1 02/36] x86/hw_breakpoint: Prevent data
 breakpoints on cpu_entry_area
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 10:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Andy Lutomirski <luto@kernel.org>
>
> A data breakpoint near the top of an IST stack will cause unresoverable
> recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
> Prevent either of these from happening.
>
> Co-developed-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/hw_breakpoint.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -227,10 +227,35 @@ int arch_check_bp_in_kernelspace(struct
>         return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
>  }
>
> +/*
> + * Checks whether the range from addr to end, inclusive, overlaps the CPU
> + * entry area range.
> + */
> +static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
> +{
> +       return end >= CPU_ENTRY_AREA_PER_CPU &&
> +              addr < (CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_TOTAL_SIZE);
> +}

Hello

These two lines:
s/CPU_ENTRY_AREA_PER_CPU/CPU_ENTRY_AREA_BASE/g
or
s/CPU_ENTRY_AREA_PER_CPU/CPU_ENTRY_AREA_RO_IDT/g

or otherwise the RO_IDT is not being protected.

sees:
#define CPU_ENTRY_AREA_PER_CPU (CPU_ENTRY_AREA_RO_IDT + PAGE_SIZE)

#define CPU_ENTRY_AREA_TOTAL_SIZE (CPU_ENTRY_AREA_ARRAY_SIZE + PAGE_SIZE)
                                     ^ sizeof PER_CPU           ^ RO_IDT


Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>


> +
>  static int arch_build_bp_info(struct perf_event *bp,
>                               const struct perf_event_attr *attr,
>                               struct arch_hw_breakpoint *hw)
>  {
> +       unsigned long bp_end;
> +
> +       bp_end = attr->bp_addr + attr->bp_len - 1;
> +       if (bp_end < attr->bp_addr)
> +               return -EINVAL;
> +
> +       /*
> +        * Prevent any breakpoint of any type that overlaps the
> +        * cpu_entry_area.  This protects the IST stacks and also
> +        * reduces the chance that we ever find out what happens if
> +        * there's a data breakpoint on the GDT, IDT, or TSS.
> +        */
> +       if (within_cpu_entry_area(attr->bp_addr, bp_end))
> +               return -EINVAL;
> +
>         hw->address = attr->bp_addr;
>         hw->mask = 0;
>
>
