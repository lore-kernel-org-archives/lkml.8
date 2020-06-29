Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32441C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038BD206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M561eCPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbgF2TQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbgF2TOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:22 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02on0605.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe06::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F1C0005FF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M31ajqneexso4AVJgEDX0GNSdr6DOTDYx91+cqEhXDPxXWZ1XT/ZIaHnpgrgbE6MNnCu+dkPQLEBpLpacspVz5PLuBhfI2p92kKIxFDVrHXEnH8pv3Appd10CT5LY383LADxTaqN80B5FLmVFKiwVV9K+upSKjkhLmeMVZ1aue3CxJHPGsW9wrBXQ0ZdaZO28ba+LRiEl85QzbCBOBQLIJaWQ20LfVhzufchp7WFHijBxJDByLQU3fkSOSUvc1RdtjyApfM4GQ1pbr4mYqgCMD4UsFkfwMqljxj/V7qOKvJ6q/dKP3ej3FdLB94fIC8aWptTE2kwXOcntIg/32Uwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HTBOsxMJ9q284P8jQS8/B52YelQj9n6MBJxYCmVmQM=;
 b=Gp5dwO9eVhxYgl/TgAfx88PL+lfvlYjUgfRtzVIwLgTdna47vVzXURjr+BrJOtFsXegPUtEqizpclCGFtJ2jTaieFf9bwJnhj77Qt6P8xJ72zzOy1UhId9jO9OR/Mxl48sXxqhQYreixsxicG92eUPOvzHAr9tu2fe4Qx0yjgqbm4gDgjNPIdeoDmaq6iRecuwSlM1qIRN7SMaCPvhQ5jCGAkpHOtWvN32TJ36CLoGZk41RDlHPQg1r5CRM/1vVA9aWc690ZkEUxIA1taqneEGhYVV4lhf6GleGhjLYGQpwniXkxJZDHphFUpcq1pLKnqZ6ukn60gLwoAXNS4zavJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HTBOsxMJ9q284P8jQS8/B52YelQj9n6MBJxYCmVmQM=;
 b=M561eCPwBLsnTOnmkCf6+E1ZgUFCLI920jzusqxmQP7BiNPngf/S5tbux+F1voPYMvJyiObMn35v67Es00/ev1ilbPAegphUPQuqFZgEKIkhs/LxMVxnYKbQbjGrk2cWiZNQlbTi6tVJ4pdPl19B6GkiBluIL37pf0dhQvlFuDA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR04MB3015.eurprd04.prod.outlook.com (2603:10a6:6:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 11:54:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:54:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
Thread-Topic: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
Thread-Index: AQHWTf+izjw19ytbhUGNPMq0Gpgef6jvdYuAgAABJSCAAAN4AIAAAOYw
Date:   Mon, 29 Jun 2020 11:54:39 +0000
Message-ID: <DB3PR0402MB3916A6B7F90D3A11AF093499F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-3-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2wsaS9i9BrV6o845Qx4TJrZM=+13C1haqBLg17HKVgXw@mail.gmail.com>
 <DB3PR0402MB3916E7A184549BF302C7401FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1qSdiKfcgXLAQ8JTWeg4_i+8+qh-7hH5rYiEjp-dJMkA@mail.gmail.com>
In-Reply-To: <CAK8P3a1qSdiKfcgXLAQ8JTWeg4_i+8+qh-7hH5rYiEjp-dJMkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20e36585-0493-450b-a710-08d81c233444
x-ms-traffictypediagnostic: DB6PR04MB3015:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3015488493B03536CE7008DBF56E0@DB6PR04MB3015.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4fSFTR/npddOYuUMx7C6n9ixLKIqyzJzGJCAlHdjR/MMPyRAP5eKLxgMoKEN1iiQ6+dI412K8kTenK+s9vzwDRSSrJ9U8P2t5eWepRV2lz8beEHXs6lx8iROOsxV0CNC/A8c5XT1JAaL5wyjsusoGAFO1YjjWU33yBybn0q3dbERsKbo1UPf6cMZZtfO2m46Tjc87JwohZZ9EmO1qPfC5L/CGNqUowj/noLtsp+yvv+atsQ2lfYbX+dGGGQVSsMljFStF7v+cUQC33HzkXp59OVJd2h9jjnD2hY/4mFEA9xTYztuA2S/I0mzGu6xs/up3XjyyODltBczkCJXMgNKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(44832011)(86362001)(478600001)(9686003)(83380400001)(55016002)(5660300002)(66446008)(52536014)(66556008)(66476007)(64756008)(7416002)(66946007)(7696005)(76116006)(4326008)(6916009)(8936002)(316002)(2906002)(71200400001)(186003)(54906003)(53546011)(6506007)(8676002)(33656002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +yhP+kcmzknpswqYHXPU8g2uTSVxdVydXiyc5eDHhUNS+MgiyM0U0ulLKvBOYZsZAzm/JP07GzYObnM9SScq4vMfEyKBW+P0M67d6upDxVqZ9g+fsMQfYlp2NVGdBgbA3eRXxl/hcKjBSAXiJywgEe4qtpSji0XhqwXkQuP6pb4DXTl3O0Wod5jKGTAeKVQP9sxIBUX5VKq7uP+5zE7rxxpgCwD/mZs7+c4p1PPuZ56ddE6XEMIXVRTt1U54GKp39IA7ZlAyJkOJirWJTE37nrM6icS6rSV1hig8mBLvW36llnXwTztpQzeR19ZMLv51VNtEfXOTX4A4XyVT0gpv+vOoJg5ebA3rVRz6xtyp1bOmCeaS01NycqM2MoRy6p6sFpr4QWkk3G5FkRRVzg/s4vIQNOLWnZ1Q4cRFbKLP/SqowGKxD7qwr+QFzQHb6WRv/eh9SoYqwnS2hmkB8W64PJ1TmD62FG5NbcJiPXWny+4RY8cN+99ZJUZU3gzcusNZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e36585-0493-450b-a710-08d81c233444
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:54:39.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+f9eZANnDprnCENFZ04KZG3EdBT/1bIDnKjno+XVzMq1mZLgl88p5ZMnWod1kJDiQrqaVGCYtCMYXakOFF5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBBUk06IGlteDogU2VsZWN0
IFJFU0VUX0lNWDcgZm9yIGkuTVg3RA0KPiANCj4gT24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMToz
NiBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIDMvM10gQVJNOiBpbXg6IFNlbGVjdCBSRVNFVF9JTVg3IGZvciBp
Lk1YN0QNCj4gPiA+DQo+ID4gPiBPbiBNb24sIEp1biAyOSwgMjAyMCBhdCAxMjoyNSBQTSBBbnNv
biBIdWFuZw0KPiA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0K
PiA+ID4gPiBpLk1YNyByZXNldCBkcml2ZXIgbm93IHN1cHBvcnRzIG1vZHVsZSBidWlsZCwgaXQg
aXMgbm8gbG9uZ2VyDQo+ID4gPiA+IGJ1aWx0IGluIGJ5IGRlZmF1bHQsIG5lZWQgdG8gc2VsZWN0
IGl0IGV4cGxpY2l0bHkgZm9yIGkuTVg3RC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiAgYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZyB8IDEgKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLWlteC9LY29uZmlnIGIvYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZw0KPiA+ID4gPiBp
bmRleCBlN2Q3YjkwLi4zNTQwNDgzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9hcmNoL2FybS9tYWNo
LWlteC9LY29uZmlnDQo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtL21hY2gtaW14L0tjb25maWcNCj4g
PiA+ID4gQEAgLTU2MSw2ICs1NjEsNyBAQCBjb25maWcgU09DX0lNWDdEX0NNNCAgY29uZmlnIFNP
Q19JTVg3RA0KPiA+ID4gPiAgICAgICAgIGJvb2wgImkuTVg3IER1YWwgc3VwcG9ydCINCj4gPiA+
ID4gICAgICAgICBzZWxlY3QgUElOQ1RSTF9JTVg3RA0KPiA+ID4gPiArICAgICAgIHNlbGVjdCBS
RVNFVF9JTVg3DQo+ID4gPg0KPiA+ID4gUGxlYXNlIGRyb3AgdGhpcyBwYXRjaCwgaXQgYnJlYWtz
IHRoZSBpbnRlbnQgb2YgdGhlIGZpcnN0IG9uZSBieQ0KPiA+ID4gZm9yY2luZyB0aGUgZHJpdmVy
IHRvIGJlIGJ1aWx0LWluIGFnYWluIHJhdGhlciB0aGFuIGEgbG9hZGFibGUgbW9kdWxlLg0KPiA+
ID4NCj4gPg0KPiA+IE9uZSB0aGluZyB0byBjbGFyaWZ5IGlzLCB0aGUgbG9hZGFibGUgbW9kdWxl
IHN1cHBvcnQgaXMgT05MWSBmb3IgaS5NWA0KPiA+IEFSTXY4IFNvQ3MsDQo+IA0KPiBJIGRvbid0
IHVuZGVyc3RhbmQuIFdoeSBjYW4ndCB0aGlzIGRyaXZlciBiZSBhIGxvYWRhYmxlIG1vZHVsZSBv
biBpLk1YNz8NCj4gUGxlYXNlIGNsYXJpZnkgaW4gdGhlIGNoYW5nZWxvZyB3aGF0IHRoZSBidWcg
aXMgb24gaS5NWDcuDQo+IA0KPiA+IEFSTXY3IFNvQ3MgaXMgTk9UIGluIHRoZSBwbGFuLCB0aGF0
IGlzIHdoeSBJIGFkZCB0aGlzIHBhdGNoIHRvIG1ha2UgaXQNCj4gPiBzYW1lIGFzIHByZXZpb3Vz
bHkgd2hlbiB0aGlzIHJlc2V0IGRyaXZlciBpcyA9eSBieSBkZWZhdWx0LiBXaXRob3V0DQo+ID4g
dGhpcyBwYXRjaCwgdGhpcyByZXNldCBkcml2ZXIgd2lsbCBOT1QgYmUgZW5hYmxlZCBieSBkZWZh
dWx0IGZvciBpLk1YIEFSTXY3DQo+IFNvQ3MsIGZ1bmN0aW9uIHdpbGwgYmUgYnJva2VuLg0KPiAN
Cj4gQnV0IGl0J3MgdGhlIHNhbWUgZHJpdmVyLCBtYWtlIGl0IHdvcmsgdGhlIHNhbWUgd2F5IG9u
IGFsbCBjaGlwcyENCj4gDQo+IEkgdGhpbmsgYXJ0aWZpY2lhbGx5IGxpbWl0aW5nIGEgbmV3IGRy
aXZlciBmZWF0dXJlIHRvIG9uZSBjaGlwIGp1c3QgYmVjYXVzZSBub2JvZHkNCj4gYXNrZWQgZm9y
IGl0IG9uIGFub3RoZXIgY2hpcCBpcyBub3QgaGVscGZ1bC4NCj4gDQoNClVuZGVyc3Rvb2QsIHdo
YXQgaWYgSSBkb24ndCBzZWxlY3QgaXQgaW4gU09DIGNvbmZpZyB3aGljaCBpcyBOT1QgZmxleGli
bGUsIGJ1dCBwdXQgaXQgaW4NCmlteF92Nl92N19kZWZjb25maWcsIHRoZW4gdXNlciBjYW4gc2Vs
ZWN0IGVpdGhlciA9eSBvciA9bSBhY2NvcmRpbmcgdGhlaXIgcmVxdWlyZW1lbnQ/DQpBbmQgaW4g
aW14X3Y2X3Y3X2RlZmNvbmZpZyBtYWtlIGl0ID15IGJ5IGRlZmF1bHQuDQoNClRoYW5rcywNCkFu
c29uDQo=
