Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B2BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B316620786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLZpvRf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgHFRJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgHFRGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D40C06138D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 10:04:11 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l17so50335044iok.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nC6PJfNXVU4vFSBxvbjKSl0ryoqOjAjd9RWGvuVHbDM=;
        b=oLZpvRf1kTJ4eibRUBcjxdeDvtdZOPtNEomtrXn5C94Hbs8Rj8dHrZnApxdRFEwjCl
         WBc8yQHq3KYajW40zb9qdXGQih4IRSt9uGsN29kdUUfkeijhhBhk6xJqY18RwkHQExnz
         En5loq1sNJvdr9jvuHobjEotIrsWjcIKsW/9iQLsjtEx4p2gHXPoyKfw1uUZjlnoMgEr
         cwfI76oogIyUiUU8qlY+Ugbn9lc35uMPWzQr+rfeC0c6wD3GxBi6pVfoIgQbJ8oLdNTa
         F4WcNsXK48XhtTQShEm/52gGR2owP8y3C7Uh7G0GJAgUeyMsrEVGHSwuLDZzOSVQ3qXj
         YEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nC6PJfNXVU4vFSBxvbjKSl0ryoqOjAjd9RWGvuVHbDM=;
        b=PPRnj14g+wzfd1hzgkHnFWxZ2GtDal0BfxSghaEUsKm0w0cYWUmsXEs2I4jfhvxLhP
         FTZl48k9MhK5GyKqjriVDug/UG/80yTk04yNXxxK7RGhdHKWyyu0bXKGTtuPArNIUBLn
         BgscBVBKb0ZCRsMoSPSws14z0StE0o9/7mUtHwVngzyCvm+7MTb4sVTUfFJHYj+bSFvq
         KqOBdtvm0r7poiXPOyZcZg4Fg3dTzo4Fb3+61cSI7SxoYfaBpUt/QznaftX7DwvJJTym
         kaXW08kho/EDP54MsNCmxA+g3VC6pw2sLIc8xuOSoWKkIedLGq1j0pKjFTRHxUXB52oq
         vBCw==
X-Gm-Message-State: AOAM533NEPLV6dS0wbURItqrTWWlxlWitE/VWb7DoLJvsWNGHioeLsNl
        49T2zzfz2i9l9BPNZzwhU7us8xgcd3WfHXGaMQ0eQQ==
X-Google-Smtp-Source: ABdhPJzzfGB7YzJrZpItnSdv7H0n5425elbodoOWx8Z/hmcoLH46KhADWrSuaoJDJxAtjYKU+SpwKZ8kaLVmNy3x9qo=
X-Received: by 2002:a5d:80cb:: with SMTP id h11mr10901351ior.189.1596733449095;
 Thu, 06 Aug 2020 10:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200805141202.8641-1-yulei.kernel@gmail.com>
In-Reply-To: <20200805141202.8641-1-yulei.kernel@gmail.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 6 Aug 2020 10:03:57 -0700
Message-ID: <CANgfPd_P_bjduGgS7miCp4BLUaDXBTYb9swC1gzxwYG2baWRVw@mail.gmail.com>
Subject: Re: [RFC 0/9] KVM:x86/mmu:Introduce parallel memory virtualization to
 boost performance
To:     Yulei Zhang <yulei.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        xiaoguangrong.eric@gmail.com, kernellwp@gmail.com,
        lihaiwei.kernel@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>,
        Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 9:53 AM Yulei Zhang <yulei.kernel@gmail.com> wrote:
>
> From: Yulei Zhang <yuleixzhang@tencent.com>
>
> Currently in KVM memory virtulization we relay on mmu_lock to synchronize
> the memory mapping update, which make vCPUs work in serialize mode and
> slow down the execution, especially after migration to do substantial
> memory mapping setup, and performance get worse if increase vCPU numbers
> and guest memories.
>
> The idea we present in this patch set is to mitigate the issue with
> pre-constructed memory mapping table. We will fast pin the guest memory
> to build up a global memory mapping table according to the guest memslots
> changes and apply it to cr3, so that after guest starts up all the vCPUs
> would be able to update the memory concurrently, thus the performance
> improvement is expected.

Is a re-implementation of the various MMU functions in this series
necessary to pre-populate the EPT/NPT? I realize the approach you took
is probably the fastest way to pre-populate an EPT, but it seems like
similar pre-population could be achieved with some changes to the PF
handler's prefault scheme or, from user space by adding a dummy vCPU
to touch memory before loading the actual guest image.

I think this series is taking a similar approach to the direct MMU RFC
I sent out a little less than a year ago. (I will send another version
of that series in the next month.) I'm not sure this level of
complexity is worth it if you're only interested in EPT pre-population.
Is pre-population your goal? You mention "parallel memory
virtualization," does that refer to parallel page fault handling you
intend to implement in a future series?

There are a number of features I see you've chosen to leave behind in
this series which might work for your use case, but I think they're
necessary. These include handling vCPUs with different roles (SMM, VMX
non root mode, etc.), MMU notifiers (which I realize matter less for
pinned memory), demand paging through UFFD, fast EPT
invalidation/teardown and others.

>
> And after test the initial patch with memory dirty pattern workload, we
> have seen positive results even with huge page enabled. For example,
> guest with 32 vCPUs and 64G memories, in 2M/1G huge page mode we would get
> more than 50% improvement.
>
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
>  arch/x86/kvm/mmu/mmu.c          | 537 ++++++++++++++++++++++++++++++--
>  arch/x86/kvm/svm/svm.c          |   2 +-
>  arch/x86/kvm/vmx/vmx.c          |  17 +-
>  arch/x86/kvm/x86.c              |  55 ++--
>  include/linux/kvm_host.h        |   7 +-
>  virt/kvm/kvm_main.c             |  43 ++-
>  10 files changed, 648 insertions(+), 65 deletions(-)
>
> --
> 2.17.1
>
