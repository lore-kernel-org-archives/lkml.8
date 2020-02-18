Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94335C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7325D2072C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRDoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:44:19 -0500
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:57946 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726166AbgBRDoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:44:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 91814180AB5F9;
        Tue, 18 Feb 2020 03:44:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light90_4240633c2603e
X-Filterd-Recvd-Size: 1719
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Feb 2020 03:44:15 +0000 (UTC)
Message-ID: <0e28c46fe2361f0bedf438818eb7bfd1197706e2.camel@perches.com>
Subject: Re: [PATCH] KVM: VMX: replace "fall through" with "return true" to
 indicate different case
From:   Joe Perches <joe@perches.com>
To:     linmiaohe <linmiaohe@huawei.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Mon, 17 Feb 2020 19:42:53 -0800
In-Reply-To: <1581997168-20350-1-git-send-email-linmiaohe@huawei.com>
References: <1581997168-20350-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 11:39 +0800, linmiaohe wrote:
> The second "/* fall through */" in rmode_exception() makes code harder to
> read. Replace it with "return true" to indicate they are different cases
> and also this improves the readability.
[]
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
[]
> @@ -4495,7 +4495,7 @@ static bool rmode_exception(struct kvm_vcpu *vcpu, int vec)
>  		if (vcpu->guest_debug &
>  			(KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))
>  			return false;
> -		/* fall through */
> +		return true;

perhaps
		return !(vcpu->guest_debug & (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP));


