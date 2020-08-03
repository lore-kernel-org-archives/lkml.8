Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D683AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AAB20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="nOXDzZ7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHCL0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:26:36 -0400
Received: from mail4.tencent.com ([183.57.53.109]:37196 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCL0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:26:35 -0400
Received: from EX-SZ022.tencent.com (unknown [10.28.6.88])
        by mail4.tencent.com (Postfix) with ESMTP id 40D4772527;
        Mon,  3 Aug 2020 19:26:30 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1596453990;
        bh=4gxuggMWH3oY8UWgheEK+vbB9l6Q89rn27r+LIz3pM8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=nOXDzZ7z5wYEGoByDmwqUp4Fo0uICXe5aBA8JoGagdRBr2Wd77q64q5iTWC0CQ+4U
         +93QXAIo0EQWxg6Zsoh5sSnRYYqNm9dZ64HSehcb1q6AfZhKVV3v001Ya8R4We6zZd
         3c8udd6aaQB/yo7nj+EGIvdsvkcXHB4MWeOCwL4o=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ022.tencent.com
 (10.28.6.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 3 Aug 2020
 19:26:30 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 3 Aug 2020
 19:26:29 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Mon, 3 Aug 2020 19:26:29 +0800
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
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DAA=
Date:   Mon, 3 Aug 2020 11:26:29 +0000
Message-ID: <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com>
References: <20200801023248.90104-1-benbjiang@gmail.com>
 <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
In-Reply-To: <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.15]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6B7BDA5CC92944DBCE59C411B35C5E8@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDMsIDIwMjAsIGF0IDQ6MTYgUE0sIERpZXRtYXIgRWdnZW1hbm4gPGRpZXRt
YXIuZWdnZW1hbm5AYXJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAwMS8wOC8yMDIwIDA0OjMyLCBK
aWFuZyBCaWFvIHdyb3RlOg0KPj4gRnJvbTogSmlhbmcgQmlhbyA8YmVuYmppYW5nQHRlbmNlbnQu
Y29tPg0KPj4gDQo+PiBObyBuZWVkIHRvIHByZWVtcHQgd2hlbiB0aGVyZSBhcmUgb25seSBvbmUg
cnVuYWJsZSBDRlMgdGFzayB3aXRoDQo+PiBvdGhlciBJRExFIHRhc2tzIG9uIHJ1bnF1ZXVlLiBU
aGUgb25seSBvbmUgQ0ZTIHRhc2sgd291bGQgYWx3YXlzDQo+PiBiZSBwaWNrZWQgaW4gdGhhdCBj
YXNlLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKaWFuZyBCaWFvIDxiZW5iamlhbmdAdGVuY2Vu
dC5jb20+DQo+PiAtLS0NCj4+IGtlcm5lbC9zY2hlZC9mYWlyLmMgfCAyICstDQo+PiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+PiBpbmRleCAw
NGZhOGRiY2ZhNGQuLjhmYjgwNjM2YjAxMCAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9zY2hlZC9m
YWlyLmMNCj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+IEBAIC00NTI3LDcgKzQ1Mjcs
NyBAQCBlbnRpdHlfdGljayhzdHJ1Y3QgY2ZzX3JxICpjZnNfcnEsIHN0cnVjdCBzY2hlZF9lbnRp
dHkgKmN1cnIsIGludCBxdWV1ZWQpDQo+PiAJCXJldHVybjsNCj4+ICNlbmRpZg0KPj4gDQo+PiAt
CWlmIChjZnNfcnEtPm5yX3J1bm5pbmcgPiAxKQ0KPj4gKwlpZiAoY2ZzX3JxLT5ucl9ydW5uaW5n
ID4gY2ZzX3JxLmlkbGVfaF9ucl9ydW5uaW5nICsgMSkNCj4gDQo+IGNmc19ycSBpcyBhIHBvaW50
ZXIuDQpJdCBpcy4gU29ycnkgYWJvdXQgdGhhdC4gOikNCg0KPiANCj4+IAkJY2hlY2tfcHJlZW1w
dF90aWNrKGNmc19ycSwgY3Vycik7DQo+PiB9DQo+IA0KPiBZb3UgY2FuJ3QgY29tcGFyZSBjZnNf
cnEtPm5yX3J1bm5pbmcgd2l0aCBjZnNfcnEtPmlkbGVfaF9ucl9ydW5uaW5nIQ0KPiANCj4gVGhl
cmUgaXMgYSBkaWZmZXJlbmNlIGJldHdlZW4gY2ZzX3JxLT5oX25yX3J1bm5pbmcgYW5kDQo+IGNm
c19ycS0+bnJfcnVubmluZy4gVGhlICdfaF8nIHN0YW5kcyBmb3IgaGllcmFyY2hpY2FsLg0KPiAN
Cj4gVGhlIGZvcm1lciBnaXZlcyB5b3UgaGllcmFyY2hpY2FsIHRhc2sgYWNjb3VudGluZyB3aGVy
ZWFzIHRoZSBsYXR0ZXIgaXMNCj4gdGhlIG51bWJlciBvZiBzY2hlZCBlbnRpdGllcyAocmVwcmVz
ZW50aW5nIHRhc2tzIG9yIHRhc2tncm91cHMpIGVucXVldWVkDQo+IGluIGNmc19ycS4NCj4gDQo+
IEluIGVudGl0eV90aWNrKCksIGNmc19ycS0+bnJfcnVubmluZyBoYXMgdG8gYmUgdXNlZCBmb3Ig
dGhlIGNvbmRpdGlvbiB0bw0KPiBjYWxsIGNoZWNrX3ByZWVtcHRfdGljaygpLiBXZSB3YW50IHRv
IGNoZWNrIGlmIGN1cnIgaGFzIHRvIGJlIHByZWVtcHRlZA0KPiBieSBfX3BpY2tfZmlyc3RfZW50
aXR5KGNmc19ycSkgb24gdGhpcyBjZnNfcnEuDQo+IA0KPiBlbnRpdHlfdGljaygpIGlzIGNhbGxl
ZCBmb3IgZWFjaCBzY2hlZCBlbnRpdHkgKGFuZCBzbyBmb3IgZWFjaA0KPiBjZnNfcnFfb2Yoc2Up
KSBvZiB0aGUgdGFzayBncm91cCBoaWVyYXJjaHkgKGUuZy4gdGFzayBwIHJ1bm5pbmcgaW4NCj4g
dGFza2dyb3VwIC9BL0IgOiBzZShwKSAtPiBzZShBL0IpIC0+IHNlKEEpKS4NClRoYXTigJlzIHRy
dWUuIEkgd2FzIHRoaW5raW5nIGFkZGluZyBhIG5ldyBjZnNfcnEtPmlkbGVfbnJfcnVubmluZyBt
ZW1iZXIgdG8NCnRyYWNrIHRoZSBwZXIgY2ZzX3JxJ3MgSURMRSB0YXNrIG51bWJlciwgYW5kIHJl
ZHVjaW5nIHByZWVtcHRpb24gaGVyZSBiYXNlZA0Kb24gdGhhdC4gDQpJ4oCZbSBub3Qgc3VyZSBp
ZiBpdOKAmXMgb2sgdG8gZG8gdGhhdCwgYmVjYXVzZSB0aGUgSURMRSBjbGFzcyBzZWVtcyBub3Qg
dG8gYmUgc28NCnB1cmUgdGhhdCBjb3VsZCB0b2xlcmF0ZSBzdGFydmluZy4NCldlIG5lZWQgYW4g
YWJzb2x1dGVseSBsb3cgcHJpb3JpdHkgY2xhc3MgdGhhdCBjb3VsZCB0b2xlcmF0ZSBzdGFydmlu
Zywgd2hpY2gNCmNvdWxkIGJlIHVzZWQgdG8gY28tbG9jYXRlIG9mZmxpbmUgdGFza3MuIEJ1dCBJ
RExFIGNsYXNzIHNlZW1zIHRvIGJlIG5vdA0KKmxvdyogZW5vdWdoLCBpZiBjb25zaWRlcmluZyB0
aGUgZmFpcm5lc3Mgb2YgQ0ZTLCBhbmQgSURMRSBjbGFzcyBzdGlsbCBoYXMgYQ0Kd2VpZ2h0Lg0K
DQpUaGFua3MgZm9yIHlvdSByZXBseS4NCg0KUmVnYXJkcywNCkppYW5n
