Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:27621
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728241AbgCKHB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:01:59 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/4] clk: imx8mn: A53 core clock no need to be critical
Date: Wed, 11 Mar 2020 07:01:53 +0000
Message-ID:
 <AM6PR0402MB3911A7252D42D875FBCCE30FF5FC0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1582620554-32689-1-git-send-email-Anson.Huang@nxp.com>
 <20200311064005.GE29269@dragon>
In-Reply-To: <20200311064005.GE29269@dragon>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311070153.BMcjZHGIqzPlN0zSB8poispexc6S6NVshbzSgRKsSyc@z>

SGksIFNoYXduDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIGNsazogaW14OG1uOiBBNTMg
Y29yZSBjbG9jayBubyBuZWVkIHRvIGJlIGNyaXRpY2FsDQo+IA0KPiBPbiBUdWUsIEZlYiAyNSwg
MjAyMCBhdCAwNDo0OToxMVBNICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiAnQTUzX0NP
UkUnIGlzIGp1c3QgYSBtdXggYW5kIG5vIG5lZWQgdG8gYmUgY3JpdGljYWwsIGJlaW5nIGNyaXRp
Y2FsDQo+ID4gd2lsbCBjYXVzZSBpdHMgcGFyZW50IGNsb2NrIGFsd2F5cyBPTiB3aGljaCBkb2Vz
IE5PVCBtYWtlIHNlbnNlLA0KPiANCj4gSSBkbyBub3QgcXVpdGUgdW5kZXJzdGFuZCB3aGF0IHBy
b2JsZW0gdGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8gZml4LiAgSW4gdGhlIGVuZCwNCj4gYWxsIHRo
ZSBhbmNlc3RvciBjbG9ja3Mgb2YgImFybSIsIGluY2x1ZGluZyAiYXJtX2E1M19jb3JlIiB3aWxs
IHN0aWxsIGJlIE9OLCBhcw0KPiAiYXJtIiBoYXMgQ0xLX0lTX0NSSVRJQ0FMIGZsYWcuICBXaGF0
IGlzIHRoZSBkaWZmZXJlbmNlIHlvdSBhcmUgdHJ5aW5nIHRvDQo+IG1ha2UgaGVyZT8NCg0KVGhp
cyBwYXRjaCBhY3R1YWxseSBpcyB0byBmaXggdGhlIGNsb2NrIHBhcmVudCBzd2l0Y2ggZmxvdyBv
ZiBBNTMsIHByZXZpb3VzIGZsb3cgaXMgaW5jb3JyZWN0LA0KdGhlIHJlYXNvbiB3aHkgaXQgd29y
a3MgaXMgdGhlIElNWDhNTl9DTEtfQTUzX0NPUkUgaXMgbWFya2VkIGFzIENSSVRJQ0FMLA0KYnV0
IGlmIHdpdGggY29ycmVjdCBmbG93IG9mIHBhcmVudCBzd2l0Y2gsIHRoZSAiYXJtIiBhcyBDTEtf
SVNfQ1JJVElDQUwgZmxhZyBpcyBlbm91Z2ggYW5kDQpJTVg4TU5fQ0xLX0E1M19DT1JFIHdpbGwg
YmUgZW5hYmxlZCBiZWNhdXNlIGl0IGlzICJhcm0iIGNsaydzIHBhcmVudC4NCg0KVGhlIEE1MyBj
bG9jayBwYXJlbnQgc3dpdGNoIHNob3VsZCBiZSBwdXQgYWZ0ZXIgdGhlICJhcm0iIGNsayBjcmVh
dGlvbiwgdGhlbiBubyBuZWVkIHRvIGhhdmUNCkNMS19JU19DUklUSUNBTCBmbGFnIGZvciBJTVg4
TU5fQ0xLX0E1M19DT1JFLCBhbmQgaXRzIHVzZWNvdW50IHdpbGwgYmUgMSBhcyBleHBlY3RlZC4N
ClByZXZpb3VzIGltcGxlbWVudGF0aW9uIHdpbGwgaGFzIHVzZSBjb3VudCBlcXVhbCAyIHdoaWNo
IGlzIGluY29ycmVjdC4NCg0KQW5zb24NCg0KPiANCj4gU2hhd24NCj4gDQo+ID4gdG8gbWFrZSBz
dXJlIENQVSdzIGhhcmR3YXJlIGNsb2NrIHNvdXJjZSBOT1QgYmVpbmcgZGlzYWJsZWQgZHVyaW5n
DQo+ID4gY2xvY2sgdHJlZSBzZXR1cCwgbmVlZCB0byBtb3ZlIHRoZSAnQTUzX1NSQycvJ0E1M19D
T1JFJyByZXBhcmVudA0KPiA+IG9wZXJhdGlvbnMgdG8gYWZ0ZXIgY3JpdGljYWwgY2xvY2sgJ0FS
TV9DTEsnIHNldHVwIGZpbmlzaGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xrL2lteC9j
bGstaW14OG1uLmMgfCA4ICsrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg4bW4uYw0KPiA+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW4uYyBpbmRl
eCA4MzYxOGFmLi4wYmM3MDcwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14OG1uLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbi5jDQo+ID4gQEAg
LTQyOCw3ICs0MjgsNyBAQCBzdGF0aWMgaW50IGlteDhtbl9jbG9ja3NfcHJvYmUoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCWh3c1tJTVg4TU5fQ0xLX0dQVV9TSEFERVJf
RElWXSA9DQo+IGh3c1tJTVg4TU5fQ0xLX0dQVV9TSEFERVJdOw0KPiA+DQo+ID4gIAkvKiBDT1JF
IFNFTCAqLw0KPiA+IC0JaHdzW0lNWDhNTl9DTEtfQTUzX0NPUkVdID0NCj4gaW14X2Nsa19od19t
dXgyX2ZsYWdzKCJhcm1fYTUzX2NvcmUiLCBiYXNlICsgMHg5ODgwLCAyNCwgMSwNCj4gaW14OG1u
X2E1M19jb3JlX3NlbHMsIEFSUkFZX1NJWkUoaW14OG1uX2E1M19jb3JlX3NlbHMpLA0KPiBDTEtf
SVNfQ1JJVElDQUwpOw0KPiA+ICsJaHdzW0lNWDhNTl9DTEtfQTUzX0NPUkVdID0gaW14X2Nsa19o
d19tdXgyKCJhcm1fYTUzX2NvcmUiLA0KPiBiYXNlICsNCj4gPiArMHg5ODgwLCAyNCwgMSwgaW14
OG1uX2E1M19jb3JlX3NlbHMsDQo+ID4gK0FSUkFZX1NJWkUoaW14OG1uX2E1M19jb3JlX3NlbHMp
KTsNCj4gPg0KPiA+ICAJLyogQlVTICovDQo+ID4gIAlod3NbSU1YOE1OX0NMS19NQUlOX0FYSV0g
PQ0KPiA+IGlteDhtX2Nsa19od19jb21wb3NpdGVfY3JpdGljYWwoIm1haW5fYXhpIiwgaW14OG1u
X21haW5fYXhpX3NlbHMsDQo+IGJhc2UNCj4gPiArIDB4ODgwMCk7IEBAIC01NTksMTUgKzU1OSwx
NSBAQCBzdGF0aWMgaW50IGlteDhtbl9jbG9ja3NfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gIAlod3NbSU1YOE1OX0NMS19EUkFNX0FMVF9ST09UXSA9
DQo+ID4gaW14X2Nsa19od19maXhlZF9mYWN0b3IoImRyYW1fYWx0X3Jvb3QiLCAiZHJhbV9hbHQi
LCAxLCA0KTsNCj4gPg0KPiA+IC0JY2xrX2h3X3NldF9wYXJlbnQoaHdzW0lNWDhNTl9DTEtfQTUz
X1NSQ10sDQo+IGh3c1tJTVg4TU5fU1lTX1BMTDFfODAwTV0pOw0KPiA+IC0JY2xrX2h3X3NldF9w
YXJlbnQoaHdzW0lNWDhNTl9DTEtfQTUzX0NPUkVdLA0KPiBod3NbSU1YOE1OX0FSTV9QTExfT1VU
XSk7DQo+ID4gLQ0KPiA+ICAJaHdzW0lNWDhNTl9DTEtfQVJNXSA9IGlteF9jbGtfaHdfY3B1KCJh
cm0iLCAiYXJtX2E1M19jb3JlIiwNCj4gPiAgCQkJCQkgICBod3NbSU1YOE1OX0NMS19BNTNfQ09S
RV0tPmNsaywNCj4gPiAgCQkJCQkgICBod3NbSU1YOE1OX0NMS19BNTNfQ09SRV0tPmNsaywNCj4g
PiAgCQkJCQkgICBod3NbSU1YOE1OX0FSTV9QTExfT1VUXS0+Y2xrLA0KPiA+ICAJCQkJCSAgIGh3
c1tJTVg4TU5fQ0xLX0E1M19ESVZdLT5jbGspOw0KPiA+DQo+ID4gKwljbGtfaHdfc2V0X3BhcmVu
dChod3NbSU1YOE1OX0NMS19BNTNfU1JDXSwNCj4gaHdzW0lNWDhNTl9TWVNfUExMMV84MDBNXSk7
DQo+ID4gKwljbGtfaHdfc2V0X3BhcmVudChod3NbSU1YOE1OX0NMS19BNTNfQ09SRV0sDQo+ID4g
K2h3c1tJTVg4TU5fQVJNX1BMTF9PVVRdKTsNCj4gPiArDQo+ID4gIAlpbXhfY2hlY2tfY2xrX2h3
cyhod3MsIElNWDhNTl9DTEtfRU5EKTsNCj4gPg0KPiA+ICAJcmV0ID0gb2ZfY2xrX2FkZF9od19w
cm92aWRlcihucCwgb2ZfY2xrX2h3X29uZWNlbGxfZ2V0LA0KPiA+IGNsa19od19kYXRhKTsNCj4g
PiAtLQ0KPiA+IDIuNy40DQo+ID4NCg==

