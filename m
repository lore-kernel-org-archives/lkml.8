Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27351C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036D120771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwGiLkce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414813AbgDOPk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:40:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47729 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404421AbgDOPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586965240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Js7wQzdOKkPlgCjhnOEg3WvsuBEMgF2C/E1tFezZmA=;
        b=bwGiLkceqiU2qA8Z07RdEkXwR0wBwurooExB8SvrAOeipccUK04yAOONtxiWk5WFYjSu/6
        cNMWZsvctMkjiC0iUq0xBOIiPl5O+ipOQgPRS88TsISPgtlogDafQ8BMoEmFtD5LoFsGCU
        XAaGKi1os13lv1qFyAHjXaLN5hhptU4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-IO6mE9HzO8mv73bGi2lO4w-1; Wed, 15 Apr 2020 11:40:34 -0400
X-MC-Unique: IO6mE9HzO8mv73bGi2lO4w-1
Received: by mail-wr1-f70.google.com with SMTP id y1so113117wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Js7wQzdOKkPlgCjhnOEg3WvsuBEMgF2C/E1tFezZmA=;
        b=rRE7p+UwmPWvmxRZSpG/I7Og6HBTKlamOSLyaTb3/UZMj5UqBQlS5kU1HdCTrBn9qA
         +2kDTpLn24m5UbodsfeoeI8ju8BK7xR5PnBta3hTHaJN5V7wqJZvcydY3ix4VpSNfALH
         H0NP6R35MszGK/mGdwaxbtlLUGYQcZwCQ2rpSW1Vn1M58CVc72dYYyRQJRxZFrq/S/zF
         UH1hg6p8ptzni3fT9l2uN623Zh8PvKd2IR8rh0aR+8qklOWfKnp5oGITu5EHoFRFHsVO
         w3I5PkmY7aj/VDkvid6rpmrRQFemkGr6kXcJ/X//O3g0LrX6dlNf6gBZXEF5IaYUcdhT
         NUaQ==
X-Gm-Message-State: AGi0PuZl/OMgtAxEjArcxqwd4HJoarEaMi2XIimRd2CVZZv5olwav4gE
        OzVFwXgr7Uchtva3+J2y0STfhvWKEIW39fVtfgPi+lbt0LVTlGH4dh1DUV8QIvRq1WnyN1Hw1+d
        PvtYeBZsdJ191lhG8HFAOd+hl
X-Received: by 2002:a1c:770e:: with SMTP id t14mr5605324wmi.187.1586965233492;
        Wed, 15 Apr 2020 08:40:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypK+AV2U2fE1j6CX0FhuIqEHhjGsXeckD+Y/3wkDcnfm/n4CR9DC7ChnPzHlPkClT4ZgVUnhQg==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr5605287wmi.187.1586965233184;
        Wed, 15 Apr 2020 08:40:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id k3sm23153779wmf.16.2020.04.15.08.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 08:40:32 -0700 (PDT)
Subject: Re: [PATCH 00/10] KVM: selftests: Add KVM_SET_MEMORY_REGION tests
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20200410231707.7128-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c03fdbd5-2e52-4c58-ae00-2d3309cf7133@redhat.com>
Date:   Wed, 15 Apr 2020 17:40:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410231707.7128-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/20 01:16, Sean Christopherson wrote:
> This is v2-ish of my series to add a "delete" testcase[1], and v5.1 of
> Wainer's series to add a "max" testcase[2].
> 
> I've only tested on x86_64.  I fudged compile testing on !x86_64 by
> inverting the ifdefs, e.g. to squish unused var warnings, but by no means
> is the code actually tested on other architectures.
> 
> I kept Andrew's review for the "max" test.  Other than the 1MB->2MB
> change (see below), it was basically a straight copy-paste of code.
> 
> v1->v2 of delete:
>   - Drop patch to expose primary memslot. [Peter]
>   - Add explicit synchronization to MOVE and DELETE tests. [Peter]
>   - Use list.h instead of open coding linked lists. [Peter]
>   - Clean up the code and separate the testcases into separate functions.
>   - Expand GUEST_ASSERT() to allow passing a value back to the host for
>     printing.
>   - Move to common KVM, with ifdefs to hide the x86_64-only stuff (which
>     is a lot at this point).
>   - Do KVM_SET_NR_MMU_PAGES in the "zero" testcase to get less obscure
>     behavior for KVM_RUN. [Christian]
> 
> v5.1 of max:
>   - Fix a whitespace issue in vm_get_fd(). [checkpatch]
>   - Move the code to set_memory_region_test.  The only _intended_
>     functional change is to create 2MB regions instead of 1MB regions.
>     The only motivation for doing so was to reuse an existing define in
>     set_memory_region_test.
> 
> [1] https://lkml.kernel.org/r/20200320205546.2396-1-sean.j.christopherson@intel.com
> [2] https://lkml.kernel.org/r/20200409220905.26573-1-wainersm@redhat.com
> 
> Sean Christopherson (8):
>   KVM: selftests: Take vcpu pointer instead of id in vm_vcpu_rm()
>   KVM: selftests: Use kernel's list instead of homebrewed replacement
>   KVM: selftests: Add util to delete memory region
>   KVM: selftests: Add GUEST_ASSERT variants to pass values to host
>   KVM: sefltests: Add explicit synchronization to move mem region test
>   KVM: selftests: Add "delete" testcase to set_memory_region_test
>   KVM: selftests: Add "zero" testcase to set_memory_region_test
>   KVM: selftests: Make set_memory_region_test common to all
>     architectures
> 
> Wainer dos Santos Moschetta (2):
>   selftests: kvm: Add vm_get_fd() in kvm_util
>   selftests: kvm: Add testcase for creating max number of memslots
> 
>  tools/testing/selftests/kvm/.gitignore        |   2 +-
>  tools/testing/selftests/kvm/Makefile          |   4 +-
>  .../testing/selftests/kvm/include/kvm_util.h  |  28 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 154 +++----
>  .../selftests/kvm/lib/kvm_util_internal.h     |   8 +-
>  .../selftests/kvm/lib/s390x/processor.c       |   5 +-
>  .../selftests/kvm/set_memory_region_test.c    | 403 ++++++++++++++++++
>  .../kvm/x86_64/set_memory_region_test.c       | 141 ------
>  8 files changed, 520 insertions(+), 225 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/set_memory_region_test.c
>  delete mode 100644 tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
> 

Queued, thanks -- while keeping the zero region test x86-only.

Paolo

