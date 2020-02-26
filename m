Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113A1C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC6B21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgBZDUh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:20:37 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729618AbgBZDUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:20:37 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 07EDB3C5C916C980CE03;
        Wed, 26 Feb 2020 11:20:34 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 11:20:33 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme753-chm.china.huawei.com (10.3.19.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 26 Feb 2020 11:20:33 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1713.004;
 Wed, 26 Feb 2020 11:20:33 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: X86: avoid meaningless kvm_apicv_activated() check
Thread-Topic: [PATCH] KVM: X86: avoid meaningless kvm_apicv_activated() check
Thread-Index: AdXsTYQADvvEvYWnS0muVSd7lZBEtQ==
Date:   Wed, 26 Feb 2020 03:20:33 +0000
Message-ID: <5d633c81d24d40aa848e1605eb0df857@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>linmiaohe <linmiaohe@huawei.com> writes:
>
>> From: Miaohe Lin <linmiaohe@huawei.com>
>>
>> After test_and_set_bit() for kvm->arch.apicv_inhibit_reasons, we will 
>> always get false when calling kvm_apicv_activated() because it's sure 
>> apicv_inhibit_reasons do not equal to 0.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  arch/x86/kvm/x86.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c index 
>> ddcc51b89e2c..fa62dcb0ed0c 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -8018,8 +8018,7 @@ void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
>>  		    !kvm_apicv_activated(kvm))
>>  			return;
>>  	} else {
>> -		if (test_and_set_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
>> -		    kvm_apicv_activated(kvm))
>> +		if (test_and_set_bit(bit, &kvm->arch.apicv_inhibit_reasons))
>>  			return;
>>  	}
>
>This seems to be correct in a sense that we are not really protected against concurrent modifications of 'apicv_inhibit_reasons' (like what if 'apicv_inhibit_reasons' gets modified right after we've checked 'kvm_apicv_activated(kvm)').

Yes, there might be a race window. But this looks benign as we recalculate kvm_apicv_activated() when we proceed with KVM_REQ_APICV_UPDATE.

>
>The function, however, still gives a flase impression it is somewhat protected against concurent modifications. Like what are these
>test_and_{set,clear}_bit() for?

Yes, I think so too. And also test_and_{set,clear}_bit() checks wheather the requested bit is {set,clear} to the requested state.

>
>If I'm not mistaken, the logic this function was supposed to implement
>is: change the requested bit to the requested state and, if
>kvm_apicv_activated() changed (we set the first bit or cleared the last), proceed with KVM_REQ_APICV_UPDATE. What if we re-write it like
>
>diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c index 2103101eca78..b97b8ff4a789 100644
>--- a/arch/x86/kvm/x86.c
>+++ b/arch/x86/kvm/x86.c
>@@ -8027,19 +8027,19 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_update_apicv);
>  */
> void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)  {
>+       bool apicv_was_activated = kvm_apicv_activated(kvm);
>+
>        if (!kvm_x86_ops->check_apicv_inhibit_reasons ||
>            !kvm_x86_ops->check_apicv_inhibit_reasons(bit))
>                return;
> 
>-       if (activate) {
>-               if (!test_and_clear_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
>-                   !kvm_apicv_activated(kvm))
>-                       return;
>-       } else {
>-               if (test_and_set_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
>-                   kvm_apicv_activated(kvm))
>-                       return;
>-       }
>+       if (activate)
>+               clear_bit(bit, &kvm->arch.apicv_inhibit_reasons);
>+       else
>+               set_bit(bit, &kvm->arch.apicv_inhibit_reasons);
>+
>+       if (kvm_apicv_activated(kvm) == apicv_was_activated)
>+               return;
> 
>        trace_kvm_apicv_update_request(activate, bit);
>        if (kvm_x86_ops->pre_update_apicv_exec_ctrl)
>
>Is this equal?
>

Looks good. I think this version also improves the readability. Many thanks for your advice and review!

