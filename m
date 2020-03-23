Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60EC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701B62051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlGsI8DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgCWTGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:06:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53005 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbgCWTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584990413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APaNQRxHTARj8BaPbjn67e2tBGbsQUvwirTO/uswCns=;
        b=DlGsI8DK0RWd+i+QA5J9sVfpu5EaDHC/40yxgl/vdATzLGTOuUKlqQle6nN2ZUZwc0BVai
        nZ5Gya9r6zkTxeYPqyO+TIZvasgMtfv5kOdzP3tqhyNnS5jDNy+K8IZgO02fY+KqPNFQmd
        gnXkL2r/xYhghOvgY+8JpMakaGOz2rs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-QL9uyy5zNq2i8hOgCSIhQg-1; Mon, 23 Mar 2020 15:06:42 -0400
X-MC-Unique: QL9uyy5zNq2i8hOgCSIhQg-1
Received: by mail-wr1-f69.google.com with SMTP id d17so7839707wrw.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=APaNQRxHTARj8BaPbjn67e2tBGbsQUvwirTO/uswCns=;
        b=bScMKpC3UY6YFuA6wQroi/9cH0Myr1bBpuOssW745dedyCq7pxVIlAZgil2L7ks+Rf
         oC5sT6fNrlR9RvRaqxEKaA+/mLHYqYQC/ZKUVjU6q63/lhDtDRIJxoX3FEcijgyHw5aL
         CAKYHWVk9NACWi2nhVkM6Av5Pc9H0T81etGH8TffZ5hUNFoMOeAHnhFtroPpWS5jh1OP
         Re+mtyb1oRLL0DFwiw5ZpQ++55x3+8lRuG/lxSUjwjxXa8TCshYG/Uo4o1rVhBK7vIQJ
         VqInHnuJloaciowgdhkAlqCLH0qoDggyXx5x8NuGVHi1TiW372u+I8ogW6JEoev80y8C
         p4VQ==
X-Gm-Message-State: ANhLgQ2wUTLQiGFk/r5c4HHGPebys19D7i0SHz5fKuujLzVcglrmj5Y2
        TxD0yYweYW83IsvL9N9mrIeGvHgb3yvhfiyRrsF0PwTn2sJ834r1Om4r5OxW1NL+ei6vCjxZgAN
        088wgWforHkEBiMmhL3F14UYL
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr31386936wrs.272.1584990400698;
        Mon, 23 Mar 2020 12:06:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsWEwSE2Xr+j5tv0NNOh61W8hlsYhecrXZL3VhQYuKxOQc/p/2kgcq+l7apJoq1CJ9V3DenmA==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr31386901wrs.272.1584990400395;
        Mon, 23 Mar 2020 12:06:40 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id e9sm25072127wrw.30.2020.03.23.12.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:06:39 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:06:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 7/7] KVM: selftests: Add "delete" testcase to
 set_memory_region_test
Message-ID: <20200323190636.GM127076@xz-x1>
References: <20200320205546.2396-1-sean.j.christopherson@intel.com>
 <20200320205546.2396-8-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320205546.2396-8-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 01:55:46PM -0700, Sean Christopherson wrote:
