Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDEC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4412070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCTOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:50:21 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:33852 "EHLO
        7.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCTOuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:50:21 -0400
X-Greylist: delayed 8434 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 10:50:19 EDT
Received: from player728.ha.ovh.net (unknown [10.110.208.160])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id A6375135FBD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 13:23:05 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 060EF108AE6BD;
        Fri, 20 Mar 2020 12:22:49 +0000 (UTC)
Date:   Fri, 20 Mar 2020 13:22:48 +0100
From:   Greg Kurz <groug@kaod.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: check caller of H_SVM_* Hcalls
Message-ID: <20200320132248.44b81b3b@bahia.lan>
In-Reply-To: <20200320102643.15516-2-ldufour@linux.ibm.com>
References: <20200320102643.15516-1-ldufour@linux.ibm.com>
        <20200320102643.15516-2-ldufour@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13089993795129285060
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeguddgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 11:26:42 +0100
Laurent Dufour <ldufour@linux.ibm.com> wrote:

> The Hcall named H_SVM_* are reserved to the Ultravisor. However, nothing
> prevent a malicious VM or SVM to call them. This could lead to weird result
> and should be filtered out.
> 
> Checking the Secure bit of the calling MSR ensure that the call is coming
> from either the Ultravisor or a SVM. But any system call made from a SVM
> are going through the Ultravisor, and the Ultravisor should filter out
> these malicious call. This way, only the Ultravisor is able to make such a
> Hcall.

"Ultravisor should filter" ? And what if it doesn't (eg. because of a bug) ?

Shouldn't we also check the HV bit of the calling MSR as well to
disambiguate SVM and UV ?

> 
> Cc: Bharata B Rao <bharata@linux.ibm.com>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 33be4d93248a..43773182a737 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1074,25 +1074,35 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  					 kvmppc_get_gpr(vcpu, 6));
>  		break;
>  	case H_SVM_PAGE_IN:
> -		ret = kvmppc_h_svm_page_in(vcpu->kvm,
> -					   kvmppc_get_gpr(vcpu, 4),
> -					   kvmppc_get_gpr(vcpu, 5),
> -					   kvmppc_get_gpr(vcpu, 6));
> +		ret = H_UNSUPPORTED;
> +		if (kvmppc_get_srr1(vcpu) & MSR_S)
> +			ret = kvmppc_h_svm_page_in(vcpu->kvm,
> +						   kvmppc_get_gpr(vcpu, 4),
> +						   kvmppc_get_gpr(vcpu, 5),
> +						   kvmppc_get_gpr(vcpu, 6));

If calling kvmppc_h_svm_page_in() produces a "weird result" when
the MSR_S bit isn't set, then I think it should do the checking
itself, ie. pass vcpu.

This would also prevent adding that many lines in kvmppc_pseries_do_hcall()
which is a big enough function already. The checking could be done in a
helper in book3s_hv_uvmem.c and used by all UV specific hcalls.

>  		break;
>  	case H_SVM_PAGE_OUT:
> -		ret = kvmppc_h_svm_page_out(vcpu->kvm,
> -					    kvmppc_get_gpr(vcpu, 4),
> -					    kvmppc_get_gpr(vcpu, 5),
> -					    kvmppc_get_gpr(vcpu, 6));
> +		ret = H_UNSUPPORTED;
> +		if (kvmppc_get_srr1(vcpu) & MSR_S)
> +			ret = kvmppc_h_svm_page_out(vcpu->kvm,
> +						    kvmppc_get_gpr(vcpu, 4),
> +						    kvmppc_get_gpr(vcpu, 5),
> +						    kvmppc_get_gpr(vcpu, 6));
>  		break;
>  	case H_SVM_INIT_START:
> -		ret = kvmppc_h_svm_init_start(vcpu->kvm);
> +		ret = H_UNSUPPORTED;
> +		if (kvmppc_get_srr1(vcpu) & MSR_S)
> +			ret = kvmppc_h_svm_init_start(vcpu->kvm);
>  		break;
>  	case H_SVM_INIT_DONE:
> -		ret = kvmppc_h_svm_init_done(vcpu->kvm);
> +		ret = H_UNSUPPORTED;
> +		if (kvmppc_get_srr1(vcpu) & MSR_S)
> +			ret = kvmppc_h_svm_init_done(vcpu->kvm);
>  		break;
>  	case H_SVM_INIT_ABORT:
> -		ret = kvmppc_h_svm_init_abort(vcpu->kvm);
> +		ret = H_UNSUPPORTED;
> +		if (kvmppc_get_srr1(vcpu) & MSR_S)
> +			ret = kvmppc_h_svm_init_abort(vcpu->kvm);
>  		break;
>  
>  	default:

