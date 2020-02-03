Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B77C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8926C20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTdQmaaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgBCJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:44:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23060 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726653AbgBCJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580723086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8lPnHaheFWGl2YTbG1NopUSDMIBfXgmeIW560W2LqE=;
        b=BTdQmaaH8UVKPJx0YnkfCK6BGhQf9CLvH6uqS8j/NJ7Uu9dxe4xG54eZflcgVEqdcdrB9w
        OgqBXgrqOhGEwNROD9LuU54LvRX2HyELmaqIXCuZl/hlSoqdiGJg2KxvNohruQiOY+qDDE
        SGzmu6LfVaocQTgALIfs8g0TOZ6rwpo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-AcYkQ24iNPCMsJBa1uZn0g-1; Mon, 03 Feb 2020 04:44:45 -0500
X-MC-Unique: AcYkQ24iNPCMsJBa1uZn0g-1
Received: by mail-wr1-f69.google.com with SMTP id z15so8007173wrw.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 01:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=U8lPnHaheFWGl2YTbG1NopUSDMIBfXgmeIW560W2LqE=;
        b=G9qaTpTkaahW/0t0UfPNV5G2KaQSd7n94fXD64knSSaRMBX3stldxJUdxFm7DzvtUE
         Y+FIzfGTRryiCFVvT3N6qL/HOxzPZyJnqO8Nx0mGf89aFYSgW8YoPgAdbG41HmCfS1n9
         uOgyO6XDOQruCngR5rIBRl9ngwQ7nJjMEayYa8JRfVNL5/xcXKY8nSUKNmHt855WpZtr
         nwFgskMvSxS40qhjARGgJIjxbDhNj6KI/ZdlPX4hAPrl+ehDmGaxqMBDmtpBjKmFfRtt
         SfbFiy2xFxaA++4FuXYkbTHa0bC3woTvtFSwgCgrpJoVd0zkFVy4XXe1+E4YBQo7Rmsj
         YgBQ==
X-Gm-Message-State: APjAAAXoEHjepgsjY3s4PxonJrbNWXz4Of5s5XLrSg8p/BxmzRK9vxoG
        OdBHxImPTmbw9FgM4RceFdRzrnTeuvQi+MXNl53w+TJjMRjHOBnyvv1Tbdl1Qn4O4cn9PGCzY3+
        acCeuJYzkk5O1DS2CHLkj4D3v
X-Received: by 2002:a7b:c249:: with SMTP id b9mr27894125wmj.74.1580723084289;
        Mon, 03 Feb 2020 01:44:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyO8bh1f7ueCskKsZa5/93taBnFg8iWR7MUcpDD+1qcKWpN/ZTcBP1pxIsphbjgbPB7ZNKZvw==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr27894091wmj.74.1580723083992;
        Mon, 03 Feb 2020 01:44:43 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a5sm22769393wmb.37.2020.02.03.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:44:43 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com,
        eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Subject: Re: [PATCH v2 2/2] selftests: KVM: SVM: Add vmcall test
In-Reply-To: <20200203090851.19938-3-eric.auger@redhat.com>
References: <20200203090851.19938-1-eric.auger@redhat.com> <20200203090851.19938-3-eric.auger@redhat.com>
Date:   Mon, 03 Feb 2020 10:44:42 +0100
Message-ID: <875zgoovhx.fsf@vitty.brq.redhat.com>
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
> ---
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  .../selftests/kvm/x86_64/svm_vmcall_test.c    | 86 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
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
> index 000000000000..75e66f3bbbc0
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
> @@ -0,0 +1,86 @@
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
> +#include "svm.h"
> +
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "kselftest.h"
> +#include <linux/kernel.h>
> +
> +#define VCPU_ID		5
> +
> +/* The virtual machine object. */

I'm not sure this comment is any helpful, the virus is probably
spreading from vmx_close_while_nested_test.c/vmx_tsc_adjust_test.c :-)

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

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

-- 
Vitaly

