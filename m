Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A9C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445A220848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgCEBw3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:52:29 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgCEBw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:52:28 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 296861E86DF980566391;
        Thu,  5 Mar 2020 09:52:26 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 09:52:25 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme753-chm.china.huawei.com (10.3.19.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 5 Mar 2020 09:52:25 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1713.004;
 Thu, 5 Mar 2020 09:52:25 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: Drop gfn_to_pfn_atomic()
Thread-Topic: [PATCH] KVM: Drop gfn_to_pfn_atomic()
Thread-Index: AdXykEMnQW+cQIFEXkipsf44zrPEIQ==
Date:   Thu, 5 Mar 2020 01:52:24 +0000
Message-ID: <2256821e496c45f5baf97f3f8f884d59@huawei.com>
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

Peter Xu <peterx@redhat.com> writes:
>It's never used anywhere now.
>
>Signed-off-by: Peter Xu <peterx@redhat.com>
>---
> include/linux/kvm_host.h | 1 -
> virt/kvm/kvm_main.c      | 6 ------
> 2 files changed, 7 deletions(-)

It seems we prefer to use kvm_vcpu_gfn_to_pfn_atomic instead now. :)
Patch looks good, but maybe we should update Documentation/virt/kvm/locking.rst too:
In locking.rst:
	For direct sp, we can easily avoid it since the spte of direct sp is fixed
	to gfn. For indirect sp, before we do cmpxchg, we call gfn_to_pfn_atomic()
	to pin gfn to pfn, because after gfn_to_pfn_atomic()

Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

