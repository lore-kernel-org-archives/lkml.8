Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3FA20739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/PQXIcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgDMSww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:52:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23666 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733123AbgDMSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586803965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEsVmmOO6axAzAyQkoOiM6SYAejl43B4iZY1NJSfZ0s=;
        b=X/PQXIcOfIYPUtd4oNDcqWHc7d061cJM8MgabI4OD6ZI0VA5X1svV1Kz7i9ZE4xmdZDHed
        Lqckcj7sm5eGgEvkSLHX1mXS/DztJFA6F28SZriblvmhaajrrogAdKlLLGWJd+1snpvbxp
        DIjPxwbuPVor8ejf4BqkEXlxFeysxZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-oP2NfmJ9OTKgGCR2_NkE1A-1; Mon, 13 Apr 2020 14:52:41 -0400
X-MC-Unique: oP2NfmJ9OTKgGCR2_NkE1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D7A5107ACCA;
        Mon, 13 Apr 2020 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B36129F99A;
        Mon, 13 Apr 2020 18:52:29 +0000 (UTC)
Subject: Re: [PATCH 03/10] KVM: selftests: Add util to delete memory region
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>
References: <20200410231707.7128-1-sean.j.christopherson@intel.com>
 <20200410231707.7128-4-sean.j.christopherson@intel.com>
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <cf3c04ac-f4f2-e1f0-4fd7-c30c28dd3563@redhat.com>
Date:   Mon, 13 Apr 2020 15:52:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200410231707.7128-4-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 8:17 PM, Sean Christopherson wrote:
> Add a utility to delete a memory region, it will be used by x86's
> set_memory_region_test.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>   .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 56 +++++++++++++------
>   2 files changed, 40 insertions(+), 17 deletions(-)

LGTM.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 2f329e785c58..d4c3e4d9cd92 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -114,6 +114,7 @@ int _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
>   void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
>   void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
>   void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
> +void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
>   void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
>   vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
>   			  uint32_t data_memslot, uint32_t pgd_memslot);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 105ee9bc09f0..ab5b7ea60f4b 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -433,34 +433,38 @@ void kvm_vm_release(struct kvm_vm *vmp)
>   		"  vmp->kvm_fd: %i rc: %i errno: %i", vmp->kvm_fd, ret, errno);
>   }
>   
> +static void __vm_mem_region_delete(struct kvm_vm *vm,
> +				   struct userspace_mem_region *region)
> +{
> +	int ret;
> +
> +	list_del(&region->list);
> +
> +	region->region.memory_size = 0;
> +	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
> +	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed, "
> +		    "rc: %i errno: %i", ret, errno);
> +
> +	sparsebit_free(&region->unused_phy_pages);
> +	ret = munmap(region->mmap_start, region->mmap_size);
> +	TEST_ASSERT(ret == 0, "munmap failed, rc: %i errno: %i", ret, errno);
> +
> +	free(region);
> +}
> +
>   /*
>    * Destroys and frees the VM pointed to by vmp.
>    */
>   void kvm_vm_free(struct kvm_vm *vmp)
>   {
>   	struct userspace_mem_region *region, *tmp;
> -	int ret;
>   
>   	if (vmp == NULL)
>   		return;
>   
>   	/* Free userspace_mem_regions. */
> -	list_for_each_entry_safe(region, tmp, &vmp->userspace_mem_regions, list) {
> -		list_del(&region->list);
> -
> -		region->region.memory_size = 0;
> -		ret = ioctl(vmp->fd, KVM_SET_USER_MEMORY_REGION,
> -			&region->region);
> -		TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed, "
> -			"rc: %i errno: %i", ret, errno);
> -
> -		sparsebit_free(&region->unused_phy_pages);
> -		ret = munmap(region->mmap_start, region->mmap_size);
> -		TEST_ASSERT(ret == 0, "munmap failed, rc: %i errno: %i",
> -			    ret, errno);
> -
> -		free(region);
> -	}
> +	list_for_each_entry_safe(region, tmp, &vmp->userspace_mem_regions, list)
> +		__vm_mem_region_delete(vmp, region);
>   
>   	/* Free sparsebit arrays. */
>   	sparsebit_free(&vmp->vpages_valid);
> @@ -775,6 +779,24 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa)
>   		    ret, errno, slot, new_gpa);
>   }
>   
> +/*
> + * VM Memory Region Delete
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   slot - Slot of the memory region to delete
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Delete a memory region.
> + */
> +void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot)
> +{
> +	__vm_mem_region_delete(vm, memslot2region(vm, slot));
> +}
> +
>   /*
>    * VCPU mmap Size
>    *

