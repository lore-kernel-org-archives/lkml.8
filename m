Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88117C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E332051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzGKmwYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCWTMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:12:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22789 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727179AbgCWTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584990731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fgrAHu1BxFkFO8E2XTbHvJRFF+z4d/8YKZf4AbCghtU=;
        b=BzGKmwYHvORXIg48h0vUhAxwKV18cjs6WMvEJVtY5jSUeedmm+x7RYf0nv0MeXq/EEchzI
        nQvwtE9F8HNzu3dbYN7PulU6BkoqHk1OPTrAn37Ofw59Rebh6STtwxjenlyi6M3ygyKHGd
        Ck9f7D1HCHNbkhjAHfZqmQRKjZqN7l4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-42C_AECpNC6GjuyiQUHdfA-1; Mon, 23 Mar 2020 15:12:09 -0400
X-MC-Unique: 42C_AECpNC6GjuyiQUHdfA-1
Received: by mail-wr1-f71.google.com with SMTP id i18so7807467wrx.17
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fgrAHu1BxFkFO8E2XTbHvJRFF+z4d/8YKZf4AbCghtU=;
        b=g4YV7NitX2ynwpHiSzz9Uk94E89ubwU1hBeSnBarX1nGBRc1E/ap7tKfyn9pbUKppd
         c5GT+/3fuGS7R5SY7VDrqABBE0LgE6IWUWDhLuwPYfBkmXW1QNYC/R1f0SkNEcjVarFi
         MINXCnp4Q5dCTmYp0iJBZ3wWEqyjiskt9e3NmUdauvgWm5QEp14uAaqy7jFRO0vd+qk5
         fjfixXHrY8fStWCmKK9QUSwVvygl/jSA82ZCGkXR004CTobRDPIsq+vPfvseidgUesJu
         Dyb4QK0FP8UEaByBW2OymoVfbEQZ9rZZ4gwIELGM223SkAQCv2iFh6mw2RIXqu4lXQCb
         dI6Q==
X-Gm-Message-State: ANhLgQ1iM9Ag0u3n8BkLPcI/+u4B+JAUQtyWcOMVzYTM35AJ8GnDEn9Y
        7E6JYFdu+4zsWBb8PoZtb9qaldERcHeXo+ON+GGdfN9vKs2uI8hc4T23p7yeMXQHscDEnh2+QU5
        fJoOG3yGLXXSl8pw6Xe7F/kb2
X-Received: by 2002:a05:600c:20c7:: with SMTP id y7mr969796wmm.38.1584990727796;
        Mon, 23 Mar 2020 12:12:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvI6FN87AuoICeOVZww+CrDUVby7jnBBCp+g/rZiiNhh884vbdRbO+WpvR0BsEJUCbSMTPLFA==
X-Received: by 2002:a05:600c:20c7:: with SMTP id y7mr969764wmm.38.1584990727468;
        Mon, 23 Mar 2020 12:12:07 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id s22sm655926wmc.16.2020.03.23.12.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:12:06 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:12:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 6/7] KVM: selftests: Expose the primary memslot number to
 tests
Message-ID: <20200323191202.GN127076@xz-x1>
References: <20200320205546.2396-1-sean.j.christopherson@intel.com>
 <20200320205546.2396-7-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320205546.2396-7-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 01:55:45PM -0700, Sean Christopherson wrote:
> Add a define for the primary memslot number so that tests can manipulate
> the memslot, e.g. to delete it.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 2 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 0f0e86e188c4..43b5feb546c6 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -60,6 +60,8 @@ enum vm_mem_backing_src_type {
>  	VM_MEM_SRC_ANONYMOUS_HUGETLB,
>  };
>  
> +#define VM_PRIMARY_MEM_SLOT	0
> +
>  int kvm_check_cap(long cap);
>  int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
>  
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index f69fa84c9a4c..6a1af0455e44 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -247,8 +247,8 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  	/* Allocate and setup memory for guest. */
>  	vm->vpages_mapped = sparsebit_alloc();
>  	if (phy_pages != 0)
> -		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> -					    0, 0, phy_pages, 0);
> +		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0,
> +					    VM_PRIMARY_MEM_SLOT, phy_pages, 0);

IIUC VM_PRIMARY_MEM_SLOT should be used more than here... E.g., to all
the places that allocate page tables in virt_map() as the last param?
I didn't check other places.

Maybe it's simpler to drop this patch for now and use 0 directly as
before for now, after all in the last patch the comment is good enough
for me to understand slot 0 is the default slot.

Thanks,

>  
>  	return vm;
>  }
> -- 
> 2.24.1
> 

-- 
Peter Xu

