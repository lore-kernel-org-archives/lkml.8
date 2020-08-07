Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B98C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9C322CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgHGJsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:48:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbgHGJsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:48:20 -0400
Received: from dggeme753-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 1D1447EF67A8C1F22133;
        Fri,  7 Aug 2020 17:48:17 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme753-chm.china.huawei.com (10.3.19.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 7 Aug 2020 17:48:16 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Fri, 7 Aug 2020 17:48:16 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC:     David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        "jeremy@azazel.net" <jeremy@azazel.net>,
        "mashirle@us.ibm.com" <mashirle@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] net: Fix potential deadloop in skb_copy_ubufs()
Thread-Topic: [PATCH 1/5] net: Fix potential deadloop in skb_copy_ubufs()
Thread-Index: AdZsk0FUblfXiml3Sou5xssb6jkOcA==
Date:   Fri, 7 Aug 2020 09:48:16 +0000
Message-ID: <5ee80f4677884c0dace60bb63646a987@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.143]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2lsbGVtIGRlIEJydWlqbiA8d2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6
DQo+T24gVGh1LCBBdWcgNiwgMjAyMCBhdCAxOjQ4IFBNIGxpbm1pYW9oZSA8bGlubWlhb2hlQGh1
YXdlaS5jb20+IHdyb3RlOg0KPj4NCj4+IEZyb206IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3
ZWkuY29tPg0KPj4NCj4+IFdlIGNvdWxkIGJlIHRyYXBwZWQgaW4gZGVhZGxvb3Agd2hlbiB3ZSB0
cnkgdG8gY29weSB1c2Vyc3BhY2Ugc2tiIA0KPj4gZnJhZ3MgYnVmZmVycyB0byBrZXJuZWwgd2l0
aCBhIGNsb25lZCBza2I6DQo+DQo+PiBDYXRjaCB0aGlzIHVuZXhwZWN0ZWQgY2FzZSBhbmQgcmV0
dXJuIC1FSU5WQUwgaW4gc2tiX29ycGhhbl9mcmFncygpIA0KPj4gYmVmb3JlIHdlIGNhbGwgc2ti
X2NvcHlfdWJ1ZnMoKSB0byBmaXggaXQuDQo+DQo+SXMgdGhpcyBhIGh5cG90aGV0aWNhbCBjb2Rl
cGF0aD8NCj4NCj5za2IgemVyb2NvcHkgY2FyZWZ1bGx5IHRyYWNrcyBjbG9uZSBjYWxscyB3aGVy
ZSBuZWNlc3NhcnkuIFNlZSB0aGUgY2FsbCB0byBza2Jfb3JwaGFuX2ZyYWdzIGluIHNrYl9jbG9u
ZSwgYW5kIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGF0IGNhbGxlZS4NCj4NCj5UaGUgb25seSBj
YWxsZXIgb2Ygc2tiIHplcm9jb3B5IHdpdGggbm91YXJnIGlzIHRwYWNrZXRfZmlsbF9za2IsIGFz
IG9mIGNvbW1pdCA1Y2Q4ZDQ2ZWExNTYgKCJwYWNrZXQ6IGNvcHkgdXNlciBidWZmZXJzIGJlZm9y
ZSBvcnBoYW4gb3IgY2xvbmUiKS4NCj4NCj5BcyB0aGUgY29tbWl0IHN1YmplY3QgaW5kaWNhdGVz
LCB0aGlzIHNldHMgc2tiX3pjb3B5X3NldF9ub3VhcmcgZXhhY3RseSB0byBiZSBzdXJlIHRoYXQg
YW55IGNsb25lIHdpbGwgdHJpZ2dlciBhIGNvcHkgb2YgInplcm9jb3B5Ig0KPnVzZXIgZGF0YSB0
byBwcml2YXRlIGtlcm5lbCBtZW1vcnkuDQo+DQo+Tm8gY2xvbmUgbXVzdCBoYXBwZW4gYmV0d2Vl
biBhbGxvY19za2IgYW5kIHNrYl96Y29weV9zZXRfbm91YXJnLCBpbmRlZWQuIEJ1dCBBRkFJSywg
bm9uZSBleGlzdHMuDQoNCk1hbnkgdGhhbmtzIGZvciB5b3VyIHJlcGx5IGFuZCBleHBsYWluYXRp
b24uIEFzIHlvdSBzYXksIHRoaXMgaXMgYSBoeXBvdGhldGljYWwgY29kZXBhdGguIFRoaXMgd291
bGQgbm90IGJlIHRyaWdnZXJkIG5vcm1hbGx5Lg0KSSBjYXRjaCB0aGlzIHN1c3BpY2lvdXMgcGF0
Y2gganVzdCBpbiBjYXNlLg0KDQo=
