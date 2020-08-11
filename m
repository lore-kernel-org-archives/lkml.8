Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C4EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8A82075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgHKLyc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:54:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728663AbgHKLyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:54:31 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id ED2C23C5DDC4E34D64B4;
        Tue, 11 Aug 2020 19:54:28 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 11 Aug 2020 19:54:28 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Tue, 11 Aug 2020 19:54:28 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Florian Westphal <fw@strlen.de>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pshelar@ovn.org" <pshelar@ovn.org>,
        "martin.varghese@nokia.com" <martin.varghese@nokia.com>,
        "dcaratti@redhat.com" <dcaratti@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "shmulik@metanetworks.com" <shmulik@metanetworks.com>,
        "kyk.segfault@gmail.com" <kyk.segfault@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: eliminate meaningless memcpy to data in
 pskb_carve_inside_nonlinear()
Thread-Topic: [PATCH] net: eliminate meaningless memcpy to data in
 pskb_carve_inside_nonlinear()
Thread-Index: AdZv1br+L6bqa4jMT5W4+rGy9yynuw==
Date:   Tue, 11 Aug 2020 11:54:28 +0000
Message-ID: <4916edcf633b4f3290d8fde26167805c@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.252]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
>Miaohe Lin <linmiaohe@huawei.com> wrote:
>> The skb_shared_info part of the data is assigned in the following loop.
>
>Where?
>

It's at the below for (i = 0; i < nfrags; i++) loop. But I missed something as Eric Dumazet pointed out.
Sorry about it.

