Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B024C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D9921655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l88rkb/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgCKJuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:50:35 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:55552
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728146AbgCKJue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2ewI7NDgZoKL6F11nRrhzyr1pPWgk7LD/MTT3MCDaDeTWLD+SfiZI/Ssz67uMyMO8wxn4RUIcTWcXpEZMKNx/6V6Cl+KjBkXa7W9hm64o+HSkqha7/FOP32eQ2aszs/Hb8Ow/pcJUtpil+Wx+TU4NgnflIAOkdH1rCDD2qDDNr7f4PmuqxbxBHMEZ595Ag1mDGMwh4+l40YhGJhjCR3zQxF1JtQKeythQRTRwKYaJOGgcXqGpXgjenVBcl2eLTym4zJt6YT7RUFr4lDVjBexVWbVzo4Hyj6csU3HIZFxUw+IkizK60w6rVL5gzASVzk3ot9+XlTD+F82cyw3IB3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AGfjxrr/jpI+FeBmfnWWoeS98BvkKsmnPZ62ifle90=;
 b=EVLPS0X8dJ8hBgEKbJ0N5uo0IUun8csiWIt8ZWAhzw302dak0qYvZ7HdUic3d2ehzrd3T/AN38NZSlrNh9t62Z3aUoshxLonTOkXTMMXYlC6iex3tDh1gLSTLdGD7KTSAwu1Eyhs0vH43jvhgMXkugpHZzmaM8pWkpm+7iTUqt6ZYAF9LdptIZn6EGi53lLhNyKBuTBdfoTV/W3ovIFnHn/pQSvnqQwopba22GZZoFH/VbX1rA+bWNZo8YsZWeh1xWeTeCHMEgPicuC5GKReigfj4t7Nm+s4Eld2STpwyeLE+bR7VLbGQ1PtDi2269r7dc8AO8SjKQrTr0Au2Aiu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AGfjxrr/jpI+FeBmfnWWoeS98BvkKsmnPZ62ifle90=;
 b=l88rkb/5Mh2AAWowo92Fnmxhtte5jPESmL1H2cXCbN/CN11PkkdoV3z2WWySWwBDM79N7vShKmXKiH554JcQ9vEoEuoZzXowH8ddzxmbW7RPf5QRhCGjsI+ECZrEL8XxhlBoN2vn/o7QJKeMY1O34zMOnFhBCpWg4e9b2JNDQtI=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5803.eurprd04.prod.outlook.com (20.179.10.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Wed, 11 Mar 2020 09:50:30 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e%5]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 09:50:30 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>, Leo Li <leoyang.li@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv7] arm64: dts: ls1028a: Add PCIe controller DT nodes
Thread-Topic: [PATCHv7] arm64: dts: ls1028a: Add PCIe controller DT nodes
Thread-Index: AQHV8Eq2QSotQxzH4Ey/X8RdJZi6q6hDG32AgAAYjxA=
Date:   Wed, 11 Mar 2020 09:50:29 +0000
Message-ID: <DB8PR04MB674761BF8BA68ACA26497B4784FC0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20200302042305.15639-1-Zhiqiang.Hou@nxp.com>
 <20200311082117.GA29269@dragon>
