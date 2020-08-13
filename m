Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB322068E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="aesGA6E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHMXzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 19:55:19 -0400
Received: from mail6.tencent.com ([220.249.245.26]:56717 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHMXzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 19:55:19 -0400
Received: from EX-SZ022.tencent.com (unknown [10.28.6.88])
        by mail6.tencent.com (Postfix) with ESMTP id 74D14CC387;
        Fri, 14 Aug 2020 07:56:29 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597362989;
        bh=aDH7gtnVbNeVDTznZZXV3zRhQ6rN4jnONoaQNx7MQJM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=aesGA6E2MdMvdz5D+aEWc9YRs+M0lKZ0JISMG4Y/HhKHtPRvYSu252/99rLN0ktec
         ThZZimOI583ZJjor8eUcnRfUSzaZHFDmHWtZUCto4s+PIgoShShlxPCPsT963Ftr1j
         SoNwtLw0N/3dD4ybV+I2lXIvwQmWScjtNDmDSJZg=
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ022.tencent.com
 (10.28.6.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 14 Aug
 2020 07:55:15 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ006.tencent.com
 (10.28.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 14 Aug
 2020 07:55:14 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Fri, 14 Aug 2020 07:55:14 +0800
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
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DACABNlRgIAAJ90AgAYgFwCAAL04gIAA/wuAgAC/bYCAAQDpAIAB6mEA
Date:   Thu, 13 Aug 2020 23:55:14 +0000
Message-ID: <643B0ECE-D758-4D08-8B1B-C70F34DD9943@tencent.com>
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
In-Reply-To: <3a1047fc-a86a-014a-b17a-eae71f669da1@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.114]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7A5164A0B98B344977F57167BD4ADDE@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gQXVnIDEzLCAyMDIwLCBhdCAyOjM5IEFNLCBEaWV0bWFyIEVnZ2VtYW5uIDxk
aWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMTIvMDgvMjAyMCAwNTox
OSwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwNCj4+IA0KPj4+IE9uIEF1ZyAxMSwg
MjAyMCwgYXQgMTE6NTQgUE0sIERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJt
LmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gMTEvMDgvMjAyMCAwMjo0MSwgYmVuYmppYW5nKOiS
i+W9qikgd3JvdGU6DQo+Pj4+IEhpLA0KPj4+PiANCj4+Pj4+IE9uIEF1ZyAxMCwgMjAyMCwgYXQg
OToyNCBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90
ZToNCj4+Pj4+IA0KPj4+Pj4gT24gMDYvMDgvMjAyMCAxNzo1MiwgYmVuYmppYW5nKOiSi+W9qikg
d3JvdGU6DQo+Pj4+Pj4gSGksIA0KPj4+Pj4+IA0KPj4+Pj4+PiBPbiBBdWcgNiwgMjAyMCwgYXQg
OToyOSBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90
ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDAzLzA4LzIwMjAgMTM6MjYsIGJlbmJqaWFuZyjokovl
vaopIHdyb3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiBBdWcgMywgMjAy
MCwgYXQgNDoxNiBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29t
PiB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiAwMS8wOC8yMDIwIDA0OjMyLCBKaWFu
ZyBCaWFvIHdyb3RlOg0KPj4+Pj4+Pj4+PiBGcm9tOiBKaWFuZyBCaWFvIDxiZW5iamlhbmdAdGVu
Y2VudC5jb20+DQo+IA0KPiBbLi4uXQ0KPiANCj4+PiBUcmFjZSBhIHJ1biBvZiAyIFNDSEVEX09U
SEVSIChuaWNlIDApIHRhc2tzIGFuZCAxIFNDSEVEX0lETEUgdGFzayBvbiBhDQo+Pj4gc2luZ2xl
IENQVSBhbmQgdHJhY2VfcHJpbnRrIHRoZSBjb25kaXRpb25zICAnaWYgKGRlbHRhIDwgMCknIGFu
ZCAnIGlmDQo+Pj4gKGRlbHRhID4gaWRlYWxfcnVudGltZSknIGluIGNoZWNrX3ByZWVtcHRfdGlj
aygpLg0KPj4+IA0KPj4+IFRoZW4gZG8gdGhlIHNhbWUgd2l0aCAzIFNDSEVEX09USEVSIChuaWNl
IDApIHRhc2tzLiBZb3UgY2FuIGFsc28gY2hhbmdlDQo+Pj4gdGhlIG5pY2VuZXNzIG9mIHRoZSAy
IFNDSEVEX09USEVSIHRhc2sgdG8gMTkgdG8gc2VlIHNvbWUgZGlmZmVyZW5jZXMgaW4NCj4+PiB0
aGUga2VybmVsc2hhcmsncyB0YXNrIGxheW91dC4NCj4+PiANCj4+PiBydC1hcHAgKGh0dHBzOi8v
Z2l0aHViLmNvbS9zY2hlZHVsZXItdG9vbHMvcnQtYXBwKSBpcyBhIG5pY2UgdG9vbCB0bw0KPj4+
IGNyYWZ0IHRob3NlIGFydGlmaWNpYWwgdXNlIGNhc2VzLg0KPj4gV2l0aCBydC1hcHAgdG9vbCwg
c2NoZWRfc3dpdGNoIHRyYWNlZCBieSBmdHJhY2UsIHRoZSByZXN1bHQgaXMgYXMgd2hhdCBJIGV4
cGVjdGVkLA0KPiANCj4gSSB1c2U6IA0KPiANCj4gew0KPiAgICAgICAgInRhc2tzIiA6IHsNCj4g
ICAgICAgICAgICAgICAgInRhc2tfb3RoZXIiIDogew0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICJpbnN0YW5jZSIgOiAyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICJsb29wIiA6IDIwMCwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAicG9saWN5IiA6ICJTQ0hFRF9PVEhFUiIsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgInJ1biIgOiA4MDAwLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICJ0aW1lciIgOiB7ICJyZWYiIDogInVuaXF1ZTEiICwgInBlcmlvZCIgOiAxNjAwMCwgIm1v
ZGUiIDogImFic29sdXRlIiB9LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICJwcmlvcml0eSIg
OiAwDQo+ICAgICAgICAgICAgICAgIH0sDQo+ICAgICAgICAgICAgICAgICJ0YXNrX2lkbGUiIDog
ew0KPiAgICAgICAgICAgICAgICAgICAgICAgICJpbnN0YW5jZSIgOiAxLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICJsb29wIiA6IDIwMCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAicG9s
aWN5IiA6ICJTQ0hFRF9JRExFIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAicnVuIiA6IDgw
MDAsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgInRpbWVyIiA6IHsgInJlZiIgOiAidW5pcXVl
MiIgLCAicGVyaW9kIiA6IDE2MDAwLCAibW9kZSIgOiAiYWJzb2x1dGUiIH0NCj4gICAgICAgICAg
ICAgICAgfQ0KPiAgICAgICAgfSwNCj4gICAgICAgICJnbG9iYWwiIDogew0KPiAgICAgICAgICAg
ICAgICAiY2FsaWJyYXRpb24iIDogMjQzLCA8LS0gSGFzIHRvIGJlIGNhbGlicmF0ZWQgYWdhaW5z
dCB0aGUgQ1BVIHlvdSBydW4gb24gISEhDQo+ICAgICAgICAgICAgICAgICJkZWZhdWx0X3BvbGlj
eSIgOiAiU0NIRURfT1RIRVIiLA0KPiAgICAgICAgICAgICAgICAiZHVyYXRpb24iIDogLTENCj4g
ICAgICAgIH0NCj4gfQ0KPiANCj4gdG8gaGF2ZSAyIChwZXJpb2RpYykgU0NIRURfT1RIRVIgYW5k
IDEgU0NIRURfSURMRSB0YXNrLiANCj4gDQo+PiAqKiAybm9ybWFsKzFpZGxlOiBpZGxlIHByZWVt
cHQgbm9ybWFsIGV2ZXJ5IDYwMCttcyAqKg0KPiANCj4gRHVyaW5nIHRoZSAzLjJzIHRoZSAyIFND
SEVEX09USEVSIHRhc2tzIHJ1biwgdGhlIFNDSEVEX0lETEUgdGFzayBpcw0KPiBzd2l0Y2hlZCBp
biBvbmx5IG9uY2UsIGFmdGVyIH4yLjVzLg0KVXNlIHlvdXIgY29uZmlnIHdpdGggbG9vcCBpbmNy
ZWFzZWQgZnJvbSAyMDAgdG8gMjAwMCwgdG8gb2JzZXJ2ZSBsb25nZXIsDQoNCiAgICAgICAgICAg
PC4uLj4tMzc2MjAgWzAwMl0gZC4uLiA0Nzk1MC40NDYxOTE6IHNjaGVkX3N3aXRjaDogcHJldl9j
b21tPXRhc2tfb3RoZXItMSBwcmV2X3BpZD0zNzYyMCBwcmV2X3ByaW89MTIwIHByZXZfc3RhdGU9
UyA9PT4gbmV4dF9jb21tPXRhc2tfaWRsZS0yIG5leHRfcGlkPTM3NjIxIG5leHRfcHJpbz0xMjAN
CiAgICAgICAgICAgPC4uLj4tMzc2MTkgWzAwMl0gZC4uLiA0Nzk1NS42ODc3MDk6IHNjaGVkX3N3
aXRjaDogcHJldl9jb21tPXRhc2tfb3RoZXItMCBwcmV2X3BpZD0zNzYxOSBwcmV2X3ByaW89MTIw
IHByZXZfc3RhdGU9UiA9PT4gbmV4dF9jb21tPXRhc2tfaWRsZS0yIG5leHRfcGlkPTM3NjIxIG5l
eHRfcHJpbz0xMjANCi8vIFRoZSBmaXJzdCBwcmVlbXB0aW9uIGludGVydmFsIGlzIDUuMnMuDQog
ICAgICAgICAgIDwuLi4+LTM3NjIwIFswMDJdIGQuLi4gNDc5NTYuMzc1NzE2OiBzY2hlZF9zd2l0
Y2g6IHByZXZfY29tbT10YXNrX290aGVyLTEgcHJldl9waWQ9Mzc2MjAgcHJldl9wcmlvPTEyMCBw
cmV2X3N0YXRlPVIgPT0+IG5leHRfY29tbT10YXNrX2lkbGUtMiBuZXh0X3BpZD0zNzYyMSBuZXh0
X3ByaW89MTIwDQogICAgICAgICAgIDwuLi4+LTM3NjE5IFswMDJdIGQuLi4gNDc5NTcuMDYwNzIy
OiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT10YXNrX290aGVyLTAgcHJldl9waWQ9Mzc2MTkgcHJl
dl9wcmlvPTEyMCBwcmV2X3N0YXRlPVIgPT0+IG5leHRfY29tbT10YXNrX2lkbGUtMiBuZXh0X3Bp
ZD0zNzYyMSBuZXh0X3ByaW89MTIwDQogICAgICAgICAgIDwuLi4+LTM3NjIwIFswMDJdIGQuLi4g
NDc5NTcuNzQ3NzI4OiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT10YXNrX290aGVyLTEgcHJldl9w
aWQ9Mzc2MjAgcHJldl9wcmlvPTEyMCBwcmV2X3N0YXRlPVIgPT0+IG5leHRfY29tbT10YXNrX2lk
bGUtMiBuZXh0X3BpZD0zNzYyMSBuZXh0X3ByaW89MTIwDQogICAgICAgICAgPC4uLj4tMzc2MjAg
WzAwMl0gZC4uLiA0Nzk1OC40MjM3MzQ6IHNjaGVkX3N3aXRjaDogcHJldl9jb21tPXRhc2tfb3Ro
ZXItMSBwcmV2X3BpZD0zNzYyMCBwcmV2X3ByaW89MTIwIHByZXZfc3RhdGU9UiA9PT4gbmV4dF9j
b21tPXRhc2tfaWRsZS0yIG5leHRfcGlkPTM3NjIxIG5leHRfcHJpbz0xMjANCiAgICAgICAgICAg
PC4uLj4tMzc2MjAgWzAwMl0gZC4uLiA0Nzk1OS4xMTk3NDA6IHNjaGVkX3N3aXRjaDogcHJldl9j
b21tPXRhc2tfb3RoZXItMSBwcmV2X3BpZD0zNzYyMCBwcmV2X3ByaW89MTIwIHByZXZfc3RhdGU9
UiA9PT4gbmV4dF9jb21tPXRhc2tfaWRsZS0yIG5leHRfcGlkPTM3NjIxIG5leHRfcHJpbz0xMjAN
Ci8vIEFmdGVyIHRoZSBmaXJzdCBwcmVlbXB0aW9uLCB0aGUgcmVzdCBwcmVlbXB0aW9uIGludGVy
dmFscyBhcmUgYWxsIGFib3V0IDYwMG1zKy4gOikNCg0KPiANCj4+ICoqIDNub3JtYWwraWRsZTog
aWRsZSBwcmVlbXB0IG5vcm1hbCBldmVyeSAxMDAwK21zICoqDQo+IA0KPiBBaCwgdGhpcyB3YXMg
bWVhbnQgdG8gYmUgMyBTQ0hFRF9PVEhFUiB0YXNrcyBvbmx5ISBUbyBzZWUgdGhlIGRpZmZlcmVu
Y2UNCj4gaW4gYmVoYXZpb3IuDQpXaXRoIDMgU0NIRURfT0hURVIgdGFza3Mgb25seSwgdGhlIFND
SEVEX09IVEVSIHRhc2sgaXMgc3dpdGNoZWQgaW4NCkV2ZXJ5IDI3bXMuDQoNCj4gDQo+PiAqKiAy
bm9ybWFsKG5pY2UgMTkpKzFpZGxlKG5pY2UgMCk6IGlkbGUgcHJlZW1wdCBub3JtYWwgZXZlcnkg
MzArbXMgKioNCj4gDQo+IER1cmluZyB0aGUgMy4ycyB0aGUgMiBTQ0hFRF9PVEhFUiB0YXNrcyBy
dW4sIHRoZSBTQ0hFRF9JRExFIHRhc2sgaXMNCj4gc3dpdGNoZWQgaW4gZXZlcnkgfjQ1bXMuDQpU
aGF04oCZcyBhcyB3aGF0IEkgZXhwZWN0ZWQuIDopDQoNClRoeC4NClJlZ2FyZHMsDQpKaWFuZw0K
PiANCj4gWy4uLl0NCg0K
