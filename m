Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46C9C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BE42063A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrQXpc17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415393AbgDOQOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:14:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41477 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1415233AbgDOQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586967241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJeTo/zRnrqHhvOgPTgaHSH4vrzTtRuXcGPzKEfUHnY=;
        b=IrQXpc172A/c9nxpXNbRKtBrk+hkcC8cFUwgnwZ34ymZhfUa9PDCBush1BA/fEZ9lg9yRt
        7sXjZBhgpdSj/0zkzIiEhVCwrVsTKSTAcgV0r2xX6QGzqEsRaOwzhpz9Js76Jj0LEq8sN+
        /u55g3Req4bhCfTo59X82c8OiMKL714=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-FeuAhBq8OBeR_yV67TAh2Q-1; Wed, 15 Apr 2020 12:13:59 -0400
X-MC-Unique: FeuAhBq8OBeR_yV67TAh2Q-1
Received: by mail-wr1-f71.google.com with SMTP id t8so137326wrq.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJeTo/zRnrqHhvOgPTgaHSH4vrzTtRuXcGPzKEfUHnY=;
        b=fwi0mw/K8wYxEJpAfewek81M2Yxa7w+JHREFEbNoQiVGbrUrQtOoePmX5wZLcfcYbY
         ykYy3bmu0lwrLLXvxmXwkrSbt1KbnkTtUb2hRootXExI6ubACqj4y3hcVHoh8UbCfx29
         B3dcGuf0B1xBjDa0S2DjMHpNF5Oa5PZhWUKl3E7Eq4WeEvXbOgZfo7nDPuaSnf4Jxflk
         VZj4a9N7dVWKzqjaRBzzC0EkwPqZX/DydfCABaMegYpYTXKgNmfLeC69gQuKv+q/BcTG
         VSvOfrJkjOENiXjSyIvKqI9PDlLbOqEwhV5IVclhX6eHM76Ld8JjnMun2AiLBjza/AQw
         pTjQ==
X-Gm-Message-State: AGi0PuaOz5UKbFX8mLKja6VqZoLRSH3QwYn3jz6rOT4nhH4JpnVRoqdE
        K7D0XQnWHxszKDA+jgJ2wiN6kNfb4lN1s3fnfh1tL7hJo8ntS05uGrDyousda5fFWxdHTL3ont/
        USifbUyl/2o4mxSpco30mhbEt
X-Received: by 2002:adf:ff82:: with SMTP id j2mr18428722wrr.96.1586967238412;
        Wed, 15 Apr 2020 09:13:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypIDz/OV9eeQuwJYvgc7hCdaj4l2fEwtDfmedhtg4jVMeo+Svh1HHKzk8lWg60lun+SjucTPTg==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr18428685wrr.96.1586967238108;
        Wed, 15 Apr 2020 09:13:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id p7sm24315229wrf.31.2020.04.15.09.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 09:13:57 -0700 (PDT)
Subject: Re: [PATCH v2] KVM/arm64: Support enabling dirty log gradually in
 small chunks
To:     Keqian Zhu <zhukeqian1@huawei.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jay Zhou <jianjay.zhou@huawei.com>, wanghaibin.wang@huawei.com
References: <20200413122023.52583-1-zhukeqian1@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be45ec89-2bdb-454b-d20a-c08898e26024@redhat.com>
Date:   Wed, 15 Apr 2020 18:13:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413122023.52583-1-zhukeqian1@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/20 14:20, Keqian Zhu wrote:
> There is already support of enabling dirty log graually in small chunks
> for x86 in commit 3c9bd4006bfc ("KVM: x86: enable dirty log gradually in
> small chunks"). This adds support for arm64.
> 
> x86 still writes protect all huge pages when DIRTY_LOG_INITIALLY_ALL_SET
> is eanbled. However, for arm64, both huge pages and normal pages can be
> write protected gradually by userspace.
> 
> Under the Huawei Kunpeng 920 2.6GHz platform, I did some tests on 128G
> Linux VMs with different page size. The memory pressure is 127G in each
> case. The time taken of memory_global_dirty_log_start in QEMU is listed
> below:
> 
> Page Size      Before    After Optimization
>   4K            650ms         1.8ms
>   2M             4ms          1.8ms
>   1G             2ms          1.8ms
> 
> Besides the time reduction, the biggest income is that we will minimize
> the performance side effect (because of dissloving huge pages and marking
> memslots dirty) on guest after enabling dirty log.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  Documentation/virt/kvm/api.rst    |  2 +-
>  arch/arm64/include/asm/kvm_host.h |  3 +++
>  virt/kvm/arm/mmu.c                | 12 ++++++++++--
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index efbbe570aa9b..0017f63fa44f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5777,7 +5777,7 @@ will be initialized to 1 when created.  This also improves performance because
>  dirty logging can be enabled gradually in small chunks on the first call
>  to KVM_CLEAR_DIRTY_LOG.  KVM_DIRTY_LOG_INITIALLY_SET depends on
>  KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (it is also only available on
> -x86 for now).
> +x86 and arm64 for now).
>  
>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 was previously available under the name
>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT, but the implementation had bugs that make
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 32c8a675e5a4..a723f84fab83 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -46,6 +46,9 @@
>  #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
>  #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>  
> +#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
> +				     KVM_DIRTY_LOG_INITIALLY_SET)
> +
>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>  
>  extern unsigned int kvm_sve_max_vl;
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index e3b9ee268823..1077f653a611 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -2265,8 +2265,16 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	 * allocated dirty_bitmap[], dirty pages will be be tracked while the
>  	 * memory slot is write protected.
>  	 */
> -	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES)
> -		kvm_mmu_wp_memory_region(kvm, mem->slot);
> +	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> +		/*
> +		 * If we're with initial-all-set, we don't need to write
> +		 * protect any pages because they're all reported as dirty.
> +		 * Huge pages and normal pages will be write protect gradually.
> +		 */
> +		if (!kvm_dirty_log_manual_protect_and_init_set(kvm)) {
> +			kvm_mmu_wp_memory_region(kvm, mem->slot);
> +		}
> +	}
>  }
>  
>  int kvm_arch_prepare_memory_region(struct kvm *kvm,
> 

Marc, what is the status of this patch?

Paolo

