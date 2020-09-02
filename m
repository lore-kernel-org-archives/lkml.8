Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E9BC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CCA206EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBBfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:35:01 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:45906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbgIBBfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:35:01 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id ABADAC093936991E11F2;
        Wed,  2 Sep 2020 09:34:59 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Sep 2020 09:34:59 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 2 Sep 2020 09:34:59 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "madhuparnabhowmik10@gmail.com" <madhuparnabhowmik10@gmail.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: clean up codestyle
Thread-Topic: [PATCH] signal: clean up codestyle
Thread-Index: AdaAyQ7srMplwVgiVkKB1FFjkYtq8Q==
Date:   Wed, 2 Sep 2020 01:34:59 +0000
Message-ID: <e436dd19f0e740ebb93133ae3c625af4@huawei.com>
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
Pk9uIFR1ZSwgU2VwIDAxLCAyMDIwIGF0IDA2OjM5OjA1UE0gKzAyMDAsIE9sZWcgTmVzdGVyb3Yg
d3JvdGU6DQo+PiBPbiAwOS8wMSwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+PiA+DQo+PiA+
IE9uIFR1ZSwgU2VwIDAxLCAyMDIwIGF0IDA3OjU4OjAwQU0gLTA0MDAsIE1pYW9oZSBMaW4gd3Jv
dGU6DQo+PiA+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+PiA+DQo+PiA+IEhl
eSBNaWFvaGUsDQo+PiA+DQo+PiA+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPj4gPiBJJ20g
c3VyZSB0aGlzIGlzIHdlbGwtaW50ZW5kZWQgYnV0IGFmYWljdCB0aGUgd2hvbGUgZmlsZSBoYXMg
bW9yZSBvciANCj4+ID4gbGVzcyBhIGNvbnNpc3RlbnQgc3R5bGUgYWxyZWFkeSB3aGVyZSBlLmcu
IHNpZy0xIHdpdGhvdXQgc3BhY2VzIA0KPj4gPiBzZWVtcyB0byBiZSBwcmVmZXJyZWQuIFRoZSBz
YW1lIGZvciB0aGUgY2FzdHMgd2hlcmUgbW9zdCBwbGFjZXMgdXNlIA0KPj4gPiBhIHNpbmdsZSBz
cGFjZS4NCj4+ID4NCj4+ID4gTm93LCBJIGtub3cgQ29kaW5nU3R5bGUucnN0IGlzIG9uIHlvdXIg
c2lkZSBhdCBsZWFzdCB3aGVuIGl0IGNvbWVzIA0KPj4gPiB0byB0aGUgZmlyc3QgcG9pbnQ6DQo+
PiA+DQo+PiA+IFVzZSBvbmUgc3BhY2UgYXJvdW5kIChvbiBlYWNoIHNpZGUgb2YpIG1vc3QgYmlu
YXJ5IGFuZCB0ZXJuYXJ5IA0KPj4gPiBvcGVyYXRvcnMsIHN1Y2ggYXMgYW55IG9mIHRoZXNlOjoN
Cj4+ID4NCj4+ID4gCT0gICsgIC0gIDwgID4gICogIC8gICUgIHwgICYgIF4gIDw9ICA+PSAgPT0g
ICE9ICA/ICA6DQo+PiA+DQo+PiA+IGJ1dCB0aGVuIHlvdSdkIG5lZWQgdG8gY2hhbmdlIGVhY2gg
cGxhY2UgaW4ga2VybmVsL3NpZ25hbC5jIHdoZXJlIA0KPj4gPiB0aGF0IGlzIGN1cnJlbnRseSBu
b3QgdGhlIGNhc2UuDQo+PiANCj4+IE9yIHNpbXBseSBsZWF2ZSB0aGlzIGNvZGUgYWxvbmUgOykN
Cj4NCj5JIHdhcyB0cnlpbmcgdG8gaW1wbHkgdGhhdCBieSBwb2ludGluZyBvdXQgdGhhdCB0aGlz
IHdvdWxkIGJlIGZpbGUtZ2xvYmFsIGNoYW5nZS4gSSB3YXMgbGlrZWx5IHRvbyBzdWJ0bGUuIDsp
DQo+DQo+Q2hyaXN0aWFuDQoNClNvcnJ5IGZvciBJIGRpZCBub3QgZ2V0IHRoZSBpbXBseS4NCg0K
