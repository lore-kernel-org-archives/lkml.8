Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A74C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917A6217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEcewj+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAUOYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:24:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728896AbgAUOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579616676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iietA04mTbBj3y8KEP1nE87RzCPxCIolbi4wDz4ohvY=;
        b=gEcewj+6vNDNPjxB+44kCmZ+rItN4DxLbT80VCVg8+N8fu2PTt+twUsu1wDr/D0rhQ+htq
        pjrJwChUdeFVogbZrrFU7UQuydVQ40ZrMocDW15OSzZa/GxCcaxL9c20F/SiGJtea9qG74
        GschU2NtrPgdD7YCRnE/Wc71nDtcVvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-izcR9TjvOzeZ_SAvqUrKhA-1; Tue, 21 Jan 2020 09:24:35 -0500
X-MC-Unique: izcR9TjvOzeZ_SAvqUrKhA-1
Received: by mail-wm1-f70.google.com with SMTP id s25so428279wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iietA04mTbBj3y8KEP1nE87RzCPxCIolbi4wDz4ohvY=;
        b=ktxWWfeyqImwhM7cbRrDFZbvh4m8VVkrFGEmcOY5TdZ5nVG9DKbGpG4yzrv10Dcmk8
         yU9H02PjQ4U/8zb7cy8Yr8oCG+JV2EpjRaITnD7ZG3zNb+ObI355oC7rR33C6dwVnugM
         SCStv4NQZdv841J42iDuOmRah/Lkpo4IGPZ+eH+4574E3ag2esyym4Nk/21i4/gC+z4O
         KjRdHPX+NG6wEI0pRx+pRBF1oaYCX0x8aRd6cryxsD4MvazP/Zn5nqgpGq6uo8FnYbmk
         hwvMkT94fHmmZSwFCYqvCmTcoXHkla4bruxou2jUwC0mlonrBjjlxge1+Pa15lvkEBnp
         6J7A==
X-Gm-Message-State: APjAAAUJfTi43bzYyry8t2gj9xz3sZEKOmYI/jvqa6mJDhkc6Se5Ow5k
        s1LS40xRP0KYzyubojrU+FeHsf0aD3ugM3SCeEfFHFBXnAC8mR4dYQj1cjmMIjlqqGsy/rhY6At
        QOixVCmqIXMubTFY43RyNMMwA
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr5440094wrt.339.1579616673969;
        Tue, 21 Jan 2020 06:24:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTZsEeiVXo1aYXs9MoGNtX19umLmm3R/ZbsXqxiGO2rVQCtL37lQcA37U+6PdsUBw/nSKlMg==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr5440056wrt.339.1579616673641;
        Tue, 21 Jan 2020 06:24:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id m3sm51279088wrs.53.2020.01.21.06.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:24:33 -0800 (PST)
Subject: Re: [PATCH 04/14] KVM: Play nice with read-only memslots when
 querying host page size
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Barret Rhoden <brho@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Zeng <jason.zeng@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <20200108202448.9669-5-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c091d40-8e32-1e55-2eff-27a4b43e0674@redhat.com>
Date:   Tue, 21 Jan 2020 15:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108202448.9669-5-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 21:24, Sean Christopherson wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5f7f06824c2b..d9aced677ddd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1418,15 +1418,23 @@ EXPORT_SYMBOL_GPL(kvm_is_visible_gfn);
>  
>  unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn)
>  {
> +	struct kvm_memory_slot *slot;
>  	struct vm_area_struct *vma;
>  	unsigned long addr, size;
>  
>  	size = PAGE_SIZE;
>  
> -	addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
> -	if (kvm_is_error_hva(addr))
> +	/*
> +	 * Manually do the equivalent of kvm_vcpu_gfn_to_hva() to avoid the
> +	 * "writable" check in __gfn_to_hva_many(), which will always fail on
> +	 * read-only memslots due to gfn_to_hva() assuming writes.
> +	 */
> +	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> +	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
>  		return PAGE_SIZE;
>  
> +	addr = __gfn_to_hva_memslot(slot, gfn);
> +
>  	down_read(&current->mm->mmap_sem);
>  	vma = find_vma(current->mm, addr);
>  	if (!vma)
> 

Even simpler: use kvm_vcpu_gfn_to_hva_prot

-	addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
+	addr = kvm_vcpu_gfn_to_hva_prot(vcpu, gfn, NULL);

"You are in a maze of twisty little functions, all alike".

Paolo

