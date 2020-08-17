Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43826C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBF32075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="hgmXb5ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHQMFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:05:18 -0400
Received: from mail6.tencent.com ([220.249.245.26]:42533 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgHQMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:05:16 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail6.tencent.com (Postfix) with ESMTP id 4CA5FCC431;
        Mon, 17 Aug 2020 20:06:25 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597665985;
        bh=KJ9gvPsiKZrynaHc0l7pc7d0ujBtW4cBWRjrzAbnCY8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=hgmXb5urcHAZfDte6iNZ512lNw76rpPb/4k+WztS7kVHfyrptd8hvGxxEmkxQGCmG
         1eN97Y6Mr1W1OS8SIvDqoIlPxJQdVDFi+lyRDb8BARdXHMqvq6fczyPsJRdUDdH6Sy
         M++8wEIPYyUeKEAvpcFnhXueIt0h3+vrY43e7eFY=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 17 Aug
 2020 20:05:09 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 17 Aug
 2020 20:05:09 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Mon, 17 Aug 2020 20:05:09 +0800
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
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DACABNlRgIAAJ90AgAYgFwCAAL04gIAA/wuAgAC/bYCAAQDpAIAB6mEAgAVOvgCAADR0AA==
Date:   Mon, 17 Aug 2020 12:05:09 +0000
Message-ID: <755BFAD0-9072-4D73-9CD7-AF4F74A79D21@tencent.com>
References: <20200801023248.90104-1-benbjiang@gmail.com>
 <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
 <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com>
 <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
 <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com>
 <5f870781-1648-b4ac-6026-557dfc347109@arm.com>
 <CCA1D942-3669-4216-92BD-768967B1ECE5@tencent.com>
 <4964e359-afc5-a256-4950-853a9485eeff@arm.com>
 <70236E62-AA36-48C1-9382-86353649253C@tencent.com>
 <3a1047fc-a86a-014a-b17a-eae71f669da1@arm.com>
 <643B0ECE-D758-4D08-8B1B-C70F34DD9943@tencent.com>
 <55f04582-69d6-aeb4-85be-3e46a3b15beb@arm.com>
In-Reply-To: <55f04582-69d6-aeb4-85be-3e46a3b15beb@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.32]
Content-Type: text/plain; charset="utf-8"
Content-ID: <921E77F0FBFFEA4EA426AD5F194CA6D7@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDE3LCAyMDIwLCBhdCA0OjU3IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0
bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMTQvMDgvMjAyMCAwMTo1NSwg
YmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwNCj4+IA0KPj4+IE9uIEF1ZyAxMywgMjAy
MCwgYXQgMjozOSBBTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29t
PiB3cm90ZToNCj4+PiANCj4+PiBPbiAxMi8wOC8yMDIwIDA1OjE5LCBiZW5iamlhbmco6JKL5b2q
KSB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+IA0KPj4+Pj4gT24gQXVnIDExLCAyMDIwLCBhdCAxMTo1
NCBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToN
Cj4+Pj4+IA0KPj4+Pj4gT24gMTEvMDgvMjAyMCAwMjo0MSwgYmVuYmppYW5nKOiSi+W9qikgd3Jv
dGU6DQo+Pj4+Pj4gSGksDQo+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIEF1ZyAxMCwgMjAyMCwgYXQgOToy
NCBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToN
Cj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDA2LzA4LzIwMjAgMTc6NTIsIGJlbmJqaWFuZyjokovlvaop
IHdyb3RlOg0KPj4+Pj4+Pj4gSGksIA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT24gQXVnIDYsIDIw
MjAsIGF0IDk6MjkgUE0sIERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNv
bT4gd3JvdGU6DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT24gMDMvMDgvMjAyMCAxMzoyNiwgYmVu
YmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+
Pj4+IE9uIEF1ZyAzLCAyMDIwLCBhdCA0OjE2IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFy
LmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBPbiAw
MS8wOC8yMDIwIDA0OjMyLCBKaWFuZyBCaWFvIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+IEZyb206IEpp
YW5nIEJpYW8gPGJlbmJqaWFuZ0B0ZW5jZW50LmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPj4+PiAq
KiAybm9ybWFsKzFpZGxlOiBpZGxlIHByZWVtcHQgbm9ybWFsIGV2ZXJ5IDYwMCttcyAqKg0KPj4+
IA0KPj4+IER1cmluZyB0aGUgMy4ycyB0aGUgMiBTQ0hFRF9PVEhFUiB0YXNrcyBydW4sIHRoZSBT
Q0hFRF9JRExFIHRhc2sgaXMNCj4+PiBzd2l0Y2hlZCBpbiBvbmx5IG9uY2UsIGFmdGVyIH4yLjVz
Lg0KPj4gVXNlIHlvdXIgY29uZmlnIHdpdGggbG9vcCBpbmNyZWFzZWQgZnJvbSAyMDAgdG8gMjAw
MCwgdG8gb2JzZXJ2ZSBsb25nZXIsDQo+PiANCj4+ICAgICAgICAgICA8Li4uPi0zNzYyMCBbMDAy
XSBkLi4uIDQ3OTUwLjQ0NjE5MTogc2NoZWRfc3dpdGNoOiBwcmV2X2NvbW09dGFza19vdGhlci0x
IHByZXZfcGlkPTM3NjIwIHByZXZfcHJpbz0xMjAgcHJldl9zdGF0ZT1TID09PiBuZXh0X2NvbW09
dGFza19pZGxlLTIgbmV4dF9waWQ9Mzc2MjEgbmV4dF9wcmlvPTEyMA0KPj4gICAgICAgICAgIDwu
Li4+LTM3NjE5IFswMDJdIGQuLi4gNDc5NTUuNjg3NzA5OiBzY2hlZF9zd2l0Y2g6IHByZXZfY29t
bT10YXNrX290aGVyLTAgcHJldl9waWQ9Mzc2MTkgcHJldl9wcmlvPTEyMCBwcmV2X3N0YXRlPVIg
PT0+IG5leHRfY29tbT10YXNrX2lkbGUtMiBuZXh0X3BpZD0zNzYyMSBuZXh0X3ByaW89MTIwDQo+
PiAvLyBUaGUgZmlyc3QgcHJlZW1wdGlvbiBpbnRlcnZhbCBpcyA1LjJzLg0KPj4gICAgICAgICAg
IDwuLi4+LTM3NjIwIFswMDJdIGQuLi4gNDc5NTYuMzc1NzE2OiBzY2hlZF9zd2l0Y2g6IHByZXZf
Y29tbT10YXNrX290aGVyLTEgcHJldl9waWQ9Mzc2MjAgcHJldl9wcmlvPTEyMCBwcmV2X3N0YXRl
PVIgPT0+IG5leHRfY29tbT10YXNrX2lkbGUtMiBuZXh0X3BpZD0zNzYyMSBuZXh0X3ByaW89MTIw
DQo+PiAgICAgICAgICAgPC4uLj4tMzc2MTkgWzAwMl0gZC4uLiA0Nzk1Ny4wNjA3MjI6IHNjaGVk
X3N3aXRjaDogcHJldl9jb21tPXRhc2tfb3RoZXItMCBwcmV2X3BpZD0zNzYxOSBwcmV2X3ByaW89
MTIwIHByZXZfc3RhdGU9UiA9PT4gbmV4dF9jb21tPXRhc2tfaWRsZS0yIG5leHRfcGlkPTM3NjIx
IG5leHRfcHJpbz0xMjANCj4+ICAgICAgICAgICA8Li4uPi0zNzYyMCBbMDAyXSBkLi4uIDQ3OTU3
Ljc0NzcyODogc2NoZWRfc3dpdGNoOiBwcmV2X2NvbW09dGFza19vdGhlci0xIHByZXZfcGlkPTM3
NjIwIHByZXZfcHJpbz0xMjAgcHJldl9zdGF0ZT1SID09PiBuZXh0X2NvbW09dGFza19pZGxlLTIg
bmV4dF9waWQ9Mzc2MjEgbmV4dF9wcmlvPTEyMA0KPj4gICAgICAgICAgPC4uLj4tMzc2MjAgWzAw
Ml0gZC4uLiA0Nzk1OC40MjM3MzQ6IHNjaGVkX3N3aXRjaDogcHJldl9jb21tPXRhc2tfb3RoZXIt
MSBwcmV2X3BpZD0zNzYyMCBwcmV2X3ByaW89MTIwIHByZXZfc3RhdGU9UiA9PT4gbmV4dF9jb21t
PXRhc2tfaWRsZS0yIG5leHRfcGlkPTM3NjIxIG5leHRfcHJpbz0xMjANCj4+ICAgICAgICAgICA8
Li4uPi0zNzYyMCBbMDAyXSBkLi4uIDQ3OTU5LjExOTc0MDogc2NoZWRfc3dpdGNoOiBwcmV2X2Nv
bW09dGFza19vdGhlci0xIHByZXZfcGlkPTM3NjIwIHByZXZfcHJpbz0xMjAgcHJldl9zdGF0ZT1S
ID09PiBuZXh0X2NvbW09dGFza19pZGxlLTIgbmV4dF9waWQ9Mzc2MjEgbmV4dF9wcmlvPTEyMA0K
Pj4gLy8gQWZ0ZXIgdGhlIGZpcnN0IHByZWVtcHRpb24sIHRoZSByZXN0IHByZWVtcHRpb24gaW50
ZXJ2YWxzIGFyZSBhbGwgYWJvdXQgNjAwbXMrLiA6KQ0KPiANCj4gQXJlIHlvdSBzdXJlIGFib3V0
IHRoaXM/DQpZZXMuIDopDQo+IA0KPiBUaGUgbWF0aCBpcyB0ZWxsaW5nIG1lIGZvciB0aGU6DQo+
IA0KPiBpZGxlIHRhc2s6ICAgICAgKDMgLyAoMTAyNCArIDEwMjQgKyAzKSleKC0xKSAqIDRtcyA9
IDI3MzVtcw0KPiANCj4gbm9ybWFsIHRhc2s6ICgxMDI0IC8gKDEwMjQgKyAxMDI0ICsgMykpXigt
MSkgKiA0bXMgPSAgICA4bXMNCj4gDQo+ICg0bXMgLSAyNTAgSHopDQpNeSB0aWNrIGlzIDFtcyAt
IDEwMDBIWiwgd2hpY2ggc2VlbXMgcmVhc29uYWJsZSBmb3IgNjAwbXM/IDopDQoNClRoeC4NClJl
Z2FyZHMsDQpKaWFuZw0KPiANCj4+Pj4gKiogM25vcm1hbCtpZGxlOiBpZGxlIHByZWVtcHQgbm9y
bWFsIGV2ZXJ5IDEwMDArbXMgKioNCj4+PiANCj4+PiBBaCwgdGhpcyB3YXMgbWVhbnQgdG8gYmUg
MyBTQ0hFRF9PVEhFUiB0YXNrcyBvbmx5ISBUbyBzZWUgdGhlIGRpZmZlcmVuY2UNCj4+PiBpbiBi
ZWhhdmlvci4NCj4+IFdpdGggMyBTQ0hFRF9PSFRFUiB0YXNrcyBvbmx5LCB0aGUgU0NIRURfT0hU
RVIgdGFzayBpcyBzd2l0Y2hlZCBpbg0KPj4gRXZlcnkgMjdtcy4NCj4gDQo+IG5vcm1hbCB0YXNr
OiAoMTAyNCAvICgxMDI0ICsgMTAyNCArIDEwMjQpKV4oLTEpICogNG1zID0gMTJtcw0KPiANCj4+
Pj4gKiogMm5vcm1hbChuaWNlIDE5KSsxaWRsZShuaWNlIDApOiBpZGxlIHByZWVtcHQgbm9ybWFs
IGV2ZXJ5IDMwK21zICoqDQo+Pj4gDQo+Pj4gRHVyaW5nIHRoZSAzLjJzIHRoZSAyIFNDSEVEX09U
SEVSIHRhc2tzIHJ1biwgdGhlIFNDSEVEX0lETEUgdGFzayBpcw0KPj4+IHN3aXRjaGVkIGluIGV2
ZXJ5IH40NW1zLg0KPj4gVGhhdOKAmXMgYXMgd2hhdCBJIGV4cGVjdGVkLiA6KQ0KPiANCj4gaWRs
ZSB0YXNrOiAgICAoMyAvICgxNSArIDE1ICsgMykpXigtMSkgKiA0bXMgPSA0NG1zDQo+IA0KPiBu
b3JtYWwgdGFzazogKDE1IC8gKDE1ICsgMTUgKyAzKSleKC0xKSAqIDRtcyA9ICA5bXMNCg0K
