Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94195C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3C207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgAMMI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:08:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbgAMMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:08:59 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 80E868F53AB1E9ABC85A;
        Mon, 13 Jan 2020 20:08:56 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jan 2020 20:08:56 +0800
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.174]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0439.000;
 Mon, 13 Jan 2020 20:08:48 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Topic: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Index: AQHVuWnsK0zwK8RxTkqe/SNAoYeaUKfT+S+AgALBI6CAAAyngIAAlqWw//+IwoCAAXt3QP//+lWAgASRonCABMxoAIAAodIAgAMuNwCAArymoP//xgwAABH8jyA=
Date:   Mon, 13 Jan 2020 12:08:47 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340E420D@DGGEMM506-MBX.china.huawei.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <20200103114011.GB19390@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340B31E9@dggemm526-mbx.china.huawei.com>
 <20200109104306.GA10914@e105550-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340BEDD6@dggemm526-mbx.china.huawei.com>
 <1a8f7963-97e9-62cc-12d2-39f816dfaf67@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340E2592@DGGEMM506-MBX.china.huawei.com>
 <15050bf2-99ec-e604-ab95-827ce86fd693@arm.com>
In-Reply-To: <15050bf2-99ec-e604-ab95-827ce86fd693@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWYWxlbnRpbiBTY2huZWlkZXIg
W21haWx0bzp2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbV0NCj4gU2VudDogTW9uZGF5LCBKYW51
YXJ5IDEzLCAyMDIwIDc6MTcgUE0NCj4gVG86IFplbmd0YW8gKEIpOyBNb3J0ZW4gUmFzbXVzc2Vu
DQo+IENjOiBTdWRlZXAgSG9sbGE7IExpbnV4YXJtOyBHcmVnIEtyb2FoLUhhcnRtYW47IFJhZmFl
bCBKLiBXeXNvY2tpOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGNwdS10b3BvbG9neTogd2FybiBpZiBOVU1BIGNvbmZpZ3VyYXRpb25zDQo+
IGNvbmZsaWN0cyB3aXRoIGxvd2VyIGxheWVyDQo+IA0KPiBPbiAxMy8wMS8yMDIwIDA2OjUxLCBa
ZW5ndGFvIChCKSB3cm90ZToNCj4gPiBJIGhhdmUgdHJpZWQgYm90aCwgdGhpcyBwcmV2aW91cyBv
bmUgZG9uJ3Qgd29yay4gQnV0IHRoaXMgb25lIHNlZW1zDQo+IHdvcmsNCj4gPiBjb3JyZWN0bHkg
d2l0aCB0aGUgd2FybmluZyBtZXNzYWdlIHByaW50b3V0IGFzIGV4cGVjdGVkLg0KPiA+DQo+IA0K
PiBUaGFua3MgZm9yIHRyeWluZyBpdCBvdXQuDQo+IA0KPiA+IFRoaXMgcGF0Y2ggaXMgYmFzZWQg
b24gdGhlIGZhY3QgIiBub24tTlVNQSBzcGFucyBzaG91bGRuJ3Qgb3ZlcmxhcCAiLA0KPiBJIGFt
DQo+ID4gbm90IHF1aXRlIHN1cmUgaWYgdGhpcyBpcyBhbHdheXMgdHJ1ZT8NCj4gPg0KPiANCj4g
SSB0aGluayB0aGlzIGlzIHJlcXVpcmVkIGZvciBnZXRfZ3JvdXAoKSB0byB3b3JrIHByb3Blcmx5
LiBPdGhlcndpc2UsDQo+IHN1Y2Nlc3NpdmUgZ2V0X2dyb3VwKCkgY2FsbHMgbWF5IG92ZXJyaWRl
IChhbmQgYnJlYWspIHRoZSBzZC0+Z3JvdXBzDQo+IGxpbmtpbmcgYXMgeW91IGluaXRpYWxseSBy
ZXBvcnRlZC4NCj4gDQo+IEluIHlvdXIgZXhhbXBsZSwgZm9yIE1DIGxldmVsIHdlIGhhdmUNCj4g
DQo+ICAgdGwtPm1hc2soMykgPT0gMy03DQo+ICAgdGwtPm1hc2soNCkgPT0gNC03DQo+IA0KPiBX
aGljaCBwYXJ0aWFsbHkgb3ZlcmxhcHMsIGNhdXNpbmcgdGhlIHJlbGlua2luZyBvZiAnNy0+Mycg
dG8gJzctPjQnLiBWYWxpZA0KPiBjb25maWd1cmF0aW9ucyB3b3VsZCBiZQ0KPiANCj4gICB3aG9s
bHkgZGlzam9pbnQ6DQo+ICAgdGwtPm1hc2soMykgPT0gMC0zDQo+ICAgdGwtPm1ha3MoNCkgPT0g
NC03DQo+IA0KPiAgIGVxdWFsOg0KPiAgIHRsLT5tYXNrKDMpID09IDMtNw0KPiAgIHRsLT5tYXNr
KDQpID09IDMtNw0KPiANCj4gPiBBbnl3YXksIENvdWxkIHlvdSBoZWxwIHRvIHJhaXNlIHRoZSBu
ZXcgcGF0Y2g/DQo+ID4NCj4gDQo+IElkZWFsbHkgSSdkIGxpa2UgdG8gYmUgYWJsZSB0byByZXBy
b2R1Y2UgdGhpcyBsb2NhbGx5IGZpcnN0IChUQkggSSdkIGxpa2UNCj4gdG8gZ2V0IG15IGZpcnN0
IHN1Z2dlc3Rpb24gdG8gd29yayBzaW5jZSBpdCdzIGxlc3MgaW50cnVzaXZlKS4gQ291bGQgeW91
DQo+IHNoYXJlIGhvdyB5b3Ugd2VyZSBhYmxlIHRvIHRyaWdnZXIgdGhpcz8gRGlldG1hcidzIGJl
ZW4gdHJ5aW5nIHRvDQo+IHJlcHJvZHVjZQ0KPiB0aGlzIHdpdGggcWVtdSBidXQgSSBkb24ndCB0
aGluayBoZSdzIHRoZXJlIGp1c3QgeWV0Lg0KDQpEbyB5b3UgaGF2ZSBnb3QgYSBoYXJkd2FyZSBw
bGF0Zm9ybSB3aXRoIGNsdXN0ZXJzP3doYXQncyB0aGUgaGFyZHdhcmUNCkNwdSB0b3BvbG9neT8N
Cg0KUmVnYXJkcw0KWmVuZ3RhbyANCg==
