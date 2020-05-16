Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D564C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD5E2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dc2XmORq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgEPJUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:20:50 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:7757
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgEPJUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgqU3bhxpmkvNsW1MeTjaej8tY0K+AMNnJKsVvF2+tRu60YzwJKc1pvE7lnRSjzjzXBVR+eb2IeU//NEV9F5L1Gym+Cz0LPmY96jI+7gJjYMPyX/119DBI21pk76XZ4I0iypoI2665GZt79kwE6CX9miZGTcvrwbiLtiVQTSXqgDZHNM8chpiho8uUNk7hegOaqEKW+XA594md2QJrYVwSbI9v7sOV0bVWw58V8un6WSKNdFlOxAFde4dE6b5fi95o+BZhOGfI7Ifpam/1I2xSklixMtWeSnrCqPPvopNMPs0c1e2Wu3m4X2sy6ZKPZo9bD4uPHmKm/roVrzW0NSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HH8yHShy5NMZhS4Rk4DzExnyvyuE5f4O05xEu4rgsQ=;
 b=I/nwFat5HBIO1n9e/Mc05lcZN2G0FKxHHOmbFQORolAKJiPvaTIfYCPtKfYynZeVjhE8Yar6D9HQhbyDEN1Da0u7tNaBFYEVevylLPTdTrj8WlaeB/HJwZ8WVx5cdiQJYaz+Khe7b12m18scsfbHZAf3zhF3w782BG0RIWwQmqIaDDX141zGxZH2A5J3dO7w1l62S288rkDskicdsTXTf51ifj8ULYFE+hWs0t6Mwxe39it36iHUzxrIktuYE9PYTDn/wS+0sliGy7vIKruB5rL4U7V5SN0R0MhalY6G+G08HP1QRwLPPLzkUean1HGA/qoTqoABaQnUbGb7+ui2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HH8yHShy5NMZhS4Rk4DzExnyvyuE5f4O05xEu4rgsQ=;
 b=Dc2XmORqlzo5Cpf8aGiRzUcLuejU6awC36EAc3MEnzFhNWS5DnHh7uivOVxlrqZsCtmu0k1OPIRt/CtXa+r840HaKwcqO0xX+XvG25OUgC67qNZ8x/gU6582riuo1h43p2+VcdYJo3s5zhhjKzACBz/ggGuoTTc1pPaMFllxuJE=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VE1PR04MB6671.eurprd04.prod.outlook.com (2603:10a6:803:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sat, 16 May
 2020 09:20:44 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::5086:ae9e:6397:6b03%7]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 09:20:44 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: RE: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Topic: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Index: AQHWJdlQZJAsekudzECWhic28QWur6io62yAgAAEAECAAPXLAIAAcdqAgAAhu3A=
Date:   Sat, 16 May 2020 09:20:43 +0000
Message-ID: <VE1PR04MB6528AB046FD441A5DDD83CD289BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <87h7wqmwrv.fsf@kernel.org>
 <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
 <87imgx35pg.fsf@kernel.org>
 <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
 <87ftc0xsig.fsf@kernel.org>
