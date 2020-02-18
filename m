Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F1FC34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF55020801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgBRCM5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:12:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3013 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbgBRCM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:12:57 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id EDE149D79A4CF291A6A8;
        Tue, 18 Feb 2020 10:12:54 +0800 (CST)
Received: from dggeme765-chm.china.huawei.com (10.3.19.111) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 10:12:54 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 18 Feb 2020 10:12:54 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Tue, 18 Feb 2020 10:12:54 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Wanpeng Li <kernellwp@gmail.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 1/2] KVM: Introduce pv check helpers
Thread-Topic: [PATCH RESEND v2 1/2] KVM: Introduce pv check helpers
Thread-Index: AdXmAHn+IJnfnTTZ8EeW+4liPWUcOg==
Date:   Tue, 18 Feb 2020 02:12:54 +0000
Message-ID: <c83aaa5530724ede8036bbb2f1730d00@huawei.com>
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

Wanpeng Li <kernellwp@gmail.com> writes:
>From: Wanpeng Li <wanpengli@tencent.com>
>
>Introduce some pv check helpers for consistency.
>
>Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>---

It seems all of my Reviewed-by tags are dropped for this patch set. But as I didn't figure anything important out, it's ok. :)

