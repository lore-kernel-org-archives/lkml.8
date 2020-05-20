Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085E9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DE020578
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9cZS+u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgETDGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:06:31 -0400
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:48006
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbgETDGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQB6Y4dqQ/m62w3KcbC0X3dEzGNMJeViH6ga/CLwq8bohHAo7+Hn4FXWL8R/RxAAIB11T8YL5c9XKSZA9gETANZAYcauWNmcNskLAHRbXR+t3eRe7eRmwsfAv+22wkyIuAeIjC2da1pZYL/3SYCY+4AS4D5g9ICBBUZMCZdFh8aTTRCOpOMCQcxTP57Bk4S0023A+fm7tQldtRZ/PXxLN63OCIwREK2QWp4nrj6TDPG6ta/ARAcJSE36Ic03hKqP6Zv6JQOdEtQMOtvkvjWKCTkJ9uPgX0Ko4MOld20GL3ZREDjXMbQLCUQUCG413xSE55bvxl2OKWbzQZO+KUdGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNMNWBRxX+rgdmlCK9LFR+FDctEBp2by/5RDGWssLqI=;
 b=HLW04LDCLj4sIWy+dEUtWjcdsLm3fIhYRPpZzDPpujlKEqWu/0ORqqfvkOdlglo5J1/bfqhUnwcqk3SqtwXbLYGFS51v0j1SJPca2aaARsskMvsQYmliojA854UJHWJu6S0MQ59D8dhsGEAmWRaZs4OYndBuwR9T01rB6PabSA6Olp9kspgjY3FNvV8ebf+tbeUYvD7X/OqQw5u1765uJPR3/U7n7hQ2cm7kdAvIOo6JU5l74FiprPnhfZ2tsymEnPqErJJsrSP1j7df/4rzLwN6eddIcV9eEC4Pxm4rnjLCRxM/DzWGfu3JENdKFVfEaJVCAaLGmn0MdG2k15XI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNMNWBRxX+rgdmlCK9LFR+FDctEBp2by/5RDGWssLqI=;
 b=U9cZS+u5LM71G59Ac7EttPyY5RN6VAIgkGOVA+rz4OijXkf/oct5WMAiknoBaZWcY5pqBbq59hFr5/Ung/P4qzl1E0e7wlPjeXAQVery+6Se73xuhW5rFmM4Pbp+BK5/8erS+U4pioirdZ0nvH6YoS+vRPioF2m28WmcL9YzGZE=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2933.eurprd04.prod.outlook.com (2603:10a6:4:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Wed, 20 May
 2020 03:06:26 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 03:06:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/3] arm64: dts: imx8mp: add mu node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mp: add mu node
Thread-Index: AQHWLkxzkzQ2vaqxukCIUytKVqWONKiwSJ8A////3aCAAAJDAP///89Q
Date:   Wed, 20 May 2020 03:06:25 +0000
Message-ID: <DB6PR0402MB2760A227F497AF7EF22079B888B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
 <1589940278-3680-4-git-send-email-peng.fan@nxp.com>
 <CAOMZO5BPPRy_XGHHyZfE3eOrmCwW_VytueY-An8qqke6HU06TQ@mail.gmail.com>
 <DB6PR0402MB27602682E90E4CED55244BCC88B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAOMZO5DmiQbfJjTLKPiv6uUNaQ8ae-0h7uOpPf2J9ZMwDoE+Eg@mail.gmail.com>
