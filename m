Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F3C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CBC21569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAMGvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:51:21 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbgAMGvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:51:21 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 03C7E55F30D6426FC107;
        Mon, 13 Jan 2020 14:51:18 +0800 (CST)
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.174]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0439.000;
 Mon, 13 Jan 2020 14:51:11 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Topic: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Index: AQHVuWnsK0zwK8RxTkqe/SNAoYeaUKfT+S+AgALBI6CAAAyngIAAlqWw//+IwoCAAXt3QP//+lWAgASRonCABMxoAIAAodIAgAMuNwCAArymoA==
Date:   Mon, 13 Jan 2020 06:51:10 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340E2592@DGGEMM506-MBX.china.huawei.com>
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
In-Reply-To: <1a8f7963-97e9-62cc-12d2-39f816dfaf67@arm.com>
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
W21haWx0bzp2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbV0NCj4gU2VudDogU3VuZGF5LCBKYW51
YXJ5IDEyLCAyMDIwIDQ6NTYgQU0NCj4gVG86IFplbmd0YW8gKEIpOyBNb3J0ZW4gUmFzbXVzc2Vu
DQo+IENjOiBTdWRlZXAgSG9sbGE7IExpbnV4YXJtOyBHcmVnIEtyb2FoLUhhcnRtYW47IFJhZmFl
bCBKLiBXeXNvY2tpOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGNwdS10b3BvbG9neTogd2FybiBpZiBOVU1BIGNvbmZpZ3VyYXRpb25zIGNv
bmZsaWN0cw0KPiB3aXRoIGxvd2VyIGxheWVyDQo+IA0KPiBPbiAwOS8wMS8yMDIwIDEyOjU4LCBa
ZW5ndGFvIChCKSB3cm90ZToNCj4gPj4gSUlVQywgdGhlIHByb2JsZW0gaXMgdGhhdCB2aXJ0IGNh
biBzZXQgdXAgYSBicm9rZW4gdG9wb2xvZ3kgaW4gc29tZQ0KPiA+PiBjYXNlcyB3aGVyZSBNUElE
UiBkb2Vzbid0IGxpbmUgdXAgY29ycmVjdGx5IHdpdGggdGhlIGRlZmluZWQgTlVNQQ0KPiA+PiBu
b2Rlcy4NCj4gPj4NCj4gPj4gV2UgY291bGQgYXJndWUgdGhhdCBpdCBpcyBhIHFlbXUvdmlydCBw
cm9ibGVtLCBidXQgaXQgd291bGQgYmUgbmljZSBpZg0KPiA+PiB3ZSBjb3VsZCBhdCBsZWFzdCBk
ZXRlY3QgaXQuIFRoZSBwcm9wb3NlZCBwYXRjaCBpc24ndCByZWFsbHkgdGhlIHJpZ2h0DQo+ID4+
IHNvbHV0aW9uIGFzIGl0IHdhcm5zIG9uIHNvbWUgdmFsaWQgdG9wb2xvZ2llcyBhcyBTdWRlZXAg
YWxyZWFkeSBwb2ludGVkDQo+ID4+IG91dC4NCj4gPj4NCj4gPj4gSXQgc291bmRzIG1vcmUgbGlr
ZSB3ZSBuZWVkIGEgbWFzayBzdWJzZXQgY2hlY2sgaW4gdGhlIHNjaGVkX2RvbWFpbg0KPiA+PiBi
dWlsZGluZyBjb2RlLCBpZiB0aGVyZSBpc24ndCBhbHJlYWR5IG9uZT8NCj4gPg0KPiA+IEN1cnJl
bnRseSBubywgaXQncyBhIGJpdCBjb21wbGV4IHRvIGRvIHRoZSBjaGVjayBpbiB0aGUgc2NoZWRf
ZG9tYWluDQo+IGJ1aWxkaW5nIGNvZGUsDQo+ID4gSSBuZWVkIHRvIHRha2UgYSB0aGluayBvZiB0
aGF0Lg0KPiA+IFN1Z2dlc3Rpb24gd2VsY29tZWQuDQo+ID4NCj4gDQo+IERvaW5nIGEgc2VhcmNo
IG9uIHRoZSBzY2hlZF9kb21haW4gc3BhbnMgdGhlbXNlbHZlcyBzaG91bGQgbG9vaw0KPiBzb21l
dGhpbmcgbGlrZQ0KPiB0aGUgY29tcGxldGVseSB1bnRlc3RlZDoNCj4gDQo+IC0tLTg8LS0tDQo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYyBiL2tlcm5lbC9zY2hlZC90b3Bv
bG9neS5jDQo+IGluZGV4IDZlYzFlNTk1YjFkNC4uOTYxMjhkMTJlYzIzIDEwMDY0NA0KPiAtLS0g
YS9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYw0KPiArKysgYi9rZXJuZWwvc2NoZWQvdG9wb2xvZ3ku
Yw0KPiBAQCAtMTg3OSw2ICsxODc5LDQzIEBAIHN0YXRpYyBzdHJ1Y3Qgc2NoZWRfZG9tYWluDQo+
ICpidWlsZF9zY2hlZF9kb21haW4oc3RydWN0IHNjaGVkX2RvbWFpbl90b3BvbG9neV9sZXZlDQo+
ICAJcmV0dXJuIHNkOw0KPiAgfQ0KPiANCj4gKy8qIEVuc3VyZSB0b3BvbG9neSBtYXNrcyBhcmUg
c2FuZTsgbm9uLU5VTUEgc3BhbnMgc2hvdWxkbid0IG92ZXJsYXAgKi8NCj4gK3N0YXRpYyBpbnQg
dmFsaWRhdGVfdG9wb2xvZ3lfc3BhbnMoY29uc3Qgc3RydWN0IGNwdW1hc2sgKmNwdV9tYXApDQo+
ICt7DQo+ICsJc3RydWN0IHNjaGVkX2RvbWFpbl90b3BvbG9neV9sZXZlbCAqdGw7DQo+ICsJaW50
IGksIGo7DQo+ICsNCj4gKwlmb3JfZWFjaF9zZF90b3BvbG9neSh0bCkgew0KPiArCQkvKiBOVU1B
IGxldmVscyBhcmUgYWxsb3dlZCB0byBvdmVybGFwICovDQo+ICsJCWlmICh0bC0+ZmxhZ3MgJiBT
RFRMX09WRVJMQVApDQo+ICsJCQlicmVhazsNCj4gKw0KPiArCQkvKg0KPiArCQkgKiBOb24tTlVN
QSBsZXZlbHMgY2Fubm90IHBhcnRpYWxseSBvdmVybGFwIC0gdGhleSBtdXN0IGJlDQo+ICsJCSAq
IGVpdGhlciBlcXVhbCBvciB3aG9sbHkgZGlzam9pbnQuIE90aGVyd2lzZSB3ZSBjYW4gZW5kIHVw
DQo+ICsJCSAqIGJyZWFraW5nIHRoZSBzY2hlZF9ncm91cCBsaXN0cyAtIGkuZS4gYSBsYXRlciBn
ZXRfZ3JvdXAoKQ0KPiArCQkgKiBwYXNzIGJyZWFrcyB0aGUgbGlua2luZyBkb25lIGZvciBhbiBl
YXJsaWVyIHNwYW4uDQo+ICsJCSAqLw0KPiArCQlmb3JfZWFjaF9jcHUoaSwgY3B1X21hcCkgew0K
PiArCQkJZm9yX2VhY2hfY3B1KGosIGNwdV9tYXApIHsNCj4gKwkJCQlpZiAoaSA9PSBqKQ0KPiAr
CQkJCQljb250aW51ZTsNCj4gKwkJCQkvKg0KPiArCQkJCSAqIFdlIHNob3VsZCAnYW5kJyBhbGwg
dGhvc2UgbWFza3Mgd2l0aCAnY3B1X21hcCcNCj4gKwkJCQkgKiB0byBleGFjdGx5IG1hdGNoIHRo
ZSB0b3BvbG9neSB3ZSdyZSBhYm91dCB0bw0KPiArCQkJCSAqIGJ1aWxkLCBidXQgdGhhdCBjYW4g
b25seSByZW1vdmUgQ1BVcywgd2hpY2gNCj4gKwkJCQkgKiBvbmx5IGxlc3NlbnMgb3VyIGFiaWxp
dHkgdG8gZGV0ZWN0IG92ZXJsYXBzDQo+ICsJCQkJICovDQo+ICsJCQkJaWYgKCFjcHVtYXNrX2Vx
dWFsKHRsLT5tYXNrKGkpLCB0bC0+bWFzayhqKSkgJiYNCj4gKwkJCQkgICAgY3B1bWFza19pbnRl
cnNlY3RzKHRsLT5tYXNrKGkpLCB0bC0+bWFzayhqKSkpDQo+ICsJCQkJCXJldHVybiAtMTsNCj4g
KwkJCX0NCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICAv
Kg0KPiAgICogRmluZCB0aGUgc2NoZWRfZG9tYWluX3RvcG9sb2d5X2xldmVsIHdoZXJlIGFsbCBD
UFUgY2FwYWNpdGllcyBhcmUNCj4gdmlzaWJsZQ0KPiAgICogZm9yIGFsbCBDUFVzLg0KPiBAQCAt
MTk1Myw3ICsxOTkwLDggQEAgYnVpbGRfc2NoZWRfZG9tYWlucyhjb25zdCBzdHJ1Y3QgY3B1bWFz
aw0KPiAqY3B1X21hcCwgc3RydWN0IHNjaGVkX2RvbWFpbl9hdHRyICphdHQNCj4gIAlzdHJ1Y3Qg
c2NoZWRfZG9tYWluX3RvcG9sb2d5X2xldmVsICp0bF9hc3ltOw0KPiAgCWJvb2wgaGFzX2FzeW0g
PSBmYWxzZTsNCj4gDQo+IC0JaWYgKFdBUk5fT04oY3B1bWFza19lbXB0eShjcHVfbWFwKSkpDQo+
ICsJaWYgKFdBUk5fT04oY3B1bWFza19lbXB0eShjcHVfbWFwKSkgfHwNCj4gKwkgICAgV0FSTl9P
Tih2YWxpZGF0ZV90b3BvbG9neV9zcGFucyhjcHVfbWFwKSkpDQo+ICAJCWdvdG8gZXJyb3I7DQo+
IA0KPiAgCWFsbG9jX3N0YXRlID0gX192aXNpdF9kb21haW5fYWxsb2NhdGlvbl9oZWxsKCZkLCBj
cHVfbWFwKTsNCj4gLS0tPjgtLS0NCj4gDQo+IEFsdGVybmF0aXZlbHkgdGhlIGFzc2VydGlvbiBv
biB0aGUgc2NoZWRfZ3JvdXAgbGlua2luZyBJIHN1Z2dlc3RlZCBlYXJsaWVyDQo+IGluIHRoZSB0
aHJlYWQgc2hvdWxkIHN1ZmZpY2UsIHNpbmNlIHRoaXMgc2hvdWxkIHRyaWdnZXIgd2hlbmV2ZXIg
d2UgaGF2ZQ0KPiBvdmVybGFwcGluZyBub24tTlVNQSBzY2hlZCBkb21haW5zLg0KPiANCj4gU2lu
Y2UgeW91IGhhdmUgYSBzZXR1cCB3aGVyZSB5b3UgY2FuIHJlcHJvZHVjZSB0aGUgaXNzdWUsIGNv
dWxkIHBsZWFzZQ0KPiBnaXZlDQo+IGVpdGhlciAoaWRlYWxseSBib3RoISkgYSB0cnk/IFRoYW5r
cy4NCg0KDQpJIGhhdmUgdHJpZWQgYm90aCwgdGhpcyBwcmV2aW91cyBvbmUgZG9uJ3Qgd29yay4g
QnV0IHRoaXMgb25lIHNlZW1zIHdvcmsNCmNvcnJlY3RseSB3aXRoIHRoZSB3YXJuaW5nIG1lc3Nh
Z2UgcHJpbnRvdXQgYXMgZXhwZWN0ZWQuDQoNClRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gdGhlIGZh
Y3QgIiBub24tTlVNQSBzcGFucyBzaG91bGRuJ3Qgb3ZlcmxhcCAiLCBJIGFtDQpub3QgcXVpdGUg
c3VyZSBpZiB0aGlzIGlzIGFsd2F5cyB0cnVlPyANCg0KQW55d2F5LCBDb3VsZCB5b3UgaGVscCB0
byByYWlzZSB0aGUgbmV3IHBhdGNoPw0KDQpUaGFua3MNClplbmd0YW8NCg0KPiANCj4gPiBUaGFu
a3MNCj4gPiBaZW5ndGFvDQo+ID4NCj4gPj4NCj4gPj4gTW9ydGVuDQo=
