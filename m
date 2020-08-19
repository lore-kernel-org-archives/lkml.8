Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D75C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5132C204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="XAcWNMQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHSOKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:10:50 -0400
Received: from mail4.tencent.com ([183.57.53.109]:33771 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHSOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:10:49 -0400
Received: from EX-SZ022.tencent.com (unknown [10.28.6.88])
        by mail4.tencent.com (Postfix) with ESMTP id AA7AA725D7;
        Wed, 19 Aug 2020 22:10:27 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597846227;
        bh=E87hWM9uFvcHqksx2lEMbWRDhEr4tutIdvUcXXTD2Y0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=XAcWNMQaqIY0w2hY2o4ncQPX6FCFmvnGZxovwFMyCzAETKS8wr9bQ5u3powGTyrSb
         1eEMUsLrrA9c29JqbmVWrjDPADcM9QHsnoXT9TAsjz8misAmZXPOdB/orLfBhXR4y+
         rBYHwmenWS20e8PAspTtxp6/zf/NUQ/1/iEyBIlo=
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ022.tencent.com
 (10.28.6.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 19 Aug
 2020 22:10:27 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ012.tencent.com
 (10.28.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 19 Aug
 2020 22:10:27 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Wed, 19 Aug 2020 22:10:24 +0800
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
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DACABNlRgIAAJ90AgAYgFwCAAL04gIAA/wuAgAC/bYCAAQDpAIAB6mEAgAVOvgCAADR0AIADDqgAgAA5AIA=
Date:   Wed, 19 Aug 2020 14:10:24 +0000
Message-ID: <D4389FC6-322C-4B0B-AF46-F3184B9E5606@tencent.com>
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
 <755BFAD0-9072-4D73-9CD7-AF4F74A79D21@tencent.com>
 <729675a2-b083-4211-62c0-f7ed7f483ae2@arm.com>
In-Reply-To: <729675a2-b083-4211-62c0-f7ed7f483ae2@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.56]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D203ABCF8563A2489EDC8209BB7703CE@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDE5LCAyMDIwLCBhdCA2OjQ2IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0
bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMTcvMDgvMjAyMCAxNDowNSwg
YmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEF1ZyAxNywgMjAyMCwg
YXQgNDo1NyBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3
cm90ZToNCj4+PiANCj4+PiBPbiAxNC8wOC8yMDIwIDAxOjU1LCBiZW5iamlhbmco6JKL5b2qKSB3
cm90ZToNCj4+Pj4gSGksDQo+Pj4+IA0KPj4+Pj4gT24gQXVnIDEzLCAyMDIwLCBhdCAyOjM5IEFN
LCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPj4+
Pj4gDQo+Pj4+PiBPbiAxMi8wOC8yMDIwIDA1OjE5LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToN
Cj4+Pj4+PiBIaSwNCj4+Pj4+PiANCj4+Pj4+Pj4gT24gQXVnIDExLCAyMDIwLCBhdCAxMTo1NCBQ
TSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToNCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDExLzA4LzIwMjAgMDI6NDEsIGJlbmJqaWFuZyjokovlvaopIHdy
b3RlOg0KPj4+Pj4+Pj4gSGksDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiBBdWcgMTAsIDIwMjAs
IGF0IDk6MjQgUE0sIERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4g
d3JvdGU6DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT24gMDYvMDgvMjAyMCAxNzo1MiwgYmVuYmpp
YW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+Pj4+IEhpLCANCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+
Pj4+PiBPbiBBdWcgNiwgMjAyMCwgYXQgOToyOSBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1h
ci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gT24g
MDMvMDgvMjAyMCAxMzoyNiwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+IE9uIEF1ZyAzLCAyMDIwLCBhdCA0OjE2IFBN
LCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPj4+
Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4gT24gMDEvMDgvMjAyMCAwNDozMiwgSmlhbmcgQmlh
byB3cm90ZToNCj4+Pj4+Pj4+Pj4+Pj4+IEZyb206IEppYW5nIEJpYW8gPGJlbmJqaWFuZ0B0ZW5j
ZW50LmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPj4+IEFyZSB5b3Ugc3VyZSBhYm91dCB0aGlzPw0K
Pj4gWWVzLiA6KQ0KPj4+IA0KPj4+IFRoZSBtYXRoIGlzIHRlbGxpbmcgbWUgZm9yIHRoZToNCj4+
PiANCj4+PiBpZGxlIHRhc2s6ICAgICAgKDMgLyAoMTAyNCArIDEwMjQgKyAzKSleKC0xKSAqIDRt
cyA9IDI3MzVtcw0KPj4+IA0KPj4+IG5vcm1hbCB0YXNrOiAoMTAyNCAvICgxMDI0ICsgMTAyNCAr
IDMpKV4oLTEpICogNG1zID0gICAgOG1zDQo+Pj4gDQo+Pj4gKDRtcyAtIDI1MCBIeikNCj4+IE15
IHRpY2sgaXMgMW1zIC0gMTAwMEhaLCB3aGljaCBzZWVtcyByZWFzb25hYmxlIGZvciA2MDBtcz8g
OikNCj4gDQo+IE9LLCBJIHNlZS4NCj4gDQo+IEJ1dCBoZXJlIHRoZSBkaWZmZXJlbnQgc2NoZWQg
c2xpY2VzIChjaGVja19wcmVlbXB0X3RpY2soKS0+DQo+IHNjaGVkX3NsaWNlKCkpIGJldHdlZW4g
bm9ybWFsIHRhc2tzIGFuZCB0aGUgaWRsZSB0YXNrIHBsYXkgYSByb2xlIHRvLg0KPiANCj4gTm9y
bWFsIHRhc2tzIGdldCB+M21zIHdoZXJlYXMgdGhlIGlkbGUgdGFzayBnZXRzIDwwLjAxbXMuDQo+
IA0KPiBTbyB0aGUgaWRsZSB0YXNrIHJ1bnMgZXZlcnkgfjY4MG1zIGJ1dCBvbmx5IGZvciAxIHRp
Y2sgKDFtcykgKDQgdGltZXMNCj4gbGVzcyB0aGFuIHRoZSBub3JtYWwgdGFza3MpLiBUaGUgY29u
ZGl0aW9uICdpZiAoZGVsdGFfZXhlYyA+DQo+IGlkZWFsX3J1bnRpbWUpJyBpbiBjaGVja19wcmVl
bXB0X3RpY2soKSBpcyBvbmx5IHRydWUgYXQgdGhlIDR0aCB0aWNrDQo+IHdoZW4gYSBub3JtYWwg
dGFzayBydW5zIGV2ZW4gdGhvdWdoIHRoZSBzbGljZSBpcyAzbXMuDQo+IA0KPiBJbiB0aGUgMjUw
IEh6IGV4YW1wbGUgdGhlIHNjaGVkIHNsaWNlIGRpZmZzIGFyZSBoaWRkZW4gYmVoaW5kIHRoZSA0
bXMgdGljay4NCkV4YWN0bHkuIFRpY2sgc2l6ZSBkZWNpZGVzIHRoZSBzaW5nbGUgcnVudGltZSBh
bmQgdGhlIGludGVydmFsIGJldHdlZW4NCnR3byBydW5zIG9mIGlkbGUgdGFzay4gDQpUaGF0IG1h
a2VzIHNlbnNlIGZvciBtb3N0IG9mIHRoZSB0ZXN0IHJlc3VsdHMgYWJvdmUuDQoNClRoeC4NClJl
Z2FyZHMsDQpKaWFuZw0KDQoNCg==
