Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7846FC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F16206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PecPdgrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgDXRl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728915AbgDXRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:41:56 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2B4C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:41:56 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id c17so10293808uae.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aKSKYDh9k1niMW7OtBVvn1z3Fu6LP0t5D1Mv02H/nno=;
        b=PecPdgrT/zl5ebE+re2uB+aoslw26DaLVuLT8b0WJ5z+rbXerQxMT7aujIhi+3wro0
         IdwUH7NFMZNueIVudTN3HMegAMjrSbCEHiTamocZz9nJIjXPAf5yajti/GSHpnZDAtM5
         152B4W2pUV6gRP+jYhozHR2HXG4UNKLNvainmP/fofhpuXKiPjQriJ3hFviMq5gUUSeB
         GUaApgISY+Xbu2ZwlRBMFQo4yFHjUkHhs1ifNUhDJelV9T3ZnuKtp4p2/SK8PKjxo/ca
         WIz05Dmc5SaS5BJpJbNWIBPci84kG8Lo3O9ECx+oop7sqBQFXDms2SceAMNQbOu9w3Dr
         Bq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aKSKYDh9k1niMW7OtBVvn1z3Fu6LP0t5D1Mv02H/nno=;
        b=ZZi9igieKauT32y6WTudnNQfilvNV5Ize4iaD9aZqBRAE4VwLe6hB97P0LlpQicWzN
         iSVnYzs2YqlQJUoBkYbJMGjsk7e5Us/rQ1ORR0GucDcZ8gfRm33A1wYM3GA/6n+G7ks1
         qn43zEl3CTnOVGndWinwvYWQJa0J19+X7BmBkAwZrhYKF9hNfA+j1A6liIQlkcE467BC
         rTNhteM4rmRhxJjRAY8WzLrFmO8YOZV6f96UMYFc1U05CYk4dZ+B6PriDIn4d4l/B82I
         hbto8eZsLMDn2lKPRrbMdxz9VmqX3MmUCsGVllpSCc/KZ1e7iUvYhfkNOEull2SzNKU3
         gqEw==
X-Gm-Message-State: AGi0PuaRdW8NwIKQ8mIHvikoRuWoLvAsNxzSWtjHWpGr818c2bab7eJD
        w49xI3cMR9I08NDp3nIWTfw60g==
X-Google-Smtp-Source: APiQypLfZz2BJcZxYHNKJSnZT0DAQ4QWxcyHUoIaJ26P4Fizpb4xAIua/6tnd5aRLAg2WHdfjlic1Q==
X-Received: by 2002:a67:f1c3:: with SMTP id v3mr8803405vsm.119.1587750115307;
        Fri, 24 Apr 2020 10:41:55 -0700 (PDT)
Received: from google.com (25.173.196.35.bc.googleusercontent.com. [35.196.173.25])
        by smtp.gmail.com with ESMTPSA id k24sm1357796uaq.20.2020.04.24.10.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:41:54 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:41:50 +0000
From:   Oliver Upton <oupton@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 02/22] KVM: SVM: leave halted state on vmexit
Message-ID: <20200424174150.GA224300@google.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
 <20200424172416.243870-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424172416.243870-3-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 01:23:56PM -0400, Paolo Bonzini wrote:
> Similar to VMX, we need to leave the halted state when performing a vmexit.
> Failure to do so will cause a hang after vmexit.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Oliver Upton <oupton@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 51cfab68428d..e69e60ac1370 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -472,6 +472,9 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  	leave_guest_mode(&svm->vcpu);
>  	svm->nested.vmcb = 0;
>  
> +	/* in case we halted in L2 */
> +	svm->vcpu.arch.mp_state = KVM_MP_STATE_RUNNABLE;
> +
>  	/* Give the current vmcb to the guest */
>  	disable_gif(svm);
>  
> -- 
> 2.18.2
> 
> 
