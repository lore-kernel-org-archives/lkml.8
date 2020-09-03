Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CECBC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605C620786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgICByx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:54:53 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:38494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727819AbgICByx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:54:53 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id BB42361D6D7D45624FAC;
        Thu,  3 Sep 2020 09:54:50 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 3 Sep 2020 09:54:50 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 3 Sep 2020 09:54:50 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     Oleg Nesterov <oleg@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "madhuparnabhowmik10@gmail.com" <madhuparnabhowmik10@gmail.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: clean up codestyle
Thread-Topic: [PATCH] signal: clean up codestyle
Thread-Index: AdaBlPZUrMplwVgiVkKB1FFjkYtq8Q==
Date:   Thu, 3 Sep 2020 01:54:50 +0000
Message-ID: <6dc3d25ff9bc4613894dd49b5c5c0dfa@huawei.com>
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
Pk9uIFdlZCwgU2VwIDAyLCAyMDIwIGF0IDAxOjM0OjU5QU0gKzAwMDAsIGxpbm1pYW9oZSB3cm90
ZToNCj4+IENocmlzdGlhbiBCcmF1bmVyIDxjaHJpc3RpYW4uYnJhdW5lckB1YnVudHUuY29tPiB3
cm90ZToNCj4+ID5PbiBUdWUsIFNlcCAwMSwgMjAyMCBhdCAwNjozOTowNVBNICswMjAwLCBPbGVn
IE5lc3Rlcm92IHdyb3RlOg0KPj4gPj4gT24gMDkvMDEsIENocmlzdGlhbiBCcmF1bmVyIHdyb3Rl
Og0KPj4gPkNocmlzdGlhbg0KPj4gDQo+PiBTb3JyeSBmb3IgSSBkaWQgbm90IGdldCB0aGUgaW1w
bHkuDQo+DQo+Tm8gbmVlZCB0byBhcG9sb2dpemUuIFRoYXQncyBteSBiYWQuIA0KPg0KPk1heWJl
IHNvbWUgY29udGV4dCBpcyB1c2VmdWwuDQo+T25lIG9mIHRoZSByZWFzb25zIHdoeSB3ZSB0ZW5k
IHRvIHNvbWV0aW1lcyBub3QgdGFrZSBjaGFuZ2VzIHN1Y2ggYXMgdGhpcyBldmVuIHRob3VnaCB0
aGV5IHdvdWxkIGJlIGNvdmVyZWQgYnkgb3VyIG9mZmljaWFsbHkgZG9jdW1lbnRlZCBjb2Rpbmcg
c3R5bGUgaXMgdG8ga2VlcCB0aGUgY2h1cm4gbWluaW1hbC4NCj5XaGVuZXZlciBmdW5jdGlvbmFs
IGNoYW5nZSBoYXBwZW5zIGluIGNvZGVwYXRocyBzdWNoIGFzIHRoaXMgdGhlIHJpc2sgb2YgcmVn
cmVzc2lvbnMgaXMgcXVpdGUgaGlnaC4gVGhhdCdzIHBhcnRpYWxseSBiZWNhdXNlIHdlIGNvdWxk
IHVzZSBtb3JlIHRlc3RzIHRvIGNhdGNoIHRoZW0gKEFuZCBpZiB5b3UncmUgaW50ZXJlc3RlZCBp
biBzdHVmZiBsaWtlIHRoaXMgdGhlbiB3cml0aW5nIHNlbGZ0ZXN0cyBpcyBhbHdheXMgZ3JlYXQu
IFdlIGNhbiBhbHdheXMgdXNlIG1vcmUgb2YgdGhlbS4pIGJ1dCBhbHNvIHNpbXBseSBiZWNhdXNl
IHRoZSBjb2RlIGlzIGNvbXBsZXguIEhhdmluZyBhIGxvdCBvZiBub24tZnVuY3Rpb25hbCBjb21t
aXRzIHRoYXQgZG9uJ3QgcmVhbGx5IGltcHJvdmUgdGhlIGxlZ2liaWxpdHkgb2YgdGhlIGNvZGUg
c2lnbmlmaWNhbnRseSBjYW4gYmVjb21lIGFuIGlzc3VlIGZvciBtYWludGFpbmVycy4gUGVyc29u
YWxseSwgSSB0ZW5kIHRvIGJlIGxlc3Mgd29ycmllZCBhYm91dCB0aGlzIGJ1dCB0aGlzIGlzIGEg
Y29sbGFib3JhdGl2ZSBlbmRlYXZvdXIuIDopDQo+DQo+VGhhbmtzIQ0KPkNocmlzdGlhbg0KDQpJ
IHRoaW5rIEkgZ2V0IHRoZSBwb2ludCB0aGlzIHRpbWUuIE1hbnkgdGhhbmtzIGZvciB5b3VyIGRl
dGFpbGVkIGV4cGxhaW5hdGlvbi4gOikNCkhhdmUgYSBnb29kIGRheSENCg0K
