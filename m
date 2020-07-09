Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89BDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC03E2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGIMAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:00:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbgGIMAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:00:07 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 990AC231693D6120607E;
        Thu,  9 Jul 2020 20:00:03 +0800 (CST)
Received: from dggema763-chm.china.huawei.com (10.1.198.205) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 9 Jul 2020 20:00:03 +0800
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 dggema763-chm.china.huawei.com (10.1.198.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 9 Jul 2020 19:59:59 +0800
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007;
 Thu, 9 Jul 2020 12:59:57 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     yuzenghui <yuzenghui@huawei.com>
CC:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
Subject: RE: [REPORT] possible circular locking dependency when booting a VM
 on arm64 host
Thread-Topic: [REPORT] possible circular locking dependency when booting a VM
 on arm64 host
Thread-Index: AQHWVd2KjX+gRVf/zUS8x8KvRiYF2qj/EP5QgAAAiYCAABH08A==
Date:   Thu, 9 Jul 2020 11:59:57 +0000
Message-ID: <937de9e7174f444bb4adae075213c92e@huawei.com>
References: <7225eba7-6e5e-ec7e-953b-d1fef0b1775b@huawei.com>
 <134ee452eda74f0cbdc10354fe66c48e@huawei.com>
 <7c1bb3c1-3f64-8c24-ed59-eb3da7bf6643@huawei.com>
In-Reply-To: <7c1bb3c1-3f64-8c24-ed59-eb3da7bf6643@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.68.122]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiB5dXplbmdodWkNCj4gU2VudDogVGh1cnNkYXksIEp1bHkgOSwgMjAyMCAxMjo1MCBQ
TQ0KPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IENjOiBNYXJj
IFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+OyBMaW51eA0KPiBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBaaHVh
bmd5dXplbmcgKFlpc2VuKQ0KPiA8eWlzZW4uemh1YW5nQGh1YXdlaS5jb20+OyBXYW5naGFpYmlu
IChEKSA8d2FuZ2hhaWJpbi53YW5nQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkVQT1JU
XSBwb3NzaWJsZSBjaXJjdWxhciBsb2NraW5nIGRlcGVuZGVuY3kgd2hlbiBib290aW5nIGEgVk0N
Cj4gb24gYXJtNjQgaG9zdA0KPiANCj4gT24gMjAyMC83LzkgMTg6NTQsIFNhbGlsIE1laHRhIHdy
b3RlOg0KPiA+IEhpIFl1emVuZ2h1aSwNCj4gPiBJIHdpbGwgdHJ5IHRvIHJlcHJvZHVjZSBpdCB0
b2RheSBhdCBvdXIgcGxhdGZvcm0uIEp1c3Qgb25lIHF1ZXN0aW9uIGlzIGl0IGVhc2lseQ0KPiA+
IHJlcHJvZHVjaWJsZSBvciBpcyBhIHJhcmUgb2NjdXJyZW5jZT8NCj4gDQo+IFNhbGlsLCBpdCdz
IDEwMCUgcmVwcm9kdWNpYmxlIG9uY2UgeW91IHN0YXJ0IGEgZ3Vlc3QuIFlvdSBkb24ndCBldmVu
DQo+IG5lZWQgdG8gYXNzaWduIGhvc3RkZXYgdG8gdGhlIFZNLg0KDQpUaGFua3MhDQo=
