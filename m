Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234252177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BROPJkRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgIIDEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgIIDEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:04:39 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A87C061573;
        Tue,  8 Sep 2020 20:04:38 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 185so906137oie.11;
        Tue, 08 Sep 2020 20:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3/+DQVzh2AU9atWFOLysKelIvXbV0cfoRaYVqxne+k=;
        b=BROPJkRjWR25FKqcJOUv2Lp8N04CBQBTHcjDVTJoC598h1z3kqcDxAeCOLX7FHk5g2
         neHdXjore7KzF3GUl/z7pQMywlzbUsIlkvDGUNW3vPoa07rd4zXzeNB82U8RFtP1madP
         nwMtVFNXjsTMCulfVxRfmPkR4CD3Ermz3zGnkOHHZwbQaJL2qJi5tGMMLbZYsVtTdNwo
         fdpTBz5QWVHLgFDkZiEmMAlC8vWQ/BV/1ACT4VwFRbyTayh6yiw9KfPpfLnG0BCbJy2t
         A8heNYZwEj9EdsA+iQCmQk7GF8VMyCRiyUARthZwFF8kQj7y5IvbeL2c46J9pGnEcxm2
         Yrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3/+DQVzh2AU9atWFOLysKelIvXbV0cfoRaYVqxne+k=;
        b=epuolXLv5m7ZIp/EycZf53VM/1/zysRO+ly3JQ4NdEt5OtcbriwLTORw/gkcf4IYPs
         uLvMp8/8XtuemVYiQaLBWwGqafRcLW5fk9BfpugoW1aNrcbKiJWT4K7xj1QVOXcfOQmK
         Ko2xbujZ8mO4FwEJ/veUe17rrup2QfbLsmYAYvcdcZiCub6Lpx6QSU8seMzXxySCsdis
         jag33jbJ0XpOljEZli2IE/eqckukUb9DggZLnUo38A8zD6Vqa+Xmg2YI3ee7Gno8YfK0
         DeVCBqyQ4FFhS32+w3WBWgc5bJQtEx9hrr47E+tHcNnoqH//tC5XGwAcXZ/mzuyIcJe+
         Cwgg==
X-Gm-Message-State: AOAM530PPLfN0PK7OBlTthHrnE3g6VlmEcPxSvT7OOPEC+hk2JTo16aU
        Qyki8KAGBYNSD/aqrWU6sr+TMSqlTiOt3LH0CTU=
X-Google-Smtp-Source: ABdhPJxuFDk0GaFt924x1ihXNKx1nLRU/Rkce9Jy6coBGFwcFJXT3QATsw4HMJPHWn7u0AwMbuaQA2bIFXu2UltmjKI=
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr1359431oic.33.1599620678349;
 Tue, 08 Sep 2020 20:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598868203.git.yulei.kernel@gmail.com>
In-Reply-To: <cover.1598868203.git.yulei.kernel@gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 9 Sep 2020 11:04:26 +0800
Message-ID: <CANRm+CwhTVHXOV6HzawHS5E_ELA3nEw0AxY1-w8vX=EsADWGSw@mail.gmail.com>
Subject: Re: [RFC V2 0/9] x86/mmu:Introduce parallel memory virtualization to
 boost performance
To:     Yulei Zhang <yulei.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments? guys!
On Tue, 1 Sep 2020 at 19:52, <yulei.kernel@gmail.com> wrote:
>
> From: Yulei Zhang <yulei.kernel@gmail.com>
>
> Currently in KVM memory virtulization we relay on mmu_lock to
> synchronize the memory mapping update, which make vCPUs work
> in serialize mode and slow down the execution, especially after
> migration to do substantial memory mapping will cause visible
> performance drop, and it can get worse if guest has more vCPU
> numbers and memories.
>
> The idea we present in this patch set is to mitigate the issue
> with pre-constructed memory mapping table. We will fast pin the
> guest memory to build up a global memory mapping table according
> to the guest memslots changes and apply it to cr3, so that after
> guest starts up all the vCPUs would be able to update the memory
> simultaneously without page fault exception, thus the performance
> improvement is expected.
>
> We use memory dirty pattern workload to test the initial patch
> set and get positive result even with huge page enabled. For example,
> we create guest with 32 vCPUs and 64G memories, and let the vcpus
> dirty the entire memory region concurrently, as the initial patch
> eliminate the overhead of mmu_lock, in 2M/1G huge page mode we would
> get the job done in about 50% faster.
>
> We only validate this feature on Intel x86 platform. And as Ben
> pointed out in RFC V1, so far we disable the SMM for resource
> consideration, drop the mmu notification as in this case the
> memory is pinned.
>
> V1->V2:
> * Rebase the code to kernel version 5.9.0-rc1.
>
> Yulei Zhang (9):
>   Introduce new fields in kvm_arch/vcpu_arch struct for direct build EPT
>     support
>   Introduce page table population function for direct build EPT feature
>   Introduce page table remove function for direct build EPT feature
>   Add release function for direct build ept when guest VM exit
>   Modify the page fault path to meet the direct build EPT requirement
>   Apply the direct build EPT according to the memory slots change
>   Add migration support when using direct build EPT
>   Introduce kvm module parameter global_tdp to turn on the direct build
>     EPT mode
>   Handle certain mmu exposed functions properly while turn on direct
>     build EPT mode
>
>  arch/mips/kvm/mips.c            |  13 +
>  arch/powerpc/kvm/powerpc.c      |  13 +
>  arch/s390/kvm/kvm-s390.c        |  13 +
>  arch/x86/include/asm/kvm_host.h |  13 +-
>  arch/x86/kvm/mmu/mmu.c          | 533 ++++++++++++++++++++++++++++++--
>  arch/x86/kvm/svm/svm.c          |   2 +-
>  arch/x86/kvm/vmx/vmx.c          |   7 +-
>  arch/x86/kvm/x86.c              |  55 ++--
>  include/linux/kvm_host.h        |   7 +-
>  virt/kvm/kvm_main.c             |  43 ++-
>  10 files changed, 639 insertions(+), 60 deletions(-)
>
> --
> 2.17.1
>
