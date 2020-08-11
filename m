Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D0FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C84920716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="ITglALbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHKLTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:19:46 -0400
Received: from mail4.tencent.com ([183.57.53.109]:50365 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgHKLTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:19:45 -0400
Received: from EX-SZ022.tencent.com (unknown [10.28.6.88])
        by mail4.tencent.com (Postfix) with ESMTP id 0FA26723BE;
        Tue, 11 Aug 2020 19:19:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597144782;
        bh=ik46Ua1t/TkaPI6X0sFrHvqZLSqTSbhSIKiPdTF69YE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=ITglALbIeNrzi9eSOgRHjxSZRobtjudFRtHbigEMb/NF3HJBRNmXYoRhrwfLhXHzQ
         lnWU212V9vAT4Gy7ZskXE11n+DUw3ODJmHer3Be2efYQ6JoXUAAlYAyfyaGa5hRnSQ
         0EaJcmlmEoJtMwF7YflDXKEEBiqsCP/gvM2+7r/I=
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ022.tencent.com
 (10.28.6.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 11 Aug
 2020 19:19:41 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ006.tencent.com
 (10.28.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 11 Aug
 2020 19:19:41 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Tue, 11 Aug 2020 19:19:41 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2] sched/fair: simplify the work when reweighting
 entity(Internet mail)
Thread-Topic: [PATCH RFC v2] sched/fair: simplify the work when reweighting
 entity(Internet mail)
Thread-Index: AQHWbAzE7ZT5yMr2eUuDjHbLKgkwdakyK2YAgAAZAAA=
Date:   Tue, 11 Aug 2020 11:19:41 +0000
Message-ID: <4E0D3766-146C-4864-984A-79B90F0B2EEF@tencent.com>
References: <20200806161406.22629-1-benbjiang@tencent.com>
 <9149cf7c-df81-cf9d-65f7-a51d4ec76f78@arm.com>
In-Reply-To: <9149cf7c-df81-cf9d-65f7-a51d4ec76f78@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.14]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E7D3BEAAA82B043A6B12476C2E9F629@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gQXVnIDExLCAyMDIwLCBhdCA1OjUwIFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxk
aWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMDYvMDgvMjAyMCAxODox
NCwgSmlhbmcgQmlhbyB3cm90ZToNCj4+IEZyb206IEppYW5nIEJpYW8gPGJlbmJqaWFuZ0B0ZW5j
ZW50LmNvbT4NCj4+IA0KPj4gSWYgYSBzZSBpcyBvbl9ycSB3aGVuIHJld2VpZ2h0aW5nIGVudGl0
eSwgYWxsIHdlIG5lZWQgc2hvdWxkIGJlDQo+PiB1cGRhdGluZyB0aGUgbG9hZCBvZiBjZnNfcnEs
IG90aGVyIGRlcXVldWUvZW5xdWV1ZSB3b3JrIGNvdWxkIGJlDQo+PiByZWR1bmRhbnQsIHN1Y2gg
YXMsDQo+PiAqIG5yX3J1bm5pbmctLS9ucl9ydW5uaW5nKysNCj4+IA0KPj4gRXZlbiB0aG91Z2gg
dGhlIGZvbGxvd2luZyBkZXF1ZXVlL2VucXVldWUgcGF0aCB3b3VsZCBuZXZlciBiZSByZWFjaGVk
DQo+PiAqIGFjY291bnRfbnVtYV9kZXF1ZXVlL2FjY291bnRfbnVtYV9lbnF1ZXVlDQo+PiAqIGxp
c3RfZGVsL2xpc3RfYWRkIGZyb20vaW50byBjZnNfdGFza3MNCj4+IGJ1dCBpdCBjb3VsZCBiZSBh
IGxpdHRsZSBjb25mdXNpbmcuDQo+PiANCj4+IFNpbXBsaWZ5aW5nIHRoZSBsb2dpYyBjb3VsZCBi
ZSBoZWxwZnVsIHRvIHJlZHVjZSBhIGxpdHRlIG92ZXJoZWFkIGZvcg0KPj4gaG90IHBhdGgsIGFu
ZCBtYWtlIGl0IGNsZWFuZXIgYW5kIG1vcmUgcmVhZGFibGUuDQo+IA0KPiBMR1RNLiBJIGd1ZXNz
IHlvdSBoYXZlIHRvIHJlc2VuZCBpdCB3L28gdGhlIFJGQyB0YWcuDQpXaWxsIGRvIHNvb24uDQo+
IA0KPiBNYXliZSB5b3UgY2FuIHJld29yayB0aGUgcGF0Y2ggaGVhZGVyIGEgbGl0dGxlPw0KPiAN
Cj4gU29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IFRoZSBjb2RlIGluIHJld2VpZ2h0X2VudGl0
eSgpIGNhbiBiZSBzaW1wbGlmaWVkLg0KPiANCj4gRm9yIGEgc2NoZWQgZW50aXR5IG9uIHRoZSBy
cSwgdGhlIGVudGl0eSBhY2NvdW50aW5nIGNhbiBiZSByZXBsYWNlZCBieQ0KPiBjZnNfcnEgaW5z
dGFudGFuZW91cyBsb2FkIHVwZGF0ZXMgY3VycmVudGx5IGNhbGxlZCBmcm9tIHdpdGhpbiB0aGUN
Cj4gZW50aXR5IGFjY291bnRpbmcuDQo+IA0KPiBFdmVuIHRob3VnaCBhbiBlbnRpdHkgb24gdGhl
IHJxIGNhbid0IHJlcHJlc2VudCBhIHRhc2sgaW4NCj4gcmV3ZWlnaHRfZW50aXR5KCkgKGEgdGFz
ayBpcyBhbHdheXMgZGVxdWV1ZWQgYmVmb3JlIGNhbGxpbmcgdGhpcw0KPiBmdW5jdGlvbikgYW5k
IHNvIHRoZSBudW1hIHRhc2sgYWNjb3VudGluZyBhbmQgdGhlIHJxLT5jZnNfdGFza3MgbGlzdA0K
PiBtYW5hZ2VtZW50IG9mIHRoZSBlbnRpdHkgYWNjb3VudGluZyBhcmUgbmV2ZXIgY2FsbGVkLCB0
aGUgcmVkdW5kYW50DQo+IGNmc19ycS0+bnJfcnVubmluZyBkZWNyZW1lbnQvaW5jcmVtZW50IHdp
bGwgYmUgYXZvaWRlZC4NClRoYXTigJlzIGEgbXVjaCBiZXR0ZXIuIEnigJlsbCBwaWNrIHRoZSBo
ZWFkZXIgaWYgeW91IGRvbuKAmXQgbWluZC4gOikNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGtp
bmRseSByZXBseSBhbmQgZGV0YWlsZWQgZXhwbGFuYXRpb24uDQoNClJlZ2FyZHMsDQpKaWFuZw0K
PiANCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSmlhbmcgQmlhbyA8YmVuYmppYW5nQHRlbmNlbnQu
Y29tPg0KPj4gLS0tDQo+PiB2MjwtdjE6IA0KPj4gLSBBbWVuZCB0aGUgY29tbWl0IGxvZy4NCj4+
IA0KPj4ga2VybmVsL3NjaGVkL2ZhaXIuYyB8IDQgKystLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+PiBpbmRleCAwNGZhOGRiY2Zh
NGQuLjE4YThmYzdiZDBkZSAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+
ICsrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+IEBAIC0zMDg2LDcgKzMwODYsNyBAQCBzdGF0
aWMgdm9pZCByZXdlaWdodF9lbnRpdHkoc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBzdHJ1Y3Qgc2No
ZWRfZW50aXR5ICpzZSwNCj4+IAkJLyogY29tbWl0IG91dHN0YW5kaW5nIGV4ZWN1dGlvbiB0aW1l
ICovDQo+PiAJCWlmIChjZnNfcnEtPmN1cnIgPT0gc2UpDQo+PiAJCQl1cGRhdGVfY3VycihjZnNf
cnEpOw0KPj4gLQkJYWNjb3VudF9lbnRpdHlfZGVxdWV1ZShjZnNfcnEsIHNlKTsNCj4+ICsJCXVw
ZGF0ZV9sb2FkX3N1YigmY2ZzX3JxLT5sb2FkLCBzZS0+bG9hZC53ZWlnaHQpOw0KPj4gCX0NCj4+
IAlkZXF1ZXVlX2xvYWRfYXZnKGNmc19ycSwgc2UpOw0KPj4gDQo+PiBAQCAtMzEwMiw3ICszMTAy
LDcgQEAgc3RhdGljIHZvaWQgcmV3ZWlnaHRfZW50aXR5KHN0cnVjdCBjZnNfcnEgKmNmc19ycSwg
c3RydWN0IHNjaGVkX2VudGl0eSAqc2UsDQo+PiANCj4+IAllbnF1ZXVlX2xvYWRfYXZnKGNmc19y
cSwgc2UpOw0KPj4gCWlmIChzZS0+b25fcnEpDQo+PiAtCQlhY2NvdW50X2VudGl0eV9lbnF1ZXVl
KGNmc19ycSwgc2UpOw0KPj4gKwkJdXBkYXRlX2xvYWRfYWRkKCZjZnNfcnEtPmxvYWQsIHNlLT5s
b2FkLndlaWdodCk7DQo+PiANCj4+IH0NCg0K
