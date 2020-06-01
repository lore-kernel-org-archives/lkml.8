Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F24CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E5320734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="csXAdiS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgFAIJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:09:04 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:45590
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbgFAIJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:09:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY1/R9SyFN0ogSIZ1DagZ9bhbohyw1AoeZ53n3S9JS8XlB2tt6NbJnpdKYzUD0sIhJB9E3EIyDsOLbL+2c9P2BY0ZjZCAhJBlIBs+5A2GFvE4WE1CDKf94UJ+AgaPJVkK5S3JBdfUl5ZUETyD92fFp7wbwkGRfUdJ0Bz0nt5Ml1g8G8pzs6M6FjKpFpwdW2Lh8x5muZFhl5QG9XxCzZWedt6nub6W5B+ZvBh6P7OLA+3ENSZyA/LnDgF1wxjWNd4/tLuknnY/vxNFocifImIfv1cTPBUFbXWlxhTC/+AdJsup42wq/BE3hbEq3uf247pi14fsZbbdMfPKuBID5QbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLH+A42FS0OPEIPuU6wp0aERKfq2jRKIs7Fn9tBTzrU=;
 b=L28CkOsY2RWzlFlJpOJHQpeJfwKZ1980mMey0T1qBW3u8liasY5TJv82YKEwERqgXRSLF7TE1BkMGRH+AgE5LhBvujbP/nPSZTaTl2I2qPDuITniSrKmWD+G50OpRaZoNSWM/rqOsI/aRS8zY7w6X2VQkx6HS4rC+qfcYjp57UH5Uviya3r5cRCSPlwJXGDUubC9c9eSA3U/BR655r+bHNCHzjpECrs7TpBRzpx92SOERXZE7QjsiVDB6BugZkDmYlbX1A9yjWDo1FdBGYA2nfYUJQrhC4aSsXMM0mKDtELwP9Cp0MYsMB0BiueyZqCFkALp57nhDi6LQaOQVOWI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLH+A42FS0OPEIPuU6wp0aERKfq2jRKIs7Fn9tBTzrU=;
 b=csXAdiS8OzftaJq79YRVOtQUouZOO9vyQ1JmXmKgE2S3TsZSjYTKRC7R07NUDPbYEEL5AuMjJS9bMqlOd1LvWSbkw6RPENaqWWoBwN87/LljdsnsgJ/xTIX6VLkepZh6Tm4WpQNKAXnnVLnMHdr08XjDg5ejtf1xNTa5Lc5n/hM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2840.eurprd04.prod.outlook.com (2603:10a6:4:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 08:08:57 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 08:08:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 2/3] arm64: dts: imx8m: add mu node
Thread-Topic: [PATCH V2 2/3] arm64: dts: imx8m: add mu node
Thread-Index: AQHWN8hFGz5776OGQUKrXwfiifS9rqjDYg0AgAAGECA=
Date:   Mon, 1 Jun 2020 08:08:57 +0000
Message-ID: <DB6PR0402MB27602E846BCFAA5A427B249E888A0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
 <1590982999-7149-3-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB496620ABEA09A0571B42A9B4808A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496620ABEA09A0571B42A9B4808A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d2fddf7-d0e1-45b2-3039-08d80603089a
