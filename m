Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C909E24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d03V+NNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAUPM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:12:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53150 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727508AbgAUPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579619575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu/iMoYfYBgd5jXQviUDjY/CFaD1fKEaBQDIzi7DS7k=;
        b=d03V+NNbwDAzbtz9CSnilOjPjOhh3OLD5C2Hd9nY014CwZUOgl1CR+DuZJinDiMw8o/6Kf
        IqFT4b8zqmg/WqdbEpSpXqqnAWyngWuLBnevXOe33oTNfaemXM6ulRkKtABlXC3RFosHCi
        MLB+n22AES15BjXHpD4ofD9LZ/0CZnw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-aCQTMdZINduxr8ANYKlSyA-1; Tue, 21 Jan 2020 10:12:51 -0500
X-MC-Unique: aCQTMdZINduxr8ANYKlSyA-1
Received: by mail-wr1-f69.google.com with SMTP id z14so1456959wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bu/iMoYfYBgd5jXQviUDjY/CFaD1fKEaBQDIzi7DS7k=;
        b=nzhE6kLy+OzR//A6X1nfXwr6HPzOgIfQCYz306AeGWbmVeHgC4P56jeuMAoHdiwsTZ
         o1iWYI/JDuHQJOVTRJDr1aajNGjIz9FYLzk96upjF9fPC4SZqh6zdfCXdVI2bbfo72Tq
         yiSEf279TuL3bUp5LFaHk+8tNMMIwafgTiZ2gPnrYjHIPJg2SVEoRizmAV4mJrcRRumg
         cMEYDBHxx1hvqAh4Cl+Vc1VvODvzKB6mc0QnqLRAiTmrQMbuMnSiRmk5XD1Ot0nWDIKK
         L7b1CYkPo/6zSAo7sMtewNntoE2cihLz6AXXdJk1Y7oFAcN10L17jGuweo8Y0zdCcAEW
         Isnw==
X-Gm-Message-State: APjAAAX3+dgZGlPieP3MrBxg4U9rIRhQPewVlsVnGtl5NZmUP3v9lshl
        tirJxQifC7BTZ4WOsYi6mW9MDWEgh5zwgmelLdIl0E/hzP4bjPTn1VTGhLonoSBAZBlU+zSpw9z
        lNosl5dKJuq/Dn4qCVuqF1Z/H
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr5000199wmd.5.1579619569960;
        Tue, 21 Jan 2020 07:12:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3W9/IFqNtFmh53Y8FuFyZdMe+4NHjz+xYUeI++YvzTVDVuRT0IkPp6ekS3qHgnEBSwWauFA==
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr5000170wmd.5.1579619569664;
        Tue, 21 Jan 2020 07:12:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id b16sm54711240wrj.23.2020.01.21.07.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 07:12:49 -0800 (PST)
Subject: Re: [PATCH 12/14] KVM: x86/mmu: Fold max_mapping_level() into
 kvm_mmu_hugepage_adjust()
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
 <20200108202448.9669-13-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52cf5d90-5e65-4878-b214-7e1809224688@redhat.com>
Date:   Tue, 21 Jan 2020 16:12:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108202448.9669-13-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 21:24, Sean Christopherson wrote:
> -	level = host_pfn_mapping_level(vcpu, gfn, pfn);
> +	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> +	if (!memslot_valid_for_gpte(slot, true))
> +		return PT_PAGE_TABLE_LEVEL;

Following up on my remark to patch 7, this can also use
gfn_to_memslot_dirty_bitmap.

Paolo

> +
> +	max_level = min(max_level, kvm_x86_ops->get_lpage_level());
> +	for ( ; max_level > PT_PAGE_TABLE_LEVEL; max_level--) {
> +		if (!__mmu_gfn_lpage_is_disallowed(gfn, max_level, slot))
> +			break;
> +	}
> +
> +	if (max_level == PT_PAGE_TABLE_LEVEL)
> +		return PT_PAGE_TABLE_LEVEL;
> +
> +	level = host_pfn_mapping_level(vcpu, gfn, pfn, slot);
>  	if (level == PT_PAGE_TABLE_LEVEL)
>  		return level;
>  
> @@ -4182,8 +4172,6 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>  	if (lpage_disallowed)
>  		max_level = PT_PAGE_TABLE_LEVEL;
>  
> -	max_level = max_mapping_level(vcpu, gfn, max_level);
> -
>  	if (fast_page_fault(vcpu, gpa, error_code))
>  		return RET_PF_RETRY;
>  
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index 0560982eda8b..ea174d85700a 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -817,8 +817,6 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
>  	else
>  		max_level = walker.level;
>  
> -	max_level = max_mapping_level(vcpu, walker.gfn, max_level);
> -
>  	mmu_seq = vcpu->kvm->mmu_notifier_seq;
>  	smp_rmb();
>  
> 

