Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCF6C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23AE20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qs5NJs5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgIDMCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729741AbgIDMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599220878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Al2z0QnC0ksQGEJoD0RhYiQbJmD54azvTeMvvOw+xd0=;
        b=Qs5NJs5+o449FQletJd3QKLuuzBvTstVPsvvFCk/BKsfA1WzoHdwLd5ZHINCBAHaSvrDOp
        fiZMIT3nuf2Arlgx7EXAxkWi4czrqH748CnMd9jS7VVn5dIh9if0W25XB0W/xyDlq47PWf
        eQ6Xw01uitEIRfHPNJSMIj7+xk0K744=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-wRs61YIXPTe_3tbgqsYMUA-1; Fri, 04 Sep 2020 08:01:16 -0400
X-MC-Unique: wRs61YIXPTe_3tbgqsYMUA-1
Received: by mail-wr1-f70.google.com with SMTP id r16so2227618wrm.18
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 05:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Al2z0QnC0ksQGEJoD0RhYiQbJmD54azvTeMvvOw+xd0=;
        b=SPoD0hUGrp8q1odSTzAx/WUSDEtXovhModg6wFV5vQXCmozgCTaWu10i7YN+wXNpeq
         INafocqWglzbf655jjIR9SASBIOqYzHMUUVr6fDXO6hTNVEjnFgx/DOxvdnUibhj1idA
         +LRt7hDbYIzLFiX4GD6c4cuEdJ+JAaBeMn/ts89ug45LbYcj4vxpLazGLscddJo8W3C9
         5MSPCO/CedRdAdBUt+bUVib8QgVIBhU4ejBDnCu6hJuzIoiSr7Iz5PkHn/cwhwlwn2P1
         A0MTDm97EoRK13WS84ig5n/g09oW/C4uBudwkT87HhmIvsCzJ/nEELPtKGbXXwteJGN4
         23dg==
X-Gm-Message-State: AOAM532X35N7pJPUnIqPGgKZCi3effi/aXZImypXRlnIGkdi2n9Iv8tJ
        uEUZodkvg12pAyu7xm5FQfllfUyhxqZPKyY28qBwAI8TQsRAJU/A7OQWrs02er6DcHcDosL/A70
        h9kLvgI+pjbtoF0WgfkR7PiML
X-Received: by 2002:adf:fb01:: with SMTP id c1mr7043273wrr.119.1599220875217;
        Fri, 04 Sep 2020 05:01:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIXro2W+UzI918zJZ8Jt2As+2AW5s/HHlp9hVGkN24CfzKnxwLXHw1csuVaPHLLwZaqe1O7A==
X-Received: by 2002:adf:fb01:: with SMTP id c1mr7043241wrr.119.1599220874941;
        Fri, 04 Sep 2020 05:01:14 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n4sm10710789wrp.61.2020.09.04.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:01:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     "hpa\@zytor.com" <hpa@zytor.com>, "bp\@alien8.de" <bp@alien8.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>, joro@8bytes.org,
        "jmattson\@google.com" <jmattson@google.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        sean.j.christopherson@intel.com,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: SVM: Add tracepoint for cr_interception
In-Reply-To: <f3031602-db3b-c4fe-b719-d402663b0a2b@gmail.com>
References: <f3031602-db3b-c4fe-b719-d402663b0a2b@gmail.com>
Date:   Fri, 04 Sep 2020 14:01:12 +0200
Message-ID: <87imctoinr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiwei Li <lihaiwei.kernel@gmail.com> writes:

> From: Haiwei Li <lihaiwei@tencent.com>
>
> Add trace_kvm_cr_write and trace_kvm_cr_read for svm.
>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>   arch/x86/kvm/svm/svm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 03dd7bac8034..2c6dea48ba62 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2261,6 +2261,7 @@ static int cr_interception(struct vcpu_svm *svm)

There are two special cases when we go to emulate_on_interception() and
these won't be logged but I don't think this is a must.

>   	if (cr >= 16) { /* mov to cr */
>   		cr -= 16;
>   		val = kvm_register_read(&svm->vcpu, reg);
> +		trace_kvm_cr_write(cr, val);
>   		switch (cr) {
>   		case 0:
>   			if (!check_selective_cr0_intercepted(svm, val))
> @@ -2306,6 +2307,7 @@ static int cr_interception(struct vcpu_svm *svm)
>   			return 1;
>   		}
>   		kvm_register_write(&svm->vcpu, reg, val);
> +		trace_kvm_cr_read(cr, val);

The 'default:' case above does 'return 1;' so we won't get the trace but
I understand you put trace_kvm_cr_read() here so you can log the
returned 'val', #UD should be clearly visible. 

>   	}
>   	return kvm_complete_insn_gp(&svm->vcpu, err);
>   }
> --
> 2.18.4
>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

