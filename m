Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE8AC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF7824697
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="UiDf5sgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1QrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:47:13 -0500
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com ([40.107.21.110]:17543
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgB1QrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:47:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTzs+g8Ml1L6Og4BVkRPVd8BOIK+7GnuuafGiNQbFl1My9Ecr4ffwCgYdUh//WrpZRsppmSNesoS+AVSUY74ie5gn6Bb9oQvnPludefijr3Wi4iM7+AulbXdvEWRB8nGUhC+TeSJHGw+PjH3x6HPWaIcOjCPHdIcdIqXyb84j9jZSpMUJ+7A45vdeGqb1ZuJcoMAUBH9nhnHyMYj0ok5xoF3m85sRxHghiX8qM0+Js9Bbn4e6UCWgdEXcDUW04XEyHRzE94s7ORLTIGZo5u4dboVfm2yfY7cdZrYS72ZK/2WL+lMtJ62IZGbFTlCQiDWZNECLbrBPu0h+n88+lmtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MfsaqkH9gzzdOj+YGCbM7pec43MM2AYADIGlscU1HM=;
 b=M+trkFeIUdspsV1tplvT1qtHsOBDKoeYKQ8QCMPts52fAqjx/uIbUG5x0RYSJ5PbWoD+PWjQXMNFEos9yQDC+x36r1cBv3icCS4zg7YjvLhk32nQ7QG7DlB/juuCU/rl8hfS0BsUMYMkVL75pF0CJPYW3n74dgm5ZLvxr1cFgNw9eWlfi7dvpSEfQ/kg4xUwudSednM0HA0pROW7hoFoa3vKANjMmrnic9HtwV7HNq+VOZwtwPNkcMKsQhMBZIJ0xqd/fEWrcSn6lWfoAr3hViR9vNJPzJUOJVdrIRifm1zkbQq9ABbRrxSKIn4i7UzF4n8dXdGZM/1spOfFoEMSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MfsaqkH9gzzdOj+YGCbM7pec43MM2AYADIGlscU1HM=;
 b=UiDf5sgzYJGoarz6gJ8B0KA8oBYHGYbXBqMQezj921+iWoQ6choqqlYj4FI8Wn2HBhdiBIG8OS1sFZpcxU4u3e+s7aqKUG+cSnjRYHGo4uKLE5r3osAphHfwr0uo/dAxf2fk2xjhJswZTcC7ttslQ/XH9gORox4rkraBYrrpIvM=
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) by
 VI1PR05MB5566.eurprd05.prod.outlook.com (20.177.203.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Fri, 28 Feb 2020 16:47:06 +0000
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb]) by VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 16:47:06 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "igor.opaniuk@gmail.com" <igor.opaniuk@gmail.com>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] arm: dts: imx6: toradex: use
 SPDX-License-Identifier
Thread-Topic: [PATCH v1 1/5] arm: dts: imx6: toradex: use
 SPDX-License-Identifier
