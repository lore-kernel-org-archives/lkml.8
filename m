Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5355C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817E620658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgBCKP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:15:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBCKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:15:56 -0500
Received: from 189-68-179-241.dsl.telesp.net.br ([189.68.179.241] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1iyYlF-0006lq-8V; Mon, 03 Feb 2020 10:15:21 +0000
Date:   Mon, 3 Feb 2020 07:15:14 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     pbonzini@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: do not setup pv tlb flush when not
 paravirtualized
Message-ID: <20200203101514.GG40679@calabresa>
References: <20200131155655.49812-1-cascardo@canonical.com>
 <87wo94ng9d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo94ng9d.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:59:10AM +0100, Vitaly Kuznetsov wrote:
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:
> 
> > kvm_setup_pv_tlb_flush will waste memory and print a misguiding message
> > when KVM paravirtualization is not available.
> >
> > Intel SDM says that the when cpuid is used with EAX higher than the
> > maximum supported value for basic of extended function, the data for the
> > highest supported basic function will be returned.
> >
> > So, in some systems, kvm_arch_para_features will return bogus data,
> > causing kvm_setup_pv_tlb_flush to detect support for pv tlb flush.
> >
> > Testing for kvm_para_available will work as it checks for the hypervisor
> > signature.
> >
> > Besides, when the "nopv" command line parameter is used, it should not
> > continue as well, as kvm_guest_init will no be called in that case.
> >
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > ---
> >  arch/x86/kernel/kvm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 81045aabb6f4..d817f255aed8 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -736,6 +736,9 @@ static __init int kvm_setup_pv_tlb_flush(void)
> >  {
> >  	int cpu;
> >  
> > +	if (!kvm_para_available() || nopv)
> > +		return 0;
> > +
> >  	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
> >  	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
> >  	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
> 
> The patch will fix the immediate issue, but why kvm_setup_pv_tlb_flush()
> is just an arch_initcall() which will be executed regardless of the fact
> if we are running on KVM or not?
> 
> In Hyper-V we setup PV TLB flush from ms_hyperv_init_platform() -- which
> only happens if Hyper-V platform was detected. Why don't we do it from
> kvm_init_platform() in KVM?
> 
> -- 
> Vitaly
> 

Because we can't call the allocator that early.

Also, see the thread where this was "decided", the v6 of the original patch:

https://lore.kernel.org/kvm/20171129162118.GA10661@flask/

Regards.
Cascardo.
