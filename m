Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D39C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C8C207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="AhyFHw5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHNHyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:54:45 -0400
Received: from mail6.tencent.com ([220.249.245.26]:51401 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgHNHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:54:45 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail6.tencent.com (Postfix) with ESMTP id F04FECC21D;
        Fri, 14 Aug 2020 15:55:53 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597391754;
        bh=o850WcbSMqnLKm9YBAzQLyImyavWOHQw53EezhFEJYM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=AhyFHw5BYaPa1+shhBmkBPubHWeettt5eBk31OP85zUDld280nge12vd74Z+6HJJz
         ck2GRcsurVOaLBxSdiYaRvE3FOTAsAwcKztJ2xj2d+KUdakfyAEWI1gAfAjh+EduSh
         Flxx562w6IgRdsMDUve/KDNQXsK5Wl0xWLgAc8UU=
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 14 Aug
 2020 15:54:39 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ012.tencent.com
 (10.28.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 14 Aug
 2020 15:54:39 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Fri, 14 Aug 2020 15:54:39 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Thomas Glexiner" <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Subhra Mazumdar" <subhra.mazumdar@oracle.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Subject: Re: [RFC PATCH 00/16] Core scheduling v6(Internet mail)
Thread-Topic: [RFC PATCH 00/16] Core scheduling v6(Internet mail)
Thread-Index: AQHWTyYIdUbfm2uvOEagav1FxQIttakluk8AgACOfACAAkvVAIAHH5EAgAPAXACAAWIeAIAAWUGAgAFOmgCAABOzAIAAKUkAgAAUpQCAACvBAA==
Date:   Fri, 14 Aug 2020 07:54:39 +0000
Message-ID: <8276AA2B-72D9-4B2A-9F50-E6C2744BB9E8@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
 <20200809164408.GA342447@google.com>
 <162a03cc-66c3-1999-83a2-deaad5aa04c8@linux.intel.com>
 <20200812230850.GA3511387@google.com>
 <5a39735d-dfd8-bdec-f068-81895799640e@linux.intel.com>
 <FAC73DE7-BAE0-42D3-BE9A-227C12275C34@tencent.com>
 <89d973d1-1302-17a6-c647-ea7c538c2747@linux.intel.com>
 <18263ED7-88B3-4DED-9714-55D9D2EB69D9@tencent.com>
 <97a82444-77ab-dbd2-f765-0d818f94ca0b@linux.intel.com>
In-Reply-To: <97a82444-77ab-dbd2-f765-0d818f94ca0b@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.15]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A35B58A183D650499AE91C0A7C8CE1DE@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gQXVnIDE0LCAyMDIwLCBhdCAxOjE4IFBNLCBMaSwgQXVicmV5IDxhdWJyZXku
bGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjAvOC8xNCAxMjowNCwgYmVu
YmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEF1ZyAxNCwgMjAyMCwgYXQg
OTozNiBBTSwgTGksIEF1YnJleSA8YXVicmV5LmxpQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+
Pj4gDQo+Pj4gT24gMjAyMC84LzE0IDg6MjYsIGJlbmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+
PiANCj4+Pj4gDQo+Pj4+PiBPbiBBdWcgMTMsIDIwMjAsIGF0IDEyOjI4IFBNLCBMaSwgQXVicmV5
IDxhdWJyZXkubGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gMjAy
MC84LzEzIDc6MDgsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+Pj4+IE9uIFdlZCwgQXVnIDEy
LCAyMDIwIGF0IDEwOjAxOjI0QU0gKzA4MDAsIExpLCBBdWJyZXkgd3JvdGU6DQo+Pj4+Pj4+IEhp
IEpvZWwsDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBPbiAyMDIwLzgvMTAgMDo0NCwgSm9lbCBGZXJuYW5k
ZXMgd3JvdGU6DQo+Pj4+Pj4+PiBIaSBBdWJyZXksDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IEFwb2xv
Z2llcyBmb3IgcmVwbHlpbmcgbGF0ZSBhcyBJIHdhcyBzdGlsbCBsb29raW5nIGludG8gdGhlIGRl
dGFpbHMuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IE9uIFdlZCwgQXVnIDA1LCAyMDIwIGF0IDExOjU3
OjIwQU0gKzA4MDAsIExpLCBBdWJyZXkgd3JvdGU6DQo+Pj4+Pj4+PiBbLi4uXQ0KPj4+Pj4+Pj4+
ICsvKg0KPj4+Pj4+Pj4+ICsgKiBDb3JlIHNjaGVkdWxpbmcgcG9saWN5Og0KPj4+Pj4+Pj4+ICsg
KiAtIENPUkVfU0NIRURfRElTQUJMRUQ6IGNvcmUgc2NoZWR1bGluZyBpcyBkaXNhYmxlZC4NCj4+
Pj4+Pj4+PiArICogLSBDT1JFX0NPT0tJRV9NQVRDSDogdGFza3Mgd2l0aCBzYW1lIGNvb2tpZSBj
YW4gcnVuDQo+Pj4+Pj4+Pj4gKyAqICAgICAgICAgICAgICAgICAgICAgb24gdGhlIHNhbWUgY29y
ZSBjb25jdXJyZW50bHkuDQo+Pj4+Pj4+Pj4gKyAqIC0gQ09SRV9DT09LSUVfVFJVU1Q6IHRydXN0
ZWQgdGFzayBjYW4gcnVuIHdpdGgga2VybmVsDQo+Pj4+Pj4+Pj4gCQkJdGhyZWFkIG9uIHRoZSBz
YW1lIGNvcmUgY29uY3VycmVudGx5LiANCj4+Pj4+Pj4+PiArICogLSBDT1JFX0NPT0tJRV9MT05F
TFk6IHRhc2tzIHdpdGggY29va2llIGNhbiBydW4gb25seQ0KPj4+Pj4+Pj4+ICsgKiAgICAgICAg
ICAgICAgICAgICAgIHdpdGggaWRsZSB0aHJlYWQgb24gdGhlIHNhbWUgY29yZS4NCj4+Pj4+Pj4+
PiArICovDQo+Pj4+Pj4+Pj4gK2VudW0gY29yZXNjaGVkX3BvbGljeSB7DQo+Pj4+Pj4+Pj4gKyAg
ICAgICBDT1JFX1NDSEVEX0RJU0FCTEVELA0KPj4+Pj4+Pj4+ICsgICAgICAgQ09SRV9TQ0hFRF9D
T09LSUVfTUFUQ0gsDQo+Pj4+Pj4+Pj4gKwlDT1JFX1NDSEVEX0NPT0tJRV9UUlVTVCwNCj4+Pj4+
Pj4+PiArICAgICAgIENPUkVfU0NIRURfQ09PS0lFX0xPTkVMWSwNCj4+Pj4+Pj4+PiArfTsNCj4+
Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBXZSBjYW4gc2V0IHBvbGljeSB0byBDT1JFX0NPT0tJRV9UUlVT
VCBvZiB1cGVyZiBjZ3JvdXAgYW5kIGZpeCB0aGlzIGtpbmQNCj4+Pj4+Pj4+PiBvZiBwZXJmb3Jt
YW5jZSByZWdyZXNzaW9uLiBOb3Qgc3VyZSBpZiB0aGlzIHNvdW5kcyBhdHRyYWN0aXZlPw0KPj4+
Pj4+Pj4gDQo+Pj4+Pj4+PiBJbnN0ZWFkIG9mIHRoaXMsIEkgdGhpbmsgaXQgY2FuIGJlIHNvbWV0
aGluZyBzaW1wbGVyIElNSE86DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IDEuIENvbnNpZGVyIGFsbCBj
b29raWUtMCB0YXNrIGFzIHRydXN0ZWQuIChFdmVuIHJpZ2h0IG5vdywgaWYgeW91IGFwcGx5IHRo
ZQ0KPj4+Pj4+Pj4gY29yZS1zY2hlZHVsaW5nIHBhdGNoc2V0LCBzdWNoIHRhc2tzIHdpbGwgc2hh
cmUgYSBjb3JlIGFuZCBzbmlmZiBvbiBlYWNoDQo+Pj4+Pj4+PiBvdGhlci4gU28gbGV0IHVzIG5v
dCBwcmV0ZW5kIHRoYXQgc3VjaCB0YXNrcyBhcmUgbm90IHRydXN0ZWQpLg0KPj4+Pj4+Pj4gDQo+
Pj4+Pj4+PiAyLiBBbGwga2VybmVsIHRocmVhZHMgYW5kIGlkbGUgdGFzayB3b3VsZCBoYXZlIGEg
Y29va2llIDAgKHNvIHRoYXQgd2lsbCBjb3Zlcg0KPj4+Pj4+Pj4ga3NvZnRpcnFkIHJlcG9ydGVk
IGluIHlvdXIgb3JpZ2luYWwgaXNzdWUpLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiAzLiBBZGQgYSBj
b25maWcgb3B0aW9uIChDT05GSUdfU0NIRURfQ09SRV9ERUZBVUxUX1RBU0tTX1VOVFJVU1RFRCku
IERlZmF1bHQNCj4+Pj4+Pj4+IGVuYWJsZSBpdC4gU2V0dGluZyB0aGlzIG9wdGlvbiB3b3VsZCB0
YWcgYWxsIHRhc2tzIHRoYXQgYXJlIGZvcmtlZCBmcm9tIGENCj4+Pj4+Pj4+IGNvb2tpZS0wIHRh
c2sgd2l0aCB0aGVpciBvd24gY29va2llLiBMYXRlciBvbiwgc3VjaCB0YXNrcyBjYW4gYmUgYWRk
ZWQgdG8NCj4+Pj4+Pj4+IGEgZ3JvdXAuIFRoaXMgY292ZXIncyBQZXRlcloncyBhc2sgYWJvdXQg
aGF2aW5nICdkZWZhdWx0IHVudHJ1c3RlZCcpLg0KPj4+Pj4+Pj4gKFVzZXJzIGxpa2UgQ2hyb21l
T1MgdGhhdCBkb24ndCB3YW50IHRvIHVzZXJzcGFjZSBzeXN0ZW0gcHJvY2Vzc2VzIHRvIGJlDQo+
Pj4+Pj4+PiB0YWdnZWQgY2FuIGRpc2FibGUgdGhpcyBvcHRpb24gc28gc3VjaCB0YXNrcyB3aWxs
IGJlIGNvb2tpZS0wKS4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gNC4gQWxsb3cgcHJjdGwvY2dyb3Vw
IGludGVyZmFjZXMgdG8gY3JlYXRlIGdyb3VwcyBvZiB0YXNrcyBhbmQgb3ZlcnJpZGUgdGhlDQo+
Pj4+Pj4+PiBhYm92ZSBiZWhhdmlvcnMuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBIb3cgZG9lcyB1cGVy
ZiBpbiBhIGNncm91cCB3b3JrIHdpdGgga3NvZnRpcnFkPyBBcmUgeW91IHN1Z2dlc3RpbmcgSSBz
ZXQgdXBlcmYncw0KPj4+Pj4+PiBjb29raWUgdG8gYmUgY29va2llLTAgdmlhIHByY3RsPw0KPj4+
Pj4+IA0KPj4+Pj4+IFllcywgYnV0IGxldCBtZSB0cnkgdG8gdW5kZXJzdGFuZCBiZXR0ZXIuIFRo
ZXJlIGFyZSAyIHByb2JsZW1zIGhlcmUgSSB0aGluazoNCj4+Pj4+PiANCj4+Pj4+PiAxLiBrc29m
dGlycWQgZ2V0dGluZyBpZGxlZCB3aGVuIEhUIGlzIHR1cm5lZCBvbiwgYmVjYXVzZSB1cGVyZiBp
cyBzaGFyaW5nIGENCj4+Pj4+PiBjb3JlIHdpdGggaXQ6IFRoaXMgc2hvdWxkIG5vdCBiZSBhbnkg
d29yc2UgdGhhbiBTTVQgT0ZGLCBiZWNhdXNlIGV2ZW4gU01UIE9GRg0KPj4+Pj4+IHdvdWxkIGFs
c28gcmVkdWNlIGtzb2Z0aXJxZCdzIENQVSB0aW1lIGp1c3QgY29yZSBzY2hlZCBpcyBkb2luZy4g
U3VyZQ0KPj4+Pj4+IGNvcmUtc2NoZWR1bGluZyBhZGRzIHNvbWUgb3ZlcmhlYWQgd2l0aCBJUElz
IGJ1dCBzdWNoIGEgaHVnZSBkcm9wIG9mIHBlcmYgaXMNCj4+Pj4+PiBzdHJhbmdlLiBQZXRlciBh
bnkgdGhvdWdodHMgb24gdGhhdD8NCj4+Pj4+PiANCj4+Pj4+PiAyLiBJbnRlcmZhY2U6IFRvIHNv
bHZlIHRoZSBwZXJmb3JtYW5jZSBwcm9ibGVtLCB5b3UgYXJlIHNheWluZyB5b3Ugd2FudCB1cGVy
Zg0KPj4+Pj4+IHRvIHNoYXJlIGEgY29yZSB3aXRoIGtzb2Z0aXJxZCBzbyB0aGF0IGl0IGlzIG5v
dCBmb3JjZWQgaW50byBpZGxlLiAgV2h5IG5vdA0KPj4+Pj4+IGp1c3Qga2VlcCB1cGVyZiBvdXQg
b2YgdGhlIGNncm91cD8NCj4+Pj4+IA0KPj4+Pj4gSSBndWVzcyB0aGlzIGlzIHVuYWNjZXB0YWJs
ZSBmb3Igd2hvIHJ1bnMgdGhlaXIgYXBwcyBpbiBjb250YWluZXIgYW5kIHZtLg0KPj4+PiBJTUhP
LCAganVzdCBhcyBKb2VsIHByb3Bvc2VkLCANCj4+Pj4gMS4gQ29uc2lkZXIgYWxsIGNvb2tpZS0w
IHRhc2sgYXMgdHJ1c3RlZC4NCj4+Pj4gMi4gQWxsIGtlcm5lbCB0aHJlYWRzIGFuZCBpZGxlIHRh
c2sgd291bGQgaGF2ZSBhIGNvb2tpZSAwIA0KPj4+PiBJbiB0aGF0IHdheSwgYWxsIHRhc2tzIHdp
dGggY29va2llcyhpbmNsdWRpbmcgdXBlcmYgaW4gYSBjZ3JvdXApIGNvdWxkIHJ1bg0KPj4+PiBj
b25jdXJyZW50bHkgd2l0aCBrZXJuZWwgdGhyZWFkcy4NCj4+Pj4gVGhhdCBjb3VsZCBiZSBhIGdv
b2Qgc29sdXRpb24gZm9yIHRoZSBpc3N1ZS4gOikNCj4+PiANCj4+PiBGcm9tIHVwZXJmIHBvaW50
IG9mIHJldmlldywgaXQgY2FuIHRydXN0IGNvb2tpZS0wKEkgYXNzdW1lIHdlIHN0aWxsIG5lZWQN
Cj4+PiBzb21lIG1vZGlmaWNhdGlvbnMgdG8gY2hhbmdlIGNvb2tpZS1tYXRjaCB0byBjb29raWUt
Y29tcGF0aWJsZSB0byBhbGxvdw0KPj4+IFpFUk8gYW5kIE5PTlpFUk8gcnVuIHRvZ2V0aGVyKS4N
Cj4+PiANCj4+PiBCdXQgZnJvbSBrZXJuZWwgdGhyZWFkIHBvaW50IG9mIHJldmlldywgaXQgY2Fu
IE5PVCB0cnVzdCB1cGVyZiwgdW5sZXNzDQo+Pj4gd2Ugc2V0IHVwZXJmJ3MgY29va2llIHRvIDAu
DQo+PiBUaGF04oCZcyByaWdodC4gOikNCj4+IENvdWxkIHdlIHNldCB0aGUgY29va2llIG9mIGNn
cm91cCB3aGVyZSB1cGVyZiBsaWVzIHRvIDA/DQo+PiANCj4gSU1ITyB0aGUgZGlzYWR2YW50YWdl
IGlzIHRoYXQgaWYgdGhlcmUgYXJlIHR3byBvciBtb3JlIGNncm91cHMgc2V0IGNvb2tpZS0wLA0K
PiB0aGVuIHRoZSB1c2VyIGFwcGxpY2F0aW9ucyBpbiB0aGVzZSBjZ3JvdXBzIGNvdWxkIHJ1biBj
b25jdXJyZW50bHkgb24gYSBjb3JlLA0KPiB0aG91Z2ggYWxsIG9mIHRoZW0gYXJlIHNldCBhcyB0
cnVzdGVkLCB3ZSBtYWRlIGEgaG9sZSBvZiB1c2VyLT51c2VyIGlzb2xhdGlvbi4NCkZvciB0aGF0
IGNhc2UsIGhvdyBhYm91dCwNCi0gdXNlIGEgc3BlY2lhbCBjb29raWUoY29va2llLXRydXN0KSBp
bnN0ZWFkIG9mIGNvb2tpZS0wIGZvciBrZXJuZWwgdGhyZWFkDQotIGltcGxlbWVudCBjb29raWVf
cGFydGlhbF9tYXRjaCgpIHRvIG1hdGNoIHBhcnQgb2YgdGhlIGNvb2tpZQ0KLSBDb29raWUtbm9y
bWFsKG5vcm1hbCB0YXNrcyB1c2UpIGNvdWxkIHRydXN0IGNvb2tpZS10cnVzdCwNCi0gdGFza3Mg
dGVuZCB0byBiZSB0cnVzdGVkIGJ5IGNvb2tpZS10cnVzdCBjb3VsZCB1c2UgY29va2llcyBpbmNs
dWRpbmcNCiAgY29va2llLXRydXN0IHBhcnRpYWxseSwgd2hpbGUgY29va2llLW5vcm1hbCBkb2Vz
IG5vdCBpbmNsdWRlIGNvb2tpZS10cnVzdC4gDQotIGNvb2tpZS10cnVzdCB0YXNrcyB1c2UgY29v
a2llX3BhcnRpYWxfbWF0Y2goKSB0byBtYXRjaCBjb29raWUNCi0gbm9ybWFsIHRhc2tzIHVzZSB0
aGUgc3RhbmRhcmQgY29va2llIG1hdGNoKGZ1bGwgbWF0Y2gpIGludGVyZmFjZSB0byBtYXRjaCBj
b29raWUuDQoNCkp1c3QgYSBzdWRkZW4gdGhvdWdodC4gOikNCg0KVGh4Lg0KUmVnYXJkcywNCkpp
YW5nDQoNCg==
