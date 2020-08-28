Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D22C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E5B20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AS4WMzgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgH1Rx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:53:29 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:12065
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726677AbgH1Rx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:53:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAAYknqT90mcfuyjxUn0Fa4mcoHtHJVEStZ1BPbTt80mj8UYmfBOnrdkzNQFKfh8NbUkMP6SLKUzu7lGa3x8WWtHLPXXBDrpBmV3GiDQKC/qORgbrB6oT4AVnk8v9mxJEYVMszikPFbaVX+ThOigQIlmftB/7rWxWGYOKJNgFRq5jY3kSjWi04dyqyZ4/JmPLqJZNaGKnNsfsu/xC5z3vFMr8aJNKfesoeIowW9KNG9m0Ug1oeCwLz+M7246Q51/UsfXVnpw334cJ2BrCxlPccKK7XQ0Xuxf+5BvjO1iSGwrPVreLzWpj4+09V8ypGTSPrSVcwLigLnfuUteHuMzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhDw++zBJ/YdlJf5oLmNioFPmRVlLOas97/cBBVOLEM=;
 b=aC8ZXAJe1a/eXpYgqo2X21Z27QLmYwe020qdpQt1IKQvRHUuTv1OpaJYbwqMn1keEo5najfWLl+9Gs8RsHkuh5SM5hlNoGfJVYjFvvmi4m5OAijc4/O+jBnwrIl15TrfKuKOrhd2FTIJ6vRep1CJBU02gL3XKgcxoTJyLdeeiuBcuKH24lVHjHfmemMU3Wok0wOercaPU75X7fyLiNGGVPiHe6PfQwxvlSoSTIw0XJK/CoFXB+K0pRxV60VEpLS5kNxyoJqTwhkINWIMs857pNccJHaI14OwAK63HwjJa+V4YlkGdajgylj5kmwX89WP4hIpabthwdQEiB1r4msfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhDw++zBJ/YdlJf5oLmNioFPmRVlLOas97/cBBVOLEM=;
 b=AS4WMzgLOVrAndskorPdkWgFeh3vbKGIbP+MLuRCgd5XFCB4YbEuOW7L6QXvo6B6ksFlp71S7JmIDdRbOabuNTANodd40yMEGeyH0vjEb5C5bXhaFvkCWg89E663yG3Gij6wCb7WmUg3wvJVJk032fh3zpFt2epIl8WAlLu2rHU=
