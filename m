Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBE5207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P4tiz9Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFQJlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:41:14 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:14402
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbgFQJlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:41:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LokqSsRmcEwZBLsMIpba2BkKZaHUCYyrzTFo1hMuYy0SOmu97KD5QtExQiyWUZhuBHwmvEmgi0EfAFdh2hAF52IrYsdlsHiai5CyN0P62sx4PLXbF92qZKVFp267Hd3+JjSPetpxtjwl15zTk3O0z3En+gop2T9JcQsCbNLqhg5U10x8ESa87jVDt6QyFQghcVPXCqSrN8PF6t8cOVB5JHa46PiGcIzjEFyLcxkbWO4BblTnawpSWclsWMiNBptY7w4+X9fmE1c90ugCAAUaB9dY/fdEqc33vjMEOR9Jdd4VqmR2GrA8Fq7SM69Mj6dvWFNaIcNvEsL7Dr8FAkVgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH4MLm/e69JsZpomYK9XFdBoK3kwAUbYMKwfVOPkP/Q=;
 b=W9+QCdlkoHITlOjBjXu4PyqdZ4nwT3XSyy3iC9IJ3s4JgvunAg5FJ/3t9YoG/HQcpY1Ca+HoDNsGjzLzaVHdoMfrxD+XwmEymsao3YYKuijzV5TP5gvDVljcQMurho+HCx/joRBkgfMlfjXQihihlyPFXBL/nS5Ivb2qmgOQHT/KO8uk/C2Vy0Oxjv2n8XoKSt5zXyVYmSj5nLD3T2EghVg6KAyF2T1I9sKzfZLJIgvOGsaewxl+Wyi0Fh+z0VjZkGP6Rgpk48mRQIFdLxeaOdxOnfkkYU7V9JA+dxe4cXp9rmIWMcZIp0VHOl7u5xE1jU/CzHm7whNDnQ0pUITmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH4MLm/e69JsZpomYK9XFdBoK3kwAUbYMKwfVOPkP/Q=;
 b=P4tiz9Tz6i/ZlwTHdRkUjS3905TIFF6LMBrr7CW3pELzheY3B1b4VqdN/gSiJ8A51ReFAp+SevxYg731HDpgx82DWUOD5A91Tc5jjd9NklOlCRdntLyvBbamy2PLaFL132/1yV9fIe45sxuQEBBpKpYvqZiXE+1mE6OoB3w6UMI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3849.eurprd04.prod.outlook.com (2603:10a6:8:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Wed, 17 Jun
 2020 09:41:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 09:41:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, "arnd@arndb.de" <arnd@arndb.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx-scu: Support module build
Thread-Topic: [PATCH] soc: imx-scu: Support module build
Thread-Index: AQHWRGTWiz8NXUZ+xUGFBcoJjUMmmqjccS8AgAAAf6CAABnooA==
Date:   Wed, 17 Jun 2020 09:41:08 +0000
Message-ID: <DB3PR0402MB39167727A8B7CEDAC531D94EF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49667E1B41DC2A77B3E2FEBF809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <AM6PR0402MB3911B852B49E194E5FE84505F59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB3911B852B49E194E5FE84505F59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96edc783-f23e-4d64-9f7b-08d812a29079
x-ms-traffictypediagnostic: DB3PR0402MB3849:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3849CC1225E37535260F347CF59A0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQ97wlO0/CpnSvPP6W7toINFo4+Kb2Z4NcFdF5qkTygidUd5N7YHvTB6L+KmMAVP4Fg0DfOlcdVZELMvwh7+Vt5JKtBcxq9zJs9mFXOfOS8bTN5xXBhYjUq3+/PYaz3NPmvq2lVdZLUHBLAUYImNIojAr5Z/xaZ7Cp/rt90rEPBHcMJqkMMnd7rpHWqyS4SvBV1gSgv+8JcjqRBLIJt7mRNSXuBQHsb78SRXLXKQqisrcmLMrNnLJMfeESv2RZRyJIyBEJLYQsqL+XN+gOZX6kDmEySGf5/NfKQ9J+MwR8h0f4d4ecoczvM8mH9DfvNtmmaR4M27/9xp00hPDyY0Wfegj5BLfOZbSWHJCuFDjRuTi2bPkroteYatRKZfIHrS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(316002)(33656002)(8676002)(186003)(44832011)(5660300002)(4326008)(83380400001)(6506007)(110136005)(55016002)(71200400001)(26005)(52536014)(9686003)(66476007)(478600001)(7696005)(76116006)(2906002)(64756008)(66946007)(86362001)(66556008)(8936002)(66446008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4EGvsl+XMev9iQ8lmqyDF1fyteaigcCkR72l/Vfr8oUg+LUWlMLulXH2AsHJ/X4fZy1Uogq1ZEto1RtJZBXFgFqQdD7nhJH7AxbXdW2nxkxXh1dKS1PF5TFLcMJdt/Zo2GDmgqIgpz7ZunYMuPJvQqXBKeRG9RqZD3gCXq6fvRINFh+2m0q9hs5/ZJG/zfL5LZhQAjH8bjTWzFd49sk7leYr99uMPwr0jPAkcARR1f+spDoofedG1VeyzGfdC3Au/w0uKQBPTm554WQ7cWV3Zy7bw+qGhuM2me9eYD+BeJk2QY+lyQXviu169rt2eEwLxhIH6T1yQCyfvLGkerJkeQgUYMozQwETTSmO5bbJhUAU/+yM8b5v8egLOhY7zqG7fdzjoAVvfH4du1/6EO+3fG0wG+aQUz7w1AP2a+tQKIZcFDN2nSltoqRrJs/5gDI781CDVP6JsdvSNiPokTHjYBEasMa/KyJGcPQchMJVnL0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96edc783-f23e-4d64-9f7b-08d812a29079
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 09:41:09.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVEvdPJoMRepQwo9ipfeJHuLY8N4sxDrBrQvsyavVpT5UPuO4KNymSZv7gOozI51qYGQ+OCMoVHDI3x0klpqVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHNvYzogaW14LXNjdTogU3VwcG9ydCBtb2R1bGUgYnVp
bGQNCj4gDQo+IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHNvYzogaW14LXNjdTogU3VwcG9y
dCBtb2R1bGUgYnVpbGQNCj4gPg0KPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMTcsIDIwMjAgMTI6NTQgUE0N
Cj4gPiA+DQo+ID4gPiBDaGFuZ2UgdGhlIGNvbmZpZ3VyYXRpb24gdHlwZSB0byB0cmlzdGF0ZSwg
YWRkIG1vZHVsZSBkZXNjcmlwdGlvbiwNCj4gPiA+IGF1dGhvciBhbmQgbGljZW5zZSB0byBzdXBw
b3J0IG1vZHVsZSBidWlsZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvc29jL2lt
eC9LY29uZmlnICAgICAgIHwgMiArLQ0KPiA+ID4gIGRyaXZlcnMvc29jL2lteC9zb2MtaW14LXNj
dS5jIHwgNSArKysrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9L
Y29uZmlnIGIvZHJpdmVycy9zb2MvaW14L0tjb25maWcgaW5kZXgNCj4gPiA+IGQ1MTVkMmMuLmMy
NTVhY2IgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3NvYy9pbXgvS2NvbmZpZw0KPiA+ID4g
KysrIGIvZHJpdmVycy9zb2MvaW14L0tjb25maWcNCj4gPiA+IEBAIC05LDcgKzksNyBAQCBjb25m
aWcgSU1YX0dQQ1YyX1BNX0RPTUFJTlMNCj4gPiA+ICAJZGVmYXVsdCB5IGlmIFNPQ19JTVg3RA0K
PiA+ID4NCj4gPiA+ICBjb25maWcgSU1YX1NDVV9TT0MNCj4gPiA+IC0JYm9vbCAiaS5NWCBTeXN0
ZW0gQ29udHJvbGxlciBVbml0IFNvQyBpbmZvIHN1cHBvcnQiDQo+ID4gPiArCXRyaXN0YXRlICJp
Lk1YIFN5c3RlbSBDb250cm9sbGVyIFVuaXQgU29DIGluZm8gc3VwcG9ydCINCj4gPiA+ICAJZGVw
ZW5kcyBvbiBJTVhfU0NVDQo+ID4gPiAgCXNlbGVjdCBTT0NfQlVTDQo+ID4gPiAgCWhlbHANCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYw0KPiA+ID4gYi9k
cml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYyBpbmRleCAyMGQzN2VhLi5iZGQ0M2VkIDEwMDY0
NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gPiA+ICsrKyBi
L2RyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jDQo+ID4gPiBAQCAtNSw2ICs1LDcgQEANCj4g
PiA+DQo+ID4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Zpcm13YXJlL2lteC9yc3JjLmg+ICAj
aW5jbHVkZQ0KPiA+ID4gPGxpbnV4L2Zpcm13YXJlL2lteC9zY2kuaD4NCj4gPiA+ICsjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiA+
ICAjaW5jbHVkZSA8bGludXgvc3lzX3NvYy5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0
Zm9ybV9kZXZpY2UuaD4NCj4gPiA+IEBAIC0xODUsMyArMTg2LDcgQEAgc3RhdGljIGludCBfX2lu
aXQgaW14X3NjdV9zb2NfaW5pdCh2b2lkKQ0KPiA+ID4gIAlyZXR1cm4gUFRSX0VSUl9PUl9aRVJP
KHBkZXYpOw0KPiA+ID4gIH0NCj4gPiA+ICBkZXZpY2VfaW5pdGNhbGwoaW14X3NjdV9zb2NfaW5p
dCk7DQo+ID4gPiArDQo+ID4gPiArTU9EVUxFX0FVVEhPUigiQW5zb24gSHVhbmcgPGFuc29uLmh1
YW5nQG54cC5jb20+Iik7DQo+ID4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJOWFAgaS5NWCBTQ1Ug
U29DIGRyaXZlciIpOw0KPiA+IE1PRFVMRV9MSUNFTlNFKCJHUEwNCj4gPiA+ICt2MiIpOw0KPiA+
DQo+ID4gSSdtIG9rIHdpdGggdGhlIGNoYW5nZS4gQnV0IEknbSBjdXJpb3VzIGhvdyBjYW4gdGhp
cyBtb2R1bGUgYmUNCj4gPiBhdXRvbG9hZGVkIHdpdGhvdXQgTU9EVUxFX0RFVklDRV9UQUJMRS4N
Cj4gPiBIYXZlIHlvdSB0ZXN0ZWQgaWYgaXQgY2FuIHdvcms/DQo+ID4NCj4gDQo+IEkgT05MWSB0
ZXN0ZWQgdGhlIG1hbnVhbCBpbnNtb2QsIGlmIHdhbnQgdG8gc3VwcG9ydCBhdXRvIGxvYWQsIG1h
eSBuZWVkDQo+IHNvbWUgbW9yZSBjaGFuZ2UsIHdpbGwgdHJ5IGl0IGxhdGVyIGFuZCBzZW5kIG91
dCBhIFYyIGlmIG5lZWRlZC4NCg0KVGhlIGZ1cnRoZXIgY2hlY2sgc2hvd3MgdGhhdCwgaWYgd2Fu
dCB0byBzdXBwb3J0IGF1dG8gbG9hZCwgdGhlIHBsYXRmb3JtIGRldmljZQ0KcmVnaXN0ZXIgbmVl
ZHMgdG8gYmUgZG9uZSBpbiBzb21ld2hlcmUgZWxzZSB3aGljaCBpcyBidWlsdC1pbiAoaW4gbXkg
dGVzdCwgSSBtb3ZlIGl0DQp0byBjbGstaW14OHF4cC5jJ3MgcHJvYmUpLCBhbmQgYWxzbyBuZWVk
IHRvIGFkZCBiZWxvdyBtb2R1bGUgYWxpYXMgaW4gdGhpcyBkcml2ZXIsDQpiZWNhdXNlIGl0IGhh
cyBubyBkZXZpY2Ugbm9kZSBpbiBEVCBhbmQgbm8gZGV2aWNlIHRhYmxlIGluIGRyaXZlci4NCg0K
K01PRFVMRV9BTElBUygicGxhdGZvcm06aW14LXNjdS1zb2MiKTsNCg0KU2luY2UgdGhpcyBkcml2
ZXIgaGFzIG5vIGRldmljZSBub2RlIGluIERULCBhbmQgdGhlIHRhcmdldCBpcyB0byBidWlsZCBh
bGwgU29DIHNwZWNpZmljDQpkcml2ZXJzIGFzIG1vZHVsZSwgc28gdGhlIGJlc3Qgd2F5IGlzIHRv
IGFkZCBhIHZpcnR1YWwgZGV2aWNlIG5vZGUgaW4gRFQgaW4gb3JkZXIgdG8gc3VwcG9ydA0KYXV0
byBsb2FkPw0KDQpBbnNvbiANCg==
