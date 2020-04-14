Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE5CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6958120678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKfOwVkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391348AbgDNQTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:19:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42067 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390953AbgDNQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586881162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6nA9JsP6NHFHE81BI0WbmxyRDhA75yxUAmygws1QELI=;
        b=VKfOwVkYXLHly6VI3XBHCeaPoOU6TUpIck/5hW12xMPMo5gT9r3l9ejuuvzWR4GpeVyFta
        ylyk2OV1QjCIwt5LbunuOo3Us1MX0FiM5IDwxgfBzL4P4DpFBJGvGOXWWvj18fUDLPRSkM
        z9PRmI61A08xdVgFA5c/Kp1NJpg5rS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-1YqG7yzvPxOwln_cdmgkuA-1; Tue, 14 Apr 2020 12:19:16 -0400
X-MC-Unique: 1YqG7yzvPxOwln_cdmgkuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFBE2107B28C;
        Tue, 14 Apr 2020 16:19:14 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE7D160BE0;
        Tue, 14 Apr 2020 16:19:03 +0000 (UTC)
Date:   Tue, 14 Apr 2020 18:19:00 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 06/10] KVM: selftests: Add "delete" testcase to
 set_memory_region_test
Message-ID: <20200414161900.ovqpaz4q36hdro4n@kamzik.brq.redhat.com>
References: <20200410231707.7128-1-sean.j.christopherson@intel.com>
 <20200410231707.7128-7-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410231707.7128-7-sean.j.christopherson@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 04:17:03PM -0700, Sean Christopherson wrote:
> Add a testcase for deleting memslots while the guest is running.
> Like the "move" testcase, this is x86_64-only as it relies on MMIO
> happening when a non-existent memslot is encountered.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  .../kvm/x86_64/set_memory_region_test.c       | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c b/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
> index 629dd8579b73..b556024af683 100644
> --- a/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
> @@ -29,6 +29,9 @@
>  
>  static const uint64_t MMIO_VAL = 0xbeefull;
>  
> +extern const uint64_t final_rip_start;
> +extern const uint64_t final_rip_end;
> +
>  static sem_t vcpu_ready;
>  
>  static inline uint64_t guest_spin_on_val(uint64_t spin_val)

We don't have guest_spin_on_val(), so it looks like this patch applies
on the older version of this series? But I don't know where
wait_for_vcpu() called below comes from.

Thanks,
drew


> @@ -203,6 +206,89 @@ static void test_move_memory_region(void)
>  	kvm_vm_free(vm);
>  }
>  
> +static void guest_code_delete_memory_region(void)
> +{
> +	uint64_t val;
> +
> +	GUEST_SYNC(0);
> +
> +	/* Spin until the memory region is deleted. */
> +	val = guest_spin_on_val(0);
> +	GUEST_ASSERT_1(val == MMIO_VAL, val);
> +
> +	/* Spin until the memory region is recreated. */
> +	val = guest_spin_on_val(MMIO_VAL);
> +	GUEST_ASSERT_1(val == 0, val);
> +
> +	/* Spin until the memory region is deleted. */
> +	val = guest_spin_on_val(0);
> +	GUEST_ASSERT_1(val == MMIO_VAL, val);
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
> +	GUEST_ASSERT_1(0, 0);
> +}
> +
> +static void test_delete_memory_region(void)
> +{
> +	pthread_t vcpu_thread;
> +	struct kvm_regs regs;
> +	struct kvm_run *run;
> +	struct kvm_vm *vm;
> +
> +	vm = spawn_vm(&vcpu_thread, guest_code_delete_memory_region);
> +
> +	/* Delete the memory region, the guest should not die. */
> +	vm_mem_region_delete(vm, MEM_REGION_SLOT);
> +	wait_for_vcpu();
> +
> +	/* Recreate the memory region.  The guest should see "0". */
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_THP,
> +				    MEM_REGION_GPA, MEM_REGION_SLOT,
> +				    MEM_REGION_SIZE / getpagesize(), 0);
> +	wait_for_vcpu();
> +
> +	/* Delete the region again so that there's only one memslot left. */
> +	vm_mem_region_delete(vm, MEM_REGION_SLOT);
> +	wait_for_vcpu();
> +
> +	/*
> +	 * Delete the primary memslot.  This should cause an emulation error or
> +	 * shutdown due to the page tables getting nuked.
> +	 */
> +	vm_mem_region_delete(vm, 0);
> +
> +	pthread_join(vcpu_thread, NULL);
> +
> +	run = vcpu_state(vm, VCPU_ID);
> +
> +	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN ||
> +		    run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
> +		    "Unexpected exit reason = %d", run->exit_reason);
> +
> +	vcpu_regs_get(vm, VCPU_ID, &regs);
> +
> +	TEST_ASSERT(regs.rip >= final_rip_start &&
> +		    regs.rip < final_rip_end,
> +		    "Bad rip, expected 0x%lx - 0x%lx, got 0x%llx\n",
> +		    final_rip_start, final_rip_end, regs.rip);
> +
> +	kvm_vm_free(vm);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	int i, loops;
> @@ -215,8 +301,13 @@ int main(int argc, char *argv[])
>  	else
>  		loops = 10;
>  
> +	pr_info("Testing MOVE of in-use region, %d loops\n", loops);
>  	for (i = 0; i < loops; i++)
>  		test_move_memory_region();
>  
> +	pr_info("Testing DELETE of in-use region, %d loops\n", loops);
> +	for (i = 0; i < loops; i++)
> +		test_delete_memory_region();
> +
>  	return 0;
>  }
> -- 
> 2.26.0
> 

