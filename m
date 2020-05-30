Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5A8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD2C2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgE3P6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 11:58:31 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:60224 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729029AbgE3P6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 11:58:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9CCB74DD8;
        Sat, 30 May 2020 15:58:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ink56_0c0299e26d6d
X-Filterd-Recvd-Size: 2145
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 May 2020 15:58:28 +0000 (UTC)
Message-ID: <0c00d96c46d34d69f5f459baebf3c89a507730fc.camel@perches.com>
Subject: Re: [PATCH] KVM: Use previously computed array_size()
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 30 May 2020 08:58:26 -0700
In-Reply-To: <20200530143558.321449-1-efremov@linux.com>
References: <20200530143558.321449-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-30 at 17:35 +0300, Denis Efremov wrote:
> array_size() is used in alloc calls to compute the allocation
> size. Next, "raw" multiplication is used to compute the size
> for copy_from_user(). The patch removes duplicated computation
> by saving the size in a var. No security concerns, just a small
> optimization.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Perhaps use vmemdup_user?

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
[]
> @@ -184,14 +184,13 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
>  		goto out;
>  	r = -ENOMEM;
>  	if (cpuid->nent) {
> -		cpuid_entries =
> -			vmalloc(array_size(sizeof(struct kvm_cpuid_entry),
> -					   cpuid->nent));
> +		const size_t size = array_size(sizeof(struct kvm_cpuid_entry),
> +					       cpuid->nent);
> +		cpuid_entries = vmalloc(size);
>  		if (!cpuid_entries)
>  			goto out;
>  		r = -EFAULT;
> -		if (copy_from_user(cpuid_entries, entries,
> -				   cpuid->nent * sizeof(struct kvm_cpuid_entry)))
> +		if (copy_from_user(cpuid_entries, entries, size))

		cpuid_entries = vmemdup_user(entries,
					     array_size(sizeof(struct kvm_cpuid_entry), cpuid->nent));
		if (IS_ERR(cpuid_entries))
			...

etc...


