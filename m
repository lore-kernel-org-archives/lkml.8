Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0500C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF5120823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="lgdrE31e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgHFCm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:42:26 -0400
Received: from mail6.tencent.com ([220.249.245.26]:50822 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHFCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:42:24 -0400
Received: from EX-SZ023.tencent.com (unknown [10.28.6.89])
        by mail6.tencent.com (Postfix) with ESMTP id 479A3CC20F;
        Thu,  6 Aug 2020 10:43:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1596681813;
        bh=wKOV/o30dU9/jeWeVsG9+DiOLXyLVKPXQ6qCdEovapA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=lgdrE31e992IrGJ8fUPfHqtQ6pdLx7STu1M+JF6CyASUzTOhLpBPQcTdU5i5Dlkjh
         tNrYK05umoBPvxW6lenHymqG6/xjnhcdXsF7PhwJsMP/MV4+LpVyfnZpT59bpnWVdL
         FJYVV1aE0MmBURfL+g4GMkTgUze9qa4jBQHVEJz8=
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ023.tencent.com
 (10.28.6.89) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 6 Aug 2020
 10:42:21 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ005.tencent.com
 (10.28.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 6 Aug 2020
 10:42:20 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Thu, 6 Aug 2020 10:42:20 +0800
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
Subject: Re: [PATCH RFC] sched/fair: simplfy the work when reweighting entity
Thread-Topic: [PATCH RFC] sched/fair: simplfy the work when reweighting entity
Thread-Index: AQHWa5s0xag9SN0O3UOdnwnx3ZtsQA==
Date:   Thu, 6 Aug 2020 02:42:20 +0000
Message-ID: <8FA38F12-3CB4-46A9-B654-92DC384D3103@tencent.com>
References: <20200804071222.31675-1-benbjiang@tencent.com>
 <f9eab9a5-c7c2-dbf3-834b-abd9c376f92c@arm.com>
In-Reply-To: <f9eab9a5-c7c2-dbf3-834b-abd9c376f92c@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F75082341898C4C9D861FBDF1A65741@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDYsIDIwMjAsIGF0IDEyOjIxIEFNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0
bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMDQvMDgvMjAyMCAwOToxMiwg
SmlhbmcgQmlhbyB3cm90ZToNCj4+IElmIGEgc2UgaXMgb25fcnEgd2hlbiByZXdlaWdodGluZyBl
bnRpdHksIGFsbCB3ZSBuZWVkIHNob3VsZCBiZQ0KPj4gdXBkYXRpbmcgdGhlIGxvYWQgb2YgY2Zz
X3JxLCBvdGhlciBkZXF1ZXVlL2VucXVldWUgd29ya3MgY291bGQgYmUNCj4+IHJlZHVuZGFudCwg
c3VjaCBhcywNCj4+ICogYWNjb3VudF9udW1hX2RlcXVldWUvYWNjb3VudF9udW1hX2VucXVldWUN
Cj4+ICogbGlzdF9kZWwvbGlzdF9hZGQgZnJvbS9pbnRvIGNmc190YXNrcw0KPj4gKiBucl9ydW5u
aW5nLS0vbnJfcnVubmluZysrDQo+IA0KPiBJIHRoaW5rIHRoaXMgY291bGQgbWFrZSBzZW5zZS4g
SGF2ZSB5b3Ugc3BvdHRlZCBhIGNvZGUgcGF0aCB3aGVyZSB0aGlzDQo+IGdpdmVzIHlvdSBhIGNo
YW5nZT8NCj4gDQo+IEkgZ3Vlc3Mgb25seSBmb3IgYSB0YXNrIG9uIHRoZSBycSwgc286IGVudGl0
eV9pc190YXNrKHNlKSAmJiBzZS0+b25fcnENClllcywgeW91J3JlIHJpZ2h0LiBObyBvdGhlciBj
b2RlIHBhdGggSSBzcG90dGVkIGV4Y2VwdCB3aGF0IHlvdSBsaXN0IGJlbG93Lg0KDQo+IA0KPj4g
SnVzdCBzaW1wbGZ5IHRoZSB3b3JrLiBDb3VsZCBiZSBoZWxwZnVsIGZvciB0aGUgaG90IHBhdGgu
DQo+IA0KPiBJTUhPIGhvdHBhdGggaXMgdXBkYXRlX2Nmc19ncm91cCgpIC0+IHJld2VpZ2h0X2Vu
dGl0eSgpIGJ1dCB0aGlzIGlzIG9ubHkNCj4gY2FsbGVkIGZvciAnIWVudGl0eV9pc190YXNrKHNl
KScuDQo+IA0KPiBTZWUNCj4gDQo+IDMyOTAgICAgICAgICBpZiAoIWdjZnNfcnEpDQo+IDMyOTEg
ICAgICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IGluIHVwZGF0ZV9jZnNfZ3JvdXAoKS4NClll
cywgSXQgaXMuDQpCdXQgKm5yX3J1bm5pbmctLS9ucl9ydW5uaW5nKysqIHdvcmtzIGFyZSBzdGls
bCByZWR1bmRhbnQgZm9yDQrigJghZW50aXR5X2lzX3Rhc2soc2UpJyBob3QgcGF0aC4gOikNCkJl
c2lkZXMsIEkgZ3Vlc3Mgd2UgY291bGQgc2ltcGxpZnkgdGhlIGxvZ2ljIGFuZCBtYWtlIGl0IGNs
ZWFuZXIgYW5kDQptb3JlIHJlYWRhYmxlIHdpdGggdGhpcyBwYXRjaC4NCklmIGl0IGNvdWxkIG1h
a2Ugc2Vuc2UgdG8geW91LCB3b3VsZCB5b3UgbWluZCBpZiBJIHJlc2VuZCB0aGUgcGF0Y2gNCndp
dGggdGhlIGNvbW1pdCBsb2cgYW1lbmRlZD8NCg0KPiANCj4gVGhlICdlbnRpdHlfaXNfdGFzayhz
ZSknIGNhc2UgaXMNCj4gDQo+IHNldF9sb2FkX3dlaWdodChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAs
IC4uLikgLT4gcmV3ZWlnaHRfdGFzayhwLCAuLi4pIC0+DQo+IHJld2VpZ2h0X2VudGl0eSguLi4s
ICZwLT5zZSwgLi4uKQ0KPiANCj4gYnV0IGhlcmUgIXNlLT5vbl9ycS4NClllcywgaW5kZWVkLg0K
DQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMuDQpSZWdhcmRzLA0KSmlhbmcNCg0KPiAN
Cj4+IFNpZ25lZC1vZmYtYnk6IEppYW5nIEJpYW8gPGJlbmJqaWFuZ0B0ZW5jZW50LmNvbT4NCj4+
IC0tLQ0KPj4ga2VybmVsL3NjaGVkL2ZhaXIuYyB8IDQgKystLQ0KPj4gMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+PiBpbmRleCAwNGZhOGRi
Y2ZhNGQuLjE4YThmYzdiZDBkZSAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9zY2hlZC9mYWlyLmMN
Cj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+IEBAIC0zMDg2LDcgKzMwODYsNyBAQCBz
dGF0aWMgdm9pZCByZXdlaWdodF9lbnRpdHkoc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBzdHJ1Y3Qg
c2NoZWRfZW50aXR5ICpzZSwNCj4+IAkJLyogY29tbWl0IG91dHN0YW5kaW5nIGV4ZWN1dGlvbiB0
aW1lICovDQo+PiAJCWlmIChjZnNfcnEtPmN1cnIgPT0gc2UpDQo+PiAJCQl1cGRhdGVfY3Vycihj
ZnNfcnEpOw0KPj4gLQkJYWNjb3VudF9lbnRpdHlfZGVxdWV1ZShjZnNfcnEsIHNlKTsNCj4+ICsJ
CXVwZGF0ZV9sb2FkX3N1YigmY2ZzX3JxLT5sb2FkLCBzZS0+bG9hZC53ZWlnaHQpOw0KPj4gCX0N
Cj4+IAlkZXF1ZXVlX2xvYWRfYXZnKGNmc19ycSwgc2UpOw0KPj4gDQo+PiBAQCAtMzEwMiw3ICsz
MTAyLDcgQEAgc3RhdGljIHZvaWQgcmV3ZWlnaHRfZW50aXR5KHN0cnVjdCBjZnNfcnEgKmNmc19y
cSwgc3RydWN0IHNjaGVkX2VudGl0eSAqc2UsDQo+PiANCj4+IAllbnF1ZXVlX2xvYWRfYXZnKGNm
c19ycSwgc2UpOw0KPj4gCWlmIChzZS0+b25fcnEpDQo+PiAtCQlhY2NvdW50X2VudGl0eV9lbnF1
ZXVlKGNmc19ycSwgc2UpOw0KPj4gKwkJdXBkYXRlX2xvYWRfYWRkKCZjZnNfcnEtPmxvYWQsIHNl
LT5sb2FkLndlaWdodCk7DQo+PiANCj4+IH0NCj4gDQoNCg==
