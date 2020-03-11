Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B63C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B6F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iDd5gpDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgCKHCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:02:00 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:27621
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728241AbgCKHB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBV8ro3XG9txzWAQBm18kwSLIDx7DaP+LGbBZfrgNNYOG/6thqBKSemG3gScSt+Hw2fLOlGuxfEOiZoO8a0R/+lYPiZfOAam8qPri7ttRU8lGoRrFp3TMFov31032zEHrUOJjUqOQv4IyYSsDclPFB7i4AbdX6L2AJxRzjaXMssGp/+GpeQwdp4ISyazRQe8GTRI4+SsKmBbPdIcfe4sIf3huGe3ycSyzLO/RqMfJgx26mLsbDjP7CUeNbo14RsuJ5GqwRUvQIGMJSqkKx3jFknyBVS3+M5xqdLFE3OE2Ynhsf8pesCvqzRbeD3YqEUxVYsZ0R/2PslJDypKJ1uVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk9Wn0+htLRNVbM2f3rrVCj5a/3VsXDQoAOud/DBtG8=;
 b=of6x3KDgIAvb1mrRWaCaH0qPE2uB3JSaKshynLNr+DK93Y8e/9FNwBEEDOu3JsMnWKgsqxQEyiaH/0RtaJCD71ggfrbE3UDhtTA+vbgzeft/3xKak6s1Yc2UpNskkqroRMmswZZUyXa/rj/tmYG+WNyZe9oEByOdRENusw9x5KHP1rjSziVupEqTn7QeVUXqMQ2ejH1CcEw1SqZ/dnrQiF4qJPzMXFgPM/eMTW1n3sR+JVZqSQiedLvIofWRaQezKbYraKKXKqHEIoOIZJ/s7VXqv8/WIsc6zfg6EdXRQYHvYj+cDYGjblWgaMtjOYmZz9Lg1jNvLyVHNVGZObvj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk9Wn0+htLRNVbM2f3rrVCj5a/3VsXDQoAOud/DBtG8=;
 b=iDd5gpDPxl2MqYkBqrVO6EXMbIe1R+XYzd2BwmtNOq7vQUL81r+uMKOTv4RoFIIE7WWUfRRu78uOrXb0YFfxkEL1XDUjOrLMjFaVde+QBrlLMu4C6TX9ROSjTsjrFr3HGEbVE33tCsYdulTxXMGRCq1djQPPhhpw493I3fLyseM=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3592.eurprd04.prod.outlook.com (52.133.20.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 07:01:54 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::5d20:834c:6d58:6110]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::5d20:834c:6d58:6110%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 07:01:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
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
Thread-Topic: [PATCH 1/4] clk: imx8mn: A53 core clock no need to be critical
Thread-Index: AQHV67lWYlwi4heaT0+36i2d6OFDc6hDCFmAgAAENWA=
Date:   Wed, 11 Mar 2020 07:01:53 +0000
Message-ID: <AM6PR0402MB3911A7252D42D875FBCCE30FF5FC0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1582620554-32689-1-git-send-email-Anson.Huang@nxp.com>
 <20200311064005.GE29269@dragon>
In-Reply-To: <20200311064005.GE29269@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32f5db02-9bbe-40c0-6ffa-08d7c58a14b6
x-ms-traffictypediagnostic: AM6PR0402MB3592:|AM6PR0402MB3592:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3592D7C573C833B1FBD5DA0BF5FC0@AM6PR0402MB3592.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(4326008)(81166006)(54906003)(52536014)(5660300002)(81156014)(8676002)(316002)(64756008)(6506007)(71200400001)(66446008)(2906002)(7696005)(26005)(66556008)(66476007)(86362001)(8936002)(76116006)(66946007)(478600001)(44832011)(186003)(6916009)(33656002)(55016002)(9686003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3592;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmOLlUJdOR84QrspVGzcuun/sPvsJxJSiL4vvFNkf6oJztdyEdifB6YspkQn84Pi/CBC+nNANXaj6eFPhBrPiN9ZaBBxOZph/9beBKVfcYVkW5fx+el6ygJzDm2Zzxt6sUE8YEgq3+N03nSHntcBAEMYkxMUgSrbj3TCGztLFzBC5fZ+GINUJMmG9s2uH/AkTwYBCu8ZWOq8Ui7tzTQAwRx8F5RcuSH/1gUQJCkmzydzqD/FhtQ5L2gv7bBnD0ATEFqgX62PfkIftpCKvZCgN+LAZ1i5NAk1sp74XyMjwFgqB9cl12EMk3zUFXSP4VpT2gw67oV30Dp2NvJLWBzNqP/94XjOfCPlEm1U+UfCtVDXizq8yr0rdCEWEi6rkBKfoQO9N3vFpQNjLo6iJdZhh6P4E/sNvYDwthZ3QSAM1ZxC+M/Nr0KAnlrj1oo17hMI5cPFVm1e44cOApXcYF7EoIBdHzNOuWw8+u+1nUG/ZgMK02x3NSJA/x7FvhI44yo/
x-ms-exchange-antispam-messagedata: cLZhg3lhcamf0LcQBfXcgs7gHmHSMp4mn6OwDv37b3cIx4EmQuq/dRuOThLHKmIzI5cb0R4XZFANc466auYtSMSpvJ1+56kpByaA9P+oMjJHIHgdOppM6wlG7cFldxwA2KC0OX1Ntl0XpgEihRWA+Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f5db02-9bbe-40c0-6ffa-08d7c58a14b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 07:01:53.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dL5Tm4iwAC9FhFugFo6/Nx7G7H06u/MzWwZPrU32QrzJSJUqpGCrW1A6o9cKvKZGK1wubvziZZ166ZNfMFYvDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
