Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1701C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5942075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwljJPYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgDMNXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:23:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28577 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729807AbgDMNXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586784183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBYP0E/9LflU1vJkdddl+wmzzsAGwHYVvotwoO+EIpA=;
        b=OwljJPYRfgw8i6gJEw1T1JfrGcYacNVnwHIE3MlHEx7EisCZWsedYt1y3dK0KHnJKG8TpD
        GcyHxG/NqnXlk/XoUmWXJAgdYF+6HTjyuMilIe0ceM2rIgL0gB6bbdKaDJJweWln7IFpUs
        d/KmatlWi7A3yaFSAW0C0aw/mxTFYIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-n-oKRo39OEKW3SiF2cqIRg-1; Mon, 13 Apr 2020 09:22:59 -0400
X-MC-Unique: n-oKRo39OEKW3SiF2cqIRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92BFC8017F3;
        Mon, 13 Apr 2020 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 361FB60BE1;
        Mon, 13 Apr 2020 13:22:42 +0000 (UTC)
Subject: Re: [PATCH 10/10] selftests: kvm: Add testcase for creating max
 number of memslots
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>
References: <20200410231707.7128-1-sean.j.christopherson@intel.com>
 <20200410231707.7128-11-sean.j.christopherson@intel.com>
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <eef06021-9613-dc1e-419e-2547d8c0ce79@redhat.com>
Date:   Mon, 13 Apr 2020 10:22:40 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200410231707.7128-11-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 8:17 PM, Sean Christopherson wrote:
> From: Wainer dos Santos Moschetta <wainersm@redhat.com>
>
> This patch introduces test_add_max_memory_regions(), which checks
> that a VM can have added memory slots up to the limit defined in
> KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
> verify it fails as expected.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>   .../selftests/kvm/set_memory_region_test.c    | 65 +++++++++++++++++--
>   1 file changed, 60 insertions(+), 5 deletions(-)

Putting the memory region related tests together into a single test file 
makes sense to me.

Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index 0f36941ebb96..cdf5024b2452 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -9,6 +9,7 @@
>   #include <stdlib.h>
>   #include <string.h>
>   #include <sys/ioctl.h>
> +#include <sys/mman.h>
>   
>   #include <linux/compiler.h>
>   
> @@ -18,14 +19,18 @@
>   
>   #define VCPU_ID 0
>   
> -#ifdef __x86_64__
>   /*
> - * Somewhat arbitrary location and slot, intended to not overlap anything.  The
> - * location and size are specifically 2mb sized/aligned so that the initial
> - * region corresponds to exactly one large page.
> + * s390x needs at least 1MB alignment, and the x86_64 MOVE/DELETE tests need a
> + * 2MB sized and aligned region so that the initial region corresponds to
> + * exactly one large page.
>    */
> -#define MEM_REGION_GPA		0xc0000000
>   #define MEM_REGION_SIZE		0x200000
> +
> +#ifdef __x86_64__
> +/*
> + * Somewhat arbitrary location and slot, intended to not overlap anything.
> + */
> +#define MEM_REGION_GPA		0xc0000000
>   #define MEM_REGION_SLOT		10
>   
>   static const uint64_t MMIO_VAL = 0xbeefull;
> @@ -318,6 +323,54 @@ static void test_zero_memory_regions(void)
>   	kvm_vm_free(vm);
>   }
>   
> +/*
> + * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then any
> + * tentative to add further slots should fail.
> + */
> +static void test_add_max_memory_regions(void)
> +{
> +	int ret;
> +	struct kvm_vm *vm;
> +	uint32_t max_mem_slots;
> +	uint32_t slot;
> +	uint64_t guest_addr = 0x0;
> +	uint64_t mem_reg_npages;
> +	void *mem;
> +
> +	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
> +	TEST_ASSERT(max_mem_slots > 0,
> +		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
> +	pr_info("Allowed number of memory slots: %i\n", max_mem_slots);
> +
> +	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
> +
> +	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, MEM_REGION_SIZE);
> +
> +	/* Check it can be added memory slots up to the maximum allowed */
> +	pr_info("Adding slots 0..%i, each memory region with %dK size\n",
> +		(max_mem_slots - 1), MEM_REGION_SIZE >> 10);
> +	for (slot = 0; slot < max_mem_slots; slot++) {
> +		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +					    guest_addr, slot, mem_reg_npages,
> +					    0);
> +		guest_addr += MEM_REGION_SIZE;
> +	}
> +
> +	/* Check it cannot be added memory slots beyond the limit */
> +	mem = mmap(NULL, MEM_REGION_SIZE, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");
> +
> +	ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION,
> +		    &(struct kvm_userspace_memory_region) {slot, 0, guest_addr,
> +		    MEM_REGION_SIZE, (uint64_t) mem});
> +	TEST_ASSERT(ret == -1 && errno == EINVAL,
> +		    "Adding one more memory slot should fail with EINVAL");
> +
> +	munmap(mem, MEM_REGION_SIZE);
> +	kvm_vm_free(vm);
> +}
> +
>   int main(int argc, char *argv[])
>   {
>   #ifdef __x86_64__
> @@ -329,6 +382,8 @@ int main(int argc, char *argv[])
>   
>   	test_zero_memory_regions();
>   
> +	test_add_max_memory_regions();
> +
>   #ifdef __x86_64__
>   	if (argc > 1)
>   		loops = atoi(argv[1]);

