Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51449C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FDB206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIAMsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:48:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727937AbgIAMre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:47:34 -0400
Received: from dggeme702-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 55F02E07E3C272259619;
        Tue,  1 Sep 2020 20:47:18 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme702-chm.china.huawei.com (10.1.199.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 1 Sep 2020 20:47:17 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Tue, 1 Sep 2020 20:47:18 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     "oleg@redhat.com" <oleg@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "madhuparnabhowmik10@gmail.com" <madhuparnabhowmik10@gmail.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: clean up codestyle
Thread-Topic: [PATCH] signal: clean up codestyle
Thread-Index: AdaAWr2XxVwWGeARTF6vGMVxh/orgQ==
Date:   Tue, 1 Sep 2020 12:47:17 +0000
Message-ID: <1461a6c6bfe34ae9a5220a7d47d304e8@huawei.com>
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

Q2hyaXN0aWFuIEJyYXVuZXIgPGNocmlzdGlhbi5icmF1bmVyQHVidW50dS5jb20+IHdyb3RlOg0K
PiBPbiBUdWUsIFNlcCAwMSwgMjAyMCBhdCAwNzo1ODowMEFNIC0wNDAwLCBNaWFvaGUgTGluIHdy
b3RlOg0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCg0KPkhleSBNaWFvaGUsDQo+
DQo+VGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+SSdtIHN1cmUgdGhpcyBpcyB3ZWxsLWludGVu
ZGVkIGJ1dCBhZmFpY3QgdGhlIHdob2xlIGZpbGUgaGFzIG1vcmUgb3IgbGVzcyBhIGNvbnNpc3Rl
bnQgc3R5bGUgYWxyZWFkeSB3aGVyZSBlLmcuIHNpZy0xIHdpdGhvdXQgc3BhY2VzIHNlZW1zIHRv
IGJlIHByZWZlcnJlZC4gVGhlIHNhbWUgZm9yIHRoZSBjYXN0cyB3aGVyZSBtb3N0IHBsYWNlcyB1
c2UgYSBzaW5nbGUgc3BhY2UuDQo+DQo+Tm93LCBJIGtub3cgQ29kaW5nU3R5bGUucnN0IGlzIG9u
IHlvdXIgc2lkZSBhdCBsZWFzdCB3aGVuIGl0IGNvbWVzIHRvIHRoZSBmaXJzdCBwb2ludDoNCj4N
Cj5Vc2Ugb25lIHNwYWNlIGFyb3VuZCAob24gZWFjaCBzaWRlIG9mKSBtb3N0IGJpbmFyeSBhbmQg
dGVybmFyeSBvcGVyYXRvcnMsIHN1Y2ggYXMgYW55IG9mIHRoZXNlOjoNCj4NCj4JPSAgKyAgLSAg
PCAgPiAgKiAgLyAgJSAgfCAgJiAgXiAgPD0gID49ICA9PSAgIT0gID8gIDoNCj4NCj5idXQgdGhl
biB5b3UnZCBuZWVkIHRvIGNoYW5nZSBlYWNoIHBsYWNlIGluIGtlcm5lbC9zaWduYWwuYyB3aGVy
ZSB0aGF0IGlzIGN1cnJlbnRseSBub3QgdGhlIGNhc2UuIE90aGVyd2lzZSB3ZSBlbmQgdXAgd2l0
aCBhIHdlaXJkIG1peC4NCj4NCj5UaGFua3MhDQo+Q2hyaXN0aWFuDQo+IA0KDQpNYW55IHRoYW5r
cyBmb3IgeW91ciByZXBseS4gSXQgbG9va3MgaXQncyBiZXR0ZXIgdG8gbWFrZSBjb2Rlc3R5bGUg
Y29uc2lzdGVudC4gV2lsbCBkbyBpdCB3aGVuIEknYW0gZnJlZS4gOikNClRoYW5rcyBhZ2Fpbi4N
Cg0K
