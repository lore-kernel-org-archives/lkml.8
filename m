Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D350BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9879520838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 00:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="FOj/Oaja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHNA0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:26:09 -0400
Received: from mail6.tencent.com ([220.249.245.26]:39338 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHNA0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 20:26:08 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail6.tencent.com (Postfix) with ESMTP id 0726ECC2AC;
        Fri, 14 Aug 2020 08:27:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597364840;
        bh=bOw86oaSsvTe0NQuzXz8SlcMqqCiR+EPWjq1IXYxioM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=FOj/Oaja0c+6s2rxg0+LDiR90xH6QQh5XKrUsCo3YbJpKbKXBag+xJOghz1MsV5pd
         BKbpnmJZPHF0iJtX2FtaHKN+S1Wcwq4BRVEIIJEXvlpV1SPxDdzNILLe4JgAAT3tlt
         yDUrc0Kxp9DdsEhtf+/6lwuBygvEpeuTRKhTXfvI=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 14 Aug
 2020 08:26:05 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 14 Aug
 2020 08:26:05 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Fri, 14 Aug 2020 08:26:02 +0800
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
Thread-Index: AQHWTyYIdUbfm2uvOEagav1FxQIttakluk8AgACOfACAAkvVAIAHH5EAgAPAXACAAWIeAIAAWUGAgAFOmgA=
Date:   Fri, 14 Aug 2020 00:26:02 +0000
Message-ID: <FAC73DE7-BAE0-42D3-BE9A-227C12275C34@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
 <20200809164408.GA342447@google.com>
 <162a03cc-66c3-1999-83a2-deaad5aa04c8@linux.intel.com>
 <20200812230850.GA3511387@google.com>
 <5a39735d-dfd8-bdec-f068-81895799640e@linux.intel.com>
In-Reply-To: <5a39735d-dfd8-bdec-f068-81895799640e@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <91BC87B539FFA9428421B7B5C468BD41@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDEzLCAyMDIwLCBhdCAxMjoyOCBQTSwgTGksIEF1YnJleSA8YXVicmV5Lmxp
QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAyMDIwLzgvMTMgNzowOCwgSm9lbCBG
ZXJuYW5kZXMgd3JvdGU6DQo+PiBPbiBXZWQsIEF1ZyAxMiwgMjAyMCBhdCAxMDowMToyNEFNICsw
ODAwLCBMaSwgQXVicmV5IHdyb3RlOg0KPj4+IEhpIEpvZWwsDQo+Pj4gDQo+Pj4gT24gMjAyMC84
LzEwIDA6NDQsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+PiBIaSBBdWJyZXksDQo+Pj4+IA0K
Pj4+PiBBcG9sb2dpZXMgZm9yIHJlcGx5aW5nIGxhdGUgYXMgSSB3YXMgc3RpbGwgbG9va2luZyBp
bnRvIHRoZSBkZXRhaWxzLg0KPj4+PiANCj4+Pj4gT24gV2VkLCBBdWcgMDUsIDIwMjAgYXQgMTE6
NTc6MjBBTSArMDgwMCwgTGksIEF1YnJleSB3cm90ZToNCj4+Pj4gWy4uLl0NCj4+Pj4+ICsvKg0K
Pj4+Pj4gKyAqIENvcmUgc2NoZWR1bGluZyBwb2xpY3k6DQo+Pj4+PiArICogLSBDT1JFX1NDSEVE
X0RJU0FCTEVEOiBjb3JlIHNjaGVkdWxpbmcgaXMgZGlzYWJsZWQuDQo+Pj4+PiArICogLSBDT1JF
X0NPT0tJRV9NQVRDSDogdGFza3Mgd2l0aCBzYW1lIGNvb2tpZSBjYW4gcnVuDQo+Pj4+PiArICog
ICAgICAgICAgICAgICAgICAgICBvbiB0aGUgc2FtZSBjb3JlIGNvbmN1cnJlbnRseS4NCj4+Pj4+
ICsgKiAtIENPUkVfQ09PS0lFX1RSVVNUOiB0cnVzdGVkIHRhc2sgY2FuIHJ1biB3aXRoIGtlcm5l
bA0KPj4+Pj4gCQkJdGhyZWFkIG9uIHRoZSBzYW1lIGNvcmUgY29uY3VycmVudGx5LiANCj4+Pj4+
ICsgKiAtIENPUkVfQ09PS0lFX0xPTkVMWTogdGFza3Mgd2l0aCBjb29raWUgY2FuIHJ1biBvbmx5
DQo+Pj4+PiArICogICAgICAgICAgICAgICAgICAgICB3aXRoIGlkbGUgdGhyZWFkIG9uIHRoZSBz
YW1lIGNvcmUuDQo+Pj4+PiArICovDQo+Pj4+PiArZW51bSBjb3Jlc2NoZWRfcG9saWN5IHsNCj4+
Pj4+ICsgICAgICAgQ09SRV9TQ0hFRF9ESVNBQkxFRCwNCj4+Pj4+ICsgICAgICAgQ09SRV9TQ0hF
RF9DT09LSUVfTUFUQ0gsDQo+Pj4+PiArCUNPUkVfU0NIRURfQ09PS0lFX1RSVVNULA0KPj4+Pj4g
KyAgICAgICBDT1JFX1NDSEVEX0NPT0tJRV9MT05FTFksDQo+Pj4+PiArfTsNCj4+Pj4+IA0KPj4+
Pj4gV2UgY2FuIHNldCBwb2xpY3kgdG8gQ09SRV9DT09LSUVfVFJVU1Qgb2YgdXBlcmYgY2dyb3Vw
IGFuZCBmaXggdGhpcyBraW5kDQo+Pj4+PiBvZiBwZXJmb3JtYW5jZSByZWdyZXNzaW9uLiBOb3Qg
c3VyZSBpZiB0aGlzIHNvdW5kcyBhdHRyYWN0aXZlPw0KPj4+PiANCj4+Pj4gSW5zdGVhZCBvZiB0
aGlzLCBJIHRoaW5rIGl0IGNhbiBiZSBzb21ldGhpbmcgc2ltcGxlciBJTUhPOg0KPj4+PiANCj4+
Pj4gMS4gQ29uc2lkZXIgYWxsIGNvb2tpZS0wIHRhc2sgYXMgdHJ1c3RlZC4gKEV2ZW4gcmlnaHQg
bm93LCBpZiB5b3UgYXBwbHkgdGhlDQo+Pj4+ICAgY29yZS1zY2hlZHVsaW5nIHBhdGNoc2V0LCBz
dWNoIHRhc2tzIHdpbGwgc2hhcmUgYSBjb3JlIGFuZCBzbmlmZiBvbiBlYWNoDQo+Pj4+ICAgb3Ro
ZXIuIFNvIGxldCB1cyBub3QgcHJldGVuZCB0aGF0IHN1Y2ggdGFza3MgYXJlIG5vdCB0cnVzdGVk
KS4NCj4+Pj4gDQo+Pj4+IDIuIEFsbCBrZXJuZWwgdGhyZWFkcyBhbmQgaWRsZSB0YXNrIHdvdWxk
IGhhdmUgYSBjb29raWUgMCAoc28gdGhhdCB3aWxsIGNvdmVyDQo+Pj4+ICAga3NvZnRpcnFkIHJl
cG9ydGVkIGluIHlvdXIgb3JpZ2luYWwgaXNzdWUpLg0KPj4+PiANCj4+Pj4gMy4gQWRkIGEgY29u
ZmlnIG9wdGlvbiAoQ09ORklHX1NDSEVEX0NPUkVfREVGQVVMVF9UQVNLU19VTlRSVVNURUQpLiBE
ZWZhdWx0DQo+Pj4+ICAgZW5hYmxlIGl0LiBTZXR0aW5nIHRoaXMgb3B0aW9uIHdvdWxkIHRhZyBh
bGwgdGFza3MgdGhhdCBhcmUgZm9ya2VkIGZyb20gYQ0KPj4+PiAgIGNvb2tpZS0wIHRhc2sgd2l0
aCB0aGVpciBvd24gY29va2llLiBMYXRlciBvbiwgc3VjaCB0YXNrcyBjYW4gYmUgYWRkZWQgdG8N
Cj4+Pj4gICBhIGdyb3VwLiBUaGlzIGNvdmVyJ3MgUGV0ZXJaJ3MgYXNrIGFib3V0IGhhdmluZyAn
ZGVmYXVsdCB1bnRydXN0ZWQnKS4NCj4+Pj4gICAoVXNlcnMgbGlrZSBDaHJvbWVPUyB0aGF0IGRv
bid0IHdhbnQgdG8gdXNlcnNwYWNlIHN5c3RlbSBwcm9jZXNzZXMgdG8gYmUNCj4+Pj4gICB0YWdn
ZWQgY2FuIGRpc2FibGUgdGhpcyBvcHRpb24gc28gc3VjaCB0YXNrcyB3aWxsIGJlIGNvb2tpZS0w
KS4NCj4+Pj4gDQo+Pj4+IDQuIEFsbG93IHByY3RsL2Nncm91cCBpbnRlcmZhY2VzIHRvIGNyZWF0
ZSBncm91cHMgb2YgdGFza3MgYW5kIG92ZXJyaWRlIHRoZQ0KPj4+PiAgIGFib3ZlIGJlaGF2aW9y
cy4NCj4+PiANCj4+PiBIb3cgZG9lcyB1cGVyZiBpbiBhIGNncm91cCB3b3JrIHdpdGgga3NvZnRp
cnFkPyBBcmUgeW91IHN1Z2dlc3RpbmcgSSBzZXQgdXBlcmYncw0KPj4+IGNvb2tpZSB0byBiZSBj
b29raWUtMCB2aWEgcHJjdGw/DQo+PiANCj4+IFllcywgYnV0IGxldCBtZSB0cnkgdG8gdW5kZXJz
dGFuZCBiZXR0ZXIuIFRoZXJlIGFyZSAyIHByb2JsZW1zIGhlcmUgSSB0aGluazoNCj4+IA0KPj4g
MS4ga3NvZnRpcnFkIGdldHRpbmcgaWRsZWQgd2hlbiBIVCBpcyB0dXJuZWQgb24sIGJlY2F1c2Ug
dXBlcmYgaXMgc2hhcmluZyBhDQo+PiBjb3JlIHdpdGggaXQ6IFRoaXMgc2hvdWxkIG5vdCBiZSBh
bnkgd29yc2UgdGhhbiBTTVQgT0ZGLCBiZWNhdXNlIGV2ZW4gU01UIE9GRg0KPj4gd291bGQgYWxz
byByZWR1Y2Uga3NvZnRpcnFkJ3MgQ1BVIHRpbWUganVzdCBjb3JlIHNjaGVkIGlzIGRvaW5nLiBT
dXJlDQo+PiBjb3JlLXNjaGVkdWxpbmcgYWRkcyBzb21lIG92ZXJoZWFkIHdpdGggSVBJcyBidXQg
c3VjaCBhIGh1Z2UgZHJvcCBvZiBwZXJmIGlzDQo+PiBzdHJhbmdlLiBQZXRlciBhbnkgdGhvdWdo
dHMgb24gdGhhdD8NCj4+IA0KPj4gMi4gSW50ZXJmYWNlOiBUbyBzb2x2ZSB0aGUgcGVyZm9ybWFu
Y2UgcHJvYmxlbSwgeW91IGFyZSBzYXlpbmcgeW91IHdhbnQgdXBlcmYNCj4+IHRvIHNoYXJlIGEg
Y29yZSB3aXRoIGtzb2Z0aXJxZCBzbyB0aGF0IGl0IGlzIG5vdCBmb3JjZWQgaW50byBpZGxlLiAg
V2h5IG5vdA0KPj4ganVzdCBrZWVwIHVwZXJmIG91dCBvZiB0aGUgY2dyb3VwPw0KPiANCj4gSSBn
dWVzcyB0aGlzIGlzIHVuYWNjZXB0YWJsZSBmb3Igd2hvIHJ1bnMgdGhlaXIgYXBwcyBpbiBjb250
YWluZXIgYW5kIHZtLg0KSU1ITywgIGp1c3QgYXMgSm9lbCBwcm9wb3NlZCwgDQoxLiBDb25zaWRl
ciBhbGwgY29va2llLTAgdGFzayBhcyB0cnVzdGVkLg0KMi4gQWxsIGtlcm5lbCB0aHJlYWRzIGFu
ZCBpZGxlIHRhc2sgd291bGQgaGF2ZSBhIGNvb2tpZSAwIA0KSW4gdGhhdCB3YXksIGFsbCB0YXNr
cyB3aXRoIGNvb2tpZXMoaW5jbHVkaW5nIHVwZXJmIGluIGEgY2dyb3VwKSBjb3VsZCBydW4NCmNv
bmN1cnJlbnRseSB3aXRoIGtlcm5lbCB0aHJlYWRzLg0KVGhhdCBjb3VsZCBiZSBhIGdvb2Qgc29s
dXRpb24gZm9yIHRoZSBpc3N1ZS4gOikNCg0KSWYgd2l0aCBDT05GSUdfU0NIRURfQ09SRV9ERUZB
VUxUX1RBU0tTX1VOVFJVU1RFRCBlbmFibGVkLA0KbWF5YmUgd2Ugc2hvdWxkIHNldCBrc29mdGly
cWTigJlzIGNvb2tpZSB0byBiZSBjb29raWUtMCB0byBzb2x2ZSB0aGUgaXNzdWUuIA0KDQpUaHgu
DQpSZWdhcmRzLA0KSmlhbmcNCj4gDQo+IFRoYW5rcywNCj4gLUF1YnJleQ0KPiANCj4+IFRoZW4g
aXQgd2lsbCBoYXZlIGNvb2tpZSAwIGFuZCBiZSBhYmxlIHRvDQo+PiBzaGFyZSBjb3JlIHdpdGgg
a2VybmVsIHRocmVhZHMuIEFib3V0IHVzZXItdXNlciBpc29sYXRpb24gdGhhdCB5b3UgbmVlZCwg
aWYNCj4+IHlvdSB0YWcgYW55ICJ1bnRydXN0ZWQiIHRocmVhZHMgYnkgYWRkaW5nIGl0IHRvIENH
cm91cCwgdGhlbiB0aGVyZSB3aWxsDQo+PiBhdXRvbWF0aWNhbGx5IGlzb2xhdGVkIGZyb20gdXBl
cmYgd2hpbGUgYWxsb3dpbmcgdXBlcmYgdG8gc2hhcmUgQ1BVIHdpdGgNCj4+IGtlcm5lbCB0aHJl
YWRzLg0KPj4gDQo+PiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBhbmQgdGhhbmtz
LA0KPj4gDQo+PiAtIEpvZWwNCj4+IA0KPj4+IA0KPj4+IFRoYW5rcywNCj4+PiAtQXVicmV5DQo+
Pj4+IA0KPj4+PiA1LiBEb2N1bWVudCBldmVyeXRoaW5nIGNsZWFybHkgc28gdGhlIHNlbWFudGlj
cyBhcmUgY2xlYXIgYm90aCB0byB0aGUNCj4+Pj4gICBkZXZlbG9wZXJzIG9mIGNvcmUgc2NoZWR1
bGluZyBhbmQgdG8gc3lzdGVtIGFkbWluaXN0cmF0b3JzLg0KPj4+PiANCj4+Pj4gTm90ZSB0aGF0
LCB3aXRoIHRoZSBjb25jZXB0IG9mICJzeXN0ZW0gdHJ1c3RlZCBjb29raWUiLCB3ZSBjYW4gYWxz
byBkbw0KPj4+PiBvcHRpbWl6YXRpb25zIGxpa2U6DQo+Pj4+IDEuIERpc2FibGUgU1RJQlAgd2hl
biBzd2l0Y2hpbmcgaW50byB0cnVzdGVkIHRhc2tzLg0KPj4+PiAyLiBEaXNhYmxlIEwxRCBmbHVz
aGluZyAvIHZlcncgc3R1ZmYgZm9yIEwxVEYvTURTIGlzc3Vlcywgd2hlbiBzd2l0Y2hpbmcgaW50
bw0KPj4+PiAgIHRydXN0ZWQgdGFza3MuDQo+Pj4+IA0KPj4+PiBBdCBsZWFzdCAjMSBzZWVtcyB0
byBiZSBiaXRpbmcgZW5hYmxpbmcgSFQgb24gQ2hyb21lT1MgcmlnaHQgbm93LCBhbmQgb25lDQo+
Pj4+IG90aGVyIGVuZ2luZWVyIHJlcXVlc3RlZCBJIGRvIHNvbWV0aGluZyBsaWtlICMyIGFscmVh
ZHkuDQo+Pj4+IA0KPj4+PiBPbmNlIHdlIGdldCBmdWxsLXN5c2NhbGwgaXNvbGF0aW9uIHdvcmtp
bmcsIHRocmVhZHMgYmVsb25naW5nIHRvIGEgcHJvY2Vzcw0KPj4+PiBjYW4gYWxzbyBzaGFyZSBh
IGNvcmUgc28gdGhvc2UgY2FuIGp1c3Qgc2hhcmUgYSBjb3JlIHdpdGggdGhlIHRhc2stZ3JvdXAN
Cj4+Pj4gbGVhZGVyLg0KPj4+PiANCj4+Pj4+PiBJcyB0aGUgdXBlcmYgdGhyb3VnaHB1dCB3b3Jz
ZSB3aXRoIFNNVCtjb3JlLXNjaGVkdWxpbmcgdmVyc3VzIG5vLVNNVCA/DQo+Pj4+PiANCj4+Pj4+
IFRoaXMgaXMgYSBnb29kIHF1ZXN0aW9uLCBmcm9tIHRoZSBkYXRhIHdlIG1lYXN1cmVkIGJ5IHVw
ZXJmLA0KPj4+Pj4gU01UK2NvcmUtc2NoZWR1bGluZyBpcyAyOC4yJSB3b3JzZSB0aGFuIG5vLVNN
VCwgOigNCj4+Pj4gDQo+Pj4+IFRoaXMgaXMgd29ycnlpbmcgZm9yIHN1cmUuIDotKC4gV2Ugb3Vn
aHQgdG8gZGVidWcvcHJvZmlsZSBpdCBtb3JlIHRvIHNlZSB3aGF0DQo+Pj4+IGlzIGNhdXNpbmcg
dGhlIG92ZXJoZWFkLiBNZS9WaW5lZXRoIGFkZGVkIGl0IGFzIGEgdG9waWMgZm9yIExQQyBhcyB3
ZWxsLg0KPj4+PiANCj4+Pj4gQW55IG90aGVyIHRob3VnaHRzIGZyb20gb3RoZXJzIG9uIHRoaXM/
DQo+Pj4+IA0KPj4+PiB0aGFua3MsDQo+Pj4+IA0KPj4+PiAtIEpvZWwNCj4+Pj4gDQo+Pj4+IA0K
Pj4+Pj4+IHRoYW5rcywNCj4+Pj4+PiANCj4+Pj4+PiAtIEpvZWwNCj4+Pj4+PiBQUzogSSBhbSBw
bGFubmluZyB0byB3cml0ZSBhIHBhdGNoIGJlaGluZCBhIENPTkZJRyBvcHRpb24gdGhhdCB0YWdz
DQo+Pj4+Pj4gYWxsIHByb2Nlc3NlcyAoZGVmYXVsdCB1bnRydXN0ZWQpIHNvIGV2ZXJ5dGhpbmcg
Z2V0cyBhIGNvb2tpZSB3aGljaA0KPj4+Pj4+IHNvbWUgZm9sa3Mgc2FpZCB3YXMgaG93IHRoZXkg
d2FudGVkIChoYXZlIGEgd2hpdGVsaXN0IGluc3RlYWQgb2YNCj4+Pj4+PiBibGFja2xpc3QpLg0K
Pj4+Pj4+IA0KPj4+Pj4gDQo+Pj4gDQo+IA0KPiANCg0K