x-ms-traffictypediagnostic: DB6PR0402MB2840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2840AACE996748A08463EB0C888A0@DB6PR0402MB2840.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xNslZA+mAtqxxriXl+yRR5NK6QVDPRLt91sx6QAkTAAxLyqPGtVMJ4z8eEN0bcTRcLPiOkErzJ/5dd2l/vY6rvIiXY717+hn57OX5r1hiJO60cziOij6aW9FvOjEBSk5KNRm4lsbq3+eJjFE5kieE3VLYpHhDv4dzuQ+vKb8sx4cMh9zYrgG+mUEDcA1EAJmh+xj4Gm0r9vjkf2abRMvAEmtbjFPo3+6N0SS4QjVYjcja8uQfE6f32LujynROepwUsY48pDzkVv8c3rUojUFQikfTitOxwlcbJxePwHc7AQloWwpCKVswgAx2xk+pWjZXsGyATES7ZUJo3pXQZ6qQ23SVw+KkLBzZTG+PBUALqCRgg+lP5RIbZH2TZ936Q6LxtqN+55xNSsI3qIn6qbo5FbFmikQ8oaqqeQVpr63v3rmndDSQ2tYOg8dE5Jj8sCf99DGCVz6klxPaGhxbGeTKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(76116006)(66476007)(64756008)(66946007)(66556008)(186003)(110136005)(2906002)(7416002)(66446008)(71200400001)(26005)(54906003)(5660300002)(6506007)(7696005)(8676002)(316002)(44832011)(8936002)(52536014)(9686003)(55016002)(33656002)(83380400001)(4326008)(478600001)(966005)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /CZRTp6iLhNuj5J7LrZVdPjLD9TCuXy5xlB0Zi/OqWQRr0DDhAcsHvhit/4yNt4ItOvzgPrcaNBhuaQsrDjLnr1S8z8RQWTxI7nOLY4nrJckzuulh4VswmYqVb5KfoDUN4n/NjLAx8GNMAD7xShSigPlYAXlZqgvK5BtYF+8CsAua9I0uORccRtRKrW6FAnKH2e+cUjEaC9BxVDhg28w30Bz00Sp+BUkPqfO2+N/Bzxz+Ciwmxw3hEnXJ14+VCJJvL/WUSzVXMHG1205adYr+ZxVxz5+bihQyl7X5RDzHC858d2PipryrwZXHRfVPv9+ruAw2tzsRYYC6qW5ugbSjsxq/vosV5tKgv4H9iKrUQdpL2U2NpL8XIh7BiQ07KCmRGZRMAq4swRknP2l/QrXam8fTcYdmpmAD8Iu/AHYo0acBUNeumYroviPM4J2dw1Uz+2LVVc8M/hOl16duFg98ZN2ZHuQUpPUsZ3Gdi7sWjWtNgEDcMbWEWjWzqXFvUyd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2fddf7-d0e1-45b2-3039-08d80603089a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 08:08:57.0736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0wEjGKEzZ6HRt+C47krEvHRmLVFetfKeltBML3Dtr6Ie4DECNiTs4oOlqPFLO3/K2D8O3g+Jd4tmCJvnPOiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIFYyIDIvM10gYXJtNjQ6IGR0czogaW14OG06IGFkZCBtdSBu
b2RlDQo+IA0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IFNlbnQ6
IE1vbmRheSwgSnVuZSAxLCAyMDIwIDExOjQzIEFNDQo+ID4NCj4gPiBBZGQgbXUgbm9kZSB0byBs
ZXQgQTUzIGNvdWxkIGNvbW11bmljYXRlIHdpdGggTSBDb3JlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgOSArKysrKysrKysNCj4gPiBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaSB8IDkgKysrKysrKysrDQo+ID4g
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgfCA5ICsrKysrKysrKw0K
PiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpIHwgOSArKysrKysr
KysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gaW5kZXggYWFm
NmU3MTEwMWExLi5mYzAwMWZiOTcxZTkgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+IEBAIC03NzUsNiArNzc1LDE1IEBADQo+ID4gIAkJ
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICAJCQl9Ow0KPiA+DQo+ID4gKwkJCW11OiBtYWls
Ym94QDMwYWEwMDAwIHsNCj4gPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1tdSIsICJm
c2wsaW14NnN4LW11IjsNCj4gPiArCQkJCXJlZyA9IDwweDMwYWEwMDAwIDB4MTAwMDA+Ow0KPiA+
ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDg4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+
ICsJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19NVV9ST09UPjsNCj4gPiArCQkJCWNsb2Nr
LW5hbWVzID0gIm11IjsNCj4gDQo+IFlvdSBtaXNzZWQgbXkgY29tbWVudHMgYWJvdXQgdGhpcyB1
bm5lZWRlZCBsaW5lIGluIHRoZSBsYXN0IHJvdW5kIG9mDQo+IHJldmlldy4NCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEyNDQ3NTIvDQoNCm9vcHMsIHdpbGwgdXBk
YXRlIGluIHYzLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBSZWdhcmRzDQo+IEFpc2hlbmcN
Cj4gDQo+ID4gKwkJCQkjbWJveC1jZWxscyA9IDwyPjsNCj4gPiArCQkJfTsNCj4gPiArDQo+ID4g
IAkJCXVzZGhjMTogbW1jQDMwYjQwMDAwIHsNCj4gPiAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtbS11c2RoYyIsICJmc2wsaW14N2QtdXNkaGMiOw0KPiA+ICAJCQkJcmVnID0gPDB4MzBiNDAw
MDAgMHgxMDAwMD47DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtbi5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW4uZHRzaQ0KPiA+IGluZGV4IDlhNGI2NWEyNjdkNC4uYzgyOTBkMjFjY2M5IDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+ID4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gPiBAQCAtNjc1
LDYgKzY3NSwxNSBAQA0KPiA+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgCQkJfTsN
Cj4gPg0KPiA+ICsJCQltdTogbWFpbGJveEAzMGFhMDAwMCB7DQo+ID4gKwkJCQljb21wYXRpYmxl
ID0gImZzbCxpbXg4bW4tbXUiLCAiZnNsLGlteDZzeC1tdSI7DQo+ID4gKwkJCQlyZWcgPSA8MHgz
MGFhMDAwMCAweDEwMDAwPjsNCj4gPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4OCBJUlFf
VFlQRV9MRVZFTF9ISUdIPjsNCj4gPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTl9DTEtfTVVf
Uk9PVD47DQo+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJtdSI7DQo+ID4gKwkJCQkjbWJveC1jZWxs
cyA9IDwyPjsNCj4gPiArCQkJfTsNCj4gPiArDQo+ID4gIAkJCXVzZGhjMTogbW1jQDMwYjQwMDAw
IHsNCj4gPiAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbi11c2RoYyIsICJmc2wsaW14N2Qt
dXNkaGMiOw0KPiA+ICAJCQkJcmVnID0gPDB4MzBiNDAwMDAgMHgxMDAwMD47DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IGluZGV4IDQ1ZTJj
MGE0ZTg4OS4uYjUzMDgwNGY3NjNlIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gPiBAQCAtNjIxLDYgKzYyMSwxNSBAQA0KPiA+ICAJCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgCQkJfTsNCj4gPg0KPiA+ICsJCQltdTogbWFpbGJv
eEAzMGFhMDAwMCB7DQo+ID4gKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXAtbXUiLCAiZnNs
LGlteDZzeC1tdSI7DQo+ID4gKwkJCQlyZWcgPSA8MHgzMGFhMDAwMCAweDEwMDAwPjsNCj4gPiAr
CQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiAr
CQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUF9DTEtfTVVfUk9PVD47DQo+ID4gKwkJCQljbG9jay1u
YW1lcyA9ICJtdSI7DQo+ID4gKwkJCQkjbWJveC1jZWxscyA9IDwyPjsNCj4gPiArCQkJfTsNCj4g
PiArDQo+ID4gIAkJCWkyYzU6IGkyY0AzMGFkMDAwMCB7DQo+ID4gIAkJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg4bXAtaTJjIiwgImZzbCxpbXgyMS1pMmMiOw0KPiA+ICAJCQkJI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcS5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEu
ZHRzaQ0KPiA+IGluZGV4IDk3OGY4MTIyYzBkMi4uNjZiYThkYTcwNGY2IDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+ID4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCj4gPiBAQCAtOTU5LDYg
Kzk1OSwxNSBAQA0KPiA+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgCQkJfTsNCj4g
Pg0KPiA+ICsJCQltdTogbWFpbGJveEAzMGFhMDAwMCB7DQo+ID4gKwkJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg4bXEtbXUiLCAiZnNsLGlteDZzeC1tdSI7DQo+ID4gKwkJCQlyZWcgPSA8MHgzMGFh
MDAwMCAweDEwMDAwPjsNCj4gPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4OCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4gPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfTVVfUk9P
VD47DQo+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJtdSI7DQo+ID4gKwkJCQkjbWJveC1jZWxscyA9
IDwyPjsNCj4gPiArCQkJfTsNCj4gPiArDQo+ID4gIAkJCXVzZGhjMTogbW1jQDMwYjQwMDAwIHsN
Cj4gPiAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS11c2RoYyIsDQo+ID4gIAkJCQkgICAg
ICAgICAgICAgImZzbCxpbXg3ZC11c2RoYyI7DQo+ID4gLS0NCj4gPiAyLjE2LjQNCg0K
