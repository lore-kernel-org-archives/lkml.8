Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFFBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8485204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="RHO1+f96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgHFQcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:32:08 -0400
Received: from mail6.tencent.com ([220.249.245.26]:34587 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHFQ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:29:26 -0400
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail6.tencent.com (Postfix) with ESMTP id 648A5CC5F1;
        Thu,  6 Aug 2020 23:53:18 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1596729198;
        bh=S/OhNIc6e92B+UDMMsxC+S23+SO+ezdepdP/NZXGYis=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=RHO1+f96IGy2Dxxw64f8Qw6ze2krItgWlCM4ue2tkZswwFTVbRxS3wfLpUBtZTO/s
         rmnst+hoZF0OaX2bJa5VnVK/MW4OV6lvj1+NPK0zKUOrMqh+97VxMVLgx90SKoBjFw
         zuJmH0kmcqE+2mzb9MIIQtxOPjiEyCr9oqkapCYk=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 6 Aug 2020
 23:52:06 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 6 Aug 2020
 23:52:05 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Thu, 6 Aug 2020 23:52:02 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
Thread-Topic: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DACABNlRgIAAJ90A
Date:   Thu, 6 Aug 2020 15:52:02 +0000
Message-ID: <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com>
References: <20200801023248.90104-1-benbjiang@gmail.com>
 <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
 <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com>
 <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
In-Reply-To: <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.122]
Content-Type: text/plain; charset="utf-8"
Content-ID: <478D52451EDC8B4F9FFA3F84CFC05C72@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQo+IE9uIEF1ZyA2LCAyMDIwLCBhdCA5OjI5IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxk
aWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMDMvMDgvMjAyMCAxMzoy
NiwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEF1ZyAzLCAyMDIw
LCBhdCA0OjE2IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+
IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDAxLzA4LzIwMjAgMDQ6MzIsIEppYW5nIEJpYW8gd3JvdGU6
DQo+Pj4+IEZyb206IEppYW5nIEJpYW8gPGJlbmJqaWFuZ0B0ZW5jZW50LmNvbT4NCj4+Pj4gDQo+
Pj4+IE5vIG5lZWQgdG8gcHJlZW1wdCB3aGVuIHRoZXJlIGFyZSBvbmx5IG9uZSBydW5hYmxlIENG
UyB0YXNrIHdpdGgNCj4+Pj4gb3RoZXIgSURMRSB0YXNrcyBvbiBydW5xdWV1ZS4gVGhlIG9ubHkg
b25lIENGUyB0YXNrIHdvdWxkIGFsd2F5cw0KPj4+PiBiZSBwaWNrZWQgaW4gdGhhdCBjYXNlLg0K
Pj4+PiANCj4+Pj4gU2lnbmVkLW9mZi1ieTogSmlhbmcgQmlhbyA8YmVuYmppYW5nQHRlbmNlbnQu
Y29tPg0KPj4+PiAtLS0NCj4+Pj4ga2VybmVsL3NjaGVkL2ZhaXIuYyB8IDIgKy0NCj4+Pj4gMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+IA0KPj4+PiBk
aWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+
Pj4gaW5kZXggMDRmYThkYmNmYTRkLi44ZmI4MDYzNmIwMTAgMTAwNjQ0DQo+Pj4+IC0tLSBhL2tl
cm5lbC9zY2hlZC9mYWlyLmMNCj4+Pj4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4+PiBA
QCAtNDUyNyw3ICs0NTI3LDcgQEAgZW50aXR5X3RpY2soc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBz
dHJ1Y3Qgc2NoZWRfZW50aXR5ICpjdXJyLCBpbnQgcXVldWVkKQ0KPj4+PiAJCXJldHVybjsNCj4+
Pj4gI2VuZGlmDQo+Pj4+IA0KPj4+PiAtCWlmIChjZnNfcnEtPm5yX3J1bm5pbmcgPiAxKQ0KPj4+
PiArCWlmIChjZnNfcnEtPm5yX3J1bm5pbmcgPiBjZnNfcnEuaWRsZV9oX25yX3J1bm5pbmcgKyAx
KQ0KPj4+IA0KPj4+IGNmc19ycSBpcyBhIHBvaW50ZXIuDQo+PiBJdCBpcy4gU29ycnkgYWJvdXQg
dGhhdC4gOikNCj4+IA0KPj4+IA0KPj4+PiAJCWNoZWNrX3ByZWVtcHRfdGljayhjZnNfcnEsIGN1
cnIpOw0KPj4+PiB9DQo+Pj4gDQo+Pj4gWW91IGNhbid0IGNvbXBhcmUgY2ZzX3JxLT5ucl9ydW5u
aW5nIHdpdGggY2ZzX3JxLT5pZGxlX2hfbnJfcnVubmluZyENCj4+PiANCj4+PiBUaGVyZSBpcyBh
IGRpZmZlcmVuY2UgYmV0d2VlbiBjZnNfcnEtPmhfbnJfcnVubmluZyBhbmQNCj4+PiBjZnNfcnEt
Pm5yX3J1bm5pbmcuIFRoZSAnX2hfJyBzdGFuZHMgZm9yIGhpZXJhcmNoaWNhbC4NCj4+PiANCj4+
PiBUaGUgZm9ybWVyIGdpdmVzIHlvdSBoaWVyYXJjaGljYWwgdGFzayBhY2NvdW50aW5nIHdoZXJl
YXMgdGhlIGxhdHRlciBpcw0KPj4+IHRoZSBudW1iZXIgb2Ygc2NoZWQgZW50aXRpZXMgKHJlcHJl
c2VudGluZyB0YXNrcyBvciB0YXNrZ3JvdXBzKSBlbnF1ZXVlZA0KPj4+IGluIGNmc19ycS4NCj4+
PiANCj4+PiBJbiBlbnRpdHlfdGljaygpLCBjZnNfcnEtPm5yX3J1bm5pbmcgaGFzIHRvIGJlIHVz
ZWQgZm9yIHRoZSBjb25kaXRpb24gdG8NCj4+PiBjYWxsIGNoZWNrX3ByZWVtcHRfdGljaygpLiBX
ZSB3YW50IHRvIGNoZWNrIGlmIGN1cnIgaGFzIHRvIGJlIHByZWVtcHRlZA0KPj4+IGJ5IF9fcGlj
a19maXJzdF9lbnRpdHkoY2ZzX3JxKSBvbiB0aGlzIGNmc19ycS4NCj4+PiANCj4+PiBlbnRpdHlf
dGljaygpIGlzIGNhbGxlZCBmb3IgZWFjaCBzY2hlZCBlbnRpdHkgKGFuZCBzbyBmb3IgZWFjaA0K
Pj4+IGNmc19ycV9vZihzZSkpIG9mIHRoZSB0YXNrIGdyb3VwIGhpZXJhcmNoeSAoZS5nLiB0YXNr
IHAgcnVubmluZyBpbg0KPj4+IHRhc2tncm91cCAvQS9CIDogc2UocCkgLT4gc2UoQS9CKSAtPiBz
ZShBKSkuDQo+PiBUaGF04oCZcyB0cnVlLiBJIHdhcyB0aGlua2luZyBhZGRpbmcgYSBuZXcgY2Zz
X3JxLT5pZGxlX25yX3J1bm5pbmcgbWVtYmVyIHRvDQo+PiB0cmFjayB0aGUgcGVyIGNmc19ycSdz
IElETEUgdGFzayBudW1iZXIsIGFuZCByZWR1Y2luZyBwcmVlbXB0aW9uIGhlcmUgYmFzZWQNCj4+
IG9uIHRoYXQuIA0KPiANCj4gSG93IHdvdWxkIHlvdSBkZWFsIHdpdGggc2UncyByZXByZXNlbnRp
bmcgdGFza2dyb3VwcyB3aGljaCBjb250YWluDQo+IFNDSEVEX0lETEUgYW5kIFNDSEVEX05PUk1B
TCB0YXNrcyBvciBvdGhlciB0YXNrZ3JvdXBzIGRvaW5nIHRoYXQ/DQpJ4oCZbSBub3Qgc3VyZSBJ
IGdldCB0aGUgcG9pbnQuIDopIEhvdyBhYm91dCB0aGUgZm9sbG93aW5nIHBhdGNoLA0KDQpkaWZm
IC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCmluZGV4
IDA0ZmE4ZGJjZmE0ZC4uODcxNWYwM2VkNmQ3IDEwMDY0NA0KLS0tIGEva2VybmVsL3NjaGVkL2Zh
aXIuYw0KKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KQEAgLTI5OTQsNiArMjk5NCw5IEBAIGFj
Y291bnRfZW50aXR5X2VucXVldWUoc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBzdHJ1Y3Qgc2NoZWRf
ZW50aXR5ICpzZSkNCiAgICAgICAgICAgICAgICBsaXN0X2FkZCgmc2UtPmdyb3VwX25vZGUsICZy
cS0+Y2ZzX3Rhc2tzKTsNCiAgICAgICAgfQ0KICNlbmRpZg0KKyAgICAgICBpZiAodGFza19oYXNf
aWRsZV9wb2xpY3kodGFza19vZihzZSkpKQ0KKyAgICAgICAgICAgICAgIGNmc19ycS0+aWRsZV9u
cl9ydW5uaW5nKys7DQorDQogICAgICAgIGNmc19ycS0+bnJfcnVubmluZysrOw0KIH0NCg0KQEAg
LTMwMDcsNiArMzAxMCw5IEBAIGFjY291bnRfZW50aXR5X2RlcXVldWUoc3RydWN0IGNmc19ycSAq
Y2ZzX3JxLCBzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpzZSkNCiAgICAgICAgICAgICAgICBsaXN0X2Rl
bF9pbml0KCZzZS0+Z3JvdXBfbm9kZSk7DQogICAgICAgIH0NCiAjZW5kaWYNCisgICAgICAgaWYg
KHRhc2tfaGFzX2lkbGVfcG9saWN5KHRhc2tfb2Yoc2UpKSkNCisgICAgICAgICAgICAgICBjZnNf
cnEtPmlkbGVfbnJfcnVubmluZy0tOw0KKw0KICAgICAgICBjZnNfcnEtPm5yX3J1bm5pbmctLTsN
CiB9DQoNCkBAIC00NTI3LDcgKzQ1MzMsNyBAQCBlbnRpdHlfdGljayhzdHJ1Y3QgY2ZzX3JxICpj
ZnNfcnEsIHN0cnVjdCBzY2hlZF9lbnRpdHkgKmN1cnIsIGludCBxdWV1ZWQpDQogICAgICAgICAg
ICAgICAgcmV0dXJuOw0KICNlbmRpZg0KDQotICAgICAgIGlmIChjZnNfcnEtPm5yX3J1bm5pbmcg
PiAxKQ0KKyAgICAgICBpZiAoY2ZzX3JxLT5ucl9ydW5uaW5nID4gY2ZzX3JxLT5pZGxlX25yX3J1
bm5pbmcgKyAxICYmDQorICAgICAgICAgICBjZnNfcnEtPmhfbnJfcnVubmluZyAtIGNmc19ycS0+
aWRsZV9oX25yX3J1bm5pbmcgPiBjZnNfcnEtPmlkbGVfbnJfcnVubmluZyArIDEpDQogICAgICAg
ICAgICAgICAgY2hlY2tfcHJlZW1wdF90aWNrKGNmc19ycSwgY3Vycik7DQogfQ0KDQpkaWZmIC0t
Z2l0IGEva2VybmVsL3NjaGVkL3NjaGVkLmggYi9rZXJuZWwvc2NoZWQvc2NoZWQuaA0KaW5kZXgg
ODc3ZmIwOGViMWIwLi40MDEwOTAzOTNlMDkgMTAwNjQ0DQotLS0gYS9rZXJuZWwvc2NoZWQvc2No
ZWQuaA0KKysrIGIva2VybmVsL3NjaGVkL3NjaGVkLmgNCkBAIC01MDAsNiArNTAwLDcgQEAgc3Ry
dWN0IGNmc19iYW5kd2lkdGggeyB9Ow0KIHN0cnVjdCBjZnNfcnEgew0KICAgICAgICBzdHJ1Y3Qg
bG9hZF93ZWlnaHQgICAgICBsb2FkOw0KICAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBu
cl9ydW5uaW5nOw0KKyAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBpZGxlX25yX3J1bm5p
bmc7DQogICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgIGhfbnJfcnVubmluZzsgICAgICAv
KiBTQ0hFRF97Tk9STUFMLEJBVENILElETEV9ICovDQogICAgICAgIHVuc2lnbmVkIGludCAgICAg
ICAgICAgIGlkbGVfaF9ucl9ydW5uaW5nOyAvKiBTQ0hFRF9JRExFICovDQo+IA0KPj4gSeKAmW0g
bm90IHN1cmUgaWYgaXTigJlzIG9rIHRvIGRvIHRoYXQsIGJlY2F1c2UgdGhlIElETEUgY2xhc3Mg
c2VlbXMgbm90IHRvIGJlIHNvDQo+PiBwdXJlIHRoYXQgY291bGQgdG9sZXJhdGUgc3RhcnZpbmcu
DQo+IA0KPiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgYnV0IGlkbGVfc2NoZWRfY2xhc3MgaXMgbm90
IHRoZSBzYW1lIGFzIFNDSEVEX0lETEUNCj4gKHBvbGljeSk/DQpUaGUgY2FzZSBpcyB0aGF0IHdl
IG5lZWQgdGFza3MobG93IHByaW9yaXR5LCBjYWxsZWQgb2ZmbGluZSB0YXNrcykgdG8gdXRpbGl6
ZSB0aGUNCnNwYXJlIGNwdSBsZWZ0IGJ5IENGUyBTQ0hFRF9OT1JNQUwgdGFza3MoY2FsbGVkIG9u
bGluZSB0YXNrcykgd2l0aG91dA0KaW50ZXJmZXJpbmcgdGhlIG9ubGluZSB0YXNrcy4gDQpPZmZs
aW5lIHRhc2tzIG9ubHkgcnVuIHdoZW4gdGhlcmXigJlzIG5vIHJ1bm5hYmxlIG9ubGluZSB0YXNr
cywgYW5kIG9mZmxpbmUgdGFza3MNCm5ldmVyIHByZWVtcHQgb25saW5lIHRhc2tzLg0KVGhlIFND
SEVEX0lETEUgcG9saWN5IHNlZW1zIG5vdCB0byBiZSBhYmxlZCB0byBiZSBxdWFsaWZpZWQgZm9y
IHRoYXQgcmVxdWlyZW1lbnQsDQpiZWNhdXNlIGl0IGhhcyBhIHdlaWdodCgzKSwgZXZlbiB0aG91
Z2ggaXTigJlzIHNtYWxsLCBidXQgaXQgY2FuIHN0aWxsIHByZWVtcHQgb25saW5lDQp0YXNrcyBj
b25zaWRlcmluZyB0aGUgZmFpcm5lc3MuIEluIHRoYXQgd2F5LCBvZmZsaW5lIHRhc2tzIG9mIFND
SEVEX0lETEUgcG9saWN5DQpjb3VsZCBpbnRlcmZlcmUgdGhlIG9ubGluZSB0YXNrcy4NCk9uIHRo
ZSBvdGhlciBoYW5kLCBpZGxlX3NjaGVkX2NsYXNzIHNlZW1zIG5vdCB0byBiZSBxdWFsaWZpZWQg
ZWl0aGVyLiBJdOKAmXMgdG9vDQpzaW1wbGUgYW5kIG9ubHkgdXNlZCBmb3IgcGVyLWNwdSBpZGxl
IHRhc2sgY3VycmVudGx5Lg0KDQpUaHguDQpSZWdhcmRzLA0KSmlhbmcgDQoNCj4gDQo+PiBXZSBu
ZWVkIGFuIGFic29sdXRlbHkgbG93IHByaW9yaXR5IGNsYXNzIHRoYXQgY291bGQgdG9sZXJhdGUg
c3RhcnZpbmcsIHdoaWNoDQo+PiBjb3VsZCBiZSB1c2VkIHRvIGNvLWxvY2F0ZSBvZmZsaW5lIHRh
c2tzLiBCdXQgSURMRSBjbGFzcyBzZWVtcyB0byBiZSBub3QNCj4+ICpsb3cqIGVub3VnaCwgaWYg
Y29uc2lkZXJpbmcgdGhlIGZhaXJuZXNzIG9mIENGUywgYW5kIElETEUgY2xhc3Mgc3RpbGwgaGFz
IGENCj4+IHdlaWdodC4NCj4gDQo+IFsuLi5dDQo+IA0KDQo=
