Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42569C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1509B20780
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHC/BCDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCWPe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:34:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52101 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbgCWPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584977662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xr99nHdAHx1m/gl45KeTdKghaJy0+26o7n9Cjks2514=;
        b=AHC/BCDcdPgNrUKAC7CK3ZcnWCEAha1LPA3n+eyq+VXPq7+Sf4/yShowJfEUKsfhewxs2E
        lL3jOB58t2MJk89jvduPIZdm91grcBe5MUqbjCVpZlC/eifya2Bl+G74txVv4JzC9R87fj
        MRljG9oL8C0fIqBqM4msisJz8AhlNHo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-ubTvAdNPPlOdlmHbNBB6Ww-1; Mon, 23 Mar 2020 11:34:20 -0400
X-MC-Unique: ubTvAdNPPlOdlmHbNBB6Ww-1
Received: by mail-wm1-f70.google.com with SMTP id n25so4136883wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Xr99nHdAHx1m/gl45KeTdKghaJy0+26o7n9Cjks2514=;
        b=Bg5ojUs1l5VJdnCThRXDizZivtWcB0gAP1wTz7ZynM9ebceGjepQHvCiR3aULPqg7u
         hmwBrsUrn++M2ClBjarDoP/LWfBla54uUKd+K2wTvj2LvNBoT72rOoJuaeFJFAjOlfXu
         fhdRL3ELX6DzUpZmihBSVuvnx+mUWevjRaxmxyCYsMHdQ0OdygL9ngmK51msQvK47Fyp
         MI6UNv3IPYbv2msFzxfkeNxsFFWX3JGM0+NHA21Am2lQ25VY2L1sqZJ0ajkFn8SrWD0k
         As9epx3Z2Mb6X3BL0x1xWDg3QvvsUPVKZdDAAz7X/f69Uumwd0ZMc1hUzvooUE1F4Q6E
         //Zg==
X-Gm-Message-State: ANhLgQ2D3ArH1DPUc2vTIn2NX7Bi043uICnvN+nK4B8YcyYab2Mjw2SG
        YGbYS8yotVLt766caNUqhfdfJruYzO7tD07MbVs8/yZxY/5lG9+2+DBmxDEZAwC+bslowcrTQJD
        jeR6O56XfcetXIhzwZoDFSrsS
X-Received: by 2002:adf:dd10:: with SMTP id a16mr22183248wrm.26.1584977659807;
        Mon, 23 Mar 2020 08:34:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsn0blaF1NsqRTvFWk7zIcpKejElkKMygTmVWdGtZamYIPseay1+YqWuE1p11Vk+CheUdYCPQ==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr22183233wrm.26.1584977659610;
        Mon, 23 Mar 2020 08:34:19 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d16sm1757012wrp.91.2020.03.23.08.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:34:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 04/37] KVM: nVMX: Invalidate all roots when emulating INVVPID without EPT
In-Reply-To: <20200320212833.3507-5-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com> <20200320212833.3507-5-sean.j.christopherson@intel.com>
Date:   Mon, 23 Mar 2020 16:34:17 +0100
Message-ID: <87v9mv84qu.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> From: Junaid Shahid <junaids@google.com>
>
> Free all roots when emulating INVVPID for L1 and EPT is disabled, as
> outstanding changes to the page tables managed by L1 need to be
> recognized.  Because L1 and L2 share an MMU when EPT is disabled, and
> because VPID is not tracked by the MMU role, all roots in the current
> MMU (root_mmu) need to be freed, otherwise a future nested VM-Enter or
> VM-Exit could do a fast CR3 switch (without a flush/sync) and consume
> stale SPTEs.
>
> Fixes: 5c614b3583e7b ("KVM: nVMX: nested VPID emulation")
> Signed-off-by: Junaid Shahid <junaids@google.com>
> [sean: ported to upstream KVM, reworded the comment and changelog]
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 9624cea4ed9f..bc74fbbf33c6 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5250,6 +5250,20 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
>  		return kvm_skip_emulated_instruction(vcpu);
>  	}
>  
> +	/*
> +	 * Sync the shadow page tables if EPT is disabled, L1 is invalidating
> +	 * linear mappings for L2 (tagged with L2's VPID).  Free all roots as
> +	 * VPIDs are not tracked in the MMU role.
> +	 *
> +	 * Note, this operates on root_mmu, not guest_mmu, as L1 and L2 share
> +	 * an MMU when EPT is disabled.
> +	 *
> +	 * TODO: sync only the affected SPTEs for INVDIVIDUAL_ADDR.
> +	 */
> +	if (!enable_ept)
> +		kvm_mmu_free_roots(vcpu, &vcpu->arch.root_mmu,
> +				   KVM_MMU_ROOTS_ALL);
> +

This is related to my remark on the previous patch; the comment above
makes me think I'm missing something obvious, enlighten me please)

My understanding is that L1 and L2 will share arch.root_mmu not only
when EPT is globally disabled, we seem to switch between
root_mmu/guest_mmu only when nested_cpu_has_ept(vmcs12) but different L2
guests may be different on this. Do we need to handle this somehow?

>  	return nested_vmx_succeed(vcpu);
>  }

-- 
Vitaly

