Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F95C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878042087D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgHNHOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:14:44 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbgHNHOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:14:43 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 0A64FF16F2CD84232FF6;
        Fri, 14 Aug 2020 15:14:40 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 14 Aug 2020 15:14:39 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Fri, 14 Aug 2020 15:14:39 +0800
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
Thread-Index: AdZyCng8yL/EIjdPQ3Gs3ioJM4VpUQ==
Date:   Fri, 14 Aug 2020 07:14:39 +0000
Message-ID: <6e3bace9ebea4f59a567a9ab0ef85d90@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.252]
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
aCBhIGNsb25lZCBza2I6DQo+PiBSZXByb2R1Y2UgY29kZSBzbmlwcGV0Og0KPj4gICAgICAgICBz
a2IgPSBhbGxvY19za2IoVUJVRl9EQVRBX0xFTiwgR0ZQX0FUT01JQyk7DQo+PiAgICAgICAgIGNs
b25lID0gc2tiX2Nsb25lKHNrYiwgR0ZQX0FUT01JQyk7DQo+PiAgICAgICAgIHNrYl96Y29weV9z
ZXRfbm91YXJnKGNsb25lLCBOVUxMKTsNCj4+ICAgICAgICAgcHNrYl9leHBhbmRfaGVhZChza2Is
IDAsIDAsIEdGUF9BVE9NSUMpOw0KPj4NCj4+IENhdGNoIHRoaXMgdW5leHBlY3RlZCBjYXNlIGFu
ZCByZXR1cm4gLUVJTlZBTCBpbiBza2Jfb3JwaGFuX2ZyYWdzKCkgDQo+PiBiZWZvcmUgd2UgY2Fs
bCBza2JfY29weV91YnVmcygpIHRvIGZpeCBpdC4NCj4NCj5JcyB0aGlzIGEgaHlwb3RoZXRpY2Fs
IGNvZGVwYXRoPw0KPg0KPnNrYiB6ZXJvY29weSBjYXJlZnVsbHkgdHJhY2tzIGNsb25lIGNhbGxz
IHdoZXJlIG5lY2Vzc2FyeS4gU2VlIHRoZSBjYWxsIHRvIHNrYl9vcnBoYW5fZnJhZ3MgaW4gc2ti
X2Nsb25lLCBhbmQgdGhlIGltcGxlbWVudGF0aW9uIG9mIHRoYXQgY2FsbGVlLg0KPg0KPlRoZSBv
bmx5IGNhbGxlciBvZiBza2IgemVyb2NvcHkgd2l0aCBub3VhcmcgaXMgdHBhY2tldF9maWxsX3Nr
YiwgYXMgb2YgY29tbWl0IDVjZDhkNDZlYTE1NiAoInBhY2tldDogY29weSB1c2VyIGJ1ZmZlcnMg
YmVmb3JlIG9ycGhhbiBvciBjbG9uZSIpLg0KPg0KPkFzIHRoZSBjb21taXQgc3ViamVjdCBpbmRp
Y2F0ZXMsIHRoaXMgc2V0cyBza2JfemNvcHlfc2V0X25vdWFyZyBleGFjdGx5IHRvIGJlIHN1cmUg
dGhhdCBhbnkgY2xvbmUgd2lsbCB0cmlnZ2VyIGEgY29weSBvZiAiemVyb2NvcHkiDQo+dXNlciBk
YXRhIHRvIHByaXZhdGUga2VybmVsIG1lbW9yeS4NCj4NCj5ObyBjbG9uZSBtdXN0IGhhcHBlbiBi
ZXR3ZWVuIGFsbG9jX3NrYiBhbmQgc2tiX3pjb3B5X3NldF9ub3VhcmcsIGluZGVlZC4gQnV0IEFG
QUlLLCBub25lIGV4aXN0cy4NCg0KU2luY2Ugd2UgYWx3YXlzIGNhbGwgc2tiX29ycGhhbl9mcmFn
cyBpbiBza2JfY2xvbmUsIGlzIGl0IHVubmVjZXNzYXJ5IHRvIGNhbGwgc2tiX29ycGhhbl9mcmFn
cyBpbiBwc2tiX2V4cGFuZF9oZWFkIHdoZW4gc2tiIGlzIGNsb25lZCA/DQoNClRoYW5rcy4NCg0K
