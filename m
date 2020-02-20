Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B306C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E54207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBTIku convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:40:50 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbgBTIkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:40:49 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id E18444B4BD356A59F3C6;
        Thu, 20 Feb 2020 16:40:37 +0800 (CST)
Received: from dggeme751-chm.china.huawei.com (10.3.19.97) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Feb 2020 16:40:37 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 20 Feb 2020 16:40:36 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1713.004;
 Thu, 20 Feb 2020 16:40:36 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>
CC:     Liran Alon <liran.alon@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH][resend] KVM: fix error handling in svm_cpu_init
Thread-Topic: [PATCH][resend] KVM: fix error handling in svm_cpu_init
Thread-Index: AdXnyIf8QCn2ngYdSyKWLfuyXd13zw==
Date:   Thu, 20 Feb 2020 08:40:36 +0000
Message-ID: <b7a41c2ec0e644119180ba61d10ab4b9@huawei.com>
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

Li,Rongqing <lirongqing@baidu.com> writes:
>> Hi,
>> Li RongQing <lirongqing@baidu.com> writes:
>> >
>> >sd->save_area should be freed in error path
>> Oh, it's strange. This is already fixed in my previous patch : [PATCH v2] KVM:
>> SVM: Fix potential memory leak in svm_cpu_init().
>> And Vitaly and Liran gave me Reviewed-by tags and Paolo queued it one 
>> month ago. But I can't found it in master or queue branch. There might 
>> be something wrong. :(
>
>In fact, I send this patch 2019/02/, and get Reviewed-by,  but did not queue
>
>https://patchwork.kernel.org/patch/10853973/
>
>and resend it 2019/07
>
>https://patchwork.kernel.org/patch/11032081/
>

Oh, it's really a pit. And in this case, we can get rid of the var r as '-ENOMEM' is actually the only possible outcome here, as
suggested by Vitaly, which looks like this: https://lkml.org/lkml/2020/1/15/933
Thanks. :)

