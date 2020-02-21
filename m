Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6694C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CD7208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBUGf7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:35:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgBUGf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:35:59 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 8CF9F309D89E45DD523F;
        Fri, 21 Feb 2020 14:35:51 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Feb 2020 14:35:50 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme753-chm.china.huawei.com (10.3.19.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 21 Feb 2020 14:35:50 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1713.004;
 Fri, 21 Feb 2020 14:35:50 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] KVM: VMX: Use vpid_sync_context() directly when
 possible
Thread-Topic: [PATCH 01/10] KVM: VMX: Use vpid_sync_context() directly when
 possible
Thread-Index: AdXogPOkawpbwJXN5EmRFC50KCVcoA==
Date:   Fri, 21 Feb 2020 06:35:50 +0000
Message-ID: <8e41f02ef7a54af19848efe572652248@huawei.com>
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

Sean Christopherson <sean.j.christopherson@intel.com> writes:
>Use vpid_sync_context() directly for flows that run if and only if enable_vpid=1, or more specifically, nested VMX flows that are gated by
>vmx->nested.msrs.secondary_ctls_high.SECONDARY_EXEC_ENABLE_VPID being
>set, which is allowed if and only if enable_vpid=1.  Because these flows call __vmx_flush_tlb() with @invalidate_gpa=false, the if-statement that decides between INVEPT and >INVVPID will always go down the INVVPID path, i.e. call vpid_sync_context() because "enable_ept && (invalidate_gpa || !enable_vpid)" always evaluates false.
>
>This helps pave the way toward removing @invalidate_gpa and @vpid from
>__vmx_flush_tlb() and its callers.
>
>No functional change intended.
>
>Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

