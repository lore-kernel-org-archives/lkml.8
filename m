Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41CEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B88C2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7ABfm78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgGIRsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:48:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726615AbgGIRsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594316921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBKaxszc9J3brzbIe9PuekXCVyqXMqYSpp7GRiPhBv8=;
        b=E7ABfm78Bfw6SdgMguaaSWq7Uv3KkWTUVlAomUOOHgneWOoOp9Jp4sYEX8jxG8LFfbFnd7
        K8i72Baj5YnAKk1kd3RWQ62xfOy7iG4bfmqsDV3yLibuufyKoNvKuaBW8CyA48Q2qqCGQL
        vO4ubFhk0xdmePJNZGOnGhnGlfsZX70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-A598r6JgNtWZPROidwbjXg-1; Thu, 09 Jul 2020 13:48:39 -0400
X-MC-Unique: A598r6JgNtWZPROidwbjXg-1
Received: by mail-wm1-f70.google.com with SMTP id 65so2894169wmd.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OBKaxszc9J3brzbIe9PuekXCVyqXMqYSpp7GRiPhBv8=;
        b=bXD0FwlFnrHC6aAl1Xsu0FvOg0vlF8obnxTL+KErW/krDQksq1CjzJAxEjCgxLVSQd
         MWQNqWJYdo61TkOZd91/jitiOk4lIl0fETgZ9gyCGUHdpjglr6pqQWEwsK+vcYQjfXBd
         K3+P8ieGZR07FszPNE3C81UCF0Cj4ivdCsEduCuE1H9tgLHnGmqkoxP5KoZjIsekBxBE
         J4OQSguPlNdYri34jBM5BQ+NuG7j5MxFu0/Xv3vH+RB61rTOB03kOxykIzoCkBphDNE3
         zf8ql8WBPo6SAb7987JgJlZGe548TQZvYmH4WO57ido0ajcAkwk9BP7Q1uw/0zlCXMSB
         jRAw==
X-Gm-Message-State: AOAM533ZOQGHR9y6N0kArdCxJoN8kog8kCvIb8t93rBZniD30r8JNJ+K
        ryqkz+jbdxcgHw5H0riQmW2QI6BUyTc1eK9IuID3GSxIKbw+ONuR/OZx63xtXKS0ihKnIblszcI
        77btHlU2ax9cbeRfRSZmTk/Ui
X-Received: by 2002:adf:81c8:: with SMTP id 66mr64370298wra.348.1594316918514;
        Thu, 09 Jul 2020 10:48:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8a4V2UuLN2uaVwSJn5bbrkO3YT8wXDAE7gV63PAyJaykIzI1KjDbVMYIB+Kg+e9aq5HyBaA==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr64370278wra.348.1594316918245;
        Thu, 09 Jul 2020 10:48:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id o205sm6104990wme.24.2020.07.09.10.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 10:48:37 -0700 (PDT)
Subject: Re: [PATCH v3 3/9] KVM: nSVM: reset nested_run_pending upon
 nested_svm_vmrun_msrpm() failure
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
References: <20200709145358.1560330-1-vkuznets@redhat.com>
 <20200709145358.1560330-4-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <262fc5f8-935d-dce2-314e-ce5db6e73940@redhat.com>
Date:   Thu, 9 Jul 2020 19:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709145358.1560330-4-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 16:53, Vitaly Kuznetsov wrote:
> WARN_ON_ONCE(svm->nested.nested_run_pending) in nested_svm_vmexit()
> will fire if nested_run_pending remains '1' but it doesn't really
> need to, we are already failing and not going to run nested guest.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/svm/nested.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index e424bce13e6c..1cc8592b1820 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -468,6 +468,8 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
>  	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb);
>  
>  	if (!nested_svm_vmrun_msrpm(svm)) {
> +		svm->nested.nested_run_pending = 0;
> +
>  		svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
>  		svm->vmcb->control.exit_code_hi = 0;
>  		svm->vmcb->control.exit_info_1  = 0;
> 

I wouldn't complain if you added a kvm-unit-tests testcase for this...

Paolo

