Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D8AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84C520678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hr2aMXSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHaRgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHaRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:36:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8042CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:36:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v16so6018832otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3KvScyvHzVRYf0RMPiy6x1jOQmJWglaF+6I1c23uFY=;
        b=Hr2aMXSVXg1s1+r7dM0EKKRt59ublxHBQ0MrlCeTvrZ1iHjR4G0NlFh6YCU90q61uB
         shwvxPAWNUpPsx9gdwQ/5nP8Yu2FuvY1VBYqt1c9IrLq8MPPM1TIJs1Qrrr06Z/GDGZe
         ALcfp2lIoLLY3UQgYRJ+PQIlw0FRj7cwpLFqx8B6FVvPaDZRQsRO5OZtR4KGxa9hw7vO
         5BMahIj5Nzw7E7HZ4RxdgnHeo3zkLqt+mn6y2Br5U/4RvqmASrcJ1ZC7sinIBIegwsS5
         l8J0ibf4qloHBue5G5U0Iz1mA0tz0hToEAU6cER7ERSA1klITxRU54g2syrZtCnAmtjd
         a/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3KvScyvHzVRYf0RMPiy6x1jOQmJWglaF+6I1c23uFY=;
        b=kfn8EtbaZxBxYrb0XfP0lcMfket83MhMRVYO0Npd2Su1ui/zE2D/qQvKvGIBmHvcd1
         SCOOG85VixMU3hfxcE3fMtlH5XLWovnMmXble0DXz1Lg+WqQkOqPmib84QqwiS3JCM4F
         fDEgD9NOiA6vkBYEcf6vptlHkg4rcVr/CdV2rFXwvHbD70erKucCdmqTAmkkPB6YaFQT
         IoqdRGDvZWIBUj2TUTTKc0ar0Co8MdNTw+ShXEZyZVBKygZODgpMUzm+iNGHeC3dJ9fz
         E0LawtOZ8h72kvzila/P3SZI4DGPIfBeOnE6D/uEdbt7Stw09IMDt8c7osXSeNNdntjj
         aMZQ==
X-Gm-Message-State: AOAM531OkouLLP+7c8k3NivynFdhVEdf/c0T9kWuF0KHrK/MWDa4vmF+
        EJXteEPVPtOv6Owye4+EO43yRnP02YKs3BFR3rIP9Q==
X-Google-Smtp-Source: ABdhPJwuMU4T7Ks3GLhpcZrjLrGzbpc/wn3gKCrvX7lv1zT7v1CT/3febeogy2pLUzx/7CFwmiVu1EGceOT3zLqJHPY=
X-Received: by 2002:a05:6830:18ca:: with SMTP id v10mr1726338ote.295.1598895412501;
 Mon, 31 Aug 2020 10:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200828085622.8365-1-chenyi.qiang@intel.com> <20200828085622.8365-2-chenyi.qiang@intel.com>
 <CALMp9eThyqWuduU=JN+w3M3ANeCYN+7=s-gippzyu_GmvgtVGA@mail.gmail.com>
 <534a4ad5-b083-1278-a6ac-4a7e2b6b1600@intel.com> <1fbfb77d-4f28-bcb6-a95c-f4ac7a313d2d@intel.com>
In-Reply-To: <1fbfb77d-4f28-bcb6-a95c-f4ac7a313d2d@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 31 Aug 2020 10:36:41 -0700
Message-ID: <CALMp9eRPLDgOkOj_chveHjzzx_PXBOb3zKNkrKTXMr=C=dENRw@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: nVMX: Fix VMX controls MSRs setup when nested
 VMX enabled
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 7:51 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> On 8/29/2020 9:49 AM, Chenyi Qiang wrote:
> >
> >
> > On 8/29/2020 1:43 AM, Jim Mattson wrote:
> >> On Fri, Aug 28, 2020 at 1:54 AM Chenyi Qiang <chenyi.qiang@intel.com>
> >> wrote:
> >>>
> >>> KVM supports the nested VM_{EXIT, ENTRY}_LOAD_IA32_PERF_GLOBAL_CTRL and
> >>> VM_{ENTRY_LOAD, EXIT_CLEAR}_BNDCFGS, but they doesn't expose during
> >>> the setup of nested VMX controls MSR.
> >>>
> >>
> >> Aren't these features added conditionally in
> >> nested_vmx_entry_exit_ctls_update() and
> >> nested_vmx_pmu_entry_exit_ctls_update()?
> >>
> >
> > Yes, but I assume vmcs_config.nested should reflect the global
> > capability of VMX MSR. KVM supports these two controls, so should be
> > exposed here.
>
> No. I prefer to say they are removed conditionally in
> nested_vmx_entry_exit_ctls_update() and
> nested_vmx_pmu_entry_exit_ctls_update().
>
> Userspace calls vmx_get_msr_feature() to query what KVM supports for
> these VMX MSR. In vmx_get_msr_feature(), it returns the value of
> vmcs_config.nested. As KVM supports these two bits, we should advertise
> them in vmcs_config.nested and report to userspace.

It would be nice if there was an API to query what MSR values KVM
supports for a specific VCPU configuration, but given that this is a
system ioctl, I agree with you.