In-Reply-To: <87ftc0xsig.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b602387-1ee4-4503-a234-08d7f97a6916
x-ms-traffictypediagnostic: VE1PR04MB6671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6671084E079586DBE4F8F53D89BA0@VE1PR04MB6671.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2O8mjWJqsiv3SlKvLRbG5jZFryc/kviPF4Y3GH/JaxOCd/ZWppCPMyRtO8q03a/7jbfrCXDtqXNcB0RKCY1cX4E61tIfhbhM34nfp/m4xkBcSVGUWVusZ3vEwQhxDP49imtUa4yP3u7BIs7U91X0S7uHU64poDkUwpiZ09vKrAF1QWI5ogX6f1TwYpjwU4M65BlIDXyoMnPw0cI59bfYCbuLR5ndIx4zVFqVYH31IwPRng25VE65kkSllK86+BrB51ecoSKx/jTI8W0uOei0azZubEWpNBnxpnZ16TTbK6xBlN8BRaE4l/ABhdAnU+h2gDYzwkzdLITWXnTdnrocRIcr0OMjLczmVxdm6eq/6H1bechirexb7pWfB6DaJUJiTjqVXXPRL8mAi/LJJYN57HfcB8uE96BiMbzgb811k9RUt8h8+FXBYbg/o8wHQ2P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(26005)(110136005)(86362001)(52536014)(54906003)(64756008)(2906002)(76116006)(8936002)(66556008)(66946007)(66476007)(66446008)(316002)(8676002)(478600001)(7696005)(44832011)(186003)(4326008)(71200400001)(53546011)(7416002)(33656002)(6506007)(5660300002)(55016002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cwaWXyZMAT8oXeXulTn6Zay2FOhYGLWaI7+o/XRoATg6eUs1tWQ3CnRmixdKwZToWaHlmgLjsKu+zf/go3iFgzr5rkFBm1jtlxdIVzadPpQC3TYW7lYfGOj3YcEoM7sJ4rqcL57PV7EXb5iIq5Y0ey7p3clTt9+ZYsbeLN3+FRsmVQxD9lXeWTKxrcjFSIsLY2JGuWaNXM2cO9uaiDvMsdFIaUs4YaOXeVli3R8j7QjVZZ1B2gg6WI7D2SyP61FMrQEhJ6xBKLMeOwkLTuZbzlhibLz0mvwRAjqgsRpqLgzsIYQjm1u8VIKqx1beyN1SXssiit4l71LfdQk8janCaHhBd0pD9/0PeX+vc9kk6rgZhqwBE0hX0j8iaj7wt5M8BCL+arT10xEFdhuEXe1MLw/3FYK+D0WgwkseYQdBZ9EB63mhdT0VunTVKKdguQktVyI2CJe9mpcrZL/FXTj2odBM5MBuF5N6XPtgpDH6irc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b602387-1ee4-4503-a234-08d7f97a6916
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 09:20:43.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KK0CdXW5y9VVOMwTeepafu+yhRR442GDmAH+g8Nvk0KYsZcjSXZ9MiIlcogirpsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZlbGlwZSBCYWxiaSA8
YmFsYmlmQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEZlbGlwZSBCYWxiaQ0KPiBTZW50OiAyMDIw
5bm0NeaciDE25pelIDE1OjEzDQo+IFRvOiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+OyBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsgSnVuIExpDQo+IDxsaWp1bi5rZXJu
ZWxAZ21haWwuY29tPg0KPiBDYzogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+
OyBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgWXUNCj4gQ2hlbiA8Y2hlbnl1
NTZAaHVhd2VpLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+OyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5k
IDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFNodUZhbiBMZWUNCj4gPHNodWZhbl9sZWVAcmljaHRl
ay5jb20+OyBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+
Ow0KPiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPjsgQ2h1bmZlbmcg
WXVuDQo+IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPjsgSGFucyBkZSBHb2VkZSA8aGRlZ29l
ZGVAcmVkaGF0LmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5keS5zaGV2Y2hlbmtvQGdtYWls
LmNvbT47IFZhbGVudGluIFNjaG5laWRlciA8dmFsZW50aW4uc2NobmVpZGVyQGFybS5jb20+Ow0K
PiBKYWNrIFBoYW0gPGphY2twQGNvZGVhdXJvcmEub3JnPjsgTGludXggVVNCIExpc3QgPGxpbnV4
LXVzYkB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuDQo+IGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxB
VFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47
DQo+IFBldGVyIENoZW4gPHBldGVyLmNoZW5AbnhwLmNvbT47IFRoaW5oIE5ndXllbiA8VGhpbmgu
Tmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAzLzldIHVzYjog
ZHdjMzogSW5jcmVhc2UgdGltZW91dCBmb3IgQ21kQWN0IGNsZWFyZWQgYnkgZGV2aWNlDQo+IGNv
bnRyb2xsZXINCj4gDQo+IA0KPiBIaSwNCj4gDQo+IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4gd3JpdGVzOg0KPiA+IEp1biBMaSB3cm90ZToNCj4gPj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBGZWxpcGUgQmFsYmkgPGJhbGJpZkBnbWFp
bC5jb20+IE9uIEJlaGFsZiBPZiBGZWxpcGUgQmFsYmkNCj4gPj4+IFNlbnQ6IDIwMjDlubQ15pyI
MTXml6UgMTc6MzENCj4gPj4+IFRvOiBKdW4gTGkgPGxpanVuLmtlcm5lbEBnbWFpbC5jb20+DQo+
ID4+PiBDYzogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+OyBsa21sDQo+ID4+
PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFl1IENoZW4gPGNoZW55dTU2QGh1YXdl
aS5jb20+OyBHcmVnDQo+ID4+PiBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz47IFJvYiBIZXJyaW5nDQo+ID4+PiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRs
YW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFNodUZhbg0KPiA+Pj4gTGVlIDxzaHVmYW5fbGVl
QHJpY2h0ZWsuY29tPjsgSGVpa2tpIEtyb2dlcnVzDQo+ID4+PiA8aGVpa2tpLmtyb2dlcnVzQGxp
bnV4LmludGVsLmNvbT47DQo+ID4+PiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBh
cm0uY29tPjsgQ2h1bmZlbmcgWXVuDQo+ID4+PiA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT47
IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ow0KPiA+Pj4gQW5keSBTaGV2Y2hl
bmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgVmFsZW50aW4gU2NobmVpZGVyDQo+ID4+
PiA8dmFsZW50aW4uc2NobmVpZGVyQGFybS5jb20+OyBKYWNrIFBoYW0gPGphY2twQGNvZGVhdXJv
cmEub3JnPjsNCj4gPj4+IExpbnV4IFVTQiBMaXN0IDxsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
Pjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUNCj4gPj4+IEFORCBGTEFUVEVORUQgREVWSUNFIFRS
RUUgQklORElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4gPj4+IFBldGVyIENo
ZW4gPHBldGVyLmNoZW5AbnhwLmNvbT47IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBUaGluaA0K
PiA+Pj4gTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCAzLzldIHVzYjogZHdjMzogSW5jcmVhc2UgdGltZW91dCBmb3IgQ21kQWN0
DQo+ID4+PiBjbGVhcmVkIGJ5IGRldmljZSBjb250cm9sbGVyDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+
IEhpLA0KPiA+Pj4NCj4gPj4+IEp1biBMaSA8bGlqdW4ua2VybmVsQGdtYWlsLmNvbT4gd3JpdGVz
Og0KPiA+Pj4+PiBAQCAtMzk3LDEyICs0MDcsMTggQEAgaW50IGR3YzNfc2VuZF9nYWRnZXRfZXBf
Y21kKHN0cnVjdCBkd2MzX2VwDQo+ID4+Pj4+ICpkZXAsIHVuc2lnbmVkDQo+ID4+PiBjbWQsDQo+
ID4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBkd2MzX2dhZGdldF9lcF9nZXRfdHJhbnNm
ZXJfaW5kZXgoZGVwKTsNCj4gPj4+Pj4gICAgICAgICAgfQ0KPiA+Pj4+Pg0KPiA+Pj4+PiAtICAg
ICAgIGlmIChzYXZlZF9jb25maWcpIHsNCj4gPj4+Pj4gKyAgICAgICBpZiAoc2F2ZWRfaHNfY29u
ZmlnKSB7DQo+ID4+Pj4+ICAgICAgICAgICAgICAgICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJl
Z3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpOw0KPiA+Pj4+PiAtICAgICAgICAgICAgICAgcmVnIHw9
IHNhdmVkX2NvbmZpZzsNCj4gPj4+Pj4gKyAgICAgICAgICAgICAgIHJlZyB8PSBzYXZlZF9oc19j
b25maWc7DQo+ID4+Pj4+ICAgICAgICAgICAgICAgICAgZHdjM193cml0ZWwoZHdjLT5yZWdzLCBE
V0MzX0dVU0IyUEhZQ0ZHKDApLCByZWcpOw0KPiA+Pj4+PiAgICAgICAgICB9DQo+ID4+Pj4+DQo+
ID4+Pj4+ICsgICAgICAgaWYgKHNhdmVkX3NzX2NvbmZpZykgew0KPiA+Pj4+PiArICAgICAgICAg
ICAgICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKDApKTsN
Cj4gPj4+Pj4gKyAgICAgICAgICAgICAgIHJlZyB8PSBzYXZlZF9zc19jb25maWc7DQo+ID4+Pj4+
ICsgICAgICAgICAgICAgICBkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RM
KDApLCByZWcpOw0KPiA+Pj4+PiArICAgICAgIH0NCj4gPj4+Pj4gKw0KPiA+Pj4+PiAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiA+Pj4+PiAgIH0NCj4gPj4+PiBVbmZvcnR1bmF0ZWx5IHRoaXMgd2F5
IGNhbid0IHdvcmssIG9uY2UgdGhlIFNTIFBIWSBlbnRlcnMgUDMsDQo+ID4+Pj4gZGlzYWJsZSBz
dXNwZW5kX2VuIGNhbid0IGZvcmNlIFNTIFBIWSBleGl0IFAzLCB1bmxlc3MgZG8gdGhpcyBhdA0K
PiA+Pj4+IHRoZSB2ZXJ5IGJlZ2lubmluZyB0byBwcmV2ZW50IFNTIFBIWSBlbnRlcmluZyBQMyhl
LmcuIGFkZA0KPiA+Pj4+ICJzbnBzLGRpc191M19zdXNwaHlfcXVpcmsiIGZvcg0KPiA+Pj4gdGVz
dCkuDQo+ID4+Pg0KPiA+Pj4gSXQgc291bmRzIGxpa2UgeW91IGhhdmUgYSBxdWlya3kgUEhZLg0K
PiA+PiAgRnJvbSB3aGF0IEkgZ290IGZyb20gdGhlIElDIGRlc2lnbiwgdGhlIGJlaGF2aW9yIG9m
DQo+ID4+IERXQzNfR1VTQjNQSVBFQ1RMX1NVU1BIWSBiaXQgc2hvdWxkIGJlIGFzIHdoYXQgSSBz
YWlkLCBub3QgYSBxdWlya3kuDQo+ID4+DQo+ID4+IEhpIFRoaW5oLCBjb3VsZCB5b3UgY29tbWVu
dCB0aGlzPw0KPiA+DQo+ID4gWW91IG9ubHkgbmVlZCB0byB3YWtlIHVwIHRoZSB1c2IyIHBoeSB3
aGVuIGlzc3VpbmcgdGhlIGNvbW1hbmQgd2hpbGUNCj4gPiBydW5uaW5nIGluIGhpZ2hzcGVlZCBv
ciBiZWxvdy4gSWYgeW91J3JlIHJ1bm5pbmcgaW4gU1Mgb3IgaGlnaGVyLA0KPiA+IGludGVybmFs
bHkgdGhlIGNvbnRyb2xsZXIgZG9lcyBpdCBmb3IgeW91IGZvciB1c2IzIHBoeS4gSW4gSnVuJ3Mg
Y2FzZSwNCj4gPiBpdCBzZWVtcyBsaWtlIGl0IHRha2VzIGxvbmdlciBmb3IgaGlzIHBoeSB0byB3
YWtlIHVwLg0KPiA+DQo+ID4gSU1PLCBpbiB0aGlzIGNhc2UsIEkgdGhpbmsgaXQncyBmaW5lIHRv
IGluY3JlYXNlIHRoZSBjb21tYW5kIHRpbWVvdXQuDQo+IA0KPiBJcyB0aGVyZSBhbiB1cHBlciBs
aW1pdCB0byB0aGlzPyBJcyAzMmsgY2xvY2sgdGhlIHNsb3dlc3QgdGhhdCBjYW4gYmUgZmVkIHRv
IHRoZQ0KPiBQSFkgYXMgYSBzdXNwZW5kIGNsb2NrPw0KDQpZZXMsIDMySyBjbG9jayBpcyB0aGUg
c2xvd2VzdCwgUGVyIERXQzMgZG9jdW1lbnQgb24gUG93ZXIgRG93biBTY2FsZQ0KKGJpdHMgMzE6
MTkgb2YgR0NUTCk6DQoNCiJQb3dlciBEb3duIFNjYWxlIChQd3JEblNjYWxlKQ0KVGhlIFVTQjMg
c3VzcGVuZF9jbGsgaW5wdXQgcmVwbGFjZXMgcGlwZTNfcnhfcGNsayBhcyBhIGNsb2NrIHNvdXJj
ZQ0KdG8gYSBzbWFsbCBwYXJ0IG9mIHRoZSBVU0IzIGNvbnRyb2xsZXIgdGhhdCBvcGVyYXRlcyB3
aGVuIHRoZSBTUyBQSFkNCmlzIGluIGl0cyBsb3dlc3QgcG93ZXIgKFAzKSBzdGF0ZSwgYW5kIHRo
ZXJlZm9yZSBkb2VzIG5vdCBwcm92aWRlIGEgY2xvY2suDQpUaGUgUG93ZXIgRG93biBTY2FsZSBm
aWVsZCBzcGVjaWZpZXMgaG93IG1hbnkgc3VzcGVuZF9jbGsgcGVyaW9kcw0KZml0IGludG8gYSAx
NiBrSHogY2xvY2sgcGVyaW9kLiBXaGVuIHBlcmZvcm1pbmcgdGhlIGRpdmlzaW9uLCByb3VuZCB1
cA0KdGhlIHJlbWFpbmRlci4NCkZvciBleGFtcGxlLCB3aGVuIHVzaW5nIGFuIDgtYml0LzE2LWJp
dC8zMi1iaXQgUEhZIGFuZCAyNS1NSHogU3VzcGVuZCBjbG9jaywNClBvd2VyIERvd24gU2NhbGUg
PSAyNTAwMCBrSHovMTYga0h6ID0gMTMnZDE1NjMgKHJvdW5kZXIgdXApDQpOb3RlOg0KLSBNaW5p
bXVtIFN1c3BlbmQgY2xvY2sgZnJlcXVlbmN5IGlzIDMyIGtIeg0KLSBNYXhpbXVtIFN1c3BlbmQg
Y2xvY2sgZnJlcXVlbmN5IGlzIDEyNSBNSHoiDQoNCkxpIEp1bg0KPiANCj4gLS0NCj4gYmFsYmkN
Cg==
