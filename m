Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B411C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB75207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kCl3u2ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgETGDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:03:33 -0400
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:17559
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbgETGDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:03:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j67kiQRwBO/YUv2NhNpthQFfh35aIKPWO2mmq/uG6Ri+7t9tT8cIzBc9U/dV9qjMlQOMoXlr9Z1o9GeC/K3WepkBwHcdz4qY8o1oqUDZ3a4RFSwVUA9l5zoqTRlm7eAogoDuTLEBwTaZsp3lEg+k3gUSsvDQKpAvFp1crdXzj6ZwNMDVV1PkrTvMtTQ8mn6GA13cY8hwRwmiQdmCJQ/eBbhSVQ7uak5Wk1PKoDwjZggKrCHwmhd1M5RdKSOfcK5yWgeoGMs2MdXZBMv4BFOTAD+EJqHLlcZ+xWP/U5hakF9CNCDr/KPblym9vJ7XH9G9GqAygBEzWokfJdG/pHmVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adx0XvIznMVwwYuSxuVXQ+o22YNJ3Uag1UAbRGlH9ao=;
 b=aaM6k1WFluya8RPtI/PFAirUd+0phPA6CwoVZF3b4TsYof7WV20eERlC7u9YuJEqXSzM125Ie/Fx1S2z592NUL7YVAuU02XRdXQ8Eu6D5fXgIo+Bdy/Byok2FFf/SQSlXa6n/WAxkvvUYZcHXXOCWxdZ8kHU0wS2tGL1g7b10UrfqCnvZHpOD/npKoX+ccTea5B4a0N7wkZMJd/uw6mZYwuyD418iVRowjrlFI2M/OiuqGTIvKGunGDBgK6arJLCZjq0A4SJAulZp7siRELvRVSclaLNWrcUlZMPLwnqJf4oBlvLmljVkPvG4Nl6YIHwvoTe96/Erke2dpOm0se7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adx0XvIznMVwwYuSxuVXQ+o22YNJ3Uag1UAbRGlH9ao=;
 b=kCl3u2ZBo862ZpSk8WpepbJiIKMUba293jlhpcfGMvDx6UG/nTk7sV6zjU6b13ckGY2F4MLxs57NvKS0oxEl+Sru6e1P6thJfrdd42oAHM2f3YU/sM0biNxSRCH9PbnENB1iydXds9RhMBE7LRoJgmBZMioozCCxLe8dPVMMU7w=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 06:03:28 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 06:03:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawn.gsc@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "git@andred.net" <git@andred.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "info@metux.net" <info@metux.net>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: RE: [PATCH V2 0/3] ARM: imx: move cpu code to drivers/soc/imx
Thread-Topic: [PATCH V2 0/3] ARM: imx: move cpu code to drivers/soc/imx
Thread-Index: AQHWHgg+JPBPF27xHUaxW24Mbwr/7aiwRvoAgAArWgCAACoYcA==
Date:   Wed, 20 May 2020 06:03:27 +0000
Message-ID: <DB6PR0402MB2760791698EADD705F5B2E6F88B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1588151843-2133-1-git-send-email-peng.fan@nxp.com>
 <20200520005638.GA11739@dragon>
 <CAJBJ56J-q7BreW9L4B7QbCkmxPEkpY6YMrBbzG3HWk3FL+wJwg@mail.gmail.com>