Received: from DM6PR02MB5898.namprd02.prod.outlook.com (2603:10b6:5:159::13)
 by DM6PR02MB6778.namprd02.prod.outlook.com (2603:10b6:5:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 17:53:22 +0000
Received: from DM6PR02MB5898.namprd02.prod.outlook.com
 ([fe80::a89e:8bd5:81f:e5ff]) by DM6PR02MB5898.namprd02.prod.outlook.com
 ([fe80::a89e:8bd5:81f:e5ff%5]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 17:53:22 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Topic: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Index: AQHWe9kSXk9fyd29ekqKVsSVp3b0nKlMTReAgAF8bsA=
Date:   Fri, 28 Aug 2020 17:53:22 +0000
Message-ID: <DM6PR02MB589878EB45E441F87B6D177CC1520@DM6PR02MB5898.namprd02.prod.outlook.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
 <0927fb9f-1044-38b3-d6f3-76edffefd99c@arm.com>
In-Reply-To: <0927fb9f-1044-38b3-d6f3-76edffefd99c@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41261886-e562-40d5-1dd5-08d84b7b41a8
x-ms-traffictypediagnostic: DM6PR02MB6778:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB67782406329CC43353674214C1520@DM6PR02MB6778.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McmlKtIe8TGp3SSZ839mQuROLKGqQ8GvkKrFo/MHHj/KP89dbfv98JJTbd3X8LDS8Gtut6uefcjPMzo5MjAI5j7f3d7SVWW4ceeZzZtGSuLEps51j9UmX9RSdbagNEOo33pQD2Dxj51/ChtCpO6ViXj8rU+d3LjiXWVO6tqRhfgCWqUdUSCamCahVGYULQUkzM/GVLv7gl2RAVyDiVrKVBwtAiqCY11Njk1TA6WvsU2StYbrjy0BLQYdTHuyXTufqdWNNMXOxfbQpa9CEXxLcl1GS8C7xdyeJKdrxBJSf7RN2/34VRj8rxrcqv2j8rHl0sA3JkMMaigoGgP9G2i6mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5898.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(136003)(396003)(2906002)(8936002)(316002)(52536014)(7696005)(86362001)(110136005)(6506007)(53546011)(76116006)(66946007)(8676002)(26005)(186003)(64756008)(66556008)(66476007)(33656002)(54906003)(7416002)(5660300002)(71200400001)(4326008)(55016002)(83380400001)(478600001)(9686003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Cy1xzB0N22DMN79qHyOjHPwcB1gssCOZXDc41wkaE2PjRSSQ71J4GdRxTNUzk3jBSPgkJfUfvnmH4gux/cW8mzrBZMko78FEbSCjkBlI0MPw49ReQ+rHA3+p3yJ2WqP8AXjpyM2sSFIQlgk1Dz52VhW6TP7L5UWbo/H5oNW0HY3VumNvF9ep+VZfKv0iTkBbEsp3Zp9eHeur6qGv9D3xHlWhwLIqbZzmYqPE3Cw1zboUkVVqf8q9iZQlyekajaqBm06bOyn+ElDX/H28Gbyf9RsFaMF+2+RqKwIxh6QwaFTl5xZ5oc/Ol2WeATIaOd+E+kxR0llw92D/MqIQRWK9e8hVmoIHnYXUhKeguRGXtUZHNJy46Wfo/ccNJXf+5FAzMlVQF9IiSV6ctZ78g6g+VPtyNo2LlFc5V5t7fTlRXxJupGj2yDiNPPKg5T8vMufDPlqWdG07fqki9pKLpSzeRhbyzrvMfnvvmxy7b1BmTNwb7MlMiB2mkO2d9MH6RjLnozHLEp/5F2VxyrrZT0OdL1xousgKV3VfFpv1w5mTG7eyq+32QYUeMEIQ6H7AX3MlZl++D0GmMjoDBcZ+by8YB/i1+bqv3owKc8UsEyDjeX3dgd+IzCUySs/s6WHmvdeM3O9cGdI/hrVwZw3al6X3jA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5898.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41261886-e562-40d5-1dd5-08d84b7b41a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 17:53:22.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtvLaNLB4RrmRS+88eXTwzu/rdRsFM1gcfAghfyL29cb8gPtVej7Hupn6LYRQRN0Jlqejfj+bScw8g3xtkzTNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6778
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gUGxlYXNlIGZpbmQgbXkgY29tbWVu
dCBiZWxvdyBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Um9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1
c3QgMjgsIDIwMjAgMTI6MTcgQU0NCj4gVG86IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54
LmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7
IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgYmFsYmlAa2VybmVsLm9yZzsNCj4g
cC56YWJlbEBwZW5ndXRyb25peC5kZQ0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBnaXQgPGdpdEB4aWxpbnguY29tPjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gdXNiOiBkd2MzOiBBZGQgZHJp
dmVyIGZvciBYaWxpbnggcGxhdGZvcm1zDQo+IA0KPiBPbiAyMDIwLTA4LTI2IDE5OjQ0LCBNYW5p
c2ggTmFyYW5pIHdyb3RlOg0KPiBbLi4uXQ0KPiA+ICsJLyoNCj4gPiArCSAqIFRoaXMgcm91dGVz
IHRoZSB1c2IgZG1hIHRyYWZmaWMgdG8gZ28gdGhyb3VnaCBDQ0kgcGF0aCBpbnN0ZWFkDQo+ID4g
KwkgKiBvZiByZWFjaGluZyBERFIgZGlyZWN0bHkuIFRoaXMgdHJhZmZpYyByb3V0aW5nIGlzIG5l
ZWRlZCB0bw0KPiA+ICsJICogbWFrZSBTTU1VIGFuZCBDQ0kgd29yayB3aXRoIFVTQiBkbWEuDQo+
ID4gKwkgKi8NCj4gPiArCWlmIChvZl9kbWFfaXNfY29oZXJlbnQoZGV2LT5vZl9ub2RlKSB8fCBk
ZXYtPmlvbW11X2dyb3VwKSB7DQo+ID4gKwkJcmVnID0gcmVhZGwocHJpdl9kYXRhLT5yZWdzICsg
WExOWF9VU0JfQ09IRVJFTkNZKTsNCj4gPiArCQlyZWcgfD0gWExOWF9VU0JfQ09IRVJFTkNZX0VO
QUJMRTsNCj4gPiArCQl3cml0ZWwocmVnLCBwcml2X2RhdGEtPnJlZ3MgKyBYTE5YX1VTQl9DT0hF
UkVOQ1kpOw0KPiA+ICsJfQ0KPiANCj4gVGhpcyBsb29rcyByYXRoZXIgc3VzcGVjdCAtIGNvaGVy
ZW5jeSBzaG91bGQgYmUgYmFzZWQgb24gY29oZXJlbmN5LCBub3QNCj4gb24gd2hldGhlciBhbiBJ
T01NVSBncm91cCBpcyBwcmVzZW50LiBJZiB0aGUgZGV2aWNlIGlzbid0IGRlc2NyaWJlZCBhcw0K
PiBjb2hlcmVudCBpbiB0aGUgRFQsIHRoZW4gYW55IFNNTVUgbWFwcGluZ3Mgd2lsbCBlbmQgdXAg
dXNpbmcgYXR0cmlidXRlcw0KPiB0aGF0IHdpbGwgZG93bmdyYWRlIHRyYWZmaWMgdG8gYmUgbm9u
LXNub29waW5nIGFueXdheS4gQW5kIGlmIHRoZSBTTU1VDQo+IGlzIGVuYWJsZWQgYnV0IG5vdCB0
cmFuc2xhdGluZyAoZS5nLiAiaW9tbXUucGFzc3Rocm91Z2g9MSIpIHRoZW4NCj4gZW5hYmxpbmcg
aGFyZHdhcmUgY29oZXJlbmN5IHdoZW4gdGhlIERNQSBsYXllciBoYXNuJ3QgYmVlbiB0b2xkIGFi
b3V0IGl0DQo+IGNhbiBwb3RlbnRpYWxseSBsZWFkIHRvIG5hc3R5IHN1YnRsZSBwcm9ibGVtcyBh
bmQgZGF0YSBsb3NzLg0KDQpNYXkgYmUgdGhlIGRlc2NyaXB0aW9uIG5lZWRzIHRvIGJlIHVwZGF0
ZWQgaW4gdGhpcy4gVGhpcyBpcyBub3QgdGhlIGFjdHVhbCBjb2hlcmVuY3kgZW5hYmxpbmcgYml0
LCBidXQgdGhpcyBpcyBuZWVkZWQgd2hlbiBjb2hlcmVuY3kgaXMgZW5hYmxlZC4NClRoaXMgaXMg
YSByZWdpc3RlciBpbnNpZGUgWGlsaW54IFVTQiBjb250cm9sbGVyIHdoaWNoIGhhbmRsZXMgVVNC
ICh3aGljaCBpcyBpbiBMUEQpIHRyYWZmaWMgcm91dGUgc3dpdGNoaW5nIGZyb20gTFBEIChMb3cg
UG93ZXIgRG9tYWluKSB0byBGUEQgKEZ1bGwgUG93ZXIgRG9tYWluKSAgcGF0aCBpbiB0aGUgWGls
aW54IFNvQyBpbiBlaXRoZXIgb2YgdGhlIGJlbG93IHNjZW5hcmlvczoNCjEuIERldmljZSBpcyBk
ZXNjcmliZWQgY29oZXJlbnQgaW4gIERULg0KMi4gU01NVSBpcyBlbmFibGVkLg0KDQpJIHdpbGwg
dXBkYXRlIHRoZSBzYW1lIGluIHYyLg0KDQpUaGFua3MsDQpNYW5pc2gNCg==
