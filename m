Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50373C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2C520776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbgEZKwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:52:01 -0400
Received: from foss.arm.com ([217.140.110.172]:49124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388486AbgEZKwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:52:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B3FC31B;
        Tue, 26 May 2020 03:52:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047543F6C4;
        Tue, 26 May 2020 03:51:56 -0700 (PDT)
Date:   Tue, 26 May 2020 11:51:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv2 4/9] kvm/arm64: Detach ESR operator from vCPU struct
Message-ID: <20200526105154.GD1363@C02TD0UTHF1T.local>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-5-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508032919.52147-5-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:29:14PM +1000, Gavin Shan wrote:
> There are a set of inline functions defined in kvm_emulate.h. Those
> functions reads ESR from vCPU fault information struct and then operate
> on it. So it's tied with vCPU fault information and vCPU struct. It
> limits their usage scope.
> 
> This detaches these functions from the vCPU struct. With this, the
> caller has flexibility on where the ESR is read. It shouldn't cause
> any functional changes.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h     | 83 +++++++++++-------------
>  arch/arm64/kvm/handle_exit.c             | 20 ++++--
>  arch/arm64/kvm/hyp/switch.c              | 24 ++++---
>  arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  7 +-
>  arch/arm64/kvm/inject_fault.c            |  4 +-
>  arch/arm64/kvm/sys_regs.c                | 12 ++--
>  virt/kvm/arm/arm.c                       |  4 +-
>  virt/kvm/arm/hyp/aarch32.c               |  2 +-
>  virt/kvm/arm/hyp/vgic-v3-sr.c            |  5 +-
>  virt/kvm/arm/mmio.c                      | 27 ++++----
>  virt/kvm/arm/mmu.c                       | 22 ++++---
>  11 files changed, 112 insertions(+), 98 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index bd1a69e7c104..2873bf6dc85e 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -270,10 +270,8 @@ static __always_inline u32 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
>  	return vcpu->arch.fault.esr_el2;
>  }
>  
> -static __always_inline int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
> +static __always_inline int kvm_vcpu_get_condition(u32 esr)

Given the `vcpu` argument has been removed, it's odd to keep `vcpu` in the
name, rather than `esr`.

e.g. this would make more sense as something like esr_get_condition().

... and if we did something like that, we could move most of the
extraction functions into <asm/esr.h>, and share them with non-KVM code.

Otherwise, do you need to extract all of these for your use-case, or do
you only need a few of the helpers? If you only need a few, it might be
better to only factor those out for now, and keep the existing API in
place with wrappers, e.g. have:

| esr_get_condition(u32 esr) {
| 	... 
| }
| 
| kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
| {
| 	return esr_get_condition(kvm_vcpu_get_esr(vcpu));
| }

Thanks,
Mark.
