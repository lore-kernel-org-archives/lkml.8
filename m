Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127DDC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E146620771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Avvogo0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGMSYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGMSYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:24:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A77C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:24:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c16so14532672ioi.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYkJT4IJ7durdcl3HAxzOHP9WiK8D09OCIn5mRv/ew0=;
        b=Avvogo0Ehwuuxv7pOUWUsVP9CBTo8Oy9rhoMRMfJXL8CTXWLE6ltS7rvu63OWcfL9+
         zzfMGIbqka1Wlk99wMB8UeyFkHCSEEVe5IpLjsBIyKQkCYPfXri+DgT6gUVPBaX41p4s
         7MANE/HHnaTsa0kqvCg/JRj0LTh1B3K7Zzo5dNsqJufOcP47rRj3PNns7t0E1IDu0Hnh
         X0Ex1ka6fF6hT6nFnbDv79JFqCF+5TdPNjRJ0n5tMWCSRm8dJg3rWWFuV5mZI9oxWFS/
         jrXRerEaQyvbkG0fK4JsGb2A/q/PkE22SHBkvCypKEm8HTU4m73Z2X7IlfHteV4O9yXw
         MfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYkJT4IJ7durdcl3HAxzOHP9WiK8D09OCIn5mRv/ew0=;
        b=ixDWV/0CccYyTnZJmEO4slmJYDIe/n4rGdMZamUmIVjncRBgvG46vVBSv1tG1jhTYA
         12XUcSaNIKMLYS9XxbSDzeMNymjZ1l14R6fCslAZX76oygUuRLiu6murzWmZDG1CMeX2
         5xtbovCMEcpFEVYSwceMu+J4c6+Fw3B4y6zRc2TXegaI4VnvpWJL1T3g3rGYs5wSRHEw
         xclGkvKG5ICEWN0vu44iyisR2wjmTopClXOEYGZQQSZFwfDdcQ6Mc3woGrK/815jqojI
         8HDautAm2hTA18xoF6T45h69JdW7iQn5DbDtXN9mGz5v22iJUNawIs6OLMNgMJtY5dNy
         1PFw==
X-Gm-Message-State: AOAM532m1V4PSdqyXFRyrrVi/YDhzmqk1+nVGGUpfHE7evQPFgNbS6EO
        wcJANcYx4K9WwSdkSfLRdJLJ7PWwvF6IeG8nWxKmMQ==
X-Google-Smtp-Source: ABdhPJzuW+QbYZgBiMGGDUi132YDZrEQbqRA6a7lx6xxTu6DtSbSx3+CqUb8OrQ2zu/CCblMAetN5Y/1qoWkUST/M+U=
X-Received: by 2002:a6b:c3cf:: with SMTP id t198mr1048147iof.164.1594664649992;
 Mon, 13 Jul 2020 11:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200713162206.1930767-1-vkuznets@redhat.com>
In-Reply-To: <20200713162206.1930767-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 13 Jul 2020 11:23:59 -0700
Message-ID: <CALMp9eR+DYVH0UZvbNKUNArzPdf1mvAoxakzj++szaVCD0Fcpw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: nVMX: fix the layout of struct kvm_vmx_nested_state_hdr
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Peter Shier <pshier@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 9:22 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Before commit 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer
> migration") struct kvm_vmx_nested_state_hdr looked like:
>
> struct kvm_vmx_nested_state_hdr {
>         __u64 vmxon_pa;
>         __u64 vmcs12_pa;
>         struct {
>                 __u16 flags;
>         } smm;
> }
>
> The ABI got broken by the above mentioned commit and an attempt
> to fix that was made in commit 83d31e5271ac ("KVM: nVMX: fixes for
> preemption timer migration") which made the structure look like:
>
> struct kvm_vmx_nested_state_hdr {
>         __u64 vmxon_pa;
>         __u64 vmcs12_pa;
>         struct {
>                 __u16 flags;
>         } smm;
>         __u32 flags;
>         __u64 preemption_timer_deadline;
> };
>
> The problem with this layout is that before both changes compilers were
> allocating 24 bytes for this and although smm.flags is padded to 8 bytes,
> it is initialized as a 2 byte value. Chances are that legacy userspaces
> using old layout will be passing uninitialized bytes which will slip into
> what is now known as 'flags'.
>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Fixes: 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration")
> Fixes: 83d31e5271ac ("KVM: nVMX: fixes for preemption timer migration")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Oops!

Reviewed-by: Jim Mattson <jmattson@google.com>
