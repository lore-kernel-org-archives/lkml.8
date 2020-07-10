Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368F2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D492078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lidn1Wjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGJGzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:55:48 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:3298
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbgGJGzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIHBEGuFoJcVsPrfJB0Dmv1cvIomyrmEAw8evgbs8SXnEPswJkZcwo0saV5/BO0nOu+4rjBBCwKf1pkqG5otz2apoUKz9ngG6k5uzInNof9Ia8vIyA3Mm/6yhIwsq5OVGKFGFSBEWKReXm+HVXQRwn2tFCqX8EJqWe2P0kRab/iaMJMtK5Sz1eG5cBj7Qb1HhDMJHBgCTE1SmjbK5ETRu6tzvBNv1hKIjdx3oz7rQVszJFsRhjTV0ckafaPxn66spmCNqDKM5b4mepIhabFD/Xaa9O1MFpGCDz9zWjBij++ou6vnm2IwfwGghJF0CNASM7iu7v9EY4tlWzc1mdXVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXn42dNeCvfWn3cuDo+4oecQQn2ide7ub3wrUtVvSbQ=;
 b=h3iyc+w9kLhfSzyakJ/DxHj3hnp72IUIlmVqHRqoSeRisHlR1ngVmIEuSRAWPa9HFzs6TDT/HweGcgiCQ1sLlEbCTTHI3xuBVeDGqeE0/J//D86qxQ+gHnDiIdpuddnFOxCwQG7zV6+Y4zD59pQUxmDpZ8PQRDfHpqIU06m0k5tAgJSp0yV+Utie3QEt2XH93YXn+Hf2Qcbfs2JsIYVVzYBw26AUEHj84rvPmq2dJ/m/PMbncKchkMHjlOdSV3nSAI5tug50h5SF02sjIlzkIKq6XE8UmxpYC4+YhQlDAdBJFrNrvV5mygSKcCJX+j32N/EnP8cesEgl6ToqM7WXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXn42dNeCvfWn3cuDo+4oecQQn2ide7ub3wrUtVvSbQ=;
 b=Lidn1WjtJXAxWPn0NU67hkBCsZlpHKbQF3QEEapg70fjfHe2QAXoTLh3P7Lc18EwFan+qLlr6rPMY8dyjW2knieOQ/UFJ2txMJxuknD3sYnysG8hqkWr+Bazz5InsKZIE0yog41TPv50ue+1n7lZBGHrT8MeH7sXnkIMa1jk3Ks=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB5854.eurprd04.prod.outlook.com (2603:10a6:803:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 06:55:42 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f%6]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 06:55:42 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] ARM: dts: imx6qp-sabreauto: enable sata on
 imx6qp sabreauto board
Thread-Topic: [EXT] Re: [PATCH] ARM: dts: imx6qp-sabreauto: enable sata on
 imx6qp sabreauto board
Thread-Index: AQHWURMMz3F4XokSwEOi4wQ2Mi7KTKj9+9+AgAJv2RA=
Date:   Fri, 10 Jul 2020 06:55:42 +0000
Message-ID: <VI1PR04MB58538CE745DAFCE6BA3434228C650@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1593764337-8267-1-git-send-email-hongxing.zhu@nxp.com>
 <CAOMZO5AHkBCnd54OZd688gbBnHs1stNAPOfKzpX0KEUUcVRxYg@mail.gmail.com>
