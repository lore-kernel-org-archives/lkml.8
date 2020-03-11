Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from szxga08-in.huawei.com ([45.249.212.255]:37010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgCKHfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:35:09 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To: zhukeqian <zhukeqian1@huawei.com>, Marc Zyngier <maz@kernel.org>
CC: "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "wangxin (U)" <wangxinxin.wang@huawei.com>
Subject: RE: [RFC] KVM: arm64: support enabling dirty log graually in small
 chunks
Date: Wed, 11 Mar 2020 07:34:55 +0000
Message-ID:
 <B2D15215269B544CADD246097EACE7474BB64495@DGGEMM528-MBX.china.huawei.com>
References: <20200309085727.1106-1-zhukeqian1@huawei.com>
 <4b85699ec1d354cc73f5302560231f86@misterjones.org>
 <64925c8b-af3d-beb5-bc9b-66ef1e47f92d@huawei.com>
 <a642a79ea9190542a9098e4c9dc5a9f2@kernel.org>
 <9ddefc54-dd5b-0555-0aaa-00a3a23febcf@huawei.com>
In-Reply-To: <9ddefc54-dd5b-0555-0aaa-00a3a23febcf@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311073455.zEbBhoWrZ4lpXtfBGIuq8_Sf3gNQ38Le97z2X77qDFE@z>



> -----Original Message-----
> From: zhukeqian
> Sent: Wednesday, March 11, 2020 3:20 PM
> To: Marc Zyngier <maz@kernel.org>
> Cc: kvmarm@lists.cs.columbia.edu; kvm@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zhoujian (jay)
> <jianjay.zhou@huawei.com>; Sean Christopherson
> <sean.j.christopherson@intel.com>; Paolo Bonzini <pbonzini@redhat.com>;
> James Morse <james.morse@arm.com>; Julien Thierry
> <julien.thierry.kdev@gmail.com>; Suzuki K Poulose <suzuki.poulose@arm.com>
> Subject: Re: [RFC] KVM: arm64: support enabling dirty log graually in small chunks
> 
> Hi Marc,
> 
> On 2020/3/10 21:16, Marc Zyngier wrote:
> > On 2020-03-10 08:26, zhukeqian wrote:
> >> Hi Marc,
> >>
> >> On 2020/3/9 19:45, Marc Zyngier wrote:
> >>> Kegian,
> >
> > [...]
> >
> >>> Is there a userspace counterpart to it?
> >>>
> >> As this KVM/x86 related changes have not been merged to mainline
> >> kernel, some little modification is needed on mainline Qemu.
> >
> > Could you please point me to these changes?
> I made some changes locally listed below.
> 
> However, Qemu can choose to enable KVM_DIRTY_LOG_INITIALLY_SET or not.
> Here I made no judgement on dirty_log_manual_caps because I just want to
> verify the optimization of this patch.
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
> 439a4efe52..1611f644a4 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2007,14 +2007,16 @@ static int kvm_init(MachineState *ms)
>      s->coalesced_pio = s->coalesced_mmio &&
>                         kvm_check_extension(s,
> KVM_CAP_COALESCED_PIO);
> 
> -    s->manual_dirty_log_protect =
> +    uint64_t dirty_log_manual_caps =
>          kvm_check_extension(s,
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> -    if (s->manual_dirty_log_protect) {
> -        ret = kvm_vm_enable_cap(s,
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0, 1);
> +    if (dirty_log_manual_caps) {
> +        ret = kvm_vm_enable_cap(s,
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0,
> +                                dirty_log_manual_caps);
>          if (ret) {
>              warn_report("Trying to enable
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 "
>                          "but failed.  Falling back to the legacy mode. ");
> -            s->manual_dirty_log_protect = false;
> +        } else {
> +            s->manual_dirty_log_protect = true;
>          }
>      }

FYI: I had submitted a patch to the Qemu community some days ago:
https://patchwork.kernel.org/patch/11419191/

> >
> >> As I tested this patch on a 128GB RAM Linux VM with no huge pages,
> >> the time of enabling dirty log will decrease obviously.
> >
> > I'm not sure how realistic that is. Not having huge pages tends to
> > lead to pretty bad performance in general...
> Sure, this has no effect on guests which are all of huge pages.
> 
> For my understanding, once a guest has normal pages (maybe are initialized at
> beginning or dissloved from huge pages), it can benefit from this patch.

Yes, I agree.



Regards,
Jay Zhou