Thread-Index: AQHV6zhrpxWYloCtVUak45/He4E7U6gw1vmA
Date:   Fri, 28 Feb 2020 16:47:06 +0000
Message-ID: <45f8acad8a095ad6761630330df64c975f3644e0.camel@toradex.com>
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
In-Reply-To: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [81.221.74.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c87c767-1912-423d-052d-08d7bc6dd875
x-ms-traffictypediagnostic: VI1PR05MB5566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5566242FA29945AA75613E80FBE80@VI1PR05MB5566.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39850400004)(366004)(136003)(376002)(189003)(199004)(5660300002)(2906002)(8936002)(44832011)(110136005)(6512007)(71200400001)(316002)(6486002)(81156014)(81166006)(2616005)(7416002)(36756003)(8676002)(54906003)(86362001)(66556008)(6506007)(4326008)(66476007)(66446008)(66946007)(26005)(91956017)(64756008)(76116006)(478600001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5566;H:VI1PR05MB6845.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+VoiOd1tHlhk+VpfQfLZ16VWyv2xyGUvhMu85U7D6NpsO2VTZv7/n60r/wqyv4FrN285adHQphdozS7NkCkIVtgH8ckFe+eVKRWH/aN771BBWqQ53L//f78Y7MVOp5PtXVoJgZpB36/44z7RjkURk+tGRHXP6ObsLqlKhKZR0OudXg1BedUdMKn5kZl7a9SaGgEMV4ubrMDPpY/DrnPZ4U0AbLjQicEk8cklIE3DCrDynaPkSOYL4JwMKmRZdZywQxv9w0EKaKtmqWpfKAZx5iMaSf6SUgTjIGsTKJ6K5fJohuw/ak7h6m0qLex5uClYx7gGwt6BvVegiFl94uMPr0QrsLFJUKvcSOgtCyBPBHsQij9gAlFYvOd/hBSM+Ook5ZBAcy9TV1qMhn3AsyE2cjhVuC/nIefcqyCfDDhvj/074Jv8s4HzTGF0ExIs50U
x-ms-exchange-antispam-messagedata: Hwe++QkO4fKzTCCVjJIq7kHxgc49q8uo/FISuetWULdflC9duJfMF0bvZ77C0MBC8Dr1561+nhM6mIq27qddkbPB1E2NMwu8YsKDmMO24E1Lvyw6B8nHrDG9OaM5h5Bg8WiTeL+89SCgBDg0O8IRUw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <724FC9E0EC854E4883967566C2DC1E8C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c87c767-1912-423d-052d-08d7bc6dd875
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 16:47:06.3835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fP5xapcEP/sXx+jYbVDmTzdhVCdRcv1NbRJR3thkXXBV//1b5pM2kw33Of+i3lenRGKKK6fOAY3C2+KAl3EBSzbXnQSRBNRFjTz1hvfh3/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWdvcg0KDQpPbiBNb24sIDIwMjAtMDItMjQgYXQgMTk6MzIgKzAyMDAsIElnb3IgT3Bhbml1
ayB3cm90ZToNCj4gRnJvbTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+
DQo+IA0KPiAxLiBSZXBsYWNlIGJvaWxlciBwbGF0ZSBsaWNlbnNlcyB0ZXh0cyB3aXRoIHRoZSBT
UERYIGxpY2Vuc2UNCj4gaWRlbnRpZmllcnMgaW4gVG9yYWRleCBpTVg2LWJhc2VkIFNvTSBkZXZp
Y2UgdHJlZXMuDQo+IDIuIEFzIFgxMSBpcyBpZGVudGljYWwgdG8gdGhlIE1JVCBMaWNlbnNlLCBi
dXQgd2l0aCBhbiBleHRyYSBzZW50ZW5jZQ0KPiB0aGF0IHByb2hpYml0cyB1c2luZyB0aGUgY29w
eXJpZ2h0IGhvbGRlcnMnIG5hbWVzIGZvciBhZHZlcnRpc2luZyBvcg0KPiBwcm9tb3Rpb25hbCBw
dXJwb3NlcyB3aXRob3V0IHdyaXR0ZW4gcGVybWlzc2lvbiwgdXNlIE1JVCBsaWNlbnNlDQo+IGlu
c3RlYWQNCj4gb2YgWDExICgncy9YMTEvTUlUL2cnKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEln
b3IgT3Bhbml1ayA8aWdvci5vcGFuaXVrQHRvcmFkZXguY29tPg0KPiAtLS0NCj4gDQo+ICBhcmNo
L2FybS9ib290L2R0cy9pbXg2ZGwtY29saWJyaS1ldmFsLXYzLmR0cyAgfCA0MCArKy0tLS0tLS0t
LS0tLS0tLQ0KPiAtLS0tLS0tLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFsaXMt
ZXZhbC5kdHMgICAgICAgfCA0MCArKy0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0tDQo+ICBh
cmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFsaXMtaXhvcmEtdjEuMS5kdHMgfCA0MCArKy0tLS0t
LS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFs
aXMtaXhvcmEuZHRzICAgICAgfCA0MCArKy0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0tDQo+
ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNpICAgICAgICAgfCA0MCArKy0t
LS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRs
LWNvbGlicmkuZHRzaSAgICAgICAgfCA0MCArKy0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0t
DQo+ICA2IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIyOCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2ZGwtY29saWJyaS1ldmFs
LXYzLmR0cw0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC1jb2xpYnJpLWV2YWwtdjMuZHRz
DQo+IGluZGV4IGNkMDc1NjIuLmFhZDQ3YjkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZkbC1jb2xpYnJpLWV2YWwtdjMuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZkbC1jb2xpYnJpLWV2YWwtdjMuZHRzDQo+IEBAIC0xLDQ0ICsxLDggQEANCj4gKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wIE9SIE1JVA0KDQpUeXBpY2FsbHksIG5vd2Fk
YXlzIEdQTC0yLjArIE9SIE1JVCBpcyB1c2VkLiBUaGUgbW9yZSByZXN0cmljdGl2ZSBHUEwNCmlz
IG5vdCBhbiBpc3N1ZSBkdWUgdG8gYmVpbmcgZHVhbCBsaWNlbnNlZC4NCg0KPiAgLyoNCj4gLSAq
IENvcHlyaWdodCAyMDE0LTIwMTYgVG9yYWRleCBBRw0KPiArICogQ29weXJpZ2h0IDIwMTQtMjAy
MCBUb3JhZGV4IEFHDQoNCkFjY29yZGluZyB0byBvdXIgbGVnYWwgd2UgbWF5IHNpbXBseSBkcm9w
IHRoaXMgQUcgcG9zdGZpeCBhcyBpdCBkb2VzDQpub3QgcmVhbGx5IHNlcnZlIGFueSBwdXJwb3Nl
IGhlcmUuDQoNCkRpdG8gaW4gYWxsIHRoZSBvdGhlciBmaWxlcy4NCg0KVGhhbmtzIQ0KDQpDaGVl
cnMNCg0KTWFyY2VsDQo=