In-Reply-To: <CAOMZO5AHkBCnd54OZd688gbBnHs1stNAPOfKzpX0KEUUcVRxYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 293cac49-9728-4ac3-7b90-08d8249e434b
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5854D7D5A0F0C4BB6ACFBA698C650@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ca5s8huupLynHSkPVeC5IC+H2xdqWegPzFV6U5ljvc2AS89WXj0/nJfEHzwqu0j6tTOYA/WtlH9JW8rQzd8ecZWFraC77C1LB0x6vdzhGZO/qe6vpX352EZedHsbixHlm4IJ8Iw0c8HNG2vrxjEAsC3I0T42b0ZU9FEOcEgkO6om2ZbibB91vhi4GT3zdJewzxn5k/Pw3lQLGVJ3nOm0Ji02uyW89rX3s44sfzPrt3vf6F0jPCRB+f4k/uMuiMvHvAwWtRRUDIjfBNgD6p6YZUr8A9zZDDGuZMro7GhrRe9tyd6Q3QDEUVehFJpI7xunfbV88mnZP0B65zsOeh3s3UUScfB2rIN46umNfxqeZsszfkvp4nfuFVGDk68sNSWR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(83380400001)(55016002)(8936002)(9686003)(186003)(64756008)(86362001)(76116006)(8676002)(478600001)(66476007)(66556008)(7696005)(4326008)(66446008)(71200400001)(53546011)(66946007)(316002)(6506007)(26005)(4744005)(54906003)(52536014)(33656002)(5660300002)(6916009)(2906002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VSSXhB5B73DZ0AQHo98qZ9qZsYwuQq0nuo7Y+Ie9slQRVmpagDIKq6NdNlN4reNX4qKnGn17lbtPc8SUgQBeZqWCOCBrSVSpYvk/ZCjaEC0eSnYLiV32fwMqXoZZlOQTG2vgl2+W/6GrmPWN/jOOefMHJhnEAbJzf5o4C5kQzoWqBjaLQJhE7+6XpdLgR3sxSzwY1wP4dTDVRVyo1MngbKAer8hhQUwX50IHHR7ZoFF3yrTVCj5L5iytSBlVMnhAq+hC0VXEGtfOwxF2zLqYhL8P1+Zj4jlFX1h1FoqBFJ5Gl5dDeVm6HL5Mj2nOagMEYiJQfW80f9DUrIac2rjHfF05iW4U2Ezk6BRDQE5nsxmHA4kEtVEPXXyz8lnGY4yE7DHRrxtaV/OBC/zoKN73Nfk1rRWV/LggSJAA9PxEsLCxK8tL4lJnOfc9Qzzauda3bngGShbkEev8czcjhE8xLZzQxO+XFRKzew200mCgKT0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293cac49-9728-4ac3-7b90-08d8249e434b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 06:55:42.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzz5+WP9g57Jd7LkOkEjkpR4Loga4xIZKKIBmThiQRavM3dmgBuNuzQXevebvDD/AcnyH1ikvOtoMO+d39DMNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjDlubQ35pyIOeaXpSAxOjQxDQo+IFRvOiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gbW9kZXJh
dGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRQ0KPiA8bGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgta2VybmVsDQo+IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBB
Uk06IGR0czogaW14NnFwLXNhYnJlYXV0bzogZW5hYmxlIHNhdGEgb24NCj4gaW14NnFwIHNhYnJl
YXV0byBib2FyZA0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBIaSBSaWNoYXJkLA0K
PiANCj4gSW4gdGhlIFN1YmplY3QgdGhlIGJvYXJkIG5hbWUgYXBwZWFycyB0d2ljZSwgd2hpY2gg
aXMgcmVkdW5kYW50Lg0KPiANCj4gSXQgY291bGQgYmUgbWFkZSBzaW1wbGVyIGxpa2UgdGhpczoN
Cj4gDQo+IEFSTTogZHRzOiBpbXg2cXAtc2FicmVhdXRvOiBlbmFibGUgc2F0YQ0KPiANCkhpIEZh
YmlvOg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4gT2theSwgc2ltcGxlIHN1YmplY3Qgd291bGQg
YmUgdXNlZCBsYXRlci4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IE9uIEZyaSwg
SnVsIDMsIDIwMjAgYXQgNToyMyBBTSBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gRW5hYmxlIFNBVEEgb24gaU1YNlFQIFNBQlJFQVVUTyBib2FyZC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT4NCj4gDQo+IFJldmlld2VkLWJ5OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+
DQo=
