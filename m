Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B21C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF726206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgEUDBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:01:04 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:33096 "EHLO
        19.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgEUDBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:01:03 -0400
X-Greylist: delayed 32998 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 23:01:02 EDT
Received: from player732.ha.ovh.net (unknown [10.108.57.150])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0A5A523673D
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 19:33:09 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player732.ha.ovh.net (Postfix) with ESMTPSA id F18101274FFBC;
        Wed, 20 May 2020 17:33:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-104R00501e830cb-d745-4bc0-ad5d-5f7e91f631ff,D4AE9CB3A4750E3488E7135F1D4D455A9A9A4933) smtp.auth=groug@kaod.org
Date:   Wed, 20 May 2020 19:32:59 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au,
        sukadev@linux.ibm.com, linuxram@us.ibm.com
Subject: Re: [PATCH] KVM: PPC: Book3S HV: relax check on H_SVM_INIT_ABORT
Message-ID: <20200520193259.0b66db32@bahia.lan>
In-Reply-To: <20200520165110.71020-1-ldufour@linux.ibm.com>
References: <20200520165110.71020-1-ldufour@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7626001547735570884
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtledgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 18:51:10 +0200
Laurent Dufour <ldufour@linux.ibm.com> wrote:

> The commit 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_*
> Hcalls") added checks of secure bit of SRR1 to filter out the Hcall
> reserved to the Ultravisor.
> 
> However, the Hcall H_SVM_INIT_ABORT is made by the Ultravisor passing the
> context of the VM calling UV_ESM. This allows the Hypervisor to return to
> the guest without going through the Ultravisor. Thus the Secure bit of SRR1
> is not set in that particular case.
> 
> In the case a regular VM is calling H_SVM_INIT_ABORT, this hcall will be
> filtered out in kvmppc_h_svm_init_abort() because kvm->arch.secure_guest is
> not set in that case.
> 

Why not checking vcpu->kvm->arch.secure_guest then ?

> Fixes: 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_* Hcalls")
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 93493f0cbfe8..eb1f96cb7b72 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1099,9 +1099,7 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  			ret = kvmppc_h_svm_init_done(vcpu->kvm);
>  		break;
>  	case H_SVM_INIT_ABORT:
> -		ret = H_UNSUPPORTED;
> -		if (kvmppc_get_srr1(vcpu) & MSR_S)
> -			ret = kvmppc_h_svm_init_abort(vcpu->kvm);

or at least put a comment to explain why H_SVM_INIT_ABORT
doesn't have the same sanity check as the other SVM hcalls.

> +		ret = kvmppc_h_svm_init_abort(vcpu->kvm);
>  		break;
>  
>  	default:

