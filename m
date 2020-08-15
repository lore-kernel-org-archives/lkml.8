Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5E2C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 02:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACFA20675
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgHPCSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 22:18:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbgHPCSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 22:18:43 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 028F7DC27C6FD4B9E471;
        Sat, 15 Aug 2020 10:18:10 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 15 Aug 2020 10:18:09 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Sat, 15 Aug 2020 10:18:09 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Eric Dumazet <edumazet@google.com>
CC:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
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
Thread-Index: AdZyqSQrc7cmKqN7TBW6GVt2+y7YJA==
Date:   Sat, 15 Aug 2020 02:18:09 +0000
Message-ID: <d4390fcd400a4dc2b8f2a61b9190155f@huawei.com>
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

RXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPiB3cm90ZToNCj5PbiBGcmksIEF1ZyAx
NCwgMjAyMCBhdCAxMjoxNCBBTSBsaW5taWFvaGUgPGxpbm1pYW9oZUBodWF3ZWkuY29tPiB3cm90
ZToNCj4+DQo+PiBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiBTaW5jZSB3ZSBhbHdheXMgY2FsbCBza2Jfb3JwaGFuX2ZyYWdz
IGluIHNrYl9jbG9uZSwgaXMgaXQgdW5uZWNlc3NhcnkgdG8gY2FsbCBza2Jfb3JwaGFuX2ZyYWdz
IGluIHBza2JfZXhwYW5kX2hlYWQgd2hlbiBza2IgaXMgY2xvbmVkID8NCj4NCj5QbGVhc2UgZ2l2
ZSB1cyBhIHJlYWwgY2FzZS4NCj4NCj5JIGZlYXIgdGhhdCB5b3VyIHBhdGNoZXMgYXJlIGNvbWlu
ZyBkaXJlY3RseSBmcm9tIHNvbWUga2luZCBvZiBhdXRvbWF0ZWQgdG9vbCwgdGhhdCByZWFsbHkg
bWlzc2VzIGhvdyB0aGUgY29kZSBpcyByZWFsbHkgdXNlZCBmcm9tIF9jdXJyZW50XyBjb2RlIGJh
c2UsIG5vdCBfaHlwb3RoZXRpY2FsXyBvbmUuDQo+DQo+VGhpcyBpcyB2ZXJ5IHRpbWUgY29uc3Vt
aW5nLiBQbGVhc2UgcHJvdmlkZSBldmlkZW5jZSBmaXJzdC4NCj4NCj5UaGFuayB5b3UuDQoNCkkn
YW0gc29ycnkgYWJvdXQgaXQuIEkgZG8gdGhpcyBtYWlubHkgdGhyb3VnaCBjb2RlIHJldmlldyBh
bmQgZG8gc29tZSB0ZXN0IGNvZGUuIFNvIHRoZSBwcm9ibGVtIGNvZGVwYXRoIG1heSBub3QgZXhp
c3QgZnJvbSBjdXJyZW50IGNvZGUgYmFzZSwgYnV0IG1heQ0KaGFwcGVuIHdoZW4gd2UgZG8gbm90
IHRha2UgY2FyZSBvZiBpdCBpbiB0aGUgZnV0dXJlIHVzZS4gV2UgbWF5IGZvcmdldCBzYW1lIGFz
c3VtcHRpb24uIEFuZCBtYWtlIHRoZXNlIGFzc3VtcHRpb25zIGNsZWFyIHNlZW1zIG5vdCBhIGJh
ZCB0aGluZy4NCkJ1dCBJJ2FtIGdvaW5nIHRvIGp1c3QgZHJvcCB0aGlzIHBhdGNoLiBJIGJlbGll
dmUgeW91IGFsbCBjYW4gaGFuZGxlIHRoZSB0aGluZ3MgY29ycmVjdGx5Lg0KDQpNYW55IHRoYW5r
cy4NCg0K