> Add coverate for running a guest with no memslots, and for deleting
> memslots while the guest is running.  Enhance the test to use, and
> expect, a unique value for MMIO reads, e.g. to verify each stage of
> the test.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  .../kvm/x86_64/set_memory_region_test.c       | 122 ++++++++++++++++--
>  1 file changed, 108 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c b/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
> index c6691cff4e19..44aed8ac932b 100644
> --- a/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
> @@ -26,42 +26,109 @@
>  #define MEM_REGION_SIZE		0x200000
>  #define MEM_REGION_SLOT		10
>  
> -static void guest_code(void)
> +static const uint64_t MMIO_VAL = 0xbeefull;
> +
> +extern const uint64_t final_rip_start;
> +extern const uint64_t final_rip_end;
> +
> +static inline uint64_t guest_spin_on_val(uint64_t spin_val)
>  {
>  	uint64_t val;
>  
>  	do {
>  		val = READ_ONCE(*((uint64_t *)MEM_REGION_GPA));
> -	} while (!val);
> +	} while (val == spin_val);
> +	return val;
> +}
>  
> -	if (val != 1)
> -		ucall(UCALL_ABORT, 1, val);
> +static void guest_code(void)
> +{
> +	uint64_t val;
>  
> -	GUEST_DONE();
> +	/*
> +	 * Spin until the memory region is moved to a misaligned address.  This
> +	 * may or may not trigger MMIO, as the window where the memslot is
> +	 * invalid is quite small.
> +	 */
> +	val = guest_spin_on_val(0);
> +	GUEST_ASSERT(val == 1 || val == MMIO_VAL);
> +
> +	/* Spin until the memory region is realigned. */
> +	GUEST_ASSERT(guest_spin_on_val(MMIO_VAL) == 1);

IIUC ideally we should do GUEST_SYNC() after each GUEST_ASSERT() to
make sure the two threads are in sync.  Otherwise e.g. there's no
guarantee that the main thread won't run too fast to quickly remove
the memslot and re-add it back before the guest_spin_on_val() starts
above, then the assert could trigger when it reads the value as zero.

> +
> +	/* Spin until the memory region is deleted. */
> +	GUEST_ASSERT(guest_spin_on_val(1) == MMIO_VAL);
> +
> +	/* Spin until the memory region is recreated. */
> +	GUEST_ASSERT(guest_spin_on_val(MMIO_VAL) == 0);
> +
> +	/* Spin until the memory region is deleted. */
> +	GUEST_ASSERT(guest_spin_on_val(0) == MMIO_VAL);
> +
> +	asm("1:\n\t"
> +	    ".pushsection .rodata\n\t"
> +	    ".global final_rip_start\n\t"
> +	    "final_rip_start: .quad 1b\n\t"
> +	    ".popsection");
> +
> +	/* Spin indefinitely (until the code memslot is deleted). */
> +	guest_spin_on_val(MMIO_VAL);
> +
> +	asm("1:\n\t"
> +	    ".pushsection .rodata\n\t"
> +	    ".global final_rip_end\n\t"
> +	    "final_rip_end: .quad 1b\n\t"
> +	    ".popsection");
> +
> +	GUEST_ASSERT(0);
>  }
>  
>  static void *vcpu_worker(void *data)
>  {
>  	struct kvm_vm *vm = data;
> +	struct kvm_regs regs;
>  	struct kvm_run *run;
>  	struct ucall uc;
> -	uint64_t cmd;
>  
>  	/*
>  	 * Loop until the guest is done.  Re-enter the guest on all MMIO exits,
> -	 * which will occur if the guest attempts to access a memslot while it
> -	 * is being moved.
> +	 * which will occur if the guest attempts to access a memslot after it
> +	 * has been deleted or while it is being moved .
>  	 */
>  	run = vcpu_state(vm, VCPU_ID);
> -	do {
> +
> +	memcpy(run->mmio.data, &MMIO_VAL, 8);
> +	while (1) {
>  		vcpu_run(vm, VCPU_ID);
> -	} while (run->exit_reason == KVM_EXIT_MMIO);
> +		if (run->exit_reason != KVM_EXIT_MMIO)
> +			break;
>  
> -	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> +		TEST_ASSERT(!run->mmio.is_write, "Unexpected exit mmio write");
> +		TEST_ASSERT(run->mmio.len == 8,
> +			    "Unexpected exit mmio size = %u", run->mmio.len);
> +
> +		TEST_ASSERT(run->mmio.phys_addr == MEM_REGION_GPA,
> +			    "Unexpected exit mmio address = 0x%llx",
> +			    run->mmio.phys_addr);
> +	}
> +
> +	if (run->exit_reason == KVM_EXIT_IO) {
> +		(void)get_ucall(vm, VCPU_ID, &uc);
> +		TEST_FAIL("%s at %s:%ld",
> +			  (const char *)uc.args[0], __FILE__, uc.args[1]);
> +	}
> +
> +	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN ||
> +		    run->exit_reason == KVM_INTERNAL_ERROR_EMULATION,
>  		    "Unexpected exit reason = %d", run->exit_reason);
>  
> -	cmd = get_ucall(vm, VCPU_ID, &uc);
> -	TEST_ASSERT(cmd == UCALL_DONE, "Unexpected val in guest = %lu", uc.args[0]);
> +	vcpu_regs_get(vm, VCPU_ID, &regs);
> +
> +	TEST_ASSERT(regs.rip >= final_rip_start &&
> +		    regs.rip < final_rip_end,
> +		    "Bad rip, expected 0x%lx - 0x%lx, got 0x%llx\n",
> +		    final_rip_start, final_rip_end, regs.rip);
> +
>  	return NULL;
>  }
>  
> @@ -72,6 +139,13 @@ static void test_move_memory_region(void)
>  	uint64_t *hva;
>  	uint64_t gpa;
>  
> +	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
> +	vm_vcpu_add(vm, VCPU_ID);
> +	/* Fails with ENOSPC because the MMU can't create pages (no slots). */
> +	TEST_ASSERT(_vcpu_run(vm, VCPU_ID) == -1 && errno == ENOSPC,
> +		    "Unexpected error code = %d", errno);
> +	kvm_vm_free(vm);
> +
>  	vm = vm_create_default(VCPU_ID, 0, guest_code);
>  
>  	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
> @@ -105,7 +179,6 @@ static void test_move_memory_region(void)
>  	 */
>  	vm_mem_region_move(vm, MEM_REGION_SLOT, MEM_REGION_GPA - 4096);
>  	WRITE_ONCE(*hva, 2);
> -
>  	usleep(100000);
>  
>  	/*
> @@ -116,6 +189,27 @@ static void test_move_memory_region(void)
>  
>  	/* Restore the original base, the guest should see "1". */
>  	vm_mem_region_move(vm, MEM_REGION_SLOT, MEM_REGION_GPA);
> +	usleep(100000);
> +
> +	/* Delete the memory region, the guest should not die. */
> +	vm_mem_region_delete(vm, MEM_REGION_SLOT);
> +	usleep(100000);
> +
> +	/* Recreate the memory region.  The guest should see "0". */
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_THP,
> +				    MEM_REGION_GPA, MEM_REGION_SLOT,
> +				    MEM_REGION_SIZE / getpagesize(), 0);
> +	usleep(100000);
> +
> +	/* Delete the region again so that there's only one memslot left. */
> +	vm_mem_region_delete(vm, MEM_REGION_SLOT);
> +	usleep(100000);
> +
> +	/*
> +	 * Delete the primary memslot.  This should cause an emulation error or
> +	 * shutdown due to the page tables getting nuked.
> +	 */
> +	vm_mem_region_delete(vm, VM_PRIMARY_MEM_SLOT);
>  
>  	pthread_join(vcpu_thread, NULL);
>  
> -- 
> 2.24.1
> 

-- 
Peter Xu

