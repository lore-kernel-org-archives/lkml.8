Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D9AC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1535120722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e3vzpO9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgEKLQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:16:29 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:54259
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgEKLQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9NZ5UaD+p+aVKsDd0of3Wpquf8N7Ma5LCwQ6qgcy6RJd4iHX0/q6+5ugS4S56Iia7yD4jCRyANEPyTzdryxOtLUmlXL9ZtizbQqdJuoYxgsHGxAqB4ZoV95RcNbJYvRCKIPUXeN3hH1wxF/XT2jCCkco48bvt/FTkfjUjDE158Gc16IY1v+cxJC3Xfvwr6nUqPMGTqFMuEeQ9pm76ACEPMh2Rt133yEg8LvuJiuI590nR25ODJPhJzTFkxCiUUvukA+xtnPiFjmy9bilLPpV2MmCm6Lug4QBS85NoMNZqx3zMBkgHI+2/kd4voIIhptFKoaVttw7UBedME6bhfoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qenBc9Pexn/0UqftHkM+2gP6cZ7+lEhBohMfn9bK1Uw=;
 b=lMidS5ZVHSTF5yDiTrCni0p/FhONnRedjug+wpiV582kHxs7OueLdSKqDSf8/Ca1THHnbFxic/IUFvcSNNxqRkqfOezJR4TZ0wCZyC2Tuo7/P68jokb0jP+Nl1diCtvQMB4ldcXmt6mvdDTJGUwB0BC1L5nei8qlq/8AKUyEwmSyq3hgn3YnOiR/VvJWZiswpAIAsxnyHx0gvyRnhSjrzMOnm4NU4pop8lIvz5rJK2MNUgorLikRuFSK41GMm83tAvWUFdrnnTqv94UTaAaX4NeQ+oLHcNPG/wh2cuKM47pIK+0c8h9wtvWIjPp9omlJJx9GSp84YL/Up4NoluX88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qenBc9Pexn/0UqftHkM+2gP6cZ7+lEhBohMfn9bK1Uw=;
 b=e3vzpO9LV0B92Ii1z/UuoUqthXrl98c0rMYQcOvqSNZ7s2Ub5fhR179qVs5qcGgaeTqdbQU/z8NBONBCcqbSlyO7H2ZPaYAkh3JVSJs0vcIHDXgmQqO2jk9o1m6MFFXBv1PCFwW4vt4RDvhEbSWnCUzL6k0nx+AgbssdD8TV7fs=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4150.eurprd04.prod.outlook.com (2603:10a6:209:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 11:16:24 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 11:16:24 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
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
Subject: RE: [PATCH] dt-bindings: reset: Convert i.MX7 reset to json-schema
Thread-Topic: [PATCH] dt-bindings: reset: Convert i.MX7 reset to json-schema
Thread-Index: AQHWJdsuI+RtHYyd5EydI3B2US1zJqiivf5g
Date:   Mon, 11 May 2020 11:16:24 +0000
Message-ID: <AM6PR04MB4966E5E547A29199B84936A180A10@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589012077-12088-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589012077-12088-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0e341fb-e3b6-4077-6baf-08d7f59cbe0e
x-ms-traffictypediagnostic: AM6PR04MB4150:|AM6PR04MB4150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB41508C4B20CDD982029632AF80A10@AM6PR04MB4150.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgFKjBeVLR8RXnbzE6hBBeA9Ap05a4mRxXOiketvjcooKe7ctWhiAY7pQjzySdXrhRvjhq9ZpxOJYL8bTHda6NEWdrdFfuDQwnc8gAP/JfFeRI7w04K/wGk9V9HFLq4Gur3R8TAPU9umguq3mdN7YsleTAgiatEerrrk94KTB8uskUT7zlknXN4Wv+QoptKt/R8GdSmu5woLXHKGfcm527/kcxnX57SAdu900C0NWVKa9i5OZBu9pC7uvejNYIVdMLjwHZXWdGM/ph8rlo6CHmy2Yi/1wYiTGh0sEvJwHA2myUBh/lSfMfymqJLG6agApuHLLJiBfSmIuECsGTwZmIkC052xNc9Fy1v/kDZ+pCQ7dVZ6j+INbieE3r62EMfzw6gif6dkcQXDFpoE6g4sLCflJkVNtvvoibAC8VdhL8n9Rb15VzW7+YE8o3tumDzaa5yZG1wR+4pmcVcFbbsvVkZkhMA4nXxUkPPsLbf86Dt5VUO0YLuyuIJHXBju3GBi2a586LikKom8eUcQdkR13+cqyq75ZtTpxrpduO+EZ40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(33430700001)(55016002)(4326008)(5660300002)(52536014)(8936002)(478600001)(76116006)(66476007)(66946007)(33440700001)(64756008)(66556008)(66446008)(33656002)(71200400001)(110136005)(9686003)(86362001)(6506007)(316002)(44832011)(2906002)(8676002)(26005)(7696005)(186003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: r6J9uiNRwfJH9UMHMtCtPDt76iOVxq5NF2MV/mbQ6k/nsoWYWTtvNn/D4OjJzY0dkeEttXfiT0v2vNARsWXbStEJi/DklVhkX+Cb4V/hX9o8NvUw3C6oKf2n6t0b36tdRiMS/+ai3IO3kXxB6bIAy5cj8ovPyexs8Xj01teV2h+7KxH1k8HK705dn1ueZqyHDuc4G59/XgFHhQy3ELFM6JjzzbmiNhwIA+24LBK/+eYIbwCdHXi+zwLtM5FKrkO2pOwDtwobUJGOnTxLThjp0unvKAxUVj5Ke/pR//a87+EG90k9Bl1GJSkanthR+U0eMf79sTSPh/79mjEAlsDA/ljwqSiwoXxbiMme248Qzjq/x5kvYo8JdACW1OteQABIA2ZxSK9+Qju8ZK6EJ+glgdgTXrCOSIklTcQZNK9e+KsrAGYkNnCbXe5OnW48olVPe6W2gHo/7CrSQmKZW45FsG4JYTw122go71nzN75uz9c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e341fb-e3b6-4077-6baf-08d7f59cbe0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 11:16:24.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAuQ2TFp5+vzmDyHbK5ITZ6zLSoq4zUXS1IMSysSAvx8z2b4jO/+OZnD4yeDdSXAcN1RYTCzOZ8lXi5EcTuu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCg0KPiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gKw0KPiArZGVzY3JpcHRpb246IHwNCj4gKyAgVGhlIHN5c3RlbSBy
ZXNldCBjb250cm9sbGVyIGNhbiBiZSB1c2VkIHRvIHJlc2V0IHZhcmlvdXMgc2V0IG9mDQo+ICsg
IHBlcmlwaGVyYWxzLiBEZXZpY2Ugbm9kZXMgdGhhdCBuZWVkIGFjY2VzcyB0byByZXNldCBsaW5l
cyBzaG91bGQNCj4gKyAgc3BlY2lmeSB0aGVtIGFzIGEgcmVzZXQgcGhhbmRsZSBpbiB0aGVpciBj
b3JyZXNwb25kaW5nIG5vZGUgYXMNCj4gKyAgc3BlY2lmaWVkIGluIHJlc2V0LnR4dC4NCj4gKw0K
PiArICBGb3IgbGlzdCBvZiBhbGwgdmFsaWQgcmVzZXQgaW5kaWNlcyBzZWUNCj4gKyAgICA8ZHQt
YmluZGluZ3MvcmVzZXQvaW14Ny1yZXNldC5oPiBmb3IgaS5NWDcsDQo+ICsgICAgPGR0LWJpbmRp
bmdzL3Jlc2V0L2lteDhtcS1yZXNldC5oPiBmb3IgaS5NWDhNUSBhbmQNCj4gKyAgICA8ZHQtYmlu
ZGluZ3MvcmVzZXQvaW14OG1xLXJlc2V0Lmg+IGZvciBpLk1YOE1NIGFuZA0KPiArICAgIDxkdC1i
aW5kaW5ncy9yZXNldC9pbXg4bXEtcmVzZXQuaD4gZm9yIGkuTVg4TU4gYW5kDQoNCkhvdyBhYm91
dCBjb21iaW5lIGFib3ZlIHRocmVlIGl0ZW1zPw0KDQo+ICsgICAgPGR0LWJpbmRpbmdzL3Jlc2V0
L2lteDhtcC1yZXNldC5oPiBmb3IgaS5NWDhNUA0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBj
b21wYXRpYmxlOg0KPiArICAgIGl0ZW1zOg0KPiArICAgICAgLSBlbnVtOg0KPiArICAgICAgICAt
IGZzbCxpbXg3ZC1zcmMNCj4gKyAgICAgICAgLSBmc2wsaW14OG1xLXNyYw0KPiArICAgICAgICAt
IGZzbCxpbXg4bW0tc3JjDQo+ICsgICAgICAgIC0gZnNsLGlteDhtbi1zcmMNCj4gKyAgICAgICAg
LSBmc2wsaW14OG1wLXNyYw0KPiArICAgICAgLSBjb25zdDogc3lzY29uDQo+ICsNCj4gKyAgcmVn
Og0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgaW50ZXJydXB0czoNCj4gKyAgICBtYXhJ
dGVtczogMQ0KPiArDQo+ICsgICcjcmVzZXQtY2VsbHMnOg0KPiArICAgIGNvbnN0OiAxDQo+ICsN
Cj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSByZWcNCj4gKyAgLSBpbnRl
cnJ1cHRzDQo+ICsgIC0gJyNyZXNldC1jZWxscycNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiArDQo+ICsgICAg
cmVzZXQtY29udHJvbGxlckAzMDM5MDAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiZnNs
LGlteDdkLXNyYyIsICJzeXNjb24iOw0KPiArICAgICAgICByZWcgPSA8MHgzMDM5MDAwMCAweDIw
MDA+Ow0KPiArICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODkgSVJRX1RZUEVfTEVWRUxf
SElHSD47DQo+ICsgICAgICAgICNyZXNldC1jZWxscyA9IDwxPjsNCj4gKyAgICB9Ow0KPiArDQo+
ICsuLi4NCg0KSXMgdGhpcyByZXF1aXJlZD8NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IC0tDQo+
IDIuNy40DQoNCg==
