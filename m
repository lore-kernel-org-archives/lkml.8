Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1647FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D46207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fkBTyNqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgERJKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:10:06 -0400
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:56256
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERJKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:10:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCUKSJJyMSJwSC7SQ/2y1DmD0OgVG6LYqPdLptSqsc7mx7u/lWI0enYw7Hyarc0VXoNPB/xE1jCyOT0sRgLmvKJKHjwq51dqIC2PPMv6WvpQlsjUvkw+UDJ/njREF322V+qeI3ca7f2l61vXZbMnAsQbvZ7lJ/O0xrP/JpoEyqdHSa6/6mwxwqNNZdB0+ceVzwwccE20S46QOD/g9/fnzh9OD7UDVdXBXGQ+yjS55+u5RCLiafUhNg5C9wI0LIfb4PhGG4R416kY3Ue7CY2gqheXPZvHu+7lFIO4BUUP5T39hYlx39KmoKdmuPQKsuEvmDA5kcO2ZOOW2U3OuuWMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYB8DQ7QC5cbGm2FYyAzGANOlN+u3vCOvc1jRRT0zQ0=;
 b=X16pnhwaKLL02Oh0G9wWjNKI+qE/e4koKsHe1ENE55vud9VU74x7fHg0DAIYLYISeDd7HOu9DWHAG+TIzFSxy+dwpExjTVmGTmWOsLLbL4VcL/kXnnFvR2ovLpovIc2QXbz4R9B5WJQPxw97CwVR8qj7Up90QIvmIb+Afpb1Ge/I+JKC3gbixT7lTfOu+NXWsJii7hR35XF6mdu5aMZTMWOYksPco2/hcO14rJ27NLux10Xzvo8ftyXXjOYDKttJSwStSRUae/HNR9gXcQYK2H+RF15fxk2o2p9ior7QCZ+QA7VeSo4IhPSoRWtlUUJnyn0yWXC7RYsiwKqLAtNkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYB8DQ7QC5cbGm2FYyAzGANOlN+u3vCOvc1jRRT0zQ0=;
 b=fkBTyNqBNw6rLtGHTbWa8QVWzMV3YjakSQqMHGFbdMJ2YZgLwWi6G9FGf2uFL2MGargM/Wv6elDRSRiy3nkYkhr/iNhAV/GJmTPjAISlcHtkZKIMuqOlUqMAbcuNwV6kS36TJXMQ5JcZQOraVKIo0T34b1UmW+YANAVjUCcHoD0=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5509.eurprd04.prod.outlook.com (2603:10a6:20b:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 09:10:02 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 09:10:02 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] ARM: dts: imx53: Add src node interrupt
Thread-Topic: [PATCH 2/2] ARM: dts: imx53: Add src node interrupt
Thread-Index: AQHWKAXgWvv/JF5RR0KX3jCYNcNCO6itmA/w
Date:   Mon, 18 May 2020 09:10:02 +0000
Message-ID: <AM6PR04MB496630FBC2A1721A5F8FF77980B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589250307-29662-1-git-send-email-Anson.Huang@nxp.com>
 <1589250307-29662-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589250307-29662-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57fafa28-4110-4761-aee5-08d7fb0b3f84
x-ms-traffictypediagnostic: AM6PR04MB5509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5509DEDDADF8EB61F80C33E580B80@AM6PR04MB5509.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMA47S4nV+QcKcW8Zzy5irzqx5AdeY3qIEHLl3qSW2U9PweRhpyWyBNI/KZhTJzr/s9nB2EfCVrpxEIf95ks/0yTpfpDWlRb4zvrhLjR7b4/Dou7ivXQpFUXVCKOTpclBHyiiMMLSsUkoOBr4uP8aL2VCODrxfrFaE2ahKdw4eR3dRB8KZrXix8pPX8ObhMp3BG1uBccCqYuS/9SPL6yIS6EcepCuQ0CSkDk2Z+V2+vbAnLTN49vdVFvWIkiboGAra/ltD4nvVYCjlU3eeGU7Fl6MMXHXtSBvjeDIkHVPFY4ukDxlZ8aCYsLWLT13f0x9mzo0oabjESRM85W2g3OmFxpJPUf1f0/79z+Y0WZ/AR5ZyfzilifOUDxL5p8GWf8XCEIX4IHANPkFTS+eJFoO/LpkZtIAsThh8S9BBYDo8ZuNz20UFmWf56K26rL0225
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(5660300002)(55016002)(8936002)(8676002)(26005)(186003)(71200400001)(6506007)(9686003)(4326008)(478600001)(7696005)(316002)(110136005)(86362001)(4744005)(44832011)(66476007)(33656002)(64756008)(2906002)(76116006)(66446008)(52536014)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PgfTmWmbpM0I0cqL2Yg4B3xaGXdFNF5r72k/y8gGmyM3BlBfNxm77B5VzR/1W/3JxzcYP2nxRZwG0YjLk8tBgf6ehr/LsHg6R4hTqoRc0j0MX6RRdsLEuukBn25yU1YRn2eAz0Ylm+qcCNZhaQghFGl3mfQl3Tc1lSTJTHRkpylBk5QLL0SRJlvVHNZlFbN/zKUmDfXAXIn0hsNb3xrZNS0kZQ3JdA5PEXUQSKNrjch/kL1sfwsjlMhaEXR09hGnckVnhziZMtW/J8pxItokSNbm8hYOssUzAgmavqCsenVOcqSFE3rMlFiEASRxJROnNdU3m0Ij/Hz1IP6LdWL2bgXyn1lid/cZSAJrWFGQuV6diwvNc6+/lAMjVpWRmagHxsAz4ClDAxGccNka0VgJ5tBFVInoQcxKm/cOvcsSrlIOzzjazDEnE8eTM3pUWnzpL5ueOZtCVcH8v0Qd7EOsX+pzTbeJiRyEgXksH6Stlh1pxrsWig5HgSP3GSe3HhVX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fafa28-4110-4761-aee5-08d7fb0b3f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 09:10:02.3827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8El9Z+RsqjL2OkGrHL5tunKs7JufeZtoRbKgw6zuwBh4daX5VnRoD3kcLXx7hHUeMOczs15tHTSsyPIt4ZvpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgTWF5IDEyLCAyMDIwIDEwOjI1IEFNDQo+IA0KPiBJbnRlcnJ1cHQgaXMgYSByZXF1aXJlZCBw
cm9wZXJ0eSBhY2NvcmRpbmcgdG8gU1JDIGJpbmRpbmcsIGFkZCBpdCBmb3IgU1JDIG5vZGUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2Fy
ZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDUzLmR0c2kgfCAx
ICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDUzLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg1My5k
dHNpIGluZGV4DQo+IDg1MzZmNTkuLjBkMDZkYmQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDUzLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NTMuZHRzaQ0K
PiBAQCAtNTkxLDYgKzU5MSw3IEBADQo+ICAJCQlzcmM6IHNyY0A1M2ZkMDAwMCB7DQo+ICAJCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsaW14NTMtc3JjIiwgImZzbCxpbXg1MS1zcmMiOw0KPiAgCQkJCXJl
ZyA9IDwweDUzZmQwMDAwIDB4NDAwMD47DQo+ICsJCQkJaW50ZXJydXB0cyA9IDw3NT47DQo+ICAJ
CQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiAgCQkJfTsNCj4gDQo+IC0tDQo+IDIuNy40DQoNCg==
