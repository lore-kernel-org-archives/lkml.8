Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E766C35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFCC2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgBXCJC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:09:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbgBXCJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:09:01 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 6E29B3A5C5539C6DDB98;
        Mon, 24 Feb 2020 10:08:58 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Feb 2020 10:08:58 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 24 Feb 2020 10:08:57 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1713.004;
 Mon, 24 Feb 2020 10:08:57 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     "Li,Rongqing" <lirongqing@baidu.com>,
        Liran Alon <liran.alon@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH][resend] KVM: fix error handling in svm_cpu_init
Thread-Topic: [PATCH][resend] KVM: fix error handling in svm_cpu_init
Thread-Index: AdXqtZiitTjZQBMTS8OADZt95RUhGA==
Date:   Mon, 24 Feb 2020 02:08:57 +0000
Message-ID: <fa876a68c7664dac85ba91d33ec16a78@huawei.com>
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

Paolo Bonzini <pbonzini@redhat.com> wrote:
>On 20/02/20 09:40, linmiaohe wrote:
>> Li,Rongqing <lirongqing@baidu.com> writes:
>>>> Hi,
>>>> Li RongQing <lirongqing@baidu.com> writes:
>>>>>
>> 
>> Oh, it's really a pit. And in this case, we can get rid of the var r 
>> as '-ENOMEM' is actually the only possible outcome here, as suggested 
>> by Vitaly, which looks like this: https://lkml.org/lkml/2020/1/15/933
>
>I queued your patch again, sorry to both of you.
>

There are tons of patches every day. It's really hard to escape from forgetting someone. :)
Many thanks for your great work all the time!

