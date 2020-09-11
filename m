Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54389C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0408E20731
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pMk2LmU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgIKHUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:20:09 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:13089
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgIKHUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:20:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpxBi0jnvSYCOpbXFGMQRnXOW45RTJt0uqDWoe1gxJV1aIU0vIxnU/c1HwEJsr2gu+URRofuZuwDlZAGqA+5RKOdi4Zu4obuGtpE7F7Uk3/goJegcmqKUGk2kI2jHLLkakv5qbzXBjzCAJTS1q1loJztvBbnnghbuXo45TDELfchbC0EgECI1Rdh9OGhCOQJ603p6EZnPy4xI4j5KKVAQq9PEmFLl9j997O9ktnRGsrrEsfnz0qdl5TB4tap3NpqNfvCh0BWJCjd27jcDWqo5r5GTIk2sc1sAj3SYOaoPIQQ7autTs6LG9dnTH+N96NbYdFPd3uq3u+BBAD7id20Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q9Yd33ubrluRg4IqkEhzePSZcz9XkbXk4kVMZdUEBI=;
 b=VGO3+pS4plg58Rl49qE9/MhxFYfSHLd3fz/azXEvgYWUTPn/vzeCc8+y421+oQSGuaf8hGJzi6eI5rvzN8nk4jWAvfqr4g2PrS65oyFzaZuxwy1CfjLAA602zeNc1FUSL4vv3ctdLl29GC7zzv1dqtGrPkyHzvmryKiBc+RgimqhsxDHx6kUDHrZo5iI2YjKxpEaopF4RkRbZrRH2ZRTT5uu9qJD+wDu/371VmZwYBzGjHph5qdUTl2ZT0eAImGY4Txsz5tDGgj/bhDJJCV3zOc5GEhu0+nIAB6sRlw6vmHusaezBZi2UuhoxYsQNQhklpzs6u6R10yE+0DNXdMarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q9Yd33ubrluRg4IqkEhzePSZcz9XkbXk4kVMZdUEBI=;
 b=pMk2LmU4hPrw19DdD1cCAEWIcXKcN3wTEd5uT83ChY4Fsc/NsYWeXHYzaccJV8iB+moiCp1jv5NLj4a0jl2qdSwxfy6jyJ+aCpR3ASpS1VuBkprA1qaZUMTjbe3fxmowbpkuoeCKRrnpXFBn9YDUHIhLyt3NSCgYWC4vqWtOPqc=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 07:19:59 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 07:19:59 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Topic: [PATCH 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Index: AQHWh+zi0lUqzLc3V0GYGgj5TwZkHqljAcZg
Date:   Fri, 11 Sep 2020 07:19:59 +0000
Message-ID: <AM6PR04MB49661958310D649508AB698B80240@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
 <1599795053-5091-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1599795053-5091-2-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20f95103-15d2-483d-4d78-08d856231805
x-ms-traffictypediagnostic: AM7PR04MB6773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB67736F4F4BF68091D17AA42980240@AM7PR04MB6773.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jDDjMqhJ51LoOAiaGHGI3xW3T0IHZu9+DTy8ysjO5V4UDrCbdYuxugejagsZXRmudOKvHtiJkT++3L6FOnXYM7nIDnl0HE3Yibb7htQur6hXJOjUjaxu0Uqmu+XG4RwVVuqCIwpKW423SWBZk7s43SF/5d4zZKMnwYLSfQ2E6W9Ciocl59EaeUfzCr55yYp3CNc2yf52Kv3EseEPwdsRSaHc92pAfq4IbasBtt2KYNHzgKzg/7a73fSCFwVviV7myPDahC3d1u3gtW1bt1hBfJJoea8dc9/YMD3nZVs58/wlVUeBnCcYpg+A5RE3UIttKld2dCQ4McEKKjXA9ezBZAFLidOcbTskL6gJ0doo6OrdhuqUVmclT+9vGbCISmoh+0/GndosSKMUp+npQJyAEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(186003)(966005)(66446008)(86362001)(26005)(6506007)(5660300002)(66556008)(66476007)(66946007)(52536014)(316002)(8936002)(76116006)(71200400001)(64756008)(4326008)(54906003)(2906002)(8676002)(9686003)(55016002)(7696005)(44832011)(33656002)(478600001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cVpFHnaGEemt19t4W6+bPcsG7zryhtcVqc6TyDe6Q1Sjx6Y2KwE5LGwAS6h1dgqsmQf34jxBlH3+bXPcuOpr1vRFII/PVSalLDJCD3OBBwSbsO7GMmx3KzbM+5gMuaBKerBdCPUnYvXETNq9EQ9A7lTH0Uqqa8MAl7US5aXkItkZuZ7GBp7Yq8Uie5iD/e1r3xFmmI38dJcwvppREpUy18Zsl/hfxftWPJOMfYqvlsYbDPLt8rf99/yG3BhPAI/NAVIv+yPFCMNjwVCE/BCAFX6WCQH0i697adKY5b2htIGfqBOp3uWp2Awx+w3zIRdxXjp+I/qcdmm+mmDzCceu1JvoK9i6b+cwrFNeATPFC2bqWvRZ8dMP095uNuamanbWavsTm6SXK8T62tzCE5VppT2iKVJH2GTPSz3JbOQjU4c1ER8usDBYOJhDzDZbewdLpgaxbS+6X0iWi9BTJ+xOsvWAkZeITtLVBBoAbbR8G8ZL56qWWiY8uBx8/+pivv8Yv2k20d/o187jsMrg2qVtoU5scD+PCaS9np63Hk3LO1+XghqyucLUeoehcL/Z8HeQbA5fuERvlv1NQ3aso7soxWdCqwWF6OkgK9KItvwycIZe/e5w2lNki665TR8H/BKlWl0pzraHPlH4yIlyZvpZ/A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f95103-15d2-483d-4d78-08d856231805
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 07:19:59.8620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRyas+zFXfcU22RYADl8NYqCnYJwWcb2Zl9lt4kPQ1McSRlCHU9xmTjLkKgzOI7+Sf7GqHiZbsUGcnu1Ns6Puw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMTEsIDIwMjAgMTE6MzEgQU0NCj4gDQo+IEFkZCBpLk1YN1VMUCBQb3dlciBNYW5hZ2Vt
ZW50IENvbnRyb2xsZXIgYmluZGluZyBkb2MNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gIC4uLi9iaW5kaW5ncy9hcm0vZnJlZXNjYWxl
L2lteDd1bHAtcG1jLnlhbWwgICB8IDMzICsrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvaW14N3VscC1wbWMueWFt
bA0KDQpJIHdvbmRlciBpZiB3ZSBjYW4gbWVyZ2UgaXQgaW50byB0aGUgZXhpc3QgaW14N3VscCBw
bSBiaW5kaW5nIGRvYy4NCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJl
ZXNjYWxlL2ZzbCxpbXg3dWxwLXBtLnlhbWwNCg0KPiANCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2lteDd1bHAtcG1jLnlh
bWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9p
bXg3dWxwLXBtYy55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uMzNhMzFkODdkZDYyDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvaW14N3VscC1wbWMueWFtbA0KPiBA
QCAtMCwwICsxLDMzIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+
ICslWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9hcm0vZnJlZXNjYWxlL2lteDd1bHAtcG1jLnlhbWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gKw0KPiArdGl0bGU6IGkuTVg3
VUxQIFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbGxlcihQTUMpIERldmljZSBUcmVlIEJpbmRpbmdz
DQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
Pg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGl0ZW1zOg0K
PiArICAgICAgLSBlbnVtOg0KPiArICAgICAgICAgIC0gZnNsLGlteDd1bHAtcG1jLW00DQo+ICsg
ICAgICAgICAgLSBmc2wsaW14N3VscC1wbWMtYTcNCg0KQ2FuIHdlIGNoYW5nZSB0byB0aGUgZXhp
c3QgbmFtaW5nIHBhdHRlcm4gd2hpY2ggYWxzbyBhbGlnbiB3aXRoIEhXIHJlZmVyZW5jZSBtYW51
YWw/DQplLmcuDQpmc2wsaW14N3VscC1wbWMwDQpmc2wsaW14N3VscC1wbWMxDQoNCkFsaWduZWQg
d2l0aDoNCmZzbCxpbXg3dWxwLXNtYzENCmZzbCxpbXg3dWxwLXBjYzINCmZzbCxpbXg3dWxwLXNj
ZzENCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+ICsNCj4gKyAgcmVnOg0KPiArICAgIG1heEl0ZW1z
OiAxDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSByZWcNCj4g
Kw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiAr
ICAtIHwNCj4gKyAgICBwbWMwOiBwbWMtbTRANDEwYTEwMDAgew0KPiArICAgICAgICBjb21wYXRp
YmxlID0gImZzbCxpbXg3dWxwLXBtYy1tNCI7DQo+ICsgICAgICAgIHJlZyA9IDwweDQxMGExMDAw
IDB4MTAwMD47DQo+ICsgICAgfTsNCj4gLS0NCj4gMi4yOC4wDQoNCg==
