Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE8A20724
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jTh57/2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGADSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:18:33 -0400
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]:64582
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgGADSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:18:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV5sPkIbQjD+BBP99liuwJxjv8sahd/VYTG5V+sbow4ZDQy2frwmI2fDGYCuYd/PKL7dsmYMQZm4ROi8Bn6Fa/ToDougIsGuyZ2SRslDZQLoPSpdV2EVVkhi6dYRQvmKzbBFO7XZPU28YVAY6Ye+E/075mBg9LJNf/hPkYfF9FFlYW5THB4cC02rqSV0VPN0FNrxAcRmkqlof/xNAfI5UvistZ1ofuDuc4SOv8LGHbi/8s1XdJcsYS6z/8VWj7mbpo2jbQudnhliH1Kyx4WU7IL45xKqoIuPl+hCkc0kfUqnpnuREZkjAkrfx7TtsQqn96jW1WCMtchQe1IM5ApClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHKKVWGNe0Y0gn7/vEGS4c1nLziNVDKy+J2lPXLi52E=;
 b=GlTJdGJes72aQNLoRlh8hMqu/dcV780Id24RAApXM+7pU7xDPBIKTuGTrEnZecrhvGmkXRDcxSN62I010/cvCkq0OQolY+RGvt5qYme0AxiMUATxCRnss6XeO+pYAmkA3C41RZ6Odb6B7q+F1Krd8HjqaVWn58QWXoz7wlvqDn7NrcLP/yJOVn0CtM0LRhovWbrF4soPldp7nrxfiEZBJcOwn+1lPHenuIGAxV4t9WFHiGcqG2Qqo2qCbI1gdWRDKrRrRIv8rLJU5Mm0kunmEo8fCkCnx4hu+G8kmvR1fFuRYG+CUk4g3MfQl6rmo3L5s01eaNg7WpGeIl7M6gWCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHKKVWGNe0Y0gn7/vEGS4c1nLziNVDKy+J2lPXLi52E=;
 b=jTh57/2zxMEvjDaYPRk5/bSEyA7cZ0GsrWyFtoCbR+mwfKN5QVh+Rs/ZRR+YVp1W4muUp8+YsdvBcgB6urPMm9MBauaBBLtz7vrT2hGwWAPuXMHrnA/0+nQKgkPs6lK1QkyrXePdHuax2tzR+xyIBd0TVIHvIySwB6qk3wWQ9C0=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM5PR0402MB2932.eurprd04.prod.outlook.com
 (2603:10a6:203:9c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 03:18:29 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 03:18:29 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Topic: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Index: AQHWThag/tmWe004ek+eXrutuxE1fajvmZEAgAAMoQCAAAM9gIABCdjwgACVb4CAAMUk8A==
Date:   Wed, 1 Jul 2020 03:18:28 +0000
Message-ID: <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200625140105.14999-1-TheSven73@gmail.com>
 <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
In-Reply-To: <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: baefae8d-d655-4fdc-182e-08d81d6d6d03
x-ms-traffictypediagnostic: AM5PR0402MB2932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR0402MB2932B6AFFD1C559A915ED6EDFF6C0@AM5PR0402MB2932.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMcvh8K5yBUjgNL7Nkmky//vOpghWWWTrkwBql9Xrgxb5sliAnUL45l1mu/NcssgbtSg7IeR9HOia6FwleA+nyKDxqwMhiwzAzg6818m+RHCBrGXMpEK97W5+Z5I0Th+GsWUeDv6wTIdIFHjBPbVIU3WvzLI5lhunnbZLERcQUcGum/B5uaQ7qxUV3WdnLNhUBVNnXRx+Darh9EgtKq77GGjWB5AYfb5usPaxoiQ2T2wefJ43zbhpY1UjBRgm258gykeYcf5z1gtAerzRNTo19xNL2HyNv/gXcAw3ExLPkqu3LwRB1lVlwp6GHFmb51Xf70H2gphWxA9S3hUJ4JypxSnM7PfCshBgP7qZckY6stw40KMtvTAklYEDA0vfOjL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(33656002)(4326008)(52536014)(83380400001)(478600001)(9686003)(2906002)(76116006)(66476007)(66556008)(66946007)(66446008)(64756008)(71200400001)(86362001)(7696005)(5660300002)(55016002)(186003)(26005)(8676002)(8936002)(53546011)(6506007)(316002)(110136005)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: z4S2SDXD/0AnVk40LLmwrLRT/+ZNOFTZsCRet1XKBez6HYIbA37vy5Ipx6ZuQ+GXeAqBKteUuPc0vmBuCvJ/rB8sepyFZ69diV2dEj/tUHF19ymulDCnHCv40SsiO9I8jqnh9JT+4mQn4CEhCjfSfhewPDcIFlZ1iPUBc7INqjDkxSTTCoA4HPkAFD67vNjRF6Hk6b53hL69k1PafYzpTujusLX0Hykjgoz2Jxt+2wH68gLEtle+UnBqz7ozwr2cDWqxlvpqmh+CuZl4GNNDCHXiNiTO/lNs0hohyBHiUAUdkZXXA6mV6jx/QYP8BUsFTPxqb69C2ejeinfto1mxIQW9mM95u9YV7ajPTIcs6b3rHsmnSfWAMDVsUxDPbagl8fZNfHUJO89zXb1G3qX2FHWjSX9WuKHIevybOHGLwwc91cf5OkBQJu71KE+9jxj/aiN++VYnqZ1j3Vzb/4peRii4rmVhApY0SgfB4EmejZTO4rppsE/Hrm+gZnVhJoeY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baefae8d-d655-4fdc-182e-08d81d6d6d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 03:18:28.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dci6AlrO0sud8SlzwYVxGZFIxQvTXz2CNvWnoPrAdSOiWy2qMcGwukrnsdNit1CHakSPjkHhifxPWKWKLYtMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3ZlbiBWYW4gQXNicm9lY2sgPHRoZXN2ZW43M0BnbWFpbC5jb20+IFNlbnQ6IFR1ZXNk
YXksIEp1bmUgMzAsIDIwMjAgMTE6MjQgUE0NCj4gQW5keSwgRmFiaW8sDQo+IA0KPiBPbiBUdWUs
IEp1biAzMCwgMjAyMCBhdCAyOjM2IEFNIEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBTdmVuLCBubyBtYXR0ZXIgUEhZIHN1cHBseSAxMjVNaHogY2xvY2sg
dG8gcGFkIG9yIG5vdCwgIEdQUjVbOV0gaXMgdG8NCj4gPiBzZWxlY3QgUkdNSUkgZ3R4IGNsb2Nr
IHNvdXJjZSBmcm9tOg0KPiA+IC0gMCBDbG9jayBmcm9tIHBhZA0KPiA+IC0gMSBDbG9jayBmcm9t
IFBMTA0KPiA+DQo+ID4gU2luY2UgaS5NWDZRUCBjYW4gaW50ZXJuYWxseSBzdXBwbHkgY2xvY2sg
dG8gTUFDLCB3ZSBjYW4gc2V0IEdQUjVbOV0gYml0IGJ5DQo+IGRlZmF1bHQuDQo+IA0KPiBUaGF0
J3MgdHJ1ZS4gQnV0IG9uIHRoZSBzYWJyZXNkIEkgbm90aWNlIHRoYXQgdGhlIFBIWSdzIHJlZl9j
bGsgb3V0cHV0IGlzIGZyb20NCj4gQ0xLXzI1TS4NCj4gVGhlIGRlZmF1bHQgcmVmX2NsayBmcmVx
IGZvciB0aGF0IFBIWSBpcyAyNSBNSHosIGFuZCBJIGRvbid0IHNlZSBhbnlvbmUgY2hhbmdlDQo+
IHRoZSBkZWZhdWx0IGluIHRoZSBkZXZpY2V0cmVlLiBJIGFsc28gc2VlIHRoYXQgYSAyNSBNSHog
Y3J5c3RhbCBpcyBmaXR0ZWQsIHdoaWNoDQo+IGFsc28gc3VnZ2VzdHMgMjUgTWh6IG91dHB1dC4N
Cj4gDQo+IE9uIHRoZSBpbXg2LCB0aGUgZGVmYXVsdCByZWZfY2xrIGZyZXF1ZW5jeSBmcm9tIEFO
QVRPUCBpcyA1ME1oei4gSSBkb24ndCBzZWUNCj4gYW55b25lIGNoYW5nZSB0aGF0IGRlZmF1bHQg
aW4gdGhlIGRldmljZXRyZWUgZWl0aGVyLg0KPiANCj4gU28gaXMgaXQgcG9zc2libGUgdGhhdCwg
d2hlbiB3ZSBzd2l0Y2ggR1BSNVs5XSBvbiwgdGhlIGV4dGVybmFsIDI1TUh6IGNsb2NrIGlzDQo+
IHJlcGxhY2VkIGJ5IHRoZSBpbnRlcm5hbCA1ME1IeiBjbG9jaz8gSWYgc28sIEknbSBub3Qgc3Vy
ZSBpdCdsbCB3b3JrLi4uPw0KDQpGYWJpbywgdGhlIHJlYXNvbiBpcyB0aGF0IHlvdSBkb24ndCB1
cGRhdGUgdWJvb3QgdGhhdCB3aHkgd2UgY2Fubm90IHJlcHJvZHVjZQ0KdGhlIGlzc3VlIG9uIGlt
eDZxcCBzYWJyZXNkLg0KDQpTdmVuLCB1Ym9vdCBib2FyZCBmaWxlIHNldCB0aGUgY2xvY2sgcmF0
ZS4NCmJvYXJkL2ZyZWVzY2FsZS9teDZzYWJyZXNkL214NnNhYnJlc2QuYzoNCiAgICAgICAgaWYg
KGlzX214NmRxcCgpKSB7DQogICAgICAgICAgICAgICAgaW50IHJldDsNCg0KICAgICAgICAgICAg
ICAgIC8qIHNlbGVjdCBFTkVUIE1BQzAgVFggY2xvY2sgZnJvbSBQTEwgKi8NCiAgICAgICAgICAg
ICAgICBpbXhfaW9tdXhfc2V0X2dwcl9yZWdpc3Rlcig1LCA5LCAxLCAxKTsNCiAgICAgICAgICAg
ICAgICByZXQgPSBlbmFibGVfZmVjX2FuYXRvcF9jbG9jaygwLCBFTkVUXzEyNU1IWik7DQogICAg
ICAgICAgICAgICAgaWYgKHJldCkNCiAgICAgICAgICAgICAgICAgICAgcHJpbnRmKCJFcnJvciBm
ZWMgYW5hdG9wIGNsb2NrIHNldHRpbmdzIVxuIik7DQogICAgICAgIH0NCg0KU3ZlbiwgdG8gYXZv
aWQgdG8gZGVwZW5kIG9uIHVib290IHNldHRpbmcsIGZvciB0aGUgcGF0Y2gsIGl0IGlzIGJldHRl
ciB0byBiaW5kDQpiZWxvdyBjaGFuZ2UgZm9yIGR0cyAoZXZlbiBpZiBub24gaW14NnFwLCBwdHAg
Y2xvY2sgY2FuIGJlIHNldCB0byAxMjVNaHopOg0KDQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9p
bXg2cWRsLXNhYnJlc2QuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1zYWJy
ZXNkLmR0c2kNCkBAIC0yMDIsNiArMjAyLDggQEANCiAmZmVjIHsNCiAgICAgICAgcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsNCiAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2VuZXQ+Ow0K
KyAgICAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfRU5FVF9SRUY+Ow0K
KyAgICAgICBhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwxMjUwMDAwMDA+Ow0KICAgICAgICBwaHkt
bW9kZSA9ICJyZ21paS1pZCI7IA0K
