Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A316C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4573F20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rWr76Hpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgGAPad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:30:33 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:6113
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731820AbgGAPac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:30:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwC9TTRqQ/gOfMMGaPAvLrfTMOatguwEhho++ZfPyLMJQm2Sz0s2Lk3AnzQ2Yzle1AUHQkiGczlRfgSsdFYzUYSD8+C6IBj0FmSFG5W+mHmzl2gJXS47j9JUyhzcq52nCTvnDEjaHh1u+MgFORlpKuIKm10jFS5siHyCXD1OZTQM1f+/M71G5xqyPI7VVVe/F713sUOJ4oD+PM9hN48SJYh68+1MzgKB3V8FNn4Z6ZpqGPQ+KLjMEhvR3V5ma6SfdV24cJi4ktF4uIFuY5d9A9MRqh334yKfYYUHFjfqoo9HtkqyYKYGF8Xn9FhyArdfxLeWoDcxGgD8/HorGhSOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oerlB0f/hTQ+AOat22RZAgZDQ6cSBmhnVxX1cmjwRQ=;
 b=bTRcSuzV4984OsEnT91tFduml8MkEzih/60kV8lDf9ipBqHzhwuyB0EbFITfcuY+x7lrKDS1XQ0eAQCPx54iLGejvG+P2jOTZFRsvVbkGQhIMTeksQWu3deEKybMvPpxBwFMslR0KbxuohgrsUls7v+fYmbmK16CnLy7zTpMvcrX89bhkRKMSk1GeIjIq/PW5XA9BMO/ui/Ovz1iRikmmVUiTfKezfSPv3M3vG9JH9KjPe/tEH36zG2RiGbyg3H9a/eGwIv/K4u0oFe2F1nQ0JCviaKfLGnfIUKDIerV9m25qFoSwXqJ1wxCoIY0nK4XSo8UwcssreWlEkkaUmITuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oerlB0f/hTQ+AOat22RZAgZDQ6cSBmhnVxX1cmjwRQ=;
 b=rWr76HpwoKW5/gJLcvRH11PH0LbgxhZbX4I+z+duY5a0MkTtm9aHjfwwzs7+y1GcqtNKviCavftGD8diC6CWRIwOnEj0SaraZMx/i64NeF4k745NJQUo9HAfL9qTbDvwVHga1fua6BhTSiL4MlrYVW/QvVZYJqFsqBsBppUqMag=
