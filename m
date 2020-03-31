Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5A6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96832071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RCsqIan5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgCaNeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:34:46 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:6502
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731085AbgCaNeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:34:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex9SXIDjfYjWVHHqUmEXe3SZbghmn7h4jpsd3WR1StSU6dDUXZXZ5Pak3YG1f5mDYt4ztrGZuRI44UATmA+YDEYi0yUVFcYHe1KP6DzgScIS3UGLgp0wjR4HSnQyVf6sXsm3NPPgCmNM6RsW2KSfZTvTYX2gtv1LptmKnGZ+tKCXdSbQswawRw3RzDLLkPCBYLmU7w9WsFJ/hqNEXJ6kMXKSRC4NuVS3lKDrKfiq8kFJ9YjZGPohChswwAvJjXQe48bYP4Bpc37pnKbYCXdjnHqzAHFxg4jiTiL1CrsH/TMrtujb2wZh8sjzMqyJYcjE0k0wI4gGzE57rv31Y/30ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD7B2H06Szm00r020+lb0A/YC73HjDQjw0pW0D8jGZU=;
 b=Wc7tMPgXU/oP14uwzYoF7RDH5e0Iu4jaHgV2D7MZnhDf4/u9VKpabRT10gvm2xeaZqAH05RF/cj9REIInBJGFHw0rECKKZDCKLZuhRpaeNVFT6NgpNdsuqF76PMshLBKvePCMCLHt99bfg90Mf6weNMSkeuBSWbnO1q9OL5ZrsJruwqfl/oU55SOpjBYVvgudQ+CqwJHlAkcM07YOHc/zdjUXmzanXhT+OXx9iobeYloeOXMOwq7ZxtzJ0xQK+wJtPwdh9yutiBK717eR05jxtGCHbeGGe6DAhJ0G3jhEQC0BCVujpKf0oOO1Xd76AvQEXOXMOlIpphJZ35kk324ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD7B2H06Szm00r020+lb0A/YC73HjDQjw0pW0D8jGZU=;
 b=RCsqIan5IAOSng57+ExHChtp2BQI2vzojmvnT27iA+exiHpyUw84rTZj9TrHy3Y05eRTsnNfhDYCfN5dK60Xc/Be+XLzKrJYqoFWIYuJ7Qib/LUmWGEwQR5QUDINNFlDU5Y5kDH0u6kpYfEgS5CKsWlGJy0ozjSDjKXdkBkCfVE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 13:34:42 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 13:34:42 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Topic: [PATCH V7 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Index: AQHV/cQDu85ufqDAx06lOMhNtamjbahaF9Qw
Date:   Tue, 31 Mar 2020 13:34:41 +0000
Message-ID: <AM0PR04MB44812577EF272CA1D457A1F788C80@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [180.107.26.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39770401-7a45-4acb-bcc3-08d7d57844a1
x-ms-traffictypediagnostic: AM0PR04MB4481:|AM0PR04MB4481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB44814CFA2266BCB32121EC3C88C80@AM0PR04MB4481.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(33656002)(9686003)(86362001)(55016002)(66446008)(66556008)(7696005)(76116006)(4326008)(66946007)(316002)(66476007)(64756008)(6506007)(966005)(478600001)(52536014)(8676002)(54906003)(5660300002)(186003)(44832011)(6636002)(81156014)(81166006)(8936002)(26005)(15650500001)(110136005)(71200400001)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8AgW0++3BMcOmkRUeGp6G51KiZwn3sMtJZpNeTZAINRuKI+9HNO+tTU9xVupf6LrblJZIAmIKNthycgDWPjBo1x1tmvBhxFXA/26z5bSjkbzaEDoU0a/qBJijp5KcNKOsCmZKMfu5ADpmMoCQk61/SPIhkjyDmSeyDTJZa1LcoVpKfzUsCmi25zu4dNTYqnBWLUjRQCXM9xTNvi6v+oBeI+ya8TS5+42nBCLNnoNjipfcZfPzDsp9A2SMr3C/6Hpb7epVv0bifug/FBB1Vx3sne1xSvueFrfFSPMUJ9nPmlAGG8eDXqn8nHds5BcGaqRjN8x52iFBOhaWKUSSB+cPiBiCycRPloAT0Kakut7X41kly2ocILSBPWk5UYl+GT/g8hV9R1zKrQ2rspcmgP8zuhE75lCpam96tp1ZKE4Z5C86+bVhHGLaul/TMI7FyuQkjhZWM9jB3tnMTWj2DCPHEGSBpGOAXaLYNlDdBdBcZTPEOeaG6O5EY4z1jhQxUlfQOwnVZPVZ+wLpkCV1pKiA==
x-ms-exchange-antispam-messagedata: PN4i72DwulORkmzulB8AUVdQhoN4L2p4pE2doxuiFDlpPI7sKPN+b+J5LhQ6BUgsdhdu1XcnKzNjrqca+itLR/1jP6ULL3+z2HbeVtchLE3kd+HoiaEsINZ06lBQVuiISDnaSEys7BI48BlpqV20xw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39770401-7a45-4acb-bcc3-08d7d57844a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 13:34:41.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5O/h3SlPHCTvRVJmch8M5WJ828dm9mRLsCnfe34UMaUfZ9MmwFyj7RrxNvqJ7oCndGzL7msBZK6upQc0lCdrjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCj4gU3ViamVjdDogW1BBVENIIFY3IDAvNF0gbWFpbGJveC9maXJtd2FyZTog
aW14OiBzdXBwb3J0IFNDVSBjaGFubmVsIHR5cGUNCg0KQXJlIHlvdSBvayB3aXRoIHRoZSBtYWls
Ym94IHBhcnQ/DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IEZyb206IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPg0KPiANCj4gVjc6DQo+ICBQZXIgTGVvbmFyZCdzIGNvbW1lbnRzLCBhZGRl
ZCBjaGVjayBmb3IgVEUvUkUgIFBhc3NlZCB0ZXN0IGZyb20NCj4gTGVvbmFyZCdzIGh0dHBzOi8v
Z2l0aHViLmNvbS9jZGxlb25hcmQvaW14LXNjdS10ZXN0DQo+IA0KPiBWNjoNCj4gIEFkZCBPbGVr
c2lqJ3MgUi1iIHRhZw0KPiAgUGF0Y2ggMy80LCBwZXINCj4gaHR0cHM6Ly93d3cua2VybmVsLm9y
Zy9kb2MvRG9jdW1lbnRhdGlvbi9wcmludGstZm9ybWF0cy50eHQNCj4gIHNob3VsZCB1c2UgJXp1
IGZvciBwcmludGsgc2l6ZW9mDQo+IA0KPiBWNToNCj4gIE1vdmUgaW14X211X2RjZmcgYmVsb3cg
aW14X211X3ByaXYNCj4gIEFkZCBpbml0IGhvb2tzIHRvIGlteF9tdV9kY2ZnDQo+ICBkcm9wIF9f
cGFja2VkIF9fYWxpZ25lZA0KPiAgQWRkIG1vcmUgZGVidWcgbXNnDQo+ICBjb2RlIHN0eWxlIGNs
ZWFudXANCj4gDQo+IFY0Og0KPiAgRHJvcCBJTVhfTVVfVFlQRV9bR0VORVJJQywgU0NVXQ0KPiAg
UGFjayBNVSBjaGFucyBpbml0IHRvIHNlcGFyYXRlIGZ1bmN0aW9uICBBZGQgc2VwYXJhdGUgZnVu
Y3Rpb24gZm9yIFNDVQ0KPiBjaGFucyBpbml0IGFuZCB4bGF0ZSAgQWRkIHNhbnRpdHkgY2hlY2sg
dG8gbXNnIGhkci5zaXplICBMaW1pdCBTQ1UgTVUgY2hhbnMNCj4gdG8gNiwgVFgwL1JYMC9SWERC
WzAtM10NCj4gDQo+IFYzOg0KPiAgUmViYXNlIHRvIFNoYXduJ3MgZm9yLW5leHQNCj4gIEluY2x1
ZGUgZnNsLGlteDgtbXUtc2N1IGNvbXBhdGlibGUNCj4gIFBlciBPbGVrc2lqJ3MgY29tbWVudHMs
IGludHJvZHVjZSBnZW5lcmljIHR4L3J4IGFuZCBhZGRlZCBzY3UgbXUgdHlwZQ0KPiBDaGVjayBm
c2wsaW14OC1tdS1zY3UgaW4gZmlybXdhcmUgZHJpdmVyIGZvciBmYXN0X2lwYw0KPiANCj4gVjI6
DQo+ICBEcm9wIHBhdGNoIDEvMyB3aGljaCBhZGRlZCBmc2wsc2N1IHByb3BlcnR5ICBGb3JjZSB0
byB1c2Ugc2N1IGNoYW5uZWwgdHlwZQ0KPiB3aGVuIG1hY2hpbmUgaGFzIG5vZGUgY29tcGF0aWJs
ZSAiZnNsLGlteC1zY3UiDQo+ICBGb3JjZSBpbXgtc2N1IHRvIHVzZSBmYXN0X2lwYw0KPiANCj4g
IEkgbm90IGZvdW5kIGEgZ2VuZXJpYyBtZXRob2QgdG8gbWFrZSBTQ0ZXIG1lc3NhZ2UgZ2VuZXJp
YyBlbm91Z2gsIFNDRlcNCj4gbWVzc2FnZSBpcyBub3QgZml4ZWQgbGVuZ3RoIGluY2x1ZGluZyBU
WCBhbmQgUlguIEFuZCBpdCB1c2UgVFIwL1JSMA0KPiBpbnRlcnJ1cHQuDQo+IA0KPiBWMToNCj4g
U29ycnkgdG8gYmluZCB0aGUgbWFpbGJveC9maXJtd2FyZSBwYXRjaCB0b2dldGhlci4gVGhpcyBp
cyBtYWtlIGl0IHRvDQo+IHVuZGVyc3RhbmQgd2hhdCBjaGFuZ2VkIHRvIHN1cHBvcnQgdXNpbmcg
MSBUWCBhbmQgMSBSWCBjaGFubmVsIGZvciBTQ0ZXDQo+IG1lc3NhZ2UuDQo+IA0KPiBQZXIgaS5N
WDhRWFAgUmVmZXJlbmNlIG1hbm51YWwsIHRoZXJlIGFyZSBzZXZlcmFsIG1lc3NhZ2UgdXNpbmcg
ZXhhbXBsZXMuDQo+IE9uZSBvZiB0aGVtIGlzOg0KPiBQYXNzaW5nIHNob3J0IG1lc3NhZ2VzOiBU
cmFuc21pdCByZWdpc3RlcihzKSBjYW4gYmUgdXNlZCB0byBwYXNzIHNob3J0DQo+IG1lc3NhZ2Vz
IGZyb20gb25lIHRvIGZvdXIgd29yZHMgaW4gbGVuZ3RoLiBGb3IgZXhhbXBsZSwgd2hlbiBhIGZv
dXItd29yZA0KPiBtZXNzYWdlIGlzIGRlc2lyZWQsIG9ubHkgb25lIG9mIHRoZSByZWdpc3RlcnMg
bmVlZHMgdG8gaGF2ZSBpdHMgY29ycmVzcG9uZGluZw0KPiBpbnRlcnJ1cHQgZW5hYmxlIGJpdCBz
ZXQgYXQgdGhlIHJlY2VpdmVyIHNpZGUuDQo+IA0KPiBUaGlzIHBhdGNoc2V0IGlzIHRvIHVzaW5n
IHRoaXMgZm9yIFNDRlcgbWVzc2FnZSB0byByZXBsYWNlIGZvdXIgVFggYW5kIGZvdXIgUlgNCj4g
bWV0aG9kLg0KPiANCj4gUGVuZyBGYW4gKDQpOg0KPiAgIGR0LWJpbmRpbmdzOiBtYWlsYm94OiBp
bXgtbXU6IGFkZCBTQ1UgTVUgc3VwcG9ydA0KPiAgIG1haWxib3g6IGlteDogcmVzdHJ1Y3R1cmUg
Y29kZSB0byBtYWtlIGVhc3kgZm9yIG5ldyBNVQ0KPiAgIG1haWxib3g6IGlteDogYWRkIFNDVSBN
VSBzdXBwb3J0DQo+ICAgZmlybXdhcmU6IGlteC1zY3U6IFN1cHBvcnQgb25lIFRYIGFuZCBvbmUg
UlgNCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2ZzbCxtdS50eHQgICAg
ICAgICB8ICAgMiArDQo+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMgICAgICAgICAg
ICAgICAgICAgICB8ICA1NCArKystDQo+ICBkcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyAg
ICAgICAgICAgICAgICAgICAgICB8IDI4OA0KPiArKysrKysrKysrKysrKysrKy0tLS0NCj4gIDMg
ZmlsZXMgY2hhbmdlZCwgMjgxIGluc2VydGlvbnMoKyksIDYzIGRlbGV0aW9ucygtKQ0KPiANCj4g
DQo+IGJhc2UtY29tbWl0OiBlNTA2ZGJhNjlhNWU5YWFmZjIwZmQ3M2ExMDg2MzlmODRlMmMzOWQ5
DQo+IC0tDQo+IDIuMTYuNA0KDQo=
