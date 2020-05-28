Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E08C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596E92074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzE8EdJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbgE1Lzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:55:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27787 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388549AbgE1Lzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590666948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMrXL5UTOuAfzZCPWxCDdnj8ZN3SNqipk1q2lcevpUM=;
        b=fzE8EdJGON1UeeaJ4FgOFOqb79FtYwoqrn91MdR67ysf9DFmH3mXXT4u6/hZBHPexDuWQy
        i+eTQAOdW/ahUq7jT6LeFD6Q1CddRG7yzrZPM6KcZ9O/bQvT/2yFsNLfHzdyt2KyDzXUyq
        0d1vMR0u7UPuIZ8RRwmevPR6LorS9FM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-3P1kaEzoN_mK9KqRKbfxfQ-1; Thu, 28 May 2020 07:55:47 -0400
X-MC-Unique: 3P1kaEzoN_mK9KqRKbfxfQ-1
Received: by mail-wm1-f71.google.com with SMTP id u15so887053wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kMrXL5UTOuAfzZCPWxCDdnj8ZN3SNqipk1q2lcevpUM=;
        b=j4gjbASIf08JvgRVdxgtrLBAyetUYevHtN9jb45+FW5D+Rj9IXQFKkh60rxqwbS//v
         bjXQI/ixdj5NHqKsu/UxntiP/arDr52mICcwi38V5pPp/evxLWl8Fu5J2Dq4vUkQWtu0
         LEoES31MfDqx9UiFBUjpsRwwciifZ1rX9Rf6/Ja7ZKUOu935vLRoMCEcMsD8IgvR2PcW
         jNUgcL0nsw7CQwzluTU1gEj8MdGnIHmWnHVOjbKasfC6H+smH7Bl42CiqaNF6vTaSC9C
         O3HfprFrvsr2aoSuxt+NJevb84/W4wE2rmxiNG91WKDM43OqtiQuLSLE9u7tn4Q5jdM3
         OvDw==
X-Gm-Message-State: AOAM531BGBxV8mUG++YTLUQXWXlxryl7wkqWB3Nz/JkXjz5BhVw1z0pp
        OmnqOB/IBxZkbq1EK7fwr+TnARUbMt6MM4N+pMzUm8f75yc1JQOB5uAp5zjCy96s6NqgKmo1Ok9
        uMkOSsr3PvtwSsQEEoJVggWAA
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr2983436wmh.37.1590666945765;
        Thu, 28 May 2020 04:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRaCegJZCXeJg+DyF1D0t/2pQf4m0FYJJ1fMY2jcdAySIKDs/WMA30cgVqg6evvPOvJlfuvA==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr2983415wmh.37.1590666945527;
        Thu, 28 May 2020 04:55:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id n23sm3423436wmc.21.2020.05.28.04.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 04:55:45 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Ignore KVM 5-level paging support for
 VM_MODE_PXXV48_4K
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergio Perez Gonzalez <sergio.perez.gonzalez@intel.com>,
        Adriana Cervantes Jimenez <adriana.cervantes.jimenez@intel.com>,
        Peter Xu <peterx@redhat.com>
References: <20200528021530.28091-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed65de29-a07a-f424-937e-38576e740de7@redhat.com>
Date:   Thu, 28 May 2020 13:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200528021530.28091-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 04:15, Sean Christopherson wrote:
> Explicitly set the VA width to 48 bits for the x86_64-only PXXV48_4K VM
> mode instead of asserting the guest VA width is 48 bits.  The fact that
> KVM supports 5-level paging is irrelevant unless the selftests opt-in to
> 5-level paging by setting CR4.LA57 for the guest.  The overzealous
> assert prevents running the selftests on a kernel with 5-level paging
> enabled.
> 
> Incorporate LA57 into the assert instead of removing the assert entirely
> as a sanity check of KVM's CPUID output.
> 
> Fixes: 567a9f1e9deb ("KVM: selftests: Introduce VM_MODE_PXXV48_4K")
> Reported-by: Sergio Perez Gonzalez <sergio.perez.gonzalez@intel.com>
> Cc: Adriana Cervantes Jimenez <adriana.cervantes.jimenez@intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index c9cede5c7d0de..74776ee228f2d 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -195,11 +195,18 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  	case VM_MODE_PXXV48_4K:
>  #ifdef __x86_64__
>  		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
> -		TEST_ASSERT(vm->va_bits == 48, "Linear address width "
> -			    "(%d bits) not supported", vm->va_bits);
> +		/*
> +		 * Ignore KVM support for 5-level paging (vm->va_bits == 57),
> +		 * it doesn't take effect unless a CR4.LA57 is set, which it
> +		 * isn't for this VM_MODE.
> +		 */
> +		TEST_ASSERT(vm->va_bits == 48 || vm->va_bits == 57,
> +			    "Linear address width (%d bits) not supported",
> +			    vm->va_bits);
>  		pr_debug("Guest physical address width detected: %d\n",
>  			 vm->pa_bits);
>  		vm->pgtable_levels = 4;
> +		vm->va_bits = 48;
>  #else
>  		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
>  #endif
> 

Queued, thnaks.

Paolo

