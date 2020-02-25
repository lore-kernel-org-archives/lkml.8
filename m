Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB1C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6803724684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NF4tdZVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgBYFSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:18:13 -0500
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:6273
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgBYFSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:18:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYZ5VeDrDqkBupDhux1e3wQdn5mshN/kbAGdpJGA4TMFS1IUY61UG5xM2/Ov5Lli1I3UTQnZT2ZIUc3ZmnoCzJJ0u5CAuHImFb3r3jCyb7hjnN9TsvfuWyIMfDazrDauY+qBnu4Xbd+3uRtEf7Xk9Se5XStHwNGf5uv5Ly2ckC1bl6jBtV8sXxwiVfjQTweuS4GTf1LP5Ky+sluIDoPwI3Dk+NguL09CSmDd6jgUGrnFREBbKndQk/cONfc4FRbDT2tVoxHocv1jjwNiXqVyh0WPKz7QtG+wo7CTEbJADAJQ2MTRiAF3lzz/P8dRkngla1fGl7AQbKWhhy4qfFW/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlCcV/APADH6Qj15IIZDDC5IRhArJXuRl2BZqVACmwo=;
 b=H6kXApWtrLgIY2JkMhhqlEia7viZYBENxqzBx+cEL1ft5NlhW9YC1trFoede6XMAtJAjTQAIJmKO+o0tAzVjjbjeMQgG/hHtG07tvcvtBAQFwFR0M+UMd0G6fSKR7i4D9kOuID5zXFxxW4EJDgU5kBpjFU8KR56sGHPDyVwnzosZlK0oRxd5eIBoNuQqwj2Ov50EOTNhcJI/KVx1I9LVMyZO1jsb/KmYJ7feErFH/zFwCi+DyYg9VoJHVUxcEaswachzrNesnpdyZ+yuDsMO367CBLHdwElWPIXSM3N1lZ3goFY1kzJ9fh9Z0AI45tzAWANbtVvaHqTBQuVv9f0g+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlCcV/APADH6Qj15IIZDDC5IRhArJXuRl2BZqVACmwo=;
 b=NF4tdZVte2KKIHIDAncxjkFrR/WigzyGesmXZuhjwo8f80RrOj8anPYv+YVq13f2V4tNUKKqYrGbK8Ovxn/nLYRaecKMmR4TAbaakdrqVdvggiDUhv5c+SLnTNLf2NvcFCPDsJQvcg0CtxeurN1LDZkNeMbnULVVLLLmRhp00Fk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6817.eurprd04.prod.outlook.com (52.132.212.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 05:18:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 05:18:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jacky Bai <ping.bai@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH] ARM64: dts: imx8m: fix aips dts node