Received: from HE1PR0402MB3612.eurprd04.prod.outlook.com (2603:10a6:7:7f::14)
 by HE1PR04MB3129.eurprd04.prod.outlook.com (2603:10a6:7:19::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 15:30:27 +0000
Received: from HE1PR0402MB3612.eurprd04.prod.outlook.com
 ([fe80::d0ff:37b5:f9b5:352b]) by HE1PR0402MB3612.eurprd04.prod.outlook.com
 ([fe80::d0ff:37b5:f9b5:352b%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 15:30:27 +0000
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
Thread-Index: AQHWThag/tmWe004ek+eXrutuxE1fajvmZEAgAAMoQCAAAM9gIABCdjwgACVb4CAAMUk8IAACGSAgAAAgUCAAAESgIAAqXeAgAATtYA=
Date:   Wed, 1 Jul 2020 15:30:27 +0000
Message-ID: <HE1PR0402MB3612B2111833521E571DC207FF6C0@HE1PR0402MB3612.eurprd04.prod.outlook.com>
References: <20200625140105.14999-1-TheSven73@gmail.com>
 <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
 <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5B-XVaZ-t2T7UBdCqqde3bJREiQhR71ET8p=9EHJ-DQbA@mail.gmail.com>
 <AM6PR0402MB360717519B42A48A754691C8FF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5CZMBeSY=0sa39wJsZpaCqWeCb4-HG4jjXO5pGeW64azg@mail.gmail.com>
 <CAGngYiWV93yWY-mWM-1YcRU71iWnP=qsLSD6Z5dZkz=Zb+iqRA@mail.gmail.com>
In-Reply-To: <CAGngYiWV93yWY-mWM-1YcRU71iWnP=qsLSD6Z5dZkz=Zb+iqRA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d25cddab-fa33-4fd7-a25b-08d81dd3aeae
x-ms-traffictypediagnostic: HE1PR04MB3129:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB31291DB39BE55F28F2296C35FF6C0@HE1PR04MB3129.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwGIgjM2fUk+0DDCZtsif08JVqmT4yfkhhB8S6GhTwSncg8d6Qx79BwBMdyUFFmJcJ0WoBqU7A8i9PeeKEeyP1Ix87cDppIF/Dbxw9Xs883NpJpfNUXQ8gQLZBdVyhkXSD6p30oP/wQdZ18xqy05NlVZo9ScP809J3Lm0eOTBTg23d7kwkrYQaj6IDs8s8BS/SQ1e38/sQVzC+nhxyNmERkL2FVla+X/sdQlwOkwHbqdTL27MgENQ76QBHSSuzC3ThamZ6hzVxJSJAeQpEL8468exuMC0WrxPwSD1x341GKW9KPGnhb9P3nHHQkCG4fvquXnfRCQml6Lq+Ll4V0xF/ZiRGitipFXcWiFsbwkE0TpXo/SuE3Ka+D4eVkZczTc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3612.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(52536014)(2906002)(9686003)(26005)(7696005)(186003)(83380400001)(6506007)(71200400001)(316002)(110136005)(5660300002)(33656002)(86362001)(4326008)(8676002)(54906003)(66946007)(66476007)(478600001)(66556008)(76116006)(66446008)(8936002)(64756008)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: V+9V/Ix29SpG5aXgJaVPn1/U20pmvgfWF0srSxg69aGZpQgBqoYTWd0wsfDypkg81HfU7RL3XwOag+M9VCQWXKeeD56HH00I+qlicMXW4eCemGhqVGYM8S61QMRMEOOcdma10w+LzzoBRGYO3SkUb5Ky0HGL5PZvWvyGOaWzSsmiwTGAyjhWD5+TwVIIVhNhHDtp+uDdByd6vOChIyZZ5COnlEOzIP7kurYq3kq5mhSGLkHJEzAJAs5bWg9zZ0qDqlPlpfUNfZUg1tKJrmeE/3BRxtUYBEdHQMnvV1w9A54yMEUQsYjmBs9l06GENWIcgLA+1PA5aPlf7uYclUmdwK1ZUvrjel8kDS5oSeLvvpexOYU+gbZmXAP1qyQ9ndXpidlVpLwCjCmnkkmlXmcVci+7VwpxDTbInLWhIwT4dohUeGv4i4HPNh6ILbntx4B46ttU7xfQS5uTDK7VYEajRTf/sZZTvOZBHOtChu4JOxfc3ZU8nHTqLl3KjvrEPrmO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3612.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25cddab-fa33-4fd7-a25b-08d81dd3aeae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 15:30:27.7611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtYYkqBFfg6bMM9DlHxg6UHyekXiVQlbBfM/I5TszkmKekzXqYMBfkuHxkmxMX0WPPcXNTBuRhCJqLCJssQ8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3ZlbiBWYW4gQXNicm9lY2sgPHRoZXN2ZW43M0BnbWFpbC5jb20+IFNlbnQ6IFdlZG5l
c2RheSwgSnVseSAxLCAyMDIwIDk6NTIgUE0NCj4gQW5keSwgRmFiaW8sDQo+IA0KPiBEb2VzIHRo
ZSBmb2xsb3dpbmcgZGVzY3JpYmUgdGhlIG1haW5saW5lIHNpdHVhdGlvbj8NCj4gUGxlYXNlIGNv
cnJlY3QgaWYgbm90Lg0KPiANCj4gMS4gaW14NiBldGhlcm5ldCByZWZfY2xrIGNhbiBiZSBnZW5l
cmF0ZWQgaW50ZXJuYWxseSAoYnkgaW14Nikgb3INCj4gICAgZXh0ZXJuYWxseSAoYnkgUEhZIG9y
IG9zY2lsbGF0b3Igb24gUENCKSAyLiBpZiBpbnRlcm5hbCwgZmVjJ3MgInB0cCIgY2xvY2sgaW4N
Cj4gZGV2aWNldHJlZSBzaG91bGQgYmUNCj4gICAgPCZjbGtzIElNWDZRRExfQ0xLX0VORVRfUkVG
Pg0KPiAzLiBpZiBleHRlcm5hbCwgZmVjJ3MgInB0cCIgY2xvY2sgc2hvdWxkIGJlIHRoYXQgZXh0
ZXJuYWwgY2xvY2ssDQo+ICAgIHNlZSA4MTBjMGNhODc5MDk4ICgiQVJNOiBpbXg2cTogc3VwcG9y
dCBwdHAgYW5kIHJtaWkgY2xvY2sgZnJvbSBwYWQiKQ0KPiA0LiBzYWJyZXNkIGRldmljZXRyZWUg
ZGVzY3JpYmVzICJwdHAiIGNsb2NrIGFzIElNWDZRRExfQ0xLX0VORVRfUkVGLA0KPiAgICBhbHRo
b3VnaCBpdCdzIGV4dGVybmFsbHkgc3VwcGxpZWQgKGJ5IFBIWSkuIFRoaXMgaXMgaW5jb3JyZWN0
Lg0KTm8sIHB0cF9jbGsgaXMgdGhlIHNhbWUgYXMgZW5ldF9yZWYsIGl0IG1lYW5zIHB0cCBjbG9j
ayBzb3VyY2UgZnJvbSBpbnRlcm5hbCBwbGwuDQpTbywgZm9yIGN1cnJlbnQgdXBzdHJlYW0gc3Rh
dHVzIGZvciBpbXg2cS82ZGwvNnFwLCBwdHAgY2xvY2sgaXMgZnJvbSBpbnRlcm5hbCBwbGwsDQpy
Z21paSBndHggY2xvY2sgaXMgZnJvbSBwaHkuIA0KDQpGb3IgNnFwLCBzb2MgYWxyZWFkeSBzdXBw
b3J0IHRvIHJvdXRlIGludGVybmFsIHBsbCB0byByZ21paSBndHggYnkgc2V0dGluZyBncHI1Wzld
LA0KdGhlIHBhdGNoIGZvcmNlIHRvIHVzZSBpbnRlcm5hbCBwbGwgaW5zdGVhZCBvZiBleHRlcm5h
bCBjbGsgZnJvbSBwaHkuIEl0IGRvZXNuJ3QNCmJyZWFrIGlteDZxLzZkbC4gQnV0IGFzIEZhYmlv
J3Mgc2FpZCwgaXQgYnJlYWsgb2xkIDZxcCBzYWJyZXNkIGR0Yi4NCg0KRGlzY3VzcyB3aXRoIEZh
YmlvLCBhbiBleGlzdGluZyhvbGQpIGR0YiBpbiBtYWlubGluZSBoYXMgdG8gd29yayBpbiBmdXR1
cmUga2VybmVscywNCndpdGhvdXQgdGhlIG5lZWQgb2YgYmVpbmcgdXBkYXRlZCwgc28gdG8gYWRk
IGludGVybmFsIHBsbCBzdXBwb3J0IGZvciA2cXAgcmdtaWkgZ3R4LA0KYW5kIG5vdCB0byBicmVh
ayA2cXAgb2xkIGR0YiwgYWRkIG5ldyBwcm9wZXJ0eSBpcyBvbmUgc29sdXRpb24uDQo=