In-Reply-To: <CAOMZO5DmiQbfJjTLKPiv6uUNaQ8ae-0h7uOpPf2J9ZMwDoE+Eg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [221.225.35.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f96cde23-ae68-4bab-b205-08d7fc6ac902
x-ms-traffictypediagnostic: DB6PR0402MB2933:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB29336C9A0A9F97BF589B557888B60@DB6PR0402MB2933.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Xk8jcBHJj/GqMvI7Y3riMLTMOKvNppneNWILPk3R8vzc92IQbN/uQ53QzflqrqHp4J1pC+VvGBzArQLxEm6Dx7aKv5ZhXPxYZR02+nJFyLgtUkkI3h1MFmUNVTHovoIn+S9GV5uC+avb1eegSi802d+H4/kDbHYVVd6PserqdE7C4MzBtxeyntvwO6B/lVKozjUjg9jUsS/3fl6taVEjKKvDvqjjdUOeQgYYGq9SbcVRM5C169fAfLC3Umr5cjDwc2zIxAYlr/A8RnzbGzZMKN05zblILxkfVTn/fZCzPd1NmWxcdQ/SLDz6n8jmDAeRSxgp/PRYl7f2L0D83m2YF6JHuS8Sc4hJUjf4ZprUjfZC7EGqfrG266IUtK7G/AJrmxFWrfxfhxIgARr2Z7TmhpZKzxu3N/Yy467c4vR+2su0glNK7SRJ2/NsgsYlfsPwKHMlMt6pFOS0YqR1hGKhv4ufRI8MMFKYW3xYbByFdq1fBgZFsR6enCbxgdGGMFZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(52536014)(71200400001)(8676002)(7416002)(86362001)(5660300002)(6506007)(53546011)(6916009)(7696005)(186003)(4326008)(4744005)(33656002)(54906003)(8936002)(44832011)(55016002)(64756008)(478600001)(66556008)(66446008)(76116006)(66476007)(66946007)(316002)(2906002)(9686003)(26005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ++uOlDS42Bhwq8CUGuvWPMlOUw7vowZY6z+gWGj+pSQD3Uon+OmRdU+wKcXIVp18+mXSPU6whKtZtLO+an6wtY7hvm7lvg6hQk6btgRX4rW4tTka+0JLf4EhQi04HTT4gOQZWfllfE/aTaMaXSJlCNx38kcrhnTWK3TBzCQe2nvxvSk8srl5QiTK3jVbz3N3N1yMuiJd6Y5X26rPBBJKu7Cwc98c/y+GTGP9V5GGNeqHPiaE2Fffil1qc3rTbIsqPVXJScmlef4/PGzqT1dx3F07XHp2LXR8OcuFIdPoYHOKcAWVHAL0sslbYUBJ+b6xMkpVzmoV46nQRzjBarit8PNV+IEE1LG0YMgpay/rNAGSrIQIv1ul8tvQNmmmTgRUTerWugp/xUyAEPjJX+Fh45F+ItrKC0ASsSU/ZZwuLkjD91VVikbK1T4AjGu7ZXu4SfXoDiyOMDoY9TrsxRs3Ws3uuBcOxRWKRMXiFr/602til/uM+kBp7QL7lDuT0c6w
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96cde23-ae68-4bab-b205-08d7fc6ac902
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 03:06:26.4274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfKv7Cdug95kFwjvRbTHs8xb4//yZe1vVH37eB4ou1O6apHMnmLKML+rEvHGLZ9qEBiCkpzP6IxIDiK1ID6j7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gYXJtNjQ6IGR0czogaW14OG1wOiBhZGQgbXUgbm9k
ZQ0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIFdlZCwgTWF5IDIwLCAyMDIwIGF0IDEyOjAxIEFN
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gTm90aGluZyBzcGVj
aWZpYyBpbiBpLk1YOE1QIGZvciB0aGUgbXUgcGFydCwgc28gZG8gd2UgcmVhbGx5IG5lZWQgYWRk
DQo+ID4gImZzbCxpbXg4bXAtbXUiPw0KPiANCj4gSXQgaXMgZ29vZCBwcmFjdGljZSB0byBhZGQg
YSBtb3JlIHNwZWNpZmljIG9wdGlvbi4NCj4gDQo+IExldCdzIHNheSBpbiBmdXR1cmUgYSBidWcg
aXMgZm91bmQgdGhhdCBhZmZlY3RzIGlteDhtcCBNVSwgdGhlbiB5b3UgY291bGQgZml4DQo+IHRo
ZSBNVSBkcml2ZXIgYW5kIGtlZXAgdGhlIGR0YiBjb21wYXRpYmlsaXR5Lg0KDQpHb3QgaXQuIFRo
YW5rcyBmb3IgdGhlIHRpcHMuDQoNClRoYW5rcywNClBlbmcuDQo=
