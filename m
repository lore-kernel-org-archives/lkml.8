Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8D8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 23:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB0422CA1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 23:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JovRvs53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGRXFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGRXFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 19:05:24 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA01C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 16:05:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i4so13951185iov.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5rC17XUacjqtPIcpgNQKRp4muU4y2Y7PtonE6EZs65Y=;
        b=JovRvs53vS3LhD4wT75SBuQ0IxMgWyEcioHUxjf0RlgV6RsWK/e1mccgRNHD9f8Rvy
         NJDRvU5IlhaBXje4zlnPg/9DeDEEMljRrriD0n7Ib0xmNr71T/MoVMAGEZUolnaTIFnF
         r4uQPLCSmbtSxjmRKa2qUv/fUr9QeWMubZ8TVxEdVP6/UCuj+ONm9Cp9Fy2XcAqrSW3z
         kc0UOEbigR6Q7S7bx4djCfpIJaZsrX7Vh9jiWo84uScielx+B9mlsfPBv+fd7q79jR00
         IH2JOHs7UoQQnw8qpH7dN3WEnlNO2pgxXdhRJ2C19ym0QNouoTEyL9sRfNbGgWyif5+4
         CFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5rC17XUacjqtPIcpgNQKRp4muU4y2Y7PtonE6EZs65Y=;
        b=NqvTb1HhABdyu11HxfZiUuoZNuvNxNsz/+ZbpgRABtoioH6lhMxouHug7ONSYu95hH
         KsL2uPQIiE7VCNaS6ea2XhNmiDG+vaU1v8jNRBVKvpHkxw2nshXwKzXOjLdc8Ftkq0eU
         je4BD0oZnD9cZTgdo9yuE7DKCHHkzotR9owZdo9L7R8SaIrDWMGOBtHzFTPgUsAr3wKV
         2YHvaBd6atrHRbkXqZf30pqt6xXFHyEr01WlEzOtcT6VWUYBVysimoFQeSDdZAJg+t+S
         Bq48HMy6OQV4wmG8U4aaSKI64IeOeVUbkqkL0H/Nufc7AM4dODdssy54p7cJf07t/tEk
         4H3Q==
X-Gm-Message-State: AOAM530JSSfJl3E/510NIBXXBw7OK9A/CxuxBfqc6J1Ic6Q+0lrZZB6m
        7XMHXBFhR9cXjfGOTMq9ugy3WaSS+Dxy7rccxFY=
X-Google-Smtp-Source: ABdhPJyHh9vzoWe7M7iy5AffSOIJUq+wYiN/f4CSywoc1sNJVCI5IymnE1WQD1egSa8s1kfqEx4FL+cYL9VEKVHhRfs=
X-Received: by 2002:a05:6638:1187:: with SMTP id f7mr18520540jas.58.1595113522233;
 Sat, 18 Jul 2020 16:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <c2bfe1aa390777b10d810d2b76a35b97fbd32a1c.camel@intel.com>
 <CALCETrUBDUKTcmmYD7BpZkL3869ELvha1PqOcScw4M-B_DQdiA@mail.gmail.com>
 <7653c6c74a4eee18b8bdc8262e0c0b5b95f9d771.camel@intel.com> <d4b9d6a1-d413-b044-1d4a-512bbbf06d78@intel.com>
In-Reply-To: <d4b9d6a1-d413-b044-1d4a-512bbbf06d78@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sat, 18 Jul 2020 16:04:46 -0700
Message-ID: <CAMe9rOo9ivMP4b4qYGWvtEzKT-h68iPecjqp3wZzQCpVqE9FsA@mail.gmail.com>
Subject: Re: Random shadow stack pointer corruption
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 3:41 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/18/20 11:24 AM, Yu-cheng Yu wrote:
> > On Sat, 2020-07-18 at 11:00 -0700, Andy Lutomirski wrote:
> >> On Sat, Jul 18, 2020 at 10:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >>> Hi,
> >>>
> >>> My shadow stack tests start to have random shadow stack pointer corruption after
> >>> v5.7 (excluding).  The symptom looks like some locking issue or the kernel is
> >>> confused about which CPU a task is on.  In later tip/master, this can be
> >>> triggered by creating two tasks and each does continuous
> >>> pthread_create()/pthread_join().  If the kernel has max_cpus=1, the issue goes
> >>> away.  I also checked XSAVES/XRSTORS, but this does not seem to be an issue
> >>> coming from there.
> >>
> >> What do you mean "shadow stack pointer corruption"?  Is SSP itself
> >> corrupt while running in the kernel?  Is one of the MSRs getting
> >> corrupted?  Is the memory to which the shadow stack points getting
> >> corrupted? Is the CPU rejecting an attempt to change SSP?
> >
> > What I see is, a new thread after ret_from_fork() and iret back to ring-3,
> > its shadow stack pointer (MSR_IA32_PL3_SSP) is corrupted.
>
> Does corrupt mean random?  Or is it a valid stack address, just not for
> _this_ thread?  Or NULL?  Or is it a kernel address?  Have you tried
> tracing *ALL* the WRMSR's and XRSTOR's that write to the MSR?

Another data point.  When memory corruption happened, there was no
core dump at all.  We verified that core dump was enabled and we did
get core dump for other programs.


-- 
H.J.
