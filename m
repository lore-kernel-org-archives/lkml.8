Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BCBC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853F220656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5iSXndv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgBQRNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:13:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728519AbgBQRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581959579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7p5g9/+JuQI5dVBHZjO5Q9kWlIBYXtB5HG4luX7GEwo=;
        b=c5iSXndv6kPklkKC/u67PoXw+dlN/Sf9IGEUSbtQpwTnZ1IUnx14XoCa5DgemRgbcKggJo
        FjQVOmlSgQOwz74yaXjL73bpZLR9hj2GYtR15yBPPNp4+L4FsodTzMSwtp3VK8hXv8HkiL
        t7djvLmLnQZqIZtGvLkNTG7zOod4wWU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-KSMpw-QbOpewWzN_otF1Kg-1; Mon, 17 Feb 2020 12:12:57 -0500
X-MC-Unique: KSMpw-QbOpewWzN_otF1Kg-1
Received: by mail-wr1-f70.google.com with SMTP id z15so9301530wrw.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7p5g9/+JuQI5dVBHZjO5Q9kWlIBYXtB5HG4luX7GEwo=;
        b=MZj9LRUJW9YoIKbPNo7hbFcrQzNylq+yRFm3J2pl/3FyP6LIVsU7ZPAMZ7zoBmyeyx
         T09ixOLk3pfa83Rf0WwNtgT5jrRLOW3J8Ey4NuNrju8mgwlL/ByXrO5haC3Ues57izKd
         zuWkWP2NZsD17mNz4w+itwh3niAf84Z0NXeUFIC0MIF9dcaFsHTEMLng5lkXgkQpOFDO
         ZoulUdhW3EwGfsszfKSnXiu5DEDSiKnYuuZl61wF/q0Na1mmwiVjUmM00gaDglu5xnd5
         wtK8AbtrUa/MVu5arqiTTYNtlktFSZZM3UO1wIOS7RBdsBUaTeMHq1CC31u8GAuBgCW8
         mZLg==
X-Gm-Message-State: APjAAAUY0Z7EfSQK2gzW92sIfb8DxTzIu2mbFY3ZIO1ZkBEG7/tcNp5+
        EcUU5XHazcjpjghY373/5VaEJptOeVb98aIULH6tDfKaUFZFeVJuLJEr0ok0PvL2/ySkIVY8W1F
        dBQuMBXNaHw8AVc9Ce6KAsBnV
X-Received: by 2002:adf:f401:: with SMTP id g1mr22756290wro.129.1581959576250;
        Mon, 17 Feb 2020 09:12:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjOKBowa9UkJsCbf6HRgTVMkdig8SA928zcp6LhcHUo+ZxZ1gtjP5M5UpyHa9alfYpEbAarQ==
X-Received: by 2002:adf:f401:: with SMTP id g1mr22756263wro.129.1581959575982;
        Mon, 17 Feb 2020 09:12:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id b18sm1907565wru.50.2020.02.17.09.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 09:12:55 -0800 (PST)
Subject: Re: [PATCH v2] kvm/emulate: fix a -Werror=cast-function-type
To:     Qian Cai <cai@lca.pw>
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1581958106-16668-1-git-send-email-cai@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad9054c5-d1fb-9cc3-4e03-0e9a0ea50d2c@redhat.com>
Date:   Mon, 17 Feb 2020 18:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581958106-16668-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/20 17:48, Qian Cai wrote:
> arch/x86/kvm/emulate.c: In function 'x86_emulate_insn':
> arch/x86/kvm/emulate.c:5686:22: error: cast between incompatible
> function types from 'int (*)(struct x86_emulate_ctxt *)' to 'void
> (*)(struct fastop *)' [-Werror=cast-function-type]
>     rc = fastop(ctxt, (fastop_t)ctxt->execute);
> 
> Fix it by using an unnamed union of a (*execute) function pointer and a
> (*fastop) function pointer.
> 
> Fixes: 3009afc6e39e ("KVM: x86: Use a typedef for fastop functions")
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: use an unnamed union.
> 
>  arch/x86/include/asm/kvm_emulate.h | 13 ++++++++++++-
>  arch/x86/kvm/emulate.c             | 36 ++++++++++++++----------------------
>  2 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
> index 03946eb3e2b9..2a8f2bd2e5cf 100644
> --- a/arch/x86/include/asm/kvm_emulate.h
> +++ b/arch/x86/include/asm/kvm_emulate.h
> @@ -292,6 +292,14 @@ enum x86emul_mode {
>  #define X86EMUL_SMM_MASK             (1 << 6)
>  #define X86EMUL_SMM_INSIDE_NMI_MASK  (1 << 7)
>  
> +/*
> + * fastop functions are declared as taking a never-defined fastop parameter,
> + * so they can't be called from C directly.
> + */
> +struct fastop;
> +
> +typedef void (*fastop_t)(struct fastop *);
> +
>  struct x86_emulate_ctxt {
>  	const struct x86_emulate_ops *ops;
>  
> @@ -324,7 +332,10 @@ struct x86_emulate_ctxt {
>  	struct operand src;
>  	struct operand src2;
>  	struct operand dst;
> -	int (*execute)(struct x86_emulate_ctxt *ctxt);
> +	union {
> +		int (*execute)(struct x86_emulate_ctxt *ctxt);
> +		fastop_t fop;
> +	};
>  	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
>  	/*
>  	 * The following six fields are cleared together,
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index ddbc61984227..dd19fb3539e0 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -191,25 +191,6 @@
>  #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
>  #define FASTOP_SIZE 8
>  
> -/*
> - * fastop functions have a special calling convention:
> - *
> - * dst:    rax        (in/out)
> - * src:    rdx        (in/out)
> - * src2:   rcx        (in)
> - * flags:  rflags     (in/out)
> - * ex:     rsi        (in:fastop pointer, out:zero if exception)
> - *
> - * Moreover, they are all exactly FASTOP_SIZE bytes long, so functions for
> - * different operand sizes can be reached by calculation, rather than a jump
> - * table (which would be bigger than the code).
> - *
> - * fastop functions are declared as taking a never-defined fastop parameter,
> - * so they can't be called from C directly.
> - */
> -
> -struct fastop;
> -
>  struct opcode {
>  	u64 flags : 56;
>  	u64 intercept : 8;
> @@ -311,8 +292,19 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
>  #define ON64(x)
>  #endif
>  
> -typedef void (*fastop_t)(struct fastop *);
> -
> +/*
> + * fastop functions have a special calling convention:
> + *
> + * dst:    rax        (in/out)
> + * src:    rdx        (in/out)
> + * src2:   rcx        (in)
> + * flags:  rflags     (in/out)
> + * ex:     rsi        (in:fastop pointer, out:zero if exception)
> + *
> + * Moreover, they are all exactly FASTOP_SIZE bytes long, so functions for
> + * different operand sizes can be reached by calculation, rather than a jump
> + * table (which would be bigger than the code).
> + */
>  static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
>  
>  #define __FOP_FUNC(name) \
> @@ -5683,7 +5675,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
>  
>  	if (ctxt->execute) {
>  		if (ctxt->d & Fastop)
> -			rc = fastop(ctxt, (fastop_t)ctxt->execute);
> +			rc = fastop(ctxt, ctxt->fop);
>  		else
>  			rc = ctxt->execute(ctxt);
>  		if (rc != X86EMUL_CONTINUE)
> 

Queued, thank you very much.

Paolo

