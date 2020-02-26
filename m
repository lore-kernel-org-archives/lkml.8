Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16EBC4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A0420838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ50qk9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBZPQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:16:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39705 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727228AbgBZPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582730201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ij8sMR6FAadSXu2miL+uunfhTRcFyYbFV2u9LA8Eu3g=;
        b=fJ50qk9PsheWd2sS0bITe9Ux11PP7DgbZLhgljJHju2rFwJiQBdEmgGJv6YxqBIQLFpAC9
        YGNs2KtHiTmtsxbQJZzTiSsnlSSnclLz2S/oEYEo3EWepbd5JeI3i/k6Q174fAQ9UzKV9c
        buYwSZp0ZMLO+KNmGbTjHXAHvH7jXCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-sN7Mhq37NriU9h8WmQeSPw-1; Wed, 26 Feb 2020 10:16:39 -0500
X-MC-Unique: sN7Mhq37NriU9h8WmQeSPw-1
Received: by mail-wm1-f70.google.com with SMTP id w12so770831wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ij8sMR6FAadSXu2miL+uunfhTRcFyYbFV2u9LA8Eu3g=;
        b=aObPY1hlqSbU/TEwtgYYbzpjejkSd7BSwR1JouyzNef+AU2u0Wr24AH4KQcHRqhnT9
         j2bsHuyURpqmsOKGS8MgDYlBqEjZyobhrJ3YNCCcs5EhVwKhf73v6+H9zmYt953Idz7P
         w9TYWtw0Uhd0cWjxzl90/FCtaYs7BVQmFT9vv2OH7d/sm48rI0YbE+Veq05mO6xSY08y
         wze8FR1TSTc5wOjsfXdq8kX8pRE0LCv6H4aZfMZKXG22AXhy+6D5P/Mcocm8cumQRlKp
         MK05h5UM9m2NqXwYTFFBD3CcYuU4J+ci9AZnERZIR2T5BQEmpWha86ZxHTxA89tIYTpD
         2rPA==
X-Gm-Message-State: APjAAAXtdNnwqyAplVqbWUtIldXyQhA7KUHd5GUh3eLFQXEX+Noh6eS7
        fl3vj/Dlq4+m5uz2eZehvsXfeSQIeHmhbDF36oTZycREsSRsHFGm09C2aKtMKGxkcwBRyIN/nhQ
        xFejLSctir9FDcsRgYdY2zPx2
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr6207295wmj.147.1582730197854;
        Wed, 26 Feb 2020 07:16:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwODxhYVXmNh74qrCy1jD35rM1qXEd6GkGv23SBY63Ed6PzBCL7nHXi11CvzZsUvet3gciVwg==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr6207270wmj.147.1582730197604;
        Wed, 26 Feb 2020 07:16:37 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q12sm3827586wrg.71.2020.02.26.07.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:16:36 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] KVM: x86: Refactor I/O emulation helpers to provide vcpu-only variant
In-Reply-To: <20200218232953.5724-2-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-2-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 16:16:35 +0100
Message-ID: <87h7zdjs4s.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Add variants of the I/O helpers that take a vCPU instead of an emulation
> context.  This will eventually allow KVM to limit use of the emulation
> context to the full emulation path.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fbabb2f06273..6554abef631f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5959,11 +5959,9 @@ static int emulator_pio_in_out(struct kvm_vcpu *vcpu, int size,
>  	return 0;
>  }
>  
> -static int emulator_pio_in_emulated(struct x86_emulate_ctxt *ctxt,
> -				    int size, unsigned short port, void *val,
> -				    unsigned int count)
> +static int emulator_pio_in(struct kvm_vcpu *vcpu, int size,
> +			   unsigned short port, void *val, unsigned int count)
>  {
> -	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
>  	int ret;
>  
>  	if (vcpu->arch.pio.count)
> @@ -5983,17 +5981,30 @@ static int emulator_pio_in_emulated(struct x86_emulate_ctxt *ctxt,
>  	return 0;
>  }
>  
> -static int emulator_pio_out_emulated(struct x86_emulate_ctxt *ctxt,
> -				     int size, unsigned short port,
> -				     const void *val, unsigned int count)
> +static int emulator_pio_in_emulated(struct x86_emulate_ctxt *ctxt,
> +				    int size, unsigned short port, void *val,
> +				    unsigned int count)
>  {
> -	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
> +	return emulator_pio_in(emul_to_vcpu(ctxt), size, port, val, count);
>  
> +}
> +
> +static int emulator_pio_out(struct kvm_vcpu *vcpu, int size,
> +			    unsigned short port, const void *val,
> +			    unsigned int count)
> +{
>  	memcpy(vcpu->arch.pio_data, val, size * count);
>  	trace_kvm_pio(KVM_PIO_OUT, port, size, count, vcpu->arch.pio_data);
>  	return emulator_pio_in_out(vcpu, size, port, (void *)val, count, false);
>  }
>  
> +static int emulator_pio_out_emulated(struct x86_emulate_ctxt *ctxt,
> +				     int size, unsigned short port,
> +				     const void *val, unsigned int count)
> +{
> +	return emulator_pio_out(emul_to_vcpu(ctxt), size, port, val, count);
> +}
> +
>  static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
>  {
>  	return kvm_x86_ops->get_segment_base(vcpu, seg);
> @@ -6930,8 +6941,8 @@ static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
>  			    unsigned short port)
>  {
>  	unsigned long val = kvm_rax_read(vcpu);
> -	int ret = emulator_pio_out_emulated(&vcpu->arch.emulate_ctxt,
> -					    size, port, &val, 1);
> +	int ret = emulator_pio_out(vcpu, size, port, &val, 1);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -6967,11 +6978,10 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
>  	val = (vcpu->arch.pio.size < 4) ? kvm_rax_read(vcpu) : 0;
>  
>  	/*
> -	 * Since vcpu->arch.pio.count == 1 let emulator_pio_in_emulated perform
> +	 * Since vcpu->arch.pio.count == 1 let emulator_pio_in perform
>  	 * the copy and tracing
>  	 */
> -	emulator_pio_in_emulated(&vcpu->arch.emulate_ctxt, vcpu->arch.pio.size,
> -				 vcpu->arch.pio.port, &val, 1);
> +	emulator_pio_in(vcpu, vcpu->arch.pio.size, vcpu->arch.pio.port, &val, 1);
>  	kvm_rax_write(vcpu, val);
>  
>  	return kvm_skip_emulated_instruction(vcpu);
> @@ -6986,8 +6996,7 @@ static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
>  	/* For size less than 4 we merge, else we zero extend */
>  	val = (size < 4) ? kvm_rax_read(vcpu) : 0;
>  
> -	ret = emulator_pio_in_emulated(&vcpu->arch.emulate_ctxt, size, port,
> -				       &val, 1);
> +	ret = emulator_pio_in(vcpu, size, port, &val, 1);
>  	if (ret) {
>  		kvm_rax_write(vcpu, val);
>  		return ret;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

