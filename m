Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDF4C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C76206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARorGs0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgD1Xph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbgD1Xph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:45:37 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE48C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:45:36 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id m5so656832ilj.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgsET8VUBtyD/s7lLWUx9sIqs9ALDQ1NZU7iSsS+5z8=;
        b=ARorGs0jnGaWn5EIpZPmClAu62Hy0g8PR3YB73+67ybQ2ieKO9vsk6kh/JQEy8xXCk
         84jvy8YVxjHRERDflDRmS0wNpoz8LfE8tEsGBTNIf2czBsRUgVRoUAUpRKIxpQtd1fqw
         +tEVCLNgDtQyo7ikNGMqWnOyIoCyg+TMmiWVnhnJIpeC2s1EMbruVG4xeIPlBBl2wtMd
         sQgbBr3iZNm+bhF+bM7m5/HP1zCAiOjdkUN/hLXZyxbrf6viHXbd+l2ZQrBi3UbOoPMA
         r38Ny0io12tjiM/0GMG4FF/uLoLAWH4Y+uij54/VTv89fs/22BRmohM0cYqR4XF9tjvY
         l7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgsET8VUBtyD/s7lLWUx9sIqs9ALDQ1NZU7iSsS+5z8=;
        b=sh8dGkfq7o1PZQvu8iVfr61LB36ZhZ/hCCPd4qElpAHe+aHNbltpIvfSiCWHFrWlUH
         kGm6gAQNHkAaarZP8HSoFU2so7tScFY/83pqdEN0i2zNcCF27jbprZfUuuD9kbdbJuZd
         iVegPovuG3e8G7/ZtgSGLZ5mhVNpmjwerlGXYCp3RPOCnwDoi4o2O5apsPj+ol1MV4wZ
         mLE7Aj1F87BZdeb9SIkvQ3Rg5VXGrej65bAAbuBJXr+8aRPTocbgZQvQY5UJhQccytal
         UoFmXay7DjnhpkoqIjdAUB3kWZJcUrZPmf3yhX5KnKlm+8Dh932jbG0h8e7ZxcCv4eP6
         lTlQ==
X-Gm-Message-State: AGi0PubrurPF8wQsVAcyBM5/0oHPONLeWk/XVuhu16Jq76KCr5SauCLF
        3kNfYF15JIbUixqGb2DzFw2gmND6H5JRdjA3Q5RQDA==
X-Google-Smtp-Source: APiQypLTeZ51rx3d7k7oUHJitoZjkQhoSrzY9QFnWEiUl88/rYYbaWgjZtgPOjwTV6yTxYYpqpuwjQLCvCNqo5pwl3Y=
X-Received: by 2002:a92:985d:: with SMTP id l90mr29658275ili.108.1588117535890;
 Tue, 28 Apr 2020 16:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200428231025.12766-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200428231025.12766-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 16:45:25 -0700
Message-ID: <CALMp9eQLPPAzM+vsrSMO6thOnCRpn6ab+VOh-1UKZug8==ME8g@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nVMX: vmcs.SYSENTER optimization and "fix"
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 4:10 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Patch 1 is a "fix" for handling SYSENTER_EIP/ESP in L2 on a 32-bit vCPU.
> The primary motivation is to provide consistent behavior after patch 2.
>
> Patch 2 is essentially a re-submission of a nested VMX optimization to
> avoid redundant VMREADs to the SYSENTER fields in the nested VM-Exit path.
>
> After patch 2 and without patch 1, KVM would end up with weird behavior
> where L1 and L2 would only see 32-bit values for their own SYSENTER_E*P
> MSRs, but L1 could see a 64-bit value for L2's MSRs.
>
> Sean Christopherson (2):
>   KVM: nVMX: Truncate writes to vmcs.SYSENTER_EIP/ESP for 32-bit vCPU
>   KVM: nVMX: Drop superfluous VMREAD of vmcs02.GUEST_SYSENTER_*
>
>  arch/x86/kvm/vmx/nested.c |  4 ----
>  arch/x86/kvm/vmx/vmx.c    | 18 ++++++++++++++++--
>  2 files changed, 16 insertions(+), 6 deletions(-)

It seems like this could be fixed more generally by truncating
natural-width fields on 32-bit vCPUs in handle_vmwrite(). However,
that also would imply that we can't shadow any natural-width fields on
a 32-bit vCPU.
