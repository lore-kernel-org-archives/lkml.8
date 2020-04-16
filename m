Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC59C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BD5206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502960AbgDPJDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:03:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54871 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502912AbgDPIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:48:01 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03G8l95w9006197, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03G8l95w9006197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Apr 2020 16:47:09 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Apr 2020 16:47:09 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Apr 2020 16:47:08 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Thu, 16 Apr 2020 16:47:08 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek PymParticle EVB
Thread-Topic: [PATCH v3 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 PymParticle EVB
Thread-Index: AQHV22rI+NjHXMOCKE2GotJYQnIOL6h5+JiAgAFvOzA=
Date:   Thu, 16 Apr 2020 08:47:08 +0000
Message-ID: <9c2e6c94400b469eaff6a370135328a1@realtek.com>
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-3-james.tai@realtek.com>
 <842e8a9d-cdd6-cb85-ce85-17f20ff7b626@suse.de>
In-Reply-To: <842e8a9d-cdd6-cb85-ce85-17f20ff7b626@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.154]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiBBbSAwNC4wMi4yMCB1bSAxNTo1MiBzY2hyaWViIEphbWVzIFRhaToN
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDEzMTktcHlt
cGFydGljbGUuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTMxOS1w
eW1wYXJ0aWNsZS5kdHMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAw
MDAwMDAwMC4uMmEzNmQyMjBmZWY2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxMzE5LXB5bXBhcnRpY2xlLmR0cw0KPiA+IEBAIC0w
LDAgKzEsNDMgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9y
LWxhdGVyIE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChjKSAy
MDE5IFJlYWx0ZWsgU2VtaWNvbmR1Y3RvciBDb3JwLg0KPiANCj4gMjAxOS0yMDIwPyAoYWxzbyBl
bHNld2hlcmUpDQo+IA0KWWVzLiBJdCBzaG91bGQgYmUgY2hhbmdlZCB0byAiMjAxOS0yMDIwIi4N
Cg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKy9kdHMtdjEvOw0KPiA+ICsNCj4gPiArI2luY2x1ZGUg
InJ0ZDEzMTkuZHRzaSINCj4gPiArDQo+ID4gKy8gew0KPiA+ICsJY29tcGF0aWJsZSA9ICJyZWFs
dGVrLHB5bXBhcnRpY2xlIiwgInJlYWx0ZWsscnRkMTMxOSI7DQo+ID4gKwltb2RlbCA9ICJSZWFs
dGVrIFB5bVBhcnRpY2xlIEVWQiI7DQo+ID4gKw0KPiA+ICsJbWVtb3J5QDJlMDAwIHsNCj4gPiAr
CQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPiA+ICsJCXJlZyA9IDwweDJlMDAwIDB4M2ZmZDIw
MDA+OyAvKiBib290IFJPTSB0byAxIEdpQiBvciAyIEdpQiAqLw0KPiA+ICsJfTsNCj4gPiArDQo+
ID4gKwljaG9zZW4gew0KPiA+ICsJCXN0ZG91dC1wYXRoID0gInNlcmlhbDA6NDYwODAwbjgiOw0K
PiA+ICsJfTsNCj4gPiArDQo+ID4gKwlhbGlhc2VzIHsNCj4gPiArCQlzZXJpYWwwID0gJnVhcnQw
Ow0KPiA+ICsJCXNlcmlhbDEgPSAmdWFydDE7DQo+ID4gKwkJc2VyaWFsMiA9ICZ1YXJ0MjsNCj4g
PiArCX07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsvKiBkZWJ1ZyBjb25zb2xlIChKMSkgKi8NCj4g
PiArJnVhcnQwIHsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArfTsNCj4gPiArDQo+ID4g
Ky8qIE0uMiBzbG90IChDT044KSAqLw0KPiANCj4gQWxzbyBKMTQgYW5kIENPTjIgKHVubGVzcyB0
aGUgYm9hcmQgaXMgbWlzbGFiZWxlZD8pLg0KPiANCj4gLyogSjE0IGFuZCBNLjIgc2xvdHMgKENP
TjIsIENPTjgpICovID8NCj4gDQpZZXMuIEl0IHNob3VsZCBiZSBjaGFuZ2VkIHRvICJNLjIgc2xv
dHMgKENPTjIsIENPTjgpIi4NCg0KPiA+ICsmdWFydDEgew0KPiA+ICsJc3RhdHVzID0gImRpc2Fi
bGVkIjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKy8qIEdQSU8gY29ubmVjdG9yIChUMSkgKi8NCj4g
PiArJnVhcnQyIHsNCj4gPiArCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gK307DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxMzE5LmR0c2kNCj4gPiBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxMzE5LmR0c2kNCj4gPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMWRjZWUwMDAwOWNkDQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxMzE5
LmR0c2kNCj4gPiBAQCAtMCwwICsxLDEyIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vci1sYXRlciBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKy8qDQo+ID4gKyAq
IFJlYWx0ZWsgUlREMTMxOSBTb0MNCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDE5
IFJlYWx0ZWsgU2VtaWNvbmR1Y3RvciBDb3JwLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNs
dWRlICJydGQxM3h4LmR0c2kiDQo+ID4gKw0KPiA+ICsvIHsNCj4gPiArCWNvbXBhdGlibGUgPSAi
cmVhbHRlayxydGQxMzE5IjsNCj4gPiArfTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9yZWFsdGVrL3J0ZDEzeHguZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9y
ZWFsdGVrL3J0ZDEzeHguZHRzaQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5mNmQ3M2YxODM0NWQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDEzeHguZHRzaQ0KPiA+IEBAIC0wLDAgKzEs
MjEzIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vci1sYXRl
ciBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKy8qDQo+ID4gKyAqIFJlYWx0ZWsgUlREMTN4eCBTb0Mg
ZmFtaWx5DQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAxOSBSZWFsdGVrIFNlbWlj
b25kdWN0b3IgQ29ycC4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsvbWVtcmVzZXJ2ZS8JMHgwMDAw
MDAwMDAwMDAwMDAwIDB4MDAwMDAwMDAwMDAyZTAwMDsgLyogQm9vdCBST00NCj4gKi8NCj4gDQo+
IENhbiB5b3UgY2hlY2sgd2hldGhlciB5b3VyIFUtQm9vdCBhbmQgTEsgcmVzcGVjdGl2ZWx5IG5l
ZWQgdGhpcyBtZW1yZXNlcnZlDQo+IGVudHJ5LCBoZXJlIGFuZCBmb3IgcHJldmlvdXMgU29Dcz8g
QmVjYXVzZSBmb3IgUlREMTZ4eCB3ZSBkb24ndCBzZWVtIHRvIGhhdmUNCj4gYW55IG1lbXJlc2Vy
dmUgZW50cmllcyBhdCBhbGwuIFdlIGRvIGhhdmUgaXQgaW4gcnRkMTM5eC5kdHNpLCBydGQxMjl4
LmR0c2kgYW5kDQo+IHJ0ZDExOTUuZHRzaS4NCj4NCkkndmUgY2hlY2tlZCB0aGF0IHRoZSBib290
IGNvZGUgZG9lc24ndCBuZWVkIHRoaXMgbWVtcmVzZXJ2ZSBlbnRyeS4NClRoZXJlZm9yZSwgSSB3
aWxsIHJlbW92ZSBpdC4NCg0KPiBVbnJlbGF0ZWQ6IFNpbmNlIHdlJ3JlIGNhcnZpbmcgb3V0IHRo
ZSAyZTAwMCBvciBzbyBmcm9tIC9tZW1vcnkgbm9kZSBhbmQNCj4gbWFwcGluZyByYW5nZXMgZm9y
IC9zb2MsIEkndmUgYmVlbiB3b25kZXJpbmcgd2hldGhlciB3ZSBzaG91bGQgcmVwcmVzZW50DQo+
IHRoZSBCb290IFJPTSBhcyBub2RlIHNvbWVob3cuIEJ1dCBzaW5jZSBpdCdzIGEgUk9NIHdpdGgg
KEkgYXNzdW1lKSBiaW5hcnkNCj4gY29kZSBvbmx5LCBJIGRpZG4ndCBzZWUgYW55IG5lZWQgdG8g
aGF2ZSBpdCBhY2Nlc3NpYmxlIGFzIG10ZC1yb20gZGV2aWNlLCBzbyBpdCdzDQo+IHdheSBkb3du
IG15IHRvLWRvIGxpc3QgdG8gcmVzZWFyY2ggaG93IG90aGVyIG1haW5saW5lIHBsYXRmb3JtcyBt
aWdodCBtb2RlbA0KPiB0aGVpciBib290IFJPTXMuLi4gKG1heWJlIHlvdXIgdGVhbSBoYXMgdGlt
ZSwgb3Igc29tZW9uZSByZWFkaW5nIGhhcHBlbnMNCj4gdG8ga25vdz8pDQo+IA0KSSdsbCBhZGQg
aXQgdG8gbXkgdG8tZG8gbGlzdC4NCg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L3RyZWUvRG9jdW0NCj4gZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbXRkLXBoeXNtYXAudHh0DQo+IA0KPiA+ICsvbWVt
cmVzZXJ2ZS8JMHgwMDAwMDAwMDAwMDJlMDAwIDB4MDAwMDAwMDAwMDEwMDAwMDsgLyogQm9vdA0K
PiBsb2FkZXIgKi8NCj4gDQo+IElzIHRoaXMgYSkgY29ycmVjdGx5IHNpemVkIChub3QgMHhkMjAw
MD8pIGFuZCBiKSBzdGlsbCBuZWVkZWQ/IEkgdGhvdWdodCB0aGUNCj4gZG9jdW1lbnRlZCBzdWIt
MHgxMDAwMDAgbWVtb3J5IGNvcnJ1cHRpb24gd2VyZSBmaXhlZCBpbiBuZXdlciBCU1BzPw0KPiAN
CldlJ3JlIGluIHRoZSBwcm9jZXNzIG9mIHJlLXBsYW5uaW5nIHRoZSBtZW1vcnkgbGF5b3V0LA0K
c28gdGhhdCBhZGRyZXNzIHdpbGwgbW92ZSB0byBuZXcgYWRkcmVzcy4NCg0KPiA+ICsvbWVtcmVz
ZXJ2ZS8JMHgwMDAwMDAwMDBmNDAwMDAwIDB4MDAwMDAwMDAwMDUwMDAwMDsgLyogVmlkZW8gRlcN
Cj4gKi8NCj4gPiArL21lbXJlc2VydmUvCTB4MDAwMDAwMDAwZjkwMDAwMCAweDAwMDAwMDAwMDA1
MDAwMDA7IC8qIEF1ZGlvIEZXDQo+ICovDQo+ID4gKy9tZW1yZXNlcnZlLwkweDAwMDAwMDAwMTAw
MDAwMDAgMHgwMDAwMDAwMDAwMDE0MDAwOyAvKiBBdWRpbyBGVw0KPiBSQU0gKi8NCj4gW3NuaXBd
DQo+IA0KPiBBcmUgdGhlc2UgbmVlZGVkIGZvciB0aGUgYm9vdGxvYWRlciBub3QgdG8gb3Zlcndy
aXRlIHByZWxvYWRlZCBmaXJtd2FyZSwgb3INCj4gY291bGQgdGhlc2UgYmVjb21lIC9tZW0tcmVz
ZXJ2ZSBzdWItbm9kZXMgaW5zdGVhZD8NCj4gDQpZZXMuIFRoZXNlIGNvdWxkIGJlY29tZSAvbWVt
LXJlc2VydmUgc3ViLW5vZGVzIGluc3RlYWQuDQoNCj4gTG9uZy10ZXJtIEknbSBhc3N1bWluZyB3
ZSB3b3VsZCBtb3ZlIHRoZSByZXNwb25zaWJpbGl0eSBmb3IgbG9hZGluZyB0aGVzZSB0bw0KPiB0
aGUgbmV3IGtlcm5lbCBkcml2ZXJzIChzbyB0aGF0IHRoZSBib290bG9hZGVyIGRvZXNuJ3QgbmVl
ZCB0byB0YWtlIGNhcmUNCj4gYW55bW9yZSkgYW5kIHNoaXAgdGhlIG5lZWRlZCBibG9icyBpbiBs
aW51eC1maXJtd2FyZS5naXQ/DQo+IA0KPiBPciBpcyB0aGUgdmlkZW8gRlcgbmVlZGVkIGJ5IHRo
ZSBib290bG9hZGVyIGl0c2VsZiBmb3IgSERNSS9EUCBvdXRwdXQ/DQo+DQpJIGFncmVlIHdpdGgg
eW91LiBUaGUgdmlkZW8gRlcgY2FuIGJlIGxvYWRlZCBpbnRvIG1lbW9yeSB0aHJvdWdoIHRoaXMg
bWVjaGFuaXNtLg0KQnV0IHRoZSBhdWRpbyBGVyBuZWVkZWQgYnkgdGhlIGJvb3Rsb2FkZXIgaXRz
ZWxmIGZvciBIRE1JL0RQIG91dHB1dC4gDQpUaGVyZWZvcmUsIHRoZSBhdWRpbyBGVyBjYW4ndCBi
ZSBsb2FkZWQgaW50byBtZW1vcnkgdGhyb3VnaCBpdC4NCg0KVGhhbmsgeW91Lg0KDQpSZWdhcmRz
LA0KSmFtZXMNCg0KDQo=
