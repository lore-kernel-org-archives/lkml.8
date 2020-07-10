Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F3C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1268220720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMGo3Bn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGJQPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:15:14 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB25C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:15:14 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a12so6565741ion.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jy29C0jNBJlzPOntslbWG5zVMkbK/yCb3aOwp+ZNwYQ=;
        b=VMGo3Bn8jtrCU+jVB8BPfXtWepk5wI4UguXdxtGp2vCwmkxmxlCWOLXYgkD4/HeoGp
         hx8nINnh2BamY0kE6CXrytvTzUpOfx4QD4f7FMQDXJKJKhieUAuCghzenALmHYBx7SvV
         zEAY9CIpiNItp9oosFkXO5UGq6T9p0aywHfzHIT2oN+mSij6BlkQ4dPop6stX+sgY5ZQ
         JQxB/9wkf/pes7TBL18mq4uepSSntWvSuS7KcjLSJ7BHGVLkCUYVaPT4Ir0Oe/+AZlYK
         quhIm+JVra13JhtSc5g8MHQDxebmlfi/Ft9rm+PGclPYBbbss7UQoEypVCPhLRqQpFx1
         QoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jy29C0jNBJlzPOntslbWG5zVMkbK/yCb3aOwp+ZNwYQ=;
        b=ktQ3aPIRaC8ohR3L2W4v6wasEqcbIAi+/ey0eMzey1kjTBkHVQ60hpy06n4Ctldlhx
         iICXOanftJCffrv2YL1gAcgM2A9nCKlYx/BpYH81ERcv3ZVwHJY71V5NRnfZmhAcCAzE
         0xR+RHutd2GytvgazBdO8vhgU6yAC7mAQylbzmxR2xmPGgdobZ4kiUqe6n72nHAu8S0i
         fB8jvw2n/YzGt7PLvsNsjefTVvUa0WniSJ8af+2wwCmiAVW+lSLv25qBQRxJJTsh/YGY
         9Q6UAay64L0ryrvGWbT4XPmr7LQ8GlMIS1jNupQklHfazCsargqeD3ikrTQYN+GWwJFZ
         u1Dw==
X-Gm-Message-State: AOAM5309XtDQGgyPp/ViavxfBLcikj1mN2cfboSbC8L17VkRpyr5R+RC
        ynBTQGDNThe9wDMs5sgE+jbvDx1UG+DhF+KKaGErBw==
X-Google-Smtp-Source: ABdhPJxQKn3C8Viy7cFZE/IciSW+3FlyvnpS95Jsc7xj299u1lHgLuAwhOWErmRh70KTECwiY6wtsPiTkjoRQuOMLDA=
X-Received: by 2002:a05:6602:2e0e:: with SMTP id o14mr47771057iow.164.1594397713805;
 Fri, 10 Jul 2020 09:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com> <20200710154811.418214-5-mgamal@redhat.com>
In-Reply-To: <20200710154811.418214-5-mgamal@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 10 Jul 2020 09:15:02 -0700
Message-ID: <CALMp9eS7MmS7G0YfXA7Wxwwxbx67LVWZ57z_ZCbpJv4euiNnAw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] KVM: x86: rename update_bp_intercept to update_exception_bitmap
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 8:48 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> We would like to introduce a callback to update the #PF intercept
> when CPUID changes.  Just reuse update_bp_intercept since VMX is
> already using update_exception_bitmap instead of a bespoke function.
>
> While at it, remove an unnecessary assignment in the SVM version,
> which is already done in the caller (kvm_arch_vcpu_ioctl_set_guest_debug)
> and has nothing to do with the exception bitmap.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
