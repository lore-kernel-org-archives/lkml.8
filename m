Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C865CC35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9192071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5AEux1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAYJeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:34:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47329 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgAYJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 04:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579944860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=799m6qKMV18ggbdbpJL4lidbUmQPUZ2uqN90WWxnXDE=;
        b=S5AEux1EhbcpuBAEHkgWWnOXSjZ1S6Vgq5x6b/i0bLkzzHismxg6iPkPgUs3dCMMXUPny1
        NKrAfJ3cQcqCBZ6FDEZ1tAZ4bV5mPRkyfqRT+wYTNjRwKyaTEJhRZGRlanxwukeJGQpG4c
        M2QQ+Y6N6RDHxf3pUOTx4+fWglN9pdE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-r1YFkEsKNYeaD-v8yHZ70A-1; Sat, 25 Jan 2020 04:34:18 -0500
X-MC-Unique: r1YFkEsKNYeaD-v8yHZ70A-1
Received: by mail-wr1-f69.google.com with SMTP id b13so2719065wrx.22
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 01:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=799m6qKMV18ggbdbpJL4lidbUmQPUZ2uqN90WWxnXDE=;
        b=GexD1Dmsu7Mj8vSQlRgiKeFBH5+iNAyCEcsL1yNcDderZEhFC5AGem5JEC+/JvZozg
         cT+fT/ICqcmLFgRmAlit1ZVRTtNoqx1srUNCngUGgp1EY5f5+SNx9PB66o4/mn8Jbtc9
         eQEZssaqbvaxBufQpOqqES+cU44OqOZMNVl5JvAkki8Wnf1F9udsa3hI+DEKV/k9rAFj
         FEJ6hL3PWKqnK8qrbvMEqVhN1H3Lw8TJpgcGMl5MTgqXuaD83wO5J5uatsNlxnURvXVw
         1cWFU+8gEV7pvfdFpM28OcBARaOe3fJlkLOobxSOUjuxITmVlPGyftsjisl2IBespzYs
         fl5Q==
X-Gm-Message-State: APjAAAUPYZMZZfM1mKw+Wo3p09/e5UaL4eu3E8YqjVHn53a9AY2wZGl0
        CkUQim6NX0djz458KELnefI1i8+iA1WItugsS8NBf3qpI8+F155QZBL48eDWOnTi5PyxAUhYpM5
        0Mq5NlZibTWfW2aYxyOY5tNFe
X-Received: by 2002:adf:f308:: with SMTP id i8mr9489204wro.42.1579944857317;
        Sat, 25 Jan 2020 01:34:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzV+U0Zk/vBr3PYTOy2NS/UOEJyzbyAI9oNA0HJiFpizgJq7/yGvYaD+zj50Eu2svel6qBslw==
X-Received: by 2002:adf:f308:: with SMTP id i8mr9489175wro.42.1579944857009;
        Sat, 25 Jan 2020 01:34:17 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f16sm11253860wrm.65.2020.01.25.01.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 01:34:16 -0800 (PST)
Subject: Re: [PATCH v4 06/10] KVM: selftests: Add support for vcpu_args_set to
 aarch64 and s390x
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-7-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6061cd22-59bb-c191-bd98-f14d7cd274ae@redhat.com>
Date:   Sat, 25 Jan 2020 10:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123180436.99487-7-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/20 19:04, Ben Gardon wrote:
> Currently vcpu_args_set is only implemented for x86. This makes writing
> tests with multiple vCPUs difficult as each guest vCPU must either a.)
> do the same thing or b.) derive some kind of unique token from it's
> registers or the architecture. To simplify the process of writing tests
> with multiple vCPUs for s390 and aarch64, add set args functions for
> those architectures.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/lib/aarch64/processor.c     | 33 +++++++++++++++++
>  .../selftests/kvm/lib/s390x/processor.c       | 35 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 86036a59a668e..a2ff90a75f326 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -333,3 +333,36 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>  {
>  	aarch64_vcpu_add_default(vm, vcpuid, NULL, guest_code);
>  }
> +
> +/* VM VCPU Args Set
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - VCPU ID
> + *   num - number of arguments
> + *   ... - arguments, each of type uint64_t
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Sets the first num function input arguments to the values
> + * given as variable args.  Each of the variable args is expected to
> + * be of type uint64_t. The registers set by this function are r0-r7.
> + */
> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> +{
> +	va_list ap;
> +
> +	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
> +		    "  num: %u\n",
> +		    num);
> +
> +	va_start(ap, num);
> +
> +	for (i = 0; i < num; i++)
> +		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[num]),
> +			va_arg(ap, uint64_t));
> +
> +	va_end(ap);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 32a02360b1eb0..680f37be9dbc9 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -269,6 +269,41 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>  	run->psw_addr = (uintptr_t)guest_code;
>  }
>  
> +/* VM VCPU Args Set
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - VCPU ID
> + *   num - number of arguments
> + *   ... - arguments, each of type uint64_t
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Sets the first num function input arguments to the values
> + * given as variable args.  Each of the variable args is expected to
> + * be of type uint64_t. The registers set by this function are r2-r6.
> + */
> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> +{
> +	va_list ap;
> +	struct kvm_regs regs;
> +
> +	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
> +		    "  num: %u\n",
> +		    num);
> +
> +	va_start(ap, num);
> +	vcpu_regs_get(vm, vcpuid, &regs);
> +
> +	for (i = 0; i < num; i++)
> +		regs.gprs[i + 2] = va_arg(ap, uint64_t);
> +
> +	vcpu_regs_set(vm, vcpuid, &regs);
> +	va_end(ap);
> +}
> +
>  void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
>  {
>  	struct vcpu *vcpu = vm->vcpu_head;
> 

Squashing this:

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index a2ff90a75f32..839a76c96f01 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -353,6 +353,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 {
 	va_list ap;
+	int i;
 
 	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
 		    "  num: %u\n",
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 680f37be9dbc..a0b84235c848 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -289,6 +289,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 {
 	va_list ap;
 	struct kvm_regs regs;
+	int i;
 
 	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
 		    "  num: %u\n",

Paolo

