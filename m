Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8D3C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DC62087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1UrTbEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgBDQJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:09:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727297AbgBDQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580832578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YYcsiG17pzIghdQ6UseEA9aCS5seLdWvZ4aLxJRrky0=;
        b=P1UrTbEr7zrFL6XUrofWMNefhrCq1LEbbtyYUHP/OPyj3WNgKFZVfx5eIcvWRS9Op1MWOr
        HbcIxZUhK2JF/lPEKbgIpildFqbts+WZL4ysJwaRRzwvJlONg2dhARJMjnI7PLDOnowKvf
        fTU8QcFc+a0KxNZATm9OQp443pYYbkE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-QH011Ee7O62m8VxH3_86yQ-1; Tue, 04 Feb 2020 11:09:37 -0500
X-MC-Unique: QH011Ee7O62m8VxH3_86yQ-1
Received: by mail-wm1-f69.google.com with SMTP id a10so1469339wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 08:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YYcsiG17pzIghdQ6UseEA9aCS5seLdWvZ4aLxJRrky0=;
        b=l17FXYNd1sU/Xq4PCgFS4yaLOJGQp6PSjkiNujEYfZm/tpOHPG6zfoxng01gmwwe1l
         yziUbGYj1MkWyleeDQeB0RVubfXO1f6+0o/EeWArKNuPDLR6Gg78U9PgJ3PAfUDpN3x5
         vntC8h+ZARpCZX+utMOOGQfAv4lamCZAU9ocfe2DC6anjUKJI38c8lYGfoUF/fKXdm/1
         tuF5CdCtsF6IKedpG8XDi9ISuzh7XlKJ/XcpKyaKFLa8M5g8IEJsnKd7AVjoqzjNRvDG
         AIpy+kgys8krH5Q9S2a4LWv44N58x4MPLUPmHNVtGGjWXrR4P8cyc8ksIJxi8fkJQYVz
         GCCw==
X-Gm-Message-State: APjAAAU54u6i7sV+EAgHkS3xvjnPYjxYWcgtwxrTq5hBm/G7dt01v7Cr
        64bodDRxS2EMmQ2fncZX6CpH3A43huTagraSXvR1qUaHWAHvwinwggSXkh0mYQQem7uVaUesFN/
        cWsyHFLm1Lzq/disCB2FaDKmn
X-Received: by 2002:adf:de86:: with SMTP id w6mr24141596wrl.115.1580832575983;
        Tue, 04 Feb 2020 08:09:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpiUuo8DCUuI4HehnezJgwBrHQmTtGUJ/5QoB6unQFb/BNtXiX8CI3ee9lbnNFv9gHgkwF/w==
X-Received: by 2002:adf:de86:: with SMTP id w6mr24141579wrl.115.1580832575791;
        Tue, 04 Feb 2020 08:09:35 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o189sm4499098wme.1.2020.02.04.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:09:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com,
        eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Subject: Re: [PATCH v3 3/3] selftests: KVM: SVM: Add vmcall test
In-Reply-To: <20200204150040.2465-4-eric.auger@redhat.com>
References: <20200204150040.2465-1-eric.auger@redhat.com> <20200204150040.2465-4-eric.auger@redhat.com>
Date:   Tue, 04 Feb 2020 17:09:34 +0100
Message-ID: <87lfpimj0h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Auger <eric.auger@redhat.com> writes:

> L2 guest calls vmcall and L1 checks the exit status does
> correspond.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> ---
>
> v2 -> v3:
> - remove useless comment and add Vitaly's R-b
> ---
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  .../selftests/kvm/x86_64/svm_vmcall_test.c    | 85 +++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 2e770f554cae..b529d3b42c02 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -26,6 +26,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_dirty_log_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xss_msr_test
> +TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>  TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
>  TEST_GEN_PROGS_x86_64 += dirty_log_test
>  TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
> new file mode 100644
> index 000000000000..33cc26b57a73
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * svm_vmcall_test
> + *
> + * Copyright (C) 2020, Red Hat, Inc.
> + *
> + * Nested SVM testing: VMCALL
> + */
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "svm_util.h"
> +

I don't think ...

> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "kselftest.h"
> +#include <linux/kernel.h>

... you need these.

> +
> +#define VCPU_ID		5
> +
> +static struct kvm_vm *vm;
> +
> +static inline void l2_vmcall(struct svm_test_data *svm)
> +{
> +	__asm__ __volatile__("vmcall");
> +}
> +
> +static void l1_guest_code(struct svm_test_data *svm)
> +{
> +	#define L2_GUEST_STACK_SIZE 64
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	struct vmcb *vmcb = svm->vmcb;
> +
> +	/* Prepare for L2 execution. */
> +	generic_svm_setup(svm, l2_vmcall,
> +			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +
> +	run_guest(vmcb, svm->vmcb_gpa);
> +
> +	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
> +	GUEST_DONE();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	vm_vaddr_t svm_gva;
> +
> +	nested_svm_check_supported();
> +
> +	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
> +	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
> +
> +	vcpu_alloc_svm(vm, &svm_gva);
> +	vcpu_args_set(vm, VCPU_ID, 1, svm_gva);
> +
> +	for (;;) {
> +		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
> +		struct ucall uc;
> +
> +		vcpu_run(vm, VCPU_ID);
> +		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> +			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
> +			    run->exit_reason,
> +			    exit_reason_str(run->exit_reason));
> +
> +		switch (get_ucall(vm, VCPU_ID, &uc)) {
> +		case UCALL_ABORT:
> +			TEST_ASSERT(false, "%s",
> +				    (const char *)uc.args[0]);
> +			/* NOT REACHED */
> +		case UCALL_SYNC:
> +			break;
> +		case UCALL_DONE:
> +			goto done;
> +		default:
> +			TEST_ASSERT(false,
> +				    "Unknown ucall 0x%x.", uc.cmd);
> +		}
> +	}
> +done:
> +	kvm_vm_free(vm);
> +	return 0;
> +}

Apart from the above,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

