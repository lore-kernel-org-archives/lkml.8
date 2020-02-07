Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2865CC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD78520715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFRZWWe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGOHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:07:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51670 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgBGOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581084425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjE0doL/Kljl7VVADzKbj9EuYEFZUKU2QlpS/aF4JRs=;
        b=JFRZWWe2aMLb3XgGwvj2NfOXT1+NNciStshJ29TF5I6cude89dwC6663MbKhWJME6lENNZ
        HUoJV9fGdEUaczN5NOi8/Qu89/8hY9FRcRURMxjTRgXvmHxHkbfVugI1TzBLLqw4FIgHsh
        nPhvEV/9t/8VVZVpwK7+SUHdHev2xig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-g0fQTHegOQmfdo9L58BH7w-1; Fri, 07 Feb 2020 09:07:03 -0500
X-MC-Unique: g0fQTHegOQmfdo9L58BH7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 725D4133656D;
        Fri,  7 Feb 2020 14:07:02 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 520A360BEC;
        Fri,  7 Feb 2020 14:06:57 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v4 3/3] selftests: KVM: SVM: Add vmcall test
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com
References: <20200206104710.16077-1-eric.auger@redhat.com>
 <20200206104710.16077-4-eric.auger@redhat.com>
 <2469b52e-9f66-b19b-7269-297dbbd0ca27@oracle.com>
Message-ID: <7ddf3ab7-ef24-0450-8084-e82435f62b5e@redhat.com>
Date:   Fri, 7 Feb 2020 15:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2469b52e-9f66-b19b-7269-297dbbd0ca27@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krish,

On 2/6/20 11:46 PM, Krish Sadhukhan wrote:
>=20
>=20
> On 02/06/2020 02:47 AM, Eric Auger wrote:
>> L2 guest calls vmcall and L1 checks the exit status does
>> correspond.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>>
>> ---
>>
>> v3 -> v4:
>> - remove useless includes
>> - collected Lin's R-b
>>
>> v2 -> v3:
>> - remove useless comment and add Vitaly's R-b
>> ---
>> =C2=A0 tools/testing/selftests/kvm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 .../selftests/kvm/x86_64/svm_vmcall_test.c=C2=A0=C2=A0=C2=A0 | =
79 +++++++++++++++++++
>> =C2=A0 2 files changed, 80 insertions(+)
>> =C2=A0 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_vmcal=
l_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile
>> b/tools/testing/selftests/kvm/Makefile
>> index 2e770f554cae..b529d3b42c02 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -26,6 +26,7 @@ TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_dirty_log_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_set_nested_state_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_tsc_adjust_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D x86_64/xss_msr_test
>> +TEST_GEN_PROGS_x86_64 +=3D x86_64/svm_vmcall_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D clear_dirty_log_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D dirty_log_test
>> =C2=A0 TEST_GEN_PROGS_x86_64 +=3D kvm_create_max_vcpus
>> diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
>> b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
>> new file mode 100644
>> index 000000000000..6d3565aab94e
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
>> @@ -0,0 +1,79 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * svm_vmcall_test
>> + *
>> + * Copyright (C) 2020, Red Hat, Inc.
>> + *
>> + * Nested SVM testing: VMCALL
>> + */
>> +
>> +#include "test_util.h"
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +#include "svm_util.h"
>> +
>> +#define VCPU_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5
>> +
>> +static struct kvm_vm *vm;
>> +
>> +static inline void l2_vmcall(struct svm_test_data *svm)
>> +{
>> +=C2=A0=C2=A0=C2=A0 __asm__ __volatile__("vmcall");
> Is it possible to re-use the existing vmcall() function ?
well the function is declared in vmx header. Also vmx_tsc_adjust_test
does not use it for instance. For this test the above is simple and does
the job.

> Also, we should probably re-name the function to 'l2_guest_code' which
> is used in the existing code and also it matches with 'l1_guest_code'
> naming.
OK
>> +}
>> +
>> +static void l1_guest_code(struct svm_test_data *svm)
>> +{
>> +=C2=A0=C2=A0=C2=A0 #define L2_GUEST_STACK_SIZE 64
>> +=C2=A0=C2=A0=C2=A0 unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
>> +=C2=A0=C2=A0=C2=A0 struct vmcb *vmcb =3D svm->vmcb;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Prepare for L2 execution. */
>> +=C2=A0=C2=A0=C2=A0 generic_svm_setup(svm, l2_vmcall,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &l2_guest_stack[L2_GUEST_STACK_SIZE]);
>> +
>> +=C2=A0=C2=A0=C2=A0 run_guest(vmcb, svm->vmcb_gpa);
>> +
>> +=C2=A0=C2=A0=C2=A0 GUEST_ASSERT(vmcb->control.exit_code =3D=3D SVM_EX=
IT_VMMCALL);
>> +=C2=A0=C2=A0=C2=A0 GUEST_DONE();
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +=C2=A0=C2=A0=C2=A0 vm_vaddr_t svm_gva;
>> +
>> +=C2=A0=C2=A0=C2=A0 nested_svm_check_supported();
>> +
>> +=C2=A0=C2=A0=C2=A0 vm =3D vm_create_default(VCPU_ID, 0, (void *) l1_g=
uest_code);
>> +=C2=A0=C2=A0=C2=A0 vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpui=
d());
>> +
>> +=C2=A0=C2=A0=C2=A0 vcpu_alloc_svm(vm, &svm_gva);
>> +=C2=A0=C2=A0=C2=A0 vcpu_args_set(vm, VCPU_ID, 1, svm_gva);
>> +
>> +=C2=A0=C2=A0=C2=A0 for (;;) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 volatile struct kvm_run *r=
un =3D vcpu_state(vm, VCPU_ID);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ucall uc;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu_run(vm, VCPU_ID);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_ASSERT(run->exit_reas=
on =3D=3D KVM_EXIT_IO,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n"=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 run->exit_reason,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 exit_reason_str(run->exit_reason));
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (get_ucall(vm, VCPU=
_ID, &uc)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case UCALL_ABORT:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TE=
ST_ASSERT(false, "%s",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (const char *)uc.args[0]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 NOT REACHED */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case UCALL_SYNC:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case UCALL_DONE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to done;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TE=
ST_ASSERT(false,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Unknown ucall 0x%x.", uc.c=
md);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +done:
>> +=C2=A0=C2=A0=C2=A0 kvm_vm_free(vm);
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>=20
Thanks

Eric

