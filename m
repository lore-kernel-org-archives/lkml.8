Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1632CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D880E246BB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+DXo/4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCBI6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:58:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43392 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:58:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id s23so7324503lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Al5IFuoY2rtnym3clzN0RNUtkS0nsC5av4BTRm+2H8=;
        b=s+DXo/4QB+gzeWecrfZeKjqe+Xn6/LZLwpd0Cm8a4dB5lSDFfBVny//mDtHl1R/ai8
         3zYOJwaHiw3RUktuC7V69MDGGfL9r3ODivQhmIs9Ai6nASDMOWfrQzqsEMDwuu0xlDq7
         jVajW5Wq0jZPWwjlhXf5Zw2G/7d+ykOVa9twrUwY/pSIiNebSJcnhLe0ERcCXgHhFD+d
         VNaIIOZUBRJvTs1GRk/t35WpDjgFhPR9hG/DA/W+daYuaGNNxt7FTMeYXuU6sKuAf2N+
         WhgSUixDeoDy5jb7ZHjTQt7W0xbrAisaBWZ0Xe8fn9Ipbfy0IdoK9NTqBaRSAR3zlHZU
         jRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Al5IFuoY2rtnym3clzN0RNUtkS0nsC5av4BTRm+2H8=;
        b=Iz2HkczNkxq/MRbugdMEpiVtb9RApQlzBrWcIj7lTkP6dvZmAhUTH1HPqK/0OLuiQx
         MhRxFoMu6yDY21UeR6Ivs63/9nnHr7OH6u7pjBtdhJYFct/VmwI6ki/CMweriK7sHBPe
         8HQHagpGit+1MYBkPWtc2AgGFc+iDK1hMVhjGny/mg7K1Gax0V8uQJQHNlYUB0D56/ON
         uGOD1TSBSH7K6fKBUwz4czw51cs0ySmX+JvcEdqfnZrkBkx/tJEwlXmFiK5+rHcR17cc
         8B+hrLcxmjz3tbrwE8d9d/RP/d8u5vD8Q2toJRRQCybApZo6nkmbrEBi3ZuQ6KJmOhEs
         1A/Q==
X-Gm-Message-State: ANhLgQ2nCiXK9gO2DXDUSwJ+mm4lYi9PfvBj/ISQuKlJ+4+/IHzFJDe0
        7W1BIPBJjEbV08VuDCGQ5BMWv6QxxckOqgaRRfjeVA==
X-Google-Smtp-Source: ADFU+vsfA5pYmFGJV50ALCmK9XG6w4XRbq54i4YJwt2GzCZisxPtols/qSbqZqDlSvdlO2myf6Uo6NfLAsAVuWjSkNo=
X-Received: by 2002:ac2:4d16:: with SMTP id r22mr9484343lfi.74.1583139517083;
 Mon, 02 Mar 2020 00:58:37 -0800 (PST)
MIME-Version: 1.0
References: <1583133336-7832-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1583133336-7832-1-git-send-email-wanpengli@tencent.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 2 Mar 2020 14:28:25 +0530
Message-ID: <CA+G9fYvnHwNHpkkEG951VcTBCVuvfMP98WDHf04dVy7K=E4pLg@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix dereference null cpufreq policy
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 at 12:48, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Naresh Kamboju reported:
>
>    Linux version 5.6.0-rc4 (oe-user@oe-host) (gcc version
>   (GCC)) #1 SMP Sun Mar 1 22:59:08 UTC 2020
>    kvm: no hardware support
>    BUG: kernel NULL pointer dereference, address: 000000000000028c
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: 0000 [#1] SMP NOPTI
>    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc4 #1
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>   04/01/2014
>    RIP: 0010:kobject_put+0x12/0x1c0
>    Call Trace:
>     cpufreq_cpu_put+0x15/0x20
>     kvm_arch_init+0x1f6/0x2b0
>     kvm_init+0x31/0x290
>     ? svm_check_processor_compat+0xd/0xd
>     ? svm_check_processor_compat+0xd/0xd
>     svm_init+0x21/0x23
>     do_one_initcall+0x61/0x2f0
>     ? rdinit_setup+0x30/0x30
>     ? rcu_read_lock_sched_held+0x4f/0x80
>     kernel_init_freeable+0x219/0x279
>     ? rest_init+0x250/0x250
>     kernel_init+0xe/0x110
>     ret_from_fork+0x27/0x50
>    Modules linked in:
>    CR2: 000000000000028c
>    ---[ end trace 239abf40c55c409b ]---
>    RIP: 0010:kobject_put+0x12/0x1c0
>
> cpufreq policy which is get by cpufreq_cpu_get() can be NULL if it is failure,
> this patch takes care of it.
>
> Fixes: aaec7c03de (KVM: x86: avoid useless copy of cpufreq policy)
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Applied this patch and test boot pass.

- Naresh
