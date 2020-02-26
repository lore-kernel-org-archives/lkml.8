Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A38C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8A421D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2aefcdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBZPYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:24:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22656 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727670AbgBZPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582730690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+QkqnbU1iFIPyAtAgMG3gn/Nhb4l1LvHJ8Yic656iE=;
        b=T2aefcdGrIbgqajzUU+hdIDsRg6PaT8mF5KvDpJeyf9sc4uPpyO26eUgEvl95F9vqFLaFN
        TDJBblqV9Vv2ZY+qpvq7lH9csr9nX65IvnnJK12acOQpTTCsLBJTAAvIwD2Nfc6xzb/r3m
        RydPZssMSr5fUvIuxHPq7zpuITQbJpg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-sF_HdhmVObSFjvAY8-J_GA-1; Wed, 26 Feb 2020 10:24:49 -0500
X-MC-Unique: sF_HdhmVObSFjvAY8-J_GA-1
Received: by mail-wr1-f69.google.com with SMTP id r1so1608304wrc.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=h+QkqnbU1iFIPyAtAgMG3gn/Nhb4l1LvHJ8Yic656iE=;
        b=Ksjm/2HkNqW1CdWPentR7/EuDktU7hSNliX0U+bIUsLTIzjSHsrrSJ360gkpRJB7Zm
         9NxaUv14evo+hrpwBQedA8CXeUMdos+I0ym0CNWXMnLYzb9gApL3nLqIoTQD/H/mjuAv
         RppFnmV3SegUmGEsuh3MgebTriq8tF1Fn/v9HzmLResgNOy4/guHTwK1V/ziVyq0yxOV
         QTTxbaEJPTRTzw1ptwViihIU4xzVwmLrCHteTANsf89Eiw6l423G9Ee7E83pRBMX2yCn
         h0J0prjsdg0keirnshPd9yQkOhuvGT0Ocf+2DRUHlg9LjIV3Ge2IlTDtr0SxAJZDLtTd
         pEyQ==
X-Gm-Message-State: APjAAAUkB0F9L2ZvZIP+HLBeMgdk43/l3ftR4uPZnLyz9QTMgGlt4khR
        /qSM2XaF7FdUPVffK2Z9qFB/rGVHzm75/CxDtzKpB3k9RrLkwFRukk+Vc+b3ogKBX+r+EgRBIb6
        usyJWlnHgCaMh9SafbxGjjq9B
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr4989654wml.38.1582730687308;
        Wed, 26 Feb 2020 07:24:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxA5F5DBc1k8YNkcYxe4gys14bSQKTA5C8H2lX9KfdEEbB4z/l9LGZIZpRT7KjVaS0UTGpHfw==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr4989634wml.38.1582730687105;
        Wed, 26 Feb 2020 07:24:47 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d18sm3794976wrw.49.2020.02.26.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:24:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] KVM: x86: Refactor R/W page helper to take the emulation context
In-Reply-To: <20200218232953.5724-5-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-5-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 16:24:45 +0100
Message-ID: <878skpjrr6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Invert the vcpu->context derivation in emulator_read_write_onepage() in
> preparation for dynamically allocating the emulation context.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 409bf35f26fd..772e704e8083 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5720,14 +5720,14 @@ static const struct read_write_emulator_ops write_emultor = {
>  static int emulator_read_write_onepage(unsigned long addr, void *val,
>  				       unsigned int bytes,
>  				       struct x86_exception *exception,
> -				       struct kvm_vcpu *vcpu,
> +				       struct x86_emulate_ctxt *ctxt,
>  				       const struct read_write_emulator_ops *ops)
>  {
>  	gpa_t gpa;
>  	int handled, ret;
>  	bool write = ops->write;
>  	struct kvm_mmio_fragment *frag;
> -	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
> +	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
>  
>  	/*
>  	 * If the exit was due to a NPF we may already have a GPA.
> @@ -5791,7 +5791,7 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
>  
>  		now = -addr & ~PAGE_MASK;
>  		rc = emulator_read_write_onepage(addr, val, now, exception,
> -						 vcpu, ops);
> +						 ctxt, ops);
>  
>  		if (rc != X86EMUL_CONTINUE)
>  			return rc;
> @@ -5803,7 +5803,7 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
>  	}
>  
>  	rc = emulator_read_write_onepage(addr, val, bytes, exception,
> -					 vcpu, ops);
> +					 ctxt, ops);
>  	if (rc != X86EMUL_CONTINUE)
>  		return rc;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

