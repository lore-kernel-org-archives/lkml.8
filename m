Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58943C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFC24684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXpnxT7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAWMPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:15:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31632 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgAWMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579781738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uxZUkgrNTOroZtqnJ9cYlspecUEZ/taij7sWcFNnzk=;
        b=eXpnxT7ZyJopME58AS3PFilC8iirSBbhs7DAbau3A8sqUMYKcZ8r75otYwTxADmFdnMFiz
        FYqV5HNx2maizVRniLeh1hLRTGEYWNsMDD1y6CsI2F0I11tPr73uthH0GvqtErBRUQxqaa
        OoRO3kZWCAsCqpYYa8Wq0vtKcy8en5k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-BVHWEsAsOT-DK-kiDG6NAA-1; Thu, 23 Jan 2020 07:15:37 -0500
X-MC-Unique: BVHWEsAsOT-DK-kiDG6NAA-1
Received: by mail-wr1-f69.google.com with SMTP id w6so1604824wrm.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 04:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3uxZUkgrNTOroZtqnJ9cYlspecUEZ/taij7sWcFNnzk=;
        b=nbHcump2SxSZxHs9WibYdOE67HIsiiP22o2Uku0ewsdMR4EIDOLXsinffeLCO4ZCaa
         YKoCTLwbeC7wXr1oq9qb1VSaeUuc1Soz1iKzC1InHp5QwCcBuzeYm16QeaS1uvX1e4YV
         q9yJV+H27/cIxFckNPp1Rn6e6tXcDXnNNg91DUjZY2F7yT6R7m61xWV65V+cXCAj8dmE
         whJCa2V+Jex4LbGfbe4PvDCsZVSwvRzz01FQufzN8NVCtn+v0XEwLnptxVbeTPScGZ1K
         0t7PlaqtgwhbbRJkj+317LWgGLkQhhTHB1Y7435a8cyzaUj5ofl2/rhiHfLIYyP7Wkf+
         cZCg==
X-Gm-Message-State: APjAAAVEEHgqJCgjbHNCWsXJYg9zfbxy8WjuFHTaJrRhPFzou2F69njt
        +ts2Gp+TAQVz7nRhYidC52BCLA8h3/wObaXTUZBhvHtx40QKHeut2yQ75Q6jCY8lVPG/wzX/gXk
        SkgVZ+EeB4YV7VG+/McfcbKig
X-Received: by 2002:a05:600c:507:: with SMTP id i7mr4035595wmc.135.1579781736163;
        Thu, 23 Jan 2020 04:15:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLchET5m6nxiyyIfett/X6yiyHn4kRf+kYA+WL90j1+aDsgYfZz8k+HM7m7PIs/HImA0dVuA==
X-Received: by 2002:a05:600c:507:: with SMTP id i7mr4035565wmc.135.1579781735923;
        Thu, 23 Jan 2020 04:15:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id n16sm2747662wro.88.2020.01.23.04.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 04:15:35 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: avoid some unnecessary copy in
 __x86_set_memory_region()
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1579748413-432-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cb1c43c-932e-d587-bc0d-5d433649abb1@redhat.com>
Date:   Thu, 23 Jan 2020 13:15:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1579748413-432-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/20 04:00, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Only userspace_addr and npages are passed to vm_munmap() when remove a
> memory region. So we shouldn't copy the integral kvm_memory_slot struct.

The compiler should be able to do this change, so I prefer to keep the
old code.  Also, moving the assignments inside the "if" risks causing
uninitialized variable warnings, even though indeed they are only used
if size == 0.

Thanks,

Paolo

> No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d1faa74981d9..767f29877938 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9735,9 +9735,9 @@ void kvm_arch_sync_events(struct kvm *kvm)
>  int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
>  {
>  	int i, r;
> -	unsigned long hva;
> +	unsigned long hva, uaddr, npages;
>  	struct kvm_memslots *slots = kvm_memslots(kvm);
> -	struct kvm_memory_slot *slot, old;
> +	struct kvm_memory_slot *slot;
>  
>  	/* Called with kvm->slots_lock held.  */
>  	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
> @@ -9761,9 +9761,10 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
>  			return 0;
>  
>  		hva = 0;
> +		uaddr = slot->userspace_addr;
> +		npages = slot->npages;
>  	}
>  
> -	old = *slot;
>  	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
>  		struct kvm_userspace_memory_region m;
>  
> @@ -9778,7 +9779,7 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
>  	}
>  
>  	if (!size)
> -		vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
> +		vm_munmap(uaddr, npages * PAGE_SIZE);
>  
>  	return 0;
>  }
> 

