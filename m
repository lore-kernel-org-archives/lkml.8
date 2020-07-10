Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F480C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A09F206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyWWqASY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgGJRDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:03:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35693 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727863AbgGJRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594400622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJSG5Xu9Pbt04zlwluiGAtbXS/uva9oKZizpa8qTv/A=;
        b=DyWWqASYO8cSoUtUyx+XanwtsEleNdWIOyan9UP0mGPclfW25rCPd4PDye64SmAYpxhDLw
        wZM+YeLtt7XzMUtMGllZqWdI6c4ofxzMgNCiJX52GJxA3rByEAvaG8MhjmrPY/ruVp/8Xz
        BrvP/3pgMKHCPTGtsTm+h6Km9GSoLeU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-nAI-aUh8N_qnTEFcSU2ZSw-1; Fri, 10 Jul 2020 13:03:40 -0400
X-MC-Unique: nAI-aUh8N_qnTEFcSU2ZSw-1
Received: by mail-wm1-f72.google.com with SMTP id z74so1979589wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJSG5Xu9Pbt04zlwluiGAtbXS/uva9oKZizpa8qTv/A=;
        b=I2w3sHTVKRdIGY394a+pywesIidZwd7JxOjyzkaUAWdB8XEyYSTN/48fP+Eu5QJmbo
         Aq1c4DEZNlXgu0CT5gqHo9lrleIz8PDtDLwhN3VmpbA1XOpDZYNFiasUwHgJGc4ONn10
         vshFrcxTuXde5refDPUChHeJDI8fYNjjx7rYNgiyHSQIwJG02xCUfu1Q0V8VZvYP+X/S
         ogkXyAI5PZw+H4Tjca4escBC8UtCzi63iL1R9y+MGZWaveT1g8/2gudCOZ8G8FUoyKUJ
         Rp2rFhYsTff4KHyMzx2MWsd64aRZFIw40nkr38RjOB/lTznwHq7fRz1OG4k3VHz/tFc1
         ALag==
X-Gm-Message-State: AOAM531UKZuEMCjoVDup+gqIhJlRRMFV0TvJW6J+3VJLCVM3BJ4byBXW
        8skKs30cw4B/matKPkshKf6dq7ICVKqb7s5pPwpu2ENVc2DKSJ9HkifuVuLtQCOJwXvhgtaXXgn
        NQn7i72G/FbvFI0nUP1B/Vuxt
X-Received: by 2002:a5d:5084:: with SMTP id a4mr71035621wrt.191.1594400619578;
        Fri, 10 Jul 2020 10:03:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3h0nVEw+2+GgsORJ2/Fsvu67DVFBqUZoc6rQmebj8pKOAagZin2+JOgn05/ohtFk1iIRbBA==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr71035602wrt.191.1594400619293;
        Fri, 10 Jul 2020 10:03:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id b10sm9459481wmj.30.2020.07.10.10.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:03:38 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] KVM: nSVM: fixes for CR3/MMU switch upon nested
 guest entry/exit
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
References: <20200710141157.1640173-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6dba1900-5149-f8dd-2da3-42803ee9f96b@redhat.com>
Date:   Fri, 10 Jul 2020 19:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710141157.1640173-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 16:11, Vitaly Kuznetsov wrote:
> Changes since v3:
> - Swapped my "KVM: nSVM: stop dereferencing vcpu->arch.mmu to get the
>  context in kvm_init_shadow{,_npt}_mmu()" with Paolo's "KVM: MMU: stop
>  dereferencing vcpu->arch.mmu to get the context for MMU init".
> - keeping nested_svm_init_mmu_context() in nested_prepare_vmcb_control()
>  as this is also used from svm_set_nested_state() [Paolo],
>  nested_svm_load_cr3() becomes a separate step in enter_svm_guest_mode().
> - nested_prepare_vmcb_save() remains 'void' [Paolo]
> 
> Original description:
> 
> This is a successor of "[PATCH v2 0/3] KVM: nSVM: fix #TF from CR3 switch
> when entering guest" and "[PATCH] KVM: x86: drop erroneous mmu_check_root()
> from fast_pgd_switch()".
> 
> The snowball is growing fast! It all started with an intention to fix
> the particular 'tripple fault' issue (now fixed by PATCH7) but now we
> also get rid of unconditional kvm_mmu_reset_context() upon nested guest
> entry/exit and make the code resemble nVMX. There is still a huge room
> for further improvement (proper error propagation, removing unconditional
> MMU sync/TLB flush,...) but at least we're making some progress.
> 
> Tested with kvm selftests/kvm-unit-tests and by running nested Hyper-V
> on KVM. The series doesn't seem to introduce any new issues.
> 
> Paolo Bonzini (1):
>   KVM: MMU: stop dereferencing vcpu->arch.mmu to get the context for MMU
>     init
> 
> Vitaly Kuznetsov (8):
>   KVM: nSVM: split kvm_init_shadow_npt_mmu() from kvm_init_shadow_mmu()
>   KVM: nSVM: reset nested_run_pending upon nested_svm_vmrun_msrpm()
>     failure
>   KVM: nSVM: prepare to handle errors from enter_svm_guest_mode()
>   KVM: nSVM: introduce nested_svm_load_cr3()/nested_npt_enabled()
>   KVM: nSVM: move kvm_set_cr3() after nested_svm_uninit_mmu_context()
>   KVM: nSVM: implement nested_svm_load_cr3() and use it for host->guest
>     switch
>   KVM: nSVM: use nested_svm_load_cr3() on guest->host switch
>   KVM: x86: drop superfluous mmu_check_root() from fast_pgd_switch()
> 
>  arch/x86/kvm/mmu.h        |  3 +-
>  arch/x86/kvm/mmu/mmu.c    | 45 ++++++++++++------
>  arch/x86/kvm/svm/nested.c | 97 ++++++++++++++++++++++++++++-----------
>  arch/x86/kvm/svm/svm.c    |  6 ++-
>  arch/x86/kvm/svm/svm.h    |  4 +-
>  5 files changed, 110 insertions(+), 45 deletions(-)
> 

Queued, thanks.

Paolo

