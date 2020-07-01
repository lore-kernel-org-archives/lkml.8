Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B12078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hEQmtY6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgGAJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:28:53 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:60177
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729371AbgGAJ2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/ER7j6eEqcdvY3vH2b0lbmoKQRCvuJO/0/KCx9geUt1mtGMRtA8/sUJoRMqvet7YhFKGJykYmniNcniSaEpEVrTjYf9H0+dP7XAym7+LS2P+z7BjwKoxqnG8xUSe7LoZj8Kw6Aam0mkWBwrwyzVpvVOlKkrgkIsOw1D3B9MOayzBX7vkWxHhZlNS0299dkMZw05QjT92e6jDSfGZ6evDJUabJNWC+aGQb8fnxHqe1+aZBa8sOt9NSeAtQh3+Sig732dEQM+JAxBe09FBX3RYiRn/31dE+9PWFjcf6DM9xdLnfPhzj3CnO+/0KUBph6erW0fQF0KP6bJ0MgXKp9ClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/GfhkDAvTTOCQOJO3iB0SE6G4y6EfkJydytxR+lj3k=;
 b=g7Gb9iYi1/eKtq5gTlcfjUW/xpJW6SzkA3HMD1AyfFNs1mFoI7ohUTvs0F5SLhv++feyTPYE5EkHmxACVUrmhsRePC+e0G7H/XWMLwzt/kN/8ufXFRQWhhUswRRY7yZIqC9+iTKlZuxOxPqzr/ZPGO4qMTVHCULWL392Ug9WvkxldFxx4HbsR7+2Lvt+2lhyDRr3iV9fYkvyNGDLa3fLXx4UoEnnzhhcCrbPBdv6QcZHhxc5EOTxThlz1kr2Tm0cll1xGTygTGU6OBPG2sUun+GmHwMTyqPSXVjM7gBIVYRMp05pPcTQaJPkEqi2NXRhfo2rgMSqD/2uPW/U8ZyCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/GfhkDAvTTOCQOJO3iB0SE6G4y6EfkJydytxR+lj3k=;
 b=hEQmtY6cQtueaUP1tF9VkgaeVRngyPbox4D4DoKg1q4sLabV89PimHQtdElRkIImw3h+/Y1HhDC1gNiAXXj77obPuoTHsemLwpeobHYbTO+YXbqn4yuVTXn4XsYOFEhHb1QaTN350o6F4vgmqRTpyQGyh/Ku8InLy98AWBXQW+s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR0401MB2534.eurprd04.prod.outlook.com (2603:10a6:4:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 09:28:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 09:28:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Dong Aisheng <dongas86@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWTdthV6wfzmMopU6pSRFnxqvg3qjvd4YAgAACQ6CAABqKgIAAAHBggAAdugCAAAKowIAA09MAgAHHMmCAABw9AIAAC3rg
Date:   Wed, 1 Jul 2020 09:28:48 +0000
Message-ID: <DB3PR0402MB3916B16516474F8D17EF9DA3F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
 <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
 <DB3PR0402MB39167F7746B4B3794600FC7FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=TYuSk=P4D_D0_Rv1O2AAB3UvYrNXToptPJjEsjECquUw@mail.gmail.com>
 <DB3PR0402MB3916E820EA1E9884DD0A08CFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1nxtFqytyTZjte-9UJQEZWp0eKF64v=E1LpgsG8R0h9w@mail.gmail.com>
In-Reply-To: <CAK8P3a1nxtFqytyTZjte-9UJQEZWp0eKF64v=E1LpgsG8R0h9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.9.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3450e9ae-6bb1-491e-279f-08d81da12923
x-ms-traffictypediagnostic: DB6PR0401MB2534:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB25349AACD63E72F2CD169D3BF56C0@DB6PR0401MB2534.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YXwvztyPu03pWRt7IVOEHeeJArWGGyMKIa0n6cbByNah8d0HeWwVnz810g6FNH6vELl0uwCSmdMbmsRQ3WLS7cMyGUpl0dzrqjzdWoDcQo4NuaASs/p/L9oBZ2bghYlQPr50xEKhgpPtvpUQPQfSpzy62mhBwhVH1IySUOGgu99g0MBLLMzNALCpjySzUVdOsKu7JnnWU/xXUpEuLyYN1qF63TdNxRy4IFVR+823SdOD1e8qOZI5T4W0LVz9BXLrBbGUweB3mnp4iuAH39LL1AYgQzzFGYMO8GHrl1qc7V4bv/ExYS4HIfTmq11469JWGK7WQQxUsCiHFIDhFxWEuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(83380400001)(186003)(316002)(66946007)(6916009)(7696005)(44832011)(33656002)(86362001)(55016002)(64756008)(66446008)(66556008)(66476007)(5660300002)(52536014)(2906002)(76116006)(54906003)(9686003)(4326008)(53546011)(26005)(71200400001)(8676002)(7416002)(478600001)(8936002)(6506007)(19627235002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wSoG52EgY1Yxo9l3LsJiz6r3M0VGT/UlyXRFEfDZeNELum5AvAlm0USDfA6k5ICnCAM/wuPgFLzdbYv+O98PVeviOVel2jE8/bQtZdSCuWwyDJtdM6zqvTYiDhQ590732MJLbBTrv2lscvoFYLE/KmZqjZzoCvAUTxJPqJBLW4g8y3JGGLDm0rB7fFFqTI5hSV2un6cDw5vYBHmwk3P+jkNM8oMN8pjSAOYRDMClAJl0cXu4QYXnYHij3HKOkRulU3hL40Lr5wzgXkTxtO24LdhYNxAt2Gq1uc4gpWImvg0hrIGbX5uILZfJyoqv6+NRdu2fnVqkFEtvUHERMKxE49gawxIsrB5Db1OsfyW1Hu3sEFyfwZ7h9o7h75/XhAO5QSzCKceUzPe3SxGJf3JoxRR4uDo2dAfl363cWtQEPkdJ47Kw5zbWlR1z1akBFXRazlh0FEXn4UY6RPRjGoJPT3kTJorTNj2oN2RycIFqBL8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3450e9ae-6bb1-491e-279f-08d81da12923
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 09:28:48.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSlqHRNM0+vDB+gtKeqMPiv2bnRHfuu9lCpWGG3KlT4ZOWqEEFFGERcAndbrQbFEP+oFfxX/gHjjAV1IFrvOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDA0LzEwXSBjbGs6IGlteDogU3Vw
cG9ydCBidWlsZGluZyBTQ1UgY2xvY2sgZHJpdmVyIGFzDQo+IG1vZHVsZQ0KPiANCj4gT24gV2Vk
LCBKdWwgMSwgMjAyMCBhdCA5OjE5IEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29t
Pg0KPiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDQvMTBdIGNsazogaW14
OiBTdXBwb3J0IGJ1aWxkaW5nIFNDVSBjbG9jaw0KPiA+ID4gZHJpdmVyIGFzIG1vZHVsZSBPbiBU
dWUsIEp1biAzMCwgMjAyMCBhdCA1OjE2IEFNIEFuc29uIEh1YW5nDQo+IDxhbnNvbi5odWFuZ0Bu
eHAuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBTQ1UgY2xvY2sgZHJpdmVyIGlzIGEgY29tbW9u
IGRyaXZlciBmb3IgYWxsIFNDVSBiYXNlZCBwbGF0Zm9ybXMuDQo+ID4gPiBDdXJyZW50IGkuTVg4
UVhQIFNDVSBjbG9jayBkcml2ZXIgd2lsbCBiZSBleHRlbmRlZCB0byBzdXBwb3J0IGFsbA0KPiA+
ID4gZnV0dXJlIFNDVSBiYXNlZCBwbGF0Zm9ybXMuDQo+ID4gPiBTbyB0aGVvcmV0aWNhbGx5IGNs
ay1zY3UubyBhbmQgY2xrLWlteDhxeHAubyBjYW4gYmUgY29tYmluZWQuIExQQ0cNCj4gPiA+IGlz
IHNpbWlsYXIuDQo+ID4gPiBNYXliZSB5b3UgY2FuIGdpdmUgYSB0cnkgYXMgQXJuZCBzdWdnZXN0
ZWQuDQo+ID4gPg0KPiA+DQo+ID4gRG8gd2UgcmVhbGx5IG5lZWQgdG8gbGluayBjbGstc2N1IGFu
ZCBpLk1YOFFYUCBjbG9jayBkcml2ZXIgdG9nZXRoZXIganVzdCB0bw0KPiBhdm9pZCBzb21lIGV4
cG9ydD8NCj4gDQo+IEl0IHdhcyBqdXN0IG1lYW50IHRvIGJlIGVhc2llciB0aGFuIGV4cG9ydGlu
ZyBhIHN5bWJvbCBhbmQgZGVhbGluZyB3aXRoDQo+IG1vZHVsZSBkZXBlbmRlbmNpZXMuIElmIGl0
J3Mgbm90IGVhc2llciwgdGhlbiBkb24ndC4NCj4gDQo+ID4gSSBtZXQgc29tZSBidWlsZCBpc3N1
ZXMgaWYgdXNpbmcgdGhpcyBtZXRob2QsIHRoZSBpLk1YOFFYUCBtb2R1bGUNCj4gPiBidWlsZCBp
cyBPSywgYnV0IG90aGVyIHBsYXRmb3JtcyBsaWtlDQo+IGkuTVg4TU0vaS5NWDhNTi9pLk1YOE1R
L2kuTVg4TVANCj4gPiBjbG9jayBkcml2ZXJzIGFyZSBqdXN0IHNraXBwZWQgZm9yIGJ1aWxkLCBl
dmVuIHRoZXNlIGkuTVg4TSBjbG9jaw0KPiA+IGNvbmZpZyBhcmUgZXhpc3RpbmcgaW4gLmNvbmZp
ZywgYW55b25lIGtub3cgd2h5PyBMb29rcyBsaWtlIHRoZSBjaGFuZ2UgaW4NCj4gTWFrZWZpbGUg
Zm9yIGkuTVg4UVhQIGNsb2NrIGRyaXZlciBpbnRyb2R1Y2UgdGhpcyBpc3N1ZS4NCj4gDQo+IFlv
dSBoYXZlIGEgIjo9IiBpbnN0ZWFkIG9mICIrPSIgdHlwbywgc28gYWxsIGVhcmxpZXIgIis9IiBh
cmUgaWdub3JlZDoNCj4gDQo+ID4gb2JqLSQoQ09ORklHX0NMS19JTVg4TU0pICs9IGNsay1pbXg4
bW0ubw0KPiA+IG9iai0kKENPTkZJR19DTEtfSU1YOE1OKSArPSBjbGstaW14OG1uLm8NCj4gPiBv
YmotJChDT05GSUdfQ0xLX0lNWDhNUCkgKz0gY2xrLWlteDhtcC5vDQo+ID4gb2JqLSQoQ09ORklH
X0NMS19JTVg4TVEpICs9IGNsay1pbXg4bXEubw0KPiA+DQo+ID4gb2JqLSQoQ09ORklHX01YQ19D
TEtfU0NVKSA6PSBjbGstaW14LXNjdS5vIGNsay1pbXgtbHBjZy1zY3Uubw0KPiANCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXg0KDQpUaGFua3MsIEkgd2lsbCBn
aXZlIGFub3RoZXIgdHJ5LCBJIHdpbGwgbWFrZSB0aGUgY29tbW9uIGNsayBwYXJ0IGFsbCBsaW5r
ZWQgaW50byBlYWNoDQpwbGF0Zm9ybSdzIGNsb2NrIGRyaXZlciwgdGhlbiBtYW55IGV4cG9ydHMg
Y2FuIGJlIHNhdmVkLg0KDQpUaGFua3MsDQpBbnNvbg0K