In-Reply-To: <CAJBJ56J-q7BreW9L4B7QbCkmxPEkpY6YMrBbzG3HWk3FL+wJwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: effd6c56-543f-4f1c-b50b-08d7fc838388
x-ms-traffictypediagnostic: DB6PR0402MB2760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB27601EEE89568824E0F4DB6588B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KhmiAKhlp4tTlzJDYF167mKrmrCAzTEtKGOB2MjZ3yUYjsebW6qvfdhn2Zx3n/0/qDcSsNZIl+kYv6WW80GGps68BU8fvtaFjolCw7KF2DnjNPoPSIqHWuRKYyU2PaItkGgiGLraeSqy477cu8OKYPPAQ04ngTDN/NlNUYA6SKn6hCGw7RDziKOYbf2sGGGPl1KhdYoAUgVt1jadYB0lmhkbbI5siSQ4rxVziu/XaLqvN+27U7OIrEpIaGNkUt8/lti83U3lepZuk9uocGJf41WLrMp7tN3HdRGmKcZ2aBaEtamhofnN+YeZ8HDqnK+EyFAfvHpeLoGy5s7uBKIazQzSJ875bAizKtM83kYQqM/rT+cYwb0vcIdC/ho49E6epOFDqBjSX2VridMqprQsBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(52536014)(71200400001)(76116006)(66946007)(316002)(83080400001)(66446008)(4326008)(7416002)(54906003)(5660300002)(2906002)(6916009)(8936002)(9686003)(7696005)(966005)(55016002)(478600001)(45080400002)(66556008)(53546011)(6506007)(64756008)(66476007)(26005)(186003)(44832011)(33656002)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TEYJ7eUJfWmepcU61xJcnDvpTVMy1wdNkY1KExAK7j4PtWG1qR7+207Q4/ulK5o2v1gaDPs3mkqmBksX3N7CZUOl9bVXM/3K0CvG/4X31J6hGrcyYOFNflLd2+1hDmtMJl5GoA16enWkMOHlPrJb2FuZ3xwuYmFZqg5HhjZJwOwCnpSH/fX4xeJfIIuSAH5DYme3lSzWQBP6JPED2evb3GT6pr2kGwm0WbnAgbWsc9H/kqv9+/o7qmxge33gB23APuZ+YaloQgJ/vEe2bO5mqVsspOr1zydvFMShkkop6xg3CwtPGVWoxS42OmMEmRov8o7C2Vmxlqk0tNYNxu/R5F7qIXHQSeIg3yvPh4GL7jsj2XN8/LpOWxrIyVW66bGoKri3hxb1aGvW/1WAF/enYJdOokP3di7+lgk+RHrpIb/nW5mVkUs6egj8iafukB+8ENLgqeQzAg2jw7eUY33uxGDPMF+WYDD4VzsUL52eA+TbiXzZIAbyA8i2bFPlL6mI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effd6c56-543f-4f1c-b50b-08d7fc838388
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 06:03:27.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXIge/aGVhdUiYKXmcfDjupzYr96+qbVPGgkqcYWYIubbZt7UlI5te0dJhWameO3MlowqbJqQJ33paH785SflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAwLzNdIEFSTTogaW14OiBtb3Zl
IGNwdSBjb2RlIHRvIGRyaXZlcnMvc29jL2lteA0KPiANCj4gT24gV2VkLCBNYXkgMjAsIDIwMjAg
YXQgODo1NyBBTSBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+
DQo+ID4gT24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMDU6MTc6MjBQTSArMDgwMCwgcGVuZy5mYW5A
bnhwLmNvbSB3cm90ZToNCj4gPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+ID4NCj4gPiA+IFYyOg0KPiA+ID4gIEtlZXAgaS5NWDEvMi8zLzUgY3B1IHR5cGUgZm9yIGNv
bXBsZXRuZXNzICBDb3JyZWN0IHJldHVybiB2YWx1ZSBpbg0KPiA+ID4gcGF0Y2ggMS8zICB1c2Ug
Q09ORklHX0FSTSB0byBndWFyZCBjb21waWxlIHNvYy1pbXguYyBpbiBwYXRjaCAzLzMNCj4gPiA+
DQo+ID4gPiBWMToNCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhDQo+ID4gPg0KPiB0Y2h3b3JrLmtlcm5lbC5v
cmclMkZjb3ZlciUyRjExNDMzNjg5JTJGJmFtcDtkYXRhPTAyJTdDMDElN0NwZW4NCj4gZy5mYW4N
Cj4gPiA+ICU0MG54cC5jb20lN0MzZmU0OTU3MGE2ODI0NjMxNDc2OTA4ZDdmYzZlNWNkMyU3QzY4
NmVhMWQzYmMyDQo+IGI0YzZmYTkyYw0KPiA+ID4NCj4gZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2
MzcyNTU0MjMyNzQ3Mzg0MDEmYW1wO3NkYXRhPUVMdEV0M05iZw0KPiBrVWc4M3c0DQo+ID4gPiBV
YkNmdGtWTXUwdG9ZRFVYSnk0TWdMYzhxYlElM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+IFJGQyB2
ZXJzaW9uIDoNCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhDQo+ID4gPg0KPiB0Y2h3b3JrLmtlcm5lbC5vcmcl
MkZjb3ZlciUyRjExMzM2NDMzJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NwZW4NCj4gZy5mYW4NCj4g
PiA+ICU0MG54cC5jb20lN0MzZmU0OTU3MGE2ODI0NjMxNDc2OTA4ZDdmYzZlNWNkMyU3QzY4NmVh
MWQzYmMyDQo+IGI0YzZmYTkyYw0KPiA+ID4NCj4gZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzcy
NTU0MjMyNzQ3Mzg0MDEmYW1wO3NkYXRhPVJFJTJGcHJ3DQo+IENMYjdmUXBZDQo+ID4gPiBobXN6
bG5YeFRCS0pWZEVYc2pNQnJkMlpIbUtjOCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ID4NCj4gPiA+
IE5vdGhpbmcgY2hhbmdlZCBpbiB2MSwganVzdCByZW5hbWUgdG8gZm9ybWFsIHBhdGNoZXMNCj4g
PiA+DQo+ID4gPiBTaGF3biwNCj4gPiA+ICBUaGUgb3JpZ2luYWwgY29uY2VybiBoYXMgYmVlbiBl
bGltaW5hdGVkIGluIFJGQyBkaXNjdXNzaW9uLCAgc28NCj4gPiA+IHRoaXMgcGF0Y2hzZXQgaXMg
cmVhZHkgdG8gYmUgaW4gbmV4dC4NCj4gPiA+IFRoYW5rcy4NCj4gPiA+DQo+ID4gPiBGb2xsb3cg
aS5NWDgsIG1vdmUgdGhlIHNvYyBkZXZpY2UgcmVnaXN0ZXIgY29kZSB0byBkcml2ZXJzL3NvYy9p
bXgNCj4gPiA+IHRvIHNpbXBsaWZ5IGFyY2gvYXJtL21hY2gtaW14L2NwdS5jDQo+ID4gPg0KPiA+
ID4gSSBwbGFubmVkIHRvIHVzZSBzaW1pbGFyIGxvZ2ljIGFzIHNvYy1pbXg4bS5jIHRvIHJlc3Ry
dWN0dXJlDQo+ID4gPiBzb2MtaW14LmMgYW5kIG1lcmdlZCB0aGUgdHdvIGZpbGVzIGludG8gb25l
LiBCdXQgbm90IHN1cmUsIHNvIHN0aWxsDQo+ID4gPiBrZWVwIHRoZSBsb2dpYyBpbiBjcHUuYy4N
Cj4gPiA+DQo+ID4gPiBUaGVyZSBpcyBvbmUgY2hhbmdlIGlzIHRoZSBwbGF0Zm9ybSBkZXZpY2Vz
IGFyZSBub3QgdW5kZXINCj4gPiA+IC9zeXMvZGV2aWNlcy9zb2MwIGFmdGVyIHBhdGNoIDEvNC4g
QWN0dWFsbHkgQVJNNjQgcGxhdGZvcm0gZGV2aWNlcw0KPiA+ID4gYXJlIG5vdCB1bmRlciAvc3lz
L2RldmljZXMvc29jMCwgc3VjaCBhcyBpLk1YOC84TS4NCj4gPiA+IFNvIGl0IHNob3VsZCBub3Qg
aHVydCB0byBsZXQgdGhlIHBsYXRmb3JtIGRldmljZXMgdW5kZXIgcGxhdGZvcm0gZGlyLg0KPiA+
ID4NCj4gPiA+IFBlbmcgRmFuICgzKToNCj4gPiA+ICAgQVJNOiBpbXg6IHVzZSBkZXZpY2VfaW5p
dGNhbGwgZm9yIGlteF9zb2NfZGV2aWNlX2luaXQNCj4gPiA+ICAgQVJNOiBpbXg6IG1vdmUgY3B1
IGRlZmluaXRpb25zIGludG8gYSBoZWFkZXINCj4gPiA+ICAgc29jOiBpbXg6IG1vdmUgY3B1IGNv
ZGUgdG8gZHJpdmVycy9zb2MvaW14DQo+ID4NCj4gPiBBcHBsaWVkIGFsbCwgdGhhbmtzLg0KPiAN
Cj4gVW5mb3J0dW5hdGVseSwgSSBoYXZlIHRvIGRyb3AgdGhpcywgYXMgaXQgdHVybnMgb3V0IHRo
ZSBzZXJpZXMgbmVlZHMgYSByZWJhc2UNCj4gb250byBmb3ItbmV4dC4gIFRoZSBzZXJpZXMgY29u
ZmxpY3RzIHdpdGggJ0FSTTogdmY2MTA6IHJlcG9ydCBzb2MgaW5mbyB2aWEgc29jDQo+IGRldmlj
ZScgdGhlcmUuDQoNCkkganVzdCBwb3N0ZWQgb3V0IHYzIHdoaWNoIHJlYmFzZWQgb24gbGF0ZXN0
IG5leHQgdHJlZSBhbmQgcmVzb2x2ZWQgdGhlIGNvbmZsaWN0cy4NCg0KVGhhbmtzLA0KUGVuZy4N
Cg0KPiANCj4gU2hhd24NCg==
