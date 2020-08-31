Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF306C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34D12076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHaBZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:25:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbgHaBZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:25:56 -0400
Received: from dggeme704-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id BFDD2B36FDBE82421A6E;
        Mon, 31 Aug 2020 09:25:54 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme704-chm.china.huawei.com (10.1.199.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 31 Aug 2020 09:25:54 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 31 Aug 2020 09:25:54 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     David Ahern <dsahern@gmail.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipv4: remove unused arg exact_dif in compute_score
Thread-Topic: [PATCH] net: ipv4: remove unused arg exact_dif in compute_score
Thread-Index: AdZ/NXnw82ZyWQToPkuXI0Hgq8w2zQ==
Date:   Mon, 31 Aug 2020 01:25:54 +0000
Message-ID: <7244626ca1494044bdd44c8269cfda91@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.74]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGF2aWQgQWhlcm4gPGRzYWhlcm5AZ21haWwuY29tPiB3cm90ZToNCj5PbiA4LzI5LzIwIDM6MDEg
QU0sIE1pYW9oZSBMaW4gd3JvdGU6DQo+PiBAQCAtMjc3LDE1ICsyNzcsMTMgQEAgc3RhdGljIHN0
cnVjdCBzb2NrICppbmV0X2xoYXNoMl9sb29rdXAoc3RydWN0IG5ldCAqbmV0LA0KPj4gIAkJCQlj
b25zdCBfX2JlMzIgZGFkZHIsIGNvbnN0IHVuc2lnbmVkIHNob3J0IGhudW0sDQo+PiAgCQkJCWNv
bnN0IGludCBkaWYsIGNvbnN0IGludCBzZGlmKQ0KPj4gIHsNCj4+IC0JYm9vbCBleGFjdF9kaWYg
PSBpbmV0X2V4YWN0X2RpZl9tYXRjaChuZXQsIHNrYik7DQo+DQo+aW5ldF9leGFjdF9kaWZfbWF0
Y2ggaXMgbm8gbG9uZ2VyIG5lZWRlZCBhZnRlciB0aGUgYWJvdmUgaXMgcmVtb3ZlZC4NCg0KT2gs
IEkgbWlzc2VkIGl0LiBXaWxsIHJlbW92ZSBpbmV0X2V4YWN0X2RpZl9tYXRjaCgpIGluIHYyLiBN
YW55IHRoYW5rcyBmb3IgcmV2aWV3IGFuZCByZXBseS4NCg0K