Thread-Topic: [PATCH] ARM64: dts: imx8m: fix aips dts node
Thread-Index: AQHV646vutoeRArZGkWqXGNmEtg+gagrTTWAgAAQcNA=
Date:   Tue, 25 Feb 2020 05:18:06 +0000
Message-ID: <AM0PR04MB448131061921C313B830802D88ED0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582602242-28577-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB69920BD928735E22A8B9928987ED0@VI1PR04MB6992.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB69920BD928735E22A8B9928987ED0@VI1PR04MB6992.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a81f70ed-170b-4869-6d98-08d7b9b2187f
x-ms-traffictypediagnostic: AM0PR04MB6817:|AM0PR04MB6817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68171292089CFCDA9DEC5E2C88ED0@AM0PR04MB6817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(8676002)(316002)(110136005)(71200400001)(478600001)(44832011)(54906003)(26005)(6506007)(2906002)(52536014)(81166006)(81156014)(53546011)(33656002)(7696005)(64756008)(8936002)(76116006)(66556008)(4326008)(55016002)(186003)(966005)(5660300002)(66446008)(9686003)(66476007)(66946007)(86362001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6817;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIGwSdDMq+q4PskAFOCLSryeZzqNv2BPOI5F5aiYu1IXr8C5HZ2a+8FgBBbWubQyt29zW+StJ8cf2UXCNraCv0LgoAj91qx6jSZ4hBzzOhVE2oiQ3DJJsSG386Uel9IzvP4/KigQY/Rhs417Ink8fRzXTAtlnVmUx/bX9NZAMUZutGw5tgJEw3yL3Q1wKI3RGFOdKleOEssXS/c9/tN5rsY/wP+rpGJRuUL8oda5qlv1UWwr1JNRcUbh7ICvbPxdeA1ZVXVCI2qY8qDs7P8nhrVGMV0s8/42RtmZmgh2RSEsEMdyDnRJ9+h90NDHRK3JnHyZEmmxZ0Wf4U3Rf8BPqkl9dIZnEhDnDnMz9K8eeIO7SuGaXdZfeaL9Bhs26Ri9MkNoAEDrZE0J6Zkat49qFbQycozmAk19ObNQW7nWd435kv+A0HcfvifUohSo+BdU8KJ7sn2+bmPZ3syAMFmIrKzeZuuyYKfWDizjKzZEfTMPkroqU/8aqM/eh2AYL2SOSvzbwi1tJbgyOp1TfLBftxrWq8keqOApyuwpw4Rxu850dXNx8EDxfXW8ESVdnfvL
x-ms-exchange-antispam-messagedata: LBB3+BGHMZeAQGgukq5hkEZPi+s7aqV77OrdoEnBjqUu/pSAEEGRM+VMeT3MHF4B4CdH6vvmAi/dOOFdr63e7zrD+c0bs5/pcw6D6dYSrfILSLGlFnOK0q+Y3pHH11E6+Io2uuIwYg3AvRrBf7hN2g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81f70ed-170b-4869-6d98-08d7b9b2187f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 05:18:06.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrja6O/YPY70CuXuzu2XqJbJC1bHAWi7qWDLjmnU6UaPsf6CsDy1IKoODs1io6YKSNpHrsVurLPvVTIq+Y0NwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIXSBBUk02NDogZHRzOiBpbXg4bTogZml4IGFpcHMgZHRzIG5v
ZGUNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNSwgMjAy
MCAxMTo0NCBBTQ0KPiA+IFRvOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4g
PiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4
LWlteA0KPiA+IDxsaW51eC1pbXhAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
Ow0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gPiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47
IExlb25hcmQgQ3Jlc3Rleg0KPiA+IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47IERhbmllbCBC
YWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47DQo+IFBlbmcNCj4gPiBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo+ID4gU3ViamVjdDogW1BBVENIXSBBUk02NDogZHRzOiBpbXg4bTogZml4IGFp
cHMgZHRzIG5vZGUNCj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+DQo+ID4gUGVyIGJpbmRpbmcgZG9jIGZzbCxhaXBzLWJ1cy55YW1sLCBjb21wYXRpYmxlIGFu
ZCByZWcgaXMgcmVxdWlyZWQuIEFuZA0KPiA+IGZvciByZWcsIHRoZSBBSVBTIGNvbmZpZ3VyYXRp
b24gc3BhY2Ugc2hvdWxkIGJlIHVzZWQsIG5vdCBhbGwgdGhlIEFJUFMgYnVzDQo+IHNwYWNlLg0K
PiA+DQo+IA0KPiBBbnkgcmVhc29uIHRoYXQgd2UgbmVlZCB0byBhZGQgdGhlIGFpcHMgYnVzIGNv
bXBhdGlibGUgJiByZWcgYmFjaz8gVGhlIGFpcHMNCj4gY29uZmlnIHNwYWNlIGNhbiBvbmx5IGJl
IHdyaXRlIGJ5IHNlY3VyZSB3b3JsZCwgbGludXggaGFzIG5vIHBlcm1pc3Npb24gdG8NCj4gY29u
ZmlnIHRoZSBhaXBzIHBvcnQuIEFuZCBpdCBzZWVtcyBubyBkcml2ZXIgdXNlICJmc2wsYWlwcyIg
YW55bW9yZS4NCg0KZHRzIGlzIG5vdCBvbmx5IHVzZWQgZm9yIExpbnV4LiBTZWUgd2hhdCBSb2Ig
Y29tbWVudGVkLA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC9DQUxf
SnNxTHNRbXYNCk0wUXNzcGo1bisxaXk1WDBUWGFVTG9uR3RqS1JrZE9vU1FWUW16d0BtYWlsLmdt
YWlsLmNvbS9ULyN1DQoNClJlZ2FyZHMsDQpQZW5nLg0KPiANCj4gQlINCj4gSmFja3kgQmFpDQo+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSB8IDEyICsr
KysrKysrLS0tLQ0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNp
IHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcC5kdHNpIHwgMTIgKysrKysrLS0tLS0tDQo+ID4gYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1xLmR0c2kgfCAxMiArKysrKysrKy0tLS0NCj4gPiAgNCBmaWxlcyBjaGFu
Z2VkLCAzMCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+IGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiBpbmRleCBiM2QwYjI5
ZDcwMDcuLmE0MzU2ZDIwNDdjZCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gQEAgLTIyNyw3ICsyMjcsOCBAQA0KPiA+ICAJCXJhbmdl
cyA9IDwweDAgMHgwIDB4MCAweDNlMDAwMDAwPjsNCj4gPg0KPiA+ICAJCWFpcHMxOiBidXNAMzAw
MDAwMDAgew0KPiA+IC0JCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+ICsJCQljb21w
YXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiA+ICsJCQlyZWcgPSA8MHgzMDFm
MDAwMCAweDEwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gIAkJCSNz
aXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXMgPSA8MHgzMDAwMDAwMCAweDMwMDAwMDAw
IDB4NDAwMDAwPjsgQEAgLTQ5Niw3DQo+ID4gKzQ5Nyw4IEBADQo+ID4gIAkJfTsNCj4gPg0KPiA+
ICAJCWFpcHMyOiBidXNAMzA0MDAwMDAgew0KPiA+IC0JCQljb21wYXRpYmxlID0gInNpbXBsZS1i
dXMiOw0KPiA+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiA+
ICsJCQlyZWcgPSA8MHgzMDVmMDAwMCAweDEwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ID4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXMgPSA8MHgz
MDQwMDAwMCAweDMwNDAwMDAwIDB4NDAwMDAwPjsgQEAgLTU1NSw3DQo+ID4gKzU1Nyw4IEBADQo+
ID4gIAkJfTsNCj4gPg0KPiA+ICAJCWFpcHMzOiBidXNAMzA4MDAwMDAgew0KPiA+IC0JCQljb21w
YXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwg
InNpbXBsZS1idXMiOw0KPiA+ICsJCQlyZWcgPSA8MHgzMDlmMDAwMCAweDEwMDAwPjsNCj4gPiAg
CQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+
ICAJCQlyYW5nZXMgPSA8MHgzMDgwMDAwMCAweDMwODAwMDAwIDB4NDAwMDAwPjsgQEAgLTgwMCw3
DQo+ID4gKzgwMyw4IEBADQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJCWFpcHM0OiBidXNAMzJjMDAw
MDAgew0KPiA+IC0JCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+ICsJCQljb21wYXRp
YmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiA+ICsJCQlyZWcgPSA8MHgzMmRmMDAw
MCAweDEwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gIAkJCSNzaXpl
LWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXMgPSA8MHgzMmMwMDAwMCAweDMyYzAwMDAwIDB4
NDAwMDAwPjsgZGlmZiAtLWdpdA0KPiA+IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1uLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5k
dHNpDQo+ID4gaW5kZXggZjI3NzU3MjQzNzdmLi40ODQ4Y2U4MmYwODMgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaQ0KPiA+IEBAIC0yMDMsOCAr
MjAzLDggQEANCj4gPiAgCQlyYW5nZXMgPSA8MHgwIDB4MCAweDAgMHgzZTAwMDAwMD47DQo+ID4N
Cj4gPiAgCQlhaXBzMTogYnVzQDMwMDAwMDAwIHsNCj4gPiAtCQkJY29tcGF0aWJsZSA9ICJzaW1w
bGUtYnVzIjsNCj4gPiAtCQkJcmVnID0gPDB4MzAwMDAwMDAgMHg0MDAwMDA+Ow0KPiA+ICsJCQlj
b21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiA+ICsJCQlyZWcgPSA8MHgz
MDFmMDAwMCAweDEwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gIAkJ
CSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXM7DQo+ID4gQEAgLTQwMSw4ICs0MDEs
OCBAQA0KPiA+ICAJCX07DQo+ID4NCj4gPiAgCQlhaXBzMjogYnVzQDMwNDAwMDAwIHsNCj4gPiAt
CQkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gPiAtCQkJcmVnID0gPDB4MzA0MDAwMDAg
MHg0MDAwMDA+Ow0KPiA+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMi
Ow0KPiA+ICsJCQlyZWcgPSA8MHgzMDVmMDAwMCAweDEwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQo+ID4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXM7
DQo+ID4gQEAgLTQ2MSw4ICs0NjEsOCBAQA0KPiA+ICAJCX07DQo+ID4NCj4gPiAgCQlhaXBzMzog
YnVzQDMwODAwMDAwIHsNCj4gPiAtCQkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gPiAt
CQkJcmVnID0gPDB4MzA4MDAwMDAgMHg0MDAwMDA+Ow0KPiA+ICsJCQljb21wYXRpYmxlID0gImZz
bCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiA+ICsJCQlyZWcgPSA8MHgzMDlmMDAwMCAweDEwMDAw
PjsNCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gIAkJCSNzaXplLWNlbGxzID0g
PDE+Ow0KPiA+ICAJCQlyYW5nZXM7DQo+ID4gQEAgLTcwNyw4ICs3MDcsOCBAQA0KPiA+ICAJCX07
DQo+ID4NCj4gPiAgCQlhaXBzNDogYnVzQDMyYzAwMDAwIHsNCj4gPiAtCQkJY29tcGF0aWJsZSA9
ICJzaW1wbGUtYnVzIjsNCj4gPiAtCQkJcmVnID0gPDB4MzJjMDAwMDAgMHg0MDAwMDA+Ow0KPiA+
ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiA+ICsJCQlyZWcg
PSA8MHgzMmRmMDAwMCAweDEwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ID4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXM7DQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IGluZGV4IDcxYjBjOGYy
MzY5My4uZWI2N2Y1NmNkZmUyIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1wLmR0c2kNCj4gPiBAQCAtMTQ0LDggKzE0NCw4IEBADQo+ID4gIAkJcmFuZ2Vz
ID0gPDB4MCAweDAgMHgwIDB4M2UwMDAwMDA+Ow0KPiA+DQo+ID4gIAkJYWlwczE6IGJ1c0AzMDAw
MDAwMCB7DQo+ID4gLQkJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ID4gLQkJCXJlZyA9
IDwweDMwMDAwMDAwIDB4NDAwMDAwPjsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsYWlwcyIs
ICJzaW1wbGUtYnVzIjsNCj4gPiArCQkJcmVnID0gPDB4MzAxZjAwMDAgMHgxMDAwMD47DQo+ID4g
IAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4g
PiAgCQkJcmFuZ2VzOw0KPiA+IEBAIC0zMDksOCArMzA5LDggQEANCj4gPiAgCQl9Ow0KPiA+DQo+
ID4gIAkJYWlwczI6IGJ1c0AzMDQwMDAwMCB7DQo+ID4gLQkJCWNvbXBhdGlibGUgPSAic2ltcGxl
LWJ1cyI7DQo+ID4gLQkJCXJlZyA9IDwweDMwNDAwMDAwIDB4NDAwMDAwPjsNCj4gPiArCQkJY29t
cGF0aWJsZSA9ICJmc2wsYWlwcyIsICJzaW1wbGUtYnVzIjsNCj4gPiArCQkJcmVnID0gPDB4MzA1
ZjAwMDAgMHg0MDAwMDA+Ow0KPiA+ICAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiAgCQkJ
I3NpemUtY2VsbHMgPSA8MT47DQo+ID4gIAkJCXJhbmdlczsNCj4gPiBAQCAtMzY5LDggKzM2OSw4
IEBADQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJCWFpcHMzOiBidXNAMzA4MDAwMDAgew0KPiA+IC0J
CQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+IC0JCQlyZWcgPSA8MHgzMDgwMDAwMCAw
eDQwMDAwMD47DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGFpcHMiLCAic2ltcGxlLWJ1cyI7
DQo+ID4gKwkJCXJlZyA9IDwweDMwOWYwMDAwIDB4NDAwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQo+ID4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXM7
DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5k
dHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiA+
IGluZGV4IDZhMWU4MzkyMmM3MS4uMDcwNzA0NjQwNjNkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCj4gPiBAQCAtMjkwLDcgKzI5MCw4IEBA
DQo+ID4gIAkJZG1hLXJhbmdlcyA9IDwweDQwMDAwMDAwIDB4MCAweDQwMDAwMDAwIDB4YzAwMDAw
MDA+Ow0KPiA+DQo+ID4gIAkJYnVzQDMwMDAwMDAwIHsgLyogQUlQUzEgKi8NCj4gPiAtCQkJY29t
cGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsYWlwcyIs
ICJzaW1wbGUtYnVzIjsNCj4gPiArCQkJcmVnID0gPDB4MzAxZjAwMDAgMHgxMDAwMD47DQo+ID4g
IAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4g
PiAgCQkJcmFuZ2VzID0gPDB4MzAwMDAwMDAgMHgzMDAwMDAwMCAweDQwMDAwMD47IEBAIC02OTIs
Nw0KPiA+ICs2OTMsOCBAQA0KPiA+ICAJCX07DQo+ID4NCj4gPiAgCQlidXNAMzA0MDAwMDAgeyAv
KiBBSVBTMiAqLw0KPiA+IC0JCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+ICsJCQlj
b21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiA+ICsJCQlyZWcgPSA8MHgz
MDVmMDAwMCAweDEwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gIAkJ
CSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXMgPSA8MHgzMDQwMDAwMCAweDMwNDAw
MDAwIDB4NDAwMDAwPjsgQEAgLTc1MSw3DQo+ID4gKzc1Myw4IEBADQo+ID4gIAkJfTsNCj4gPg0K
PiA+ICAJCWJ1c0AzMDgwMDAwMCB7IC8qIEFJUFMzICovDQo+ID4gLQkJCWNvbXBhdGlibGUgPSAi
c2ltcGxlLWJ1cyI7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGFpcHMiLCAic2ltcGxlLWJ1
cyI7DQo+ID4gKwkJCXJlZyA9IDwweDMwOWYwMDAwIDB4MTAwMDA+Ow0KPiA+ICAJCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gPiAgCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gIAkJCXJhbmdl
cyA9IDwweDMwODAwMDAwIDB4MzA4MDAwMDAgMHg0MDAwMDA+LCBAQCAtMTAyMyw3DQo+ID4gKzEw
MjYsOCBAQA0KPiA+ICAJCX07DQo+ID4NCj4gPiAgCQlidXNAMzJjMDAwMDAgeyAvKiBBSVBTNCAq
Lw0KPiA+IC0JCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+ICsJCQljb21wYXRpYmxl
ID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiA+ICsJCQlyZWcgPSA8MHgzMmRmMDAwMCAw
eDEwMDAwPjsNCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gIAkJCSNzaXplLWNl
bGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXMgPSA8MHgzMmMwMDAwMCAweDMyYzAwMDAwIDB4NDAw
MDAwPjsNCj4gPiAtLQ0KPiA+IDIuMTYuNA0KDQo=
