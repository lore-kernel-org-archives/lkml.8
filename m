Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MENTIONS_GIT_HOSTING,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40322 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729673AbgCKQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:39:23 -0400
Received: by mail-qt1-f198.google.com with SMTP id c13so1557714qtq.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:39:09 -0700 (PDT)
Date: Wed, 11 Mar 2020 12:39:06 -0400
From: Peter Xu <peterx@redhat.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 03/14] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200311163906.GG479302@xz-x1>
References: <20200309214424.330363-4-peterx@redhat.com>
 <202003110908.UE6SBwLU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202003110908.UE6SBwLU%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 11, 2020 at 09:10:04AM +0800, kbuild test robot wrote:
> Hi Peter,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/auto-latest]
> [also build test WARNING on vhost/linux-next linus/master v5.6-rc5 next-20200310]
> [cannot apply to kvm/linux-next linux/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Xu/KVM-Dirty-ring-interface/20200310-070637
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 12481c76713078054f2d043b3ce946e4814ac29f
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-174-g094d5a94-dirty
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    arch/x86/kvm/x86.c:2599:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const [noderef] <asn:1> * @@    got  const [noderef] <asn:1> * @@
>    arch/x86/kvm/x86.c:2599:38: sparse:    expected void const [noderef] <asn:1> *
>    arch/x86/kvm/x86.c:2599:38: sparse:    got unsigned char [usertype] *
>    arch/x86/kvm/x86.c:7501:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    arch/x86/kvm/x86.c:7501:15: sparse:    struct kvm_apic_map [noderef] <asn:4> *
>    arch/x86/kvm/x86.c:7501:15: sparse:    struct kvm_apic_map *
> >> arch/x86/kvm/x86.c:9794:31: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@

I'm not sure on how I can reproduce this locally, and also I'm not
very sure I understand this warning.  I'd be glad to know if anyone
knows...

If without further hints, I'll try to remove the __user for
__x86_set_memory_region() and use a cast on the callers next.

Thanks,

>    arch/x86/kvm/x86.c:9794:31: sparse:    expected void [noderef] <asn:1> *
>    arch/x86/kvm/x86.c:9794:31: sparse:    got void *
>    arch/x86/kvm/x86.c:9799:39: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
>    arch/x86/kvm/x86.c:9799:39: sparse:    expected void [noderef] <asn:1> *
>    arch/x86/kvm/x86.c:9799:39: sparse:    got void *
>    arch/x86/kvm/x86.c:9811:39: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
>    arch/x86/kvm/x86.c:9811:39: sparse:    expected void [noderef] <asn:1> *
>    arch/x86/kvm/x86.c:9811:39: sparse:    got void *
>    arch/x86/kvm/x86.c:9827:39: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
>    arch/x86/kvm/x86.c:9827:39: sparse:    expected void [noderef] <asn:1> *
>    arch/x86/kvm/x86.c:9827:39: sparse:    got void *
>    arch/x86/kvm/x86.c:9863:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    arch/x86/kvm/x86.c:9863:16: sparse:    struct kvm_apic_map [noderef] <asn:4> *
>    arch/x86/kvm/x86.c:9863:16: sparse:    struct kvm_apic_map *
>    arch/x86/kvm/x86.c:9864:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    arch/x86/kvm/x86.c:9864:15: sparse:    struct kvm_pmu_event_filter [noderef] <asn:4> *
>    arch/x86/kvm/x86.c:9864:15: sparse:    struct kvm_pmu_event_filter *
>    include/linux/srcu.h:179:9: sparse: sparse: context imbalance in 'vcpu_enter_guest' - unexpected unlock
> 
> vim +9794 arch/x86/kvm/x86.c
> 
>   9758	
>   9759	/**
>   9760	 * __x86_set_memory_region: Setup KVM internal memory slot
>   9761	 *
>   9762	 * @kvm: the kvm pointer to the VM.
>   9763	 * @id: the slot ID to setup.
>   9764	 * @gpa: the GPA to install the slot (unused when @size == 0).
>   9765	 * @size: the size of the slot. Set to zero to uninstall a slot.
>   9766	 *
>   9767	 * This function helps to setup a KVM internal memory slot.  Specify
>   9768	 * @size > 0 to install a new slot, while @size == 0 to uninstall a
>   9769	 * slot.  The return code can be one of the following:
>   9770	 *
>   9771	 *   - An error number if error happened, or,
>   9772	 *   - For installation: the HVA of the newly mapped memory slot, or,
>   9773	 *   - For uninstallation: zero if we successfully uninstall a slot.
>   9774	 *
>   9775	 * The caller should always use IS_ERR() to check the return value
>   9776	 * before use.  NOTE: KVM internal memory slots are guaranteed and
>   9777	 * won't change until the VM is destroyed. This is also true to the
>   9778	 * returned HVA when installing a new memory slot.  The HVA can be
>   9779	 * invalidated by either an errornous userspace program or a VM under
>   9780	 * destruction, however as long as we use __copy_{to|from}_user()
>   9781	 * properly upon the HVAs and handle the failure paths always then
>   9782	 * we're safe.
>   9783	 */
>   9784	void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
>   9785					      u32 size)
>   9786	{
>   9787		int i, r;
>   9788		unsigned long hva;
>   9789		struct kvm_memslots *slots = kvm_memslots(kvm);
>   9790		struct kvm_memory_slot *slot, old;
>   9791	
>   9792		/* Called with kvm->slots_lock held.  */
>   9793		if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
> > 9794			return ERR_PTR(-EINVAL);
>   9795	
>   9796		slot = id_to_memslot(slots, id);
>   9797		if (size) {
>   9798			if (slot->npages)
>   9799				return ERR_PTR(-EEXIST);
>   9800	
>   9801			/*
>   9802			 * MAP_SHARED to prevent internal slot pages from being moved
>   9803			 * by fork()/COW.
>   9804			 */
>   9805			hva = vm_mmap(NULL, 0, size, PROT_READ | PROT_WRITE,
>   9806				      MAP_SHARED | MAP_ANONYMOUS, 0);
>   9807			if (IS_ERR((void *)hva))
>   9808				return (void __user *)hva;
>   9809		} else {
>   9810			if (!slot->npages)
>   9811				return ERR_PTR(0);
>   9812	
>   9813			hva = 0;
>   9814		}
>   9815	
>   9816		old = *slot;
>   9817		for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
>   9818			struct kvm_userspace_memory_region m;
>   9819	
>   9820			m.slot = id | (i << 16);
>   9821			m.flags = 0;
>   9822			m.guest_phys_addr = gpa;
>   9823			m.userspace_addr = hva;
>   9824			m.memory_size = size;
>   9825			r = __kvm_set_memory_region(kvm, &m);
>   9826			if (r < 0)
>   9827				return ERR_PTR(r);
>   9828		}
>   9829	
>   9830		if (!size)
>   9831			vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
>   9832	
>   9833		return (void __user *)hva;
>   9834	}
>   9835	EXPORT_SYMBOL_GPL(__x86_set_memory_region);
>   9836	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

-- 
Peter Xu