In-Reply-To: <20200311082117.GA29269@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a432f504-671d-4f31-526e-08d7c5a1a259
x-ms-traffictypediagnostic: DB8PR04MB5803:|DB8PR04MB5803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB58036C4E3B3DD8111C21B66984FC0@DB8PR04MB5803.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(316002)(6916009)(52536014)(33656002)(2906002)(4326008)(54906003)(86362001)(5660300002)(8936002)(81166006)(186003)(55016002)(81156014)(9686003)(26005)(7696005)(8676002)(6506007)(71200400001)(478600001)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5803;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gBUN3D3pZ+8LpomIKNNJDMFnxbl+nVQTONa2L45BeIFqzZzBD5HEYL96/P4Vu0fozOPpwCvf+B+ajAADI9tVIe7Xuc/xQOKmmRk6MMlPZ7Yezhi30EACheNUUTnwLugmfUnicOq0IiLEf1ZCPSc1V2OAt61dg8cHjxlnIvgKBROM9bLxpmuzwlE+2GrWWJWRHV9ZjyxlEjtA9a2pfedxrfa1g52ZWt7BY02feVI4Fg72P1FUlJPXRUwf+DhnOshN/rL3uJgzvYPqv0QpuOygT3kR0ggc8545aYN5OYHOmWgc3RETJF+TAHb2Bn8TT57oHEtpi3khv50lfRnspYGJfOt1sp5X595pxyoROBfVHIWLep3SQc/9EGuAwxZaK+lc32Vl6gQx2n8KVDOwdCYjrWO20jEU/idKuKHsNziyJrTSG/Bn+um+9KmKaX93WNCm
x-ms-exchange-antispam-messagedata: LeeTYM7GwvHNpybADMup6/rtp+C+UZ6n/ykVR6HzM1tkhw6FJPc+vdasrgG/jn/X1bVc9KvEobb3FqhKAKpr63MqYWPYAHQA9YVg5XpYqowXgKIjyzEFyOs7GIXLl5qNhHttgcHGVqRyk8O5nU3Wlg==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a432f504-671d-4f31-526e-08d7c5a1a259
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 09:50:29.9664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhDe5Q02463ILD/a9NS6McVE37a2JCz+UtjOJUVKW1Nuc2q46a3Pq9Je4uSYBExl745Pg9lHWQklHJDTUUmmIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+DQo+IFNlbnQ6IDIwMjDE6jPUwjExyNUgMTY6MjENCj4gVG86IFoucS4gSG91IDx6aGlxaWFu
Zy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IG1pY2hhZWxAd2Fs
bGUuY2M7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4gTWluZ2thaSBIdSA8bWluZ2th
aS5odUBueHAuY29tPjsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+Ow0KPiBYaWFv
d2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSHY3XSBh
cm02NDogZHRzOiBsczEwMjhhOiBBZGQgUENJZSBjb250cm9sbGVyIERUIG5vZGVzDQo+IA0KPiBP
biBNb24sIE1hciAwMiwgMjAyMCBhdCAxMjoyMzowNVBNICswODAwLCBaaGlxaWFuZyBIb3Ugd3Jv
dGU6DQo+ID4gRnJvbTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+ID4NCj4g
PiBMUzEwMjhhIGltcGxlbWVudHMgMiBQQ0llIDMuMCBjb250cm9sbGVycy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gVGVzdGVk
LWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiA+IC0tLQ0KPiA+IFY3Og0K
PiA+ICAtIFJlYmFzZWQgdGhlIHBhdGNoIHRvIHRoZSBsYXRlc3QgY29kZSBiYXNlLg0KPiA+ICAt
IEFkZGVkIHByb3BlcnR5ICdpb21tdS1tYXAnLg0KPiA+DQo+ID4gIC4uLi9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaSB8IDU0DQo+ICsrKysrKysrKysrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQo+IGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiA+IGluZGV4
IDQxYzk2MzMyOTNmYi4uM2YzMTY0MWRjY2VkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQo+ID4gQEAgLTcxNyw2ICs3MTcs
NjAgQEANCj4gPiAgCQkJI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+Ow0KPiA+ICAJCX07DQo+
ID4NCj4gPiArCQlwY2llQDM0MDAwMDAgew0KPiANCj4gUGxlYXNlIGtlZXAgbm9kZXMgc29ydGVk
IGluIHVuaXQtYWRkcmVzcy4NCg0KT0ssIHdpbGwgY29ycmVjdCBpbiBuZXh0IHZlcnNpb24uDQoN
ClRoYW5rcywNClpoaXFpYW5nDQoNCj4gDQo+IFNoYXduDQo+IA0KPiA+ICsJCQljb21wYXRpYmxl
ID0gImZzbCxsczEwMjhhLXBjaWUiOw0KPiA+ICsJCQlyZWcgPSA8MHgwMCAweDAzNDAwMDAwIDB4
MCAweDAwMTAwMDAwICAgLyogY29udHJvbGxlcg0KPiByZWdpc3RlcnMgKi8NCj4gPiArCQkJICAg
ICAgIDB4ODAgMHgwMDAwMDAwMCAweDAgMHgwMDAwMjAwMD47IC8qIGNvbmZpZ3VyYXRpb24NCj4g
c3BhY2UgKi8NCj4gPiArCQkJcmVnLW5hbWVzID0gInJlZ3MiLCAiY29uZmlnIjsNCj4gPiArCQkJ
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDEwOCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1FDQo+
IGludGVycnVwdCAqLw0KPiA+ICsJCQkJICAgICA8R0lDX1NQSSAxMDkgSVJRX1RZUEVfTEVWRUxf
SElHSD47IC8qIGFlcg0KPiBpbnRlcnJ1cHQgKi8NCj4gPiArCQkJaW50ZXJydXB0LW5hbWVzID0g
InBtZSIsICJhZXIiOw0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiArCQkJI3Np
emUtY2VsbHMgPSA8Mj47DQo+ID4gKwkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ID4gKwkJCWRt
YS1jb2hlcmVudDsNCj4gPiArCQkJbnVtLXZpZXdwb3J0ID0gPDg+Ow0KPiA+ICsJCQlidXMtcmFu
Z2UgPSA8MHgwIDB4ZmY+Ow0KPiA+ICsJCQlyYW5nZXMgPSA8MHg4MTAwMDAwMCAweDAgMHgwMDAw
MDAwMCAweDgwIDB4MDAwMTAwMDAgMHgwDQo+IDB4MDAwMTAwMDAgICAvKiBkb3duc3RyZWFtIEkv
TyAqLw0KPiA+ICsJCQkJICAweDgyMDAwMDAwIDB4MCAweDQwMDAwMDAwIDB4ODAgMHg0MDAwMDAw
MCAweDANCj4gMHg0MDAwMDAwMD47IC8qIG5vbi1wcmVmZXRjaGFibGUgbWVtb3J5ICovDQo+ID4g
KwkJCW1zaS1wYXJlbnQgPSA8Jml0cz47DQo+ID4gKwkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47
DQo+ID4gKwkJCWludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCj4gPiArCQkJaW50ZXJy
dXB0LW1hcCA9IDwwMDAwIDAgMCAxICZnaWMgMCAwIEdJQ19TUEkgMTA5DQo+IElSUV9UWVBFX0xF
VkVMX0hJR0g+LA0KPiA+ICsJCQkJCTwwMDAwIDAgMCAyICZnaWMgMCAwIEdJQ19TUEkgMTEwDQo+
IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsJCQkJCTwwMDAwIDAgMCAzICZnaWMgMCAwIEdJ
Q19TUEkgMTExDQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsJCQkJCTwwMDAwIDAgMCA0
ICZnaWMgMCAwIEdJQ19TUEkgMTEyDQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsJCQlp
b21tdS1tYXAgPSA8MCAmc21tdSAwIDE+OyAvKiBGaXhlZC11cCBieSBib290bG9hZGVyICovDQo+
ID4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJcGNp
ZUAzNTAwMDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YS1wY2llIjsNCj4g
PiArCQkJcmVnID0gPDB4MDAgMHgwMzUwMDAwMCAweDAgMHgwMDEwMDAwMCAgIC8qIGNvbnRyb2xs
ZXINCj4gcmVnaXN0ZXJzICovDQo+ID4gKwkJCSAgICAgICAweDg4IDB4MDAwMDAwMDAgMHgwIDB4
MDAwMDIwMDA+OyAvKiBjb25maWd1cmF0aW9uDQo+IHNwYWNlICovDQo+ID4gKwkJCXJlZy1uYW1l
cyA9ICJyZWdzIiwgImNvbmZpZyI7DQo+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMTMg
SVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gKwkJCQkgICAgIDxHSUNfU1BJIDExNCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4gPiArCQkJaW50ZXJydXB0LW5hbWVzID0gInBtZSIsICJhZXIiOw0K
PiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiArCQkJI3NpemUtY2VsbHMgPSA8Mj47
DQo+ID4gKwkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ID4gKwkJCWRtYS1jb2hlcmVudDsNCj4g
PiArCQkJbnVtLXZpZXdwb3J0ID0gPDg+Ow0KPiA+ICsJCQlidXMtcmFuZ2UgPSA8MHgwIDB4ZmY+
Ow0KPiA+ICsJCQlyYW5nZXMgPSA8MHg4MTAwMDAwMCAweDAgMHgwMDAwMDAwMCAweDg4IDB4MDAw
MTAwMDAgMHgwDQo+IDB4MDAwMTAwMDAgICAvKiBkb3duc3RyZWFtIEkvTyAqLw0KPiA+ICsJCQkJ
ICAweDgyMDAwMDAwIDB4MCAweDQwMDAwMDAwIDB4ODggMHg0MDAwMDAwMCAweDANCj4gMHg0MDAw
MDAwMD47IC8qIG5vbi1wcmVmZXRjaGFibGUgbWVtb3J5ICovDQo+ID4gKwkJCW1zaS1wYXJlbnQg
PSA8Jml0cz47DQo+ID4gKwkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ID4gKwkJCWludGVy
cnVwdC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCj4gPiArCQkJaW50ZXJydXB0LW1hcCA9IDwwMDAw
IDAgMCAxICZnaWMgMCAwIEdJQ19TUEkgMTE0DQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+
ICsJCQkJCTwwMDAwIDAgMCAyICZnaWMgMCAwIEdJQ19TUEkgMTE1DQo+IElSUV9UWVBFX0xFVkVM
X0hJR0g+LA0KPiA+ICsJCQkJCTwwMDAwIDAgMCAzICZnaWMgMCAwIEdJQ19TUEkgMTE2DQo+IElS
UV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsJCQkJCTwwMDAwIDAgMCA0ICZnaWMgMCAwIEdJQ19T
UEkgMTE3DQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsJCQlpb21tdS1tYXAgPSA8MCAm
c21tdSAwIDE+OyAvKiBGaXhlZC11cCBieSBib290bG9hZGVyICovDQo+ID4gKwkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gIAkJcGNpZUAxZjAwMDAwMDAgeyAv
KiBJbnRlZ3JhdGVkIEVuZHBvaW50IFJvb3QgQ29tcGxleCAqLw0KPiA+ICAJCQljb21wYXRpYmxl
ID0gInBjaS1ob3N0LWVjYW0tZ2VuZXJpYyI7DQo+ID4gIAkJCXJlZyA9IDwweDAxIDB4ZjAwMDAw
MDAgMHgwIDB4MTAwMDAwPjsNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
