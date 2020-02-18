Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3085CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092682176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICvTlLVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgBROyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:54:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgBROyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582037662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAYE5zIUMBfPxzBexfTcLOpuwobiWBtk76M7O7fy2cY=;
        b=ICvTlLVaZz1DWEuQeP2kLUID6fxg01LHT9O2Gf0yokpCRNv3KPvkqKV5xNbdrbMZ7Ued8q
        8Cnpfe34T7SnYUQ+O/3whHrSBJ2UUHjcvY7c5v8XNM74ehqFFvp8JIpRLSn4nO8vfvy2LP
        ao1Yv9mY3XH0IyC9lOH+VThomET7sXU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-mXt8Z40zP0Wtyk7yOAfKHQ-1; Tue, 18 Feb 2020 09:54:18 -0500
X-MC-Unique: mXt8Z40zP0Wtyk7yOAfKHQ-1
Received: by mail-wr1-f71.google.com with SMTP id v17so10864242wrm.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oAYE5zIUMBfPxzBexfTcLOpuwobiWBtk76M7O7fy2cY=;
        b=kC3N02bm4ybFpIkhibCUo9Ryeia8kktpUmQePEm72yH76KrXB5Ie1pIsKMRygcnXLr
         DLyd5BtIR2w+/XZO01c465JHuxuCOWUPYqrZO4kheJwe1Rx5nFWEWXIlihnWoVNQctd5
         tZD0TjrSkAS1l1kmzPcuuvR8qo334BXwK2C1caLGPGiBSEUvr8V0LUx6/t7mRseSLOHk
         iWn2Ve+S0AT9necx2jMPxpwvesQLR/fqqLgeo+wHep9ROgO44dRxz20mcQ9YzPmpoepg
         c6bzgoBBtvwQMi/Hg2VB4c54RmyuNJhQTdSHJ1Uwqq/oQ0xSV5kbf9Wpze1u7LRsIN8I
         B6qA==
X-Gm-Message-State: APjAAAUKcxMTPGd7fszVke7s+MxgZOQJI9Dq6wtZF7nGxH5qh2c92B+8
        N83mZYNPf0vl0PMoCSRz/SxxWpR4L6pUnICL1v1tr4FW5pU9ezwbKkuDSDYelsl+XLGFHRCZQ5S
        K/xSiIngYzJNFxCmAvTtKdtdX
X-Received: by 2002:adf:f606:: with SMTP id t6mr29394031wrp.304.1582037657393;
        Tue, 18 Feb 2020 06:54:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3KNJMO5F3fa7ubC1BaO9mmpNeE7KVzCllzDAfvWz7/f13qvu0EW0swAoA822SBicvqKuTfQ==
X-Received: by 2002:adf:f606:: with SMTP id t6mr29394011wrp.304.1582037657204;
        Tue, 18 Feb 2020 06:54:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a13sm6288184wrp.93.2020.02.18.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 06:54:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] KVM: X86: Less kvmclock sync induced vmexits after VM boots
In-Reply-To: <1581988630-19182-1-git-send-email-wanpengli@tencent.com>
References: <1581988630-19182-1-git-send-email-wanpengli@tencent.com>
Date:   Tue, 18 Feb 2020 15:54:15 +0100
Message-ID: <87r1ys7xpk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> In the progress of vCPUs creation, it queues a kvmclock sync worker to the global 
> workqueue before each vCPU creation completes. Each worker will be scheduled 
> after 300 * HZ delay and request a kvmclock update for all vCPUs and kick them 
> out. This is especially worse when scaling to large VMs due to a lot of vmexits. 
> Just one worker as a leader to trigger the kvmclock sync request for all vCPUs is 
> enough.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v3 -> v4:
>  * check vcpu->vcpu_idx
>
>  arch/x86/kvm/x86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fb5d64e..d0ba2d4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9390,8 +9390,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  	if (!kvmclock_periodic_sync)
>  		return;
>  
> -	schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> -					KVMCLOCK_SYNC_PERIOD);
> +	if (vcpu->vcpu_idx == 0)
> +		schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> +						KVMCLOCK_SYNC_PERIOD);
>  }
>  
>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)

Forgive me my ignorance, I was under the impression
schedule_delayed_work() doesn't do anything if the work is already
queued (see queue_delayed_work_on()) and we seem to be scheduling the
same work (&kvm->arch.kvmclock_sync_work) which is per-kvm (not
per-vcpu). Do we actually happen to finish executing it before next vCPU
is created or why does the storm you describe happens?

-- 
Vitaly

