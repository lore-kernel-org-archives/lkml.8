Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545ADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F902207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590777149;
	bh=ER6SpCnwMQt6LkAIjAW7Qi0kcdcfNlB1rmdIRR5H+fE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q8zyyC5WZkPMv4CRCnPtEg13/b52nZFWaV59hKt39wLAI0386FDqahm3sGo+nTVN/
	 0d7tfgBQfNN8xkaRGCNdseoktMGNhweC5f+TfFIJ/kTfustN7OWLRGqqsQDozYB0hT
	 Cw0AR3gbRnKGT8k6/2fCGWcSzpzacey90aVrmlH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgE2Sc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2Sc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:32:28 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35656208B8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590777147;
        bh=ER6SpCnwMQt6LkAIjAW7Qi0kcdcfNlB1rmdIRR5H+fE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TNNP0VsQ95ksHfDnC6VyWgknhe/zdlFKYGXkfQevjCDd53HJpuZNRylwDkYrkid6L
         WcS58HSW3zXVCfZ0879PeSSeoDx5TO9mjtnPJWLJJAZc/ga/sxseEUHcYv8T7gE0V+
         X8DO5eNsX1X4wNTcE9mzsXfY7XGzwQCx28c7M9fw=
Received: by mail-wm1-f45.google.com with SMTP id f5so4866897wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:32:27 -0700 (PDT)
X-Gm-Message-State: AOAM531+oVzzcZmg7kR+wqpTEMq2unjXvi0JpYoSdAqDZBeVeJ1p8QXm
        8BJtKDatt/BX8yJWgonGvMc14dE2CSH6REkdh7nm6g==
X-Google-Smtp-Source: ABdhPJzdxWFVJHASpKboazTm8PaAUYTjIZrzsuCQ5J9PTBRJsNDc1IRTVnuc4HZr7MrwhVYllEf6ddnL7lKQyP8RsUA=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr10342787wmr.49.1590777145586;
 Fri, 29 May 2020 11:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <87mu5roov6.fsf@nanos.tec.linutronix.de> <20200529082618.1697-1-laijs@linux.alibaba.com>
In-Reply-To: <20200529082618.1697-1-laijs@linux.alibaba.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 29 May 2020 11:32:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXKdh=nBWz96pow5roLmh0ez2YeQ9P+H5gxdor5TfrqUQ@mail.gmail.com>
Message-ID: <CALCETrXKdh=nBWz96pow5roLmh0ez2YeQ9P+H5gxdor5TfrqUQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] x86/entry: simply stack switching when exception
 on userspace
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 1:26 AM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
>
> 7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
> has resulted that when exception on userspace, the kernel (error_entry)
> always push the pt_regs to entry stack(sp0), and then copy them to the
> kernel stack.
>
> And recent x86/entry work makes interrupt also use idtentry
> and makes all the interrupt code save the pt_regs on the sp0 stack
> and then copy it to the thread stack like exception.
>
> This is hot path (page fault, ipi), such overhead should be avoided.
> And the original interrupt_entry directly switches to kernel stack
> and pushes pt_regs to kernel stack. We should do it for error_entry.
> This is the job of patch1.
>
> Patch 2-4 simply stack switching for .Lerror_bad_iret by just doing
> all the work in one function (fixup_bad_iret()).
>
> The patch set is based on tip/x86/entry (28447ea41542) (May 20).

There are definitely good cleanups in here, but I think it would be
nice rebased to whatever lands in 5.8-rc1 settles.

--Andy
