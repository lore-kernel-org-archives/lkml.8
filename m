Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B276C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08A420722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgBUBgf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:36:35 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728992AbgBUBge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:36:34 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id E59ABF4BD2F240CF04C;
        Fri, 21 Feb 2020 09:36:31 +0800 (CST)
Received: from dggeme701-chm.china.huawei.com (10.1.199.97) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Feb 2020 09:36:31 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 21 Feb 2020 09:36:31 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1713.004;
 Fri, 21 Feb 2020 09:36:31 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: apic: avoid calculating pending eoi from an
 uninitialized val
Thread-Topic: [PATCH] KVM: apic: avoid calculating pending eoi from an
 uninitialized val
Thread-Index: AdXoVrOxSS/7U36ORtuu/no+ULXV5A==
Date:   Fri, 21 Feb 2020 01:36:31 +0000
Message-ID: <776348e8d2b844068bbe23ce67d23f7a@huawei.com>
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

Sean Christopherson <sean.j.christopherson@intel.com> wrote:
>On Thu, Feb 20, 2020 at 05:33:17PM +0100, Vitaly Kuznetsov wrote:
>> linmiaohe <linmiaohe@huawei.com> writes:
>> 
>
>Rather than initialize @val, I'd prefer to explicitly handle the error, similar to pv_eoi_clr_pending() and pv_eoi_set_pending(), e.g.
>
>	u8 val;
>
>	if (pv_eoi_get_user(vcpu, &val) < 0) {
>		printk(KERN_WARNING "Can't read EOI MSR value: 0x%llx\n",
>			   (unsigned long long)vcpu->arch.pv_eoi.msr_val);
>		return false;
>	}
>	return val & 0x1;

Looks good. Handle the error explicitly can help remind us @val is unusable.
Will do. Thanks.

>> >  	if (pv_eoi_get_user(vcpu, &val) < 0)
>> >  		printk(KERN_WARNING "Can't read EOI MSR value: 0x%llx\n",
>> >  			   (unsigned long long)vcpu->arch.pv_eoi.msr_val);
>> 
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
>> But why compilers don't complain?
>
>Clang might?
>
