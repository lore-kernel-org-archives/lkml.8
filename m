Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B987C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 04:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07FB2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 04:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AQaADcVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgDZEnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 00:43:23 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:36198
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbgDZEnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 00:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVN/1lTCtI9puWPmSvX6p63DYM1fDNboCQt4daOMdBn8XfuYiPFHtTVzAdWciWkp453H942WehJ84x4Fv9PtDSHS51rRkv/3NSr9TyvKgHd60RshAj35lYQ8iO4FL1uDFUPS5p3OWedvz5/hKuSLq+CHos3mIWmC56YhxdgZvwoOzkMtdwLZQo7zuXfpQ1xEgou3uLFlrngrgrp9vaPp4piHZVFndMNqPJcLNp6FrplYiwSp8DB5+/KyFS2e6bDXo9uo7U7qCA9AoJh1AM4jQTDFSQEQmRNFkkv9O89waBiYKpBVrhJA+CLJxse4R217ZJgn8eLGSNdj7yDrkCeUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWmDZIdghu5Vyaw36MYmxiG8kPFQRGDHONhyCw5t2nQ=;
 b=SWOibPqawBIMVWbGKujaoM37z/IpEDxF+UvBeRAJCEgM/8QzebPWp7pSlSApZDumaCbjMFSUROrxQug2tEH3NH/fGjMk/qoTHOZ/G6Wc88dq/h8oRt/KNSTOLnLjmZaspIFw+/59Oq2mRN/6+P8dOx+9VbBNSk7qrBOVyWESen+aoLJkdgpATm7bDwWb/Bj3+L9L/Xp49Nr2AhWA743LLn5YM1q4QRfBJanvzq66xDDN/RWvVU9kpScBhbucZK851M5WuYrz/AGhLeRogpmuUW/ulEyFq5o1fqDXbARsvxOeMY3v370wp5m4V6WFj5saRdlZCmd/D3YAon8geKyRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWmDZIdghu5Vyaw36MYmxiG8kPFQRGDHONhyCw5t2nQ=;
 b=AQaADcVGEa9AQh6S/7xIgeL4ffSJNo4U5liqOZSpGN32a9cEckJWG5WOpQ/uMtjS944RwhfLoT7jZbFNrRZTSsb8vRJadn3kcygCmefiLVDJGuMix0U3hqJtB+x93GsXdcKTxjGfJOh62CNf+stIZUIiuLWUCDNi7NRJWCly/lw=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5589.eurprd04.prod.outlook.com (2603:10a6:20b:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 04:43:17 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 04:43:17 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 06/10] clk: imx8m: migrate A53 clk root to use
 composite core
Thread-Topic: [PATCH V2 06/10] clk: imx8m: migrate A53 clk root to use
 composite core
Thread-Index: AQHV+FjL9xTJNMAdE0mjNiD58Y5PKKiLGQOg
Date:   Sun, 26 Apr 2020 04:43:17 +0000
Message-ID: <AM6PR04MB49664159E56A48EC6C4CBCC880AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-7-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584008384-11578-7-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1fdfa35-bbce-4e22-8a21-08d7e99c56cf
x-ms-traffictypediagnostic: AM6PR04MB5589:|AM6PR04MB5589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5589EC861E851AB3DDBB83C680AE0@AM6PR04MB5589.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(9686003)(110136005)(54906003)(81156014)(316002)(8676002)(8936002)(5660300002)(44832011)(33656002)(6506007)(52536014)(55016002)(478600001)(86362001)(186003)(2906002)(26005)(66446008)(7696005)(76116006)(66946007)(66556008)(66476007)(64756008)(71200400001)(7416002)(4326008)(6636002)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kysfSPTxuQF/aOWBRusZd227d2M32kmndBBq3bhJPDVJFLFo/0pi8Yb6IfVtGRax0Z8JmODjsCmumzHzGGxyH3u4y4BA+BCkTJUEdXq1qIjz9F6JxTk/fDkAUBwEm4Lzf80GBT33h6xYWcyWZC+7FxP8y1FHp9dOBvqitA9jRoTgvdpi8cK8J4zt/cud3Apgywt52ZYVBobF19m7rskBbnrr6s5twomUKKNtdIF5nzcIea3xXAfvXxflpEACJTkV72uW6yqn4tdbIEgGwhiw7RmHH4BvdKS8ccYm5UNZu8vI/XjW3T5jl9m2K3V2anSub4tKgLd/zcnIOs4CA496wMQofh9r3EX1p8oxPlzYx+YOyptql0zZk3525oESI3yglwPH/r3tdRFFfciwWgrY16d/HUB4YTHU1hsSz6IpKmrX8fdcxnxi106xwv6RWqo2rO6zTM7I6aBWWL/KHX0tMWzAT5wJZJg9P9R/XWEHT0iTwoz5rC1lXZ7m1SNZ0vQ2
x-ms-exchange-antispam-messagedata: pbbPPlmhVcTGuHAIalLnRjIt/GsBgwN0JXrlGmedZqh5MaqpYVdCgbTRXomojpIjTZJt70ffYwn47ShM5eRBd+2vDrSFwOg+E2BlgHrQ929s+BWt6JBvUr+H5Pai96ni/6uRPodJbhVpJzw8Y3Kr/5N662I4Q9xz5TiOUhzokEbFe5Qb5UdTdGG/PpirCc36t9zBbie2DAxqsk1Gy73Mf6ikuRJI8c4d9lrdU+VYNVZlWCl+49jwxKaQafghhc5CHEsSJ1kQx/yNxh6d/6Yxm3B7hYHZZkUWQ23SsjfL5zraVuobaf2lU+KwwPl3zVx8J8OOfEa5fhMWXTSXe7+Ry5N6aLNmh7CDw4+xOIkZZxN5tQbb2HRz5s15JyGewLyPoAysu4ejzKT5e3G9pRRakSfRlwrC+5hyroeyzFJONQ4slTFRb68fLrBbRshMMcTO6k54hOZj5gYRNTQTCVTMRUABrGhaP4B9qrAZlV+CDnPmxjAG1/WIJ2ETveLPPcx2KKf3ny8Gv2MQGzgN84qBqxJ2k3GldGyRF6gFLqYDeooQ68ku2l6jyaAzMGiR3OHTBbT2CAVMkaIe3gbsXmlDXFspYL4Q54To/rgUW9raPqKdjQcGnRWjdkx5IA4b31oVxKNt+EazQstfwsvOqc8cmuAh7GNTX2/i/DQ6koT+jVQSIBgKVt4PldSplrjbBy4WlSJT1ulblDLk8hELB4WHIFmx9Ae63sSNO0qOH2qv44ksBPLOhcPX3aLlIEpe3FZvZvBJsVrEcV/fheCSYzJoMDXruNVXHsNswa3bDiJ4D1o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fdfa35-bbce-4e22-8a21-08d7e99c56cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 04:43:17.5637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juLxq03jbTFNRuUWcujAmHd8xje2zzQlQWeJr4Mnc0a8xBwbvmtLIOeQqsAJS6Y3J9j66PsStVHtH5CMgkqzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDEyLCAyMDIwIDY6MjAgUE0NCj4gDQo+IE1pZ3JhdGUgQTUzIGNsayByb290IHRvIHVzZSBj
b21wb3NpdGUgY29yZSBjbGsgdHlwZS4gSXQgd2lsbCBzaW1wbGlmeSBjb2RlIGFuZA0KPiBtYWtl
IGl0IGVhc3kgdG8gdXNlIGNvbXBvc2l0ZSBzcGVjaWZpYyBtdXggb3BlcmF0aW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYyB8IDYgKysrLS0tICBkcml2ZXJzL2Nsay9pbXgvY2xr
LWlteDhtbi5jIHwgNg0KPiArKystLS0gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OG1xLmMgfCA2
ICsrKy0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYyBiL2Ry
aXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMgaW5kZXgNCj4gNTQzNTA0MmEwNmUzLi4xMjQ0M2Uw
NmYzMjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMNCj4gKysr
IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYw0KPiBAQCAtNDE2LDkgKzQxNiw5IEBAIHN0
YXRpYyBpbnQgaW14OG1tX2Nsb2Nrc19wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihiYXNlKTsNCj4gDQo+ICAJLyogQ29yZSBTbGljZSAq
Lw0KPiAtCWh3c1tJTVg4TU1fQ0xLX0E1M19TUkNdID0gaW14X2Nsa19od19tdXgyKCJhcm1fYTUz
X3NyYyIsIGJhc2UgKw0KPiAweDgwMDAsIDI0LCAzLCBpbXg4bW1fYTUzX3NlbHMsIEFSUkFZX1NJ
WkUoaW14OG1tX2E1M19zZWxzKSk7DQo+IC0JaHdzW0lNWDhNTV9DTEtfQTUzX0NHXSA9IGlteF9j
bGtfaHdfZ2F0ZTMoImFybV9hNTNfY2ciLA0KPiAiYXJtX2E1M19zcmMiLCBiYXNlICsgMHg4MDAw
LCAyOCk7DQo+IC0JaHdzW0lNWDhNTV9DTEtfQTUzX0RJVl0gPSBpbXhfY2xrX2h3X2RpdmlkZXIy
KCJhcm1fYTUzX2RpdiIsDQo+ICJhcm1fYTUzX2NnIiwgYmFzZSArIDB4ODAwMCwgMCwgMyk7DQo+
ICsJaHdzW0lNWDhNTV9DTEtfQTUzX0RJVl0gPQ0KPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2Nv
cmUoImFybV9hNTNfZGl2IiwgaW14OG1tX2E1M19zZWxzLCBiYXNlICsNCj4gMHg4MDAwKTsNCj4g
Kwlod3NbSU1YOE1NX0NMS19BNTNfQ0ddID0gaHdzW0lNWDhNTV9DTEtfQTUzX0RJVl07DQo+ICsJ
aHdzW0lNWDhNTV9DTEtfQTUzX1NSQ10gPSBod3NbSU1YOE1NX0NMS19BNTNfRElWXTsNCg0KVGhl
IGZvcm1lciBwYXRjaCBhbHJlYWR5IGJyZWFrcyB0aGUgY29tcGF0aWJpbGl0eS4NCk5vdCBzdXJl
IGlmIHdlIHJlYWxseSBuZWVkIGtlZXAgaXQgZm9yIG9ubHkgQTUzIGNsb2NrIGhlcmUgYXMgd2Ug
YXJlIHN0aWxsIGF0IHZlcnkgZWFybHkgZW5hYmxlbWVudA0KUGhhc2UgZm9yIE1YOE1QLiAgU28g
d2UgbWF5IGp1c3QgcmVtb3ZlIHRoZW0gSU1ITy4NClNoYXduLCB3aGF0J3MgeW91ciBzdWdnZXN0
aW9uPw0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gDQo+ICAJaHdzW0lNWDhNTV9DTEtfTTRfQ09S
RV0gPQ0KPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2NvcmUoImFybV9tNF9jb3JlIiwgaW14OG1t
X200X3NlbHMsIGJhc2UgKw0KPiAweDgwODApOw0KPiAgCWh3c1tJTVg4TU1fQ0xLX1ZQVV9DT1JF
XSA9DQo+IGlteDhtX2Nsa19od19jb21wb3NpdGVfY29yZSgidnB1X2NvcmUiLCBpbXg4bW1fdnB1
X3NlbHMsIGJhc2UgKw0KPiAweDgxMDApOyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Ns
ay1pbXg4bW4uYw0KPiBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1uLmMgaW5kZXggNmNhYzZj
YTAzZTEyLi5iZDM3NTliNGFmZDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14OG1uLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW4uYw0KPiBAQCAtNDEz
LDkgKzQxMyw5IEBAIHN0YXRpYyBpbnQgaW14OG1uX2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCX0NCj4gDQo+ICAJLyogQ09SRSAqLw0KPiAtCWh3c1tJ
TVg4TU5fQ0xLX0E1M19TUkNdID0gaW14X2Nsa19od19tdXgyKCJhcm1fYTUzX3NyYyIsIGJhc2Ug
Kw0KPiAweDgwMDAsIDI0LCAzLCBpbXg4bW5fYTUzX3NlbHMsIEFSUkFZX1NJWkUoaW14OG1uX2E1
M19zZWxzKSk7DQo+IC0JaHdzW0lNWDhNTl9DTEtfQTUzX0NHXSA9IGlteF9jbGtfaHdfZ2F0ZTMo
ImFybV9hNTNfY2ciLA0KPiAiYXJtX2E1M19zcmMiLCBiYXNlICsgMHg4MDAwLCAyOCk7DQo+IC0J
aHdzW0lNWDhNTl9DTEtfQTUzX0RJVl0gPSBpbXhfY2xrX2h3X2RpdmlkZXIyKCJhcm1fYTUzX2Rp
diIsDQo+ICJhcm1fYTUzX2NnIiwgYmFzZSArIDB4ODAwMCwgMCwgMyk7DQo+ICsJaHdzW0lNWDhN
Tl9DTEtfQTUzX0RJVl0gPQ0KPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2NvcmUoImFybV9hNTNf
ZGl2IiwgaW14OG1uX2E1M19zZWxzLCBiYXNlICsNCj4gMHg4MDAwKTsNCj4gKwlod3NbSU1YOE1O
X0NMS19BNTNfU1JDXSA9IGh3c1tJTVg4TU5fQ0xLX0E1M19ESVZdOw0KPiArCWh3c1tJTVg4TU5f
Q0xLX0E1M19DR10gPSBod3NbSU1YOE1OX0NMS19BNTNfRElWXTsNCj4gDQo+ICAJaHdzW0lNWDhN
Tl9DTEtfR1BVX0NPUkVdID0NCj4gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9jb3JlKCJncHVfY29y
ZSIsIGlteDhtbl9ncHVfY29yZV9zZWxzLCBiYXNlICsNCj4gMHg4MTgwKTsNCj4gIAlod3NbSU1Y
OE1OX0NMS19HUFVfU0hBREVSXSA9DQo+IGlteDhtX2Nsa19od19jb21wb3NpdGVfY29yZSgiZ3B1
X3NoYWRlciIsIGlteDhtbl9ncHVfc2hhZGVyX3NlbHMsIGJhc2UNCj4gKyAweDgyMDApOyBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYw0KPiBiL2RyaXZlcnMvY2xrL2lt
eC9jbGstaW14OG1xLmMgaW5kZXggMjAxYzdiYmIyMDFmLi45MTMwOWZmNjU0NDEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1xLmMNCj4gKysrIGIvZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg4bXEuYw0KPiBAQCAtNDA1LDkgKzQwNSw5IEBAIHN0YXRpYyBpbnQgaW14OG1x
X2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCQlyZXR1
cm4gUFRSX0VSUihiYXNlKTsNCj4gDQo+ICAJLyogQ09SRSAqLw0KPiAtCWh3c1tJTVg4TVFfQ0xL
X0E1M19TUkNdID0gaW14X2Nsa19od19tdXgyKCJhcm1fYTUzX3NyYyIsIGJhc2UgKw0KPiAweDgw
MDAsIDI0LCAzLCBpbXg4bXFfYTUzX3NlbHMsIEFSUkFZX1NJWkUoaW14OG1xX2E1M19zZWxzKSk7
DQo+IC0JaHdzW0lNWDhNUV9DTEtfQTUzX0NHXSA9IGlteF9jbGtfaHdfZ2F0ZTNfZmxhZ3MoImFy
bV9hNTNfY2ciLA0KPiAiYXJtX2E1M19zcmMiLCBiYXNlICsgMHg4MDAwLCAyOCwgQ0xLX0lTX0NS
SVRJQ0FMKTsNCj4gLQlod3NbSU1YOE1RX0NMS19BNTNfRElWXSA9IGlteF9jbGtfaHdfZGl2aWRl
cjIoImFybV9hNTNfZGl2IiwNCj4gImFybV9hNTNfY2ciLCBiYXNlICsgMHg4MDAwLCAwLCAzKTsN
Cj4gKwlod3NbSU1YOE1RX0NMS19BNTNfRElWXSA9DQo+IGlteDhtX2Nsa19od19jb21wb3NpdGVf
Y29yZSgiYXJtX2E1M19kaXYiLCBpbXg4bXFfYTUzX3NlbHMsIGJhc2UgKw0KPiAweDgwMDApOw0K
PiArCWh3c1tJTVg4TVFfQ0xLX0E1M19DR10gPSBod3NbSU1YOE1RX0NMS19BNTNfRElWXTsNCj4g
Kwlod3NbSU1YOE1RX0NMS19BNTNfU1JDXSA9IGh3c1tJTVg4TVFfQ0xLX0E1M19ESVZdOw0KPiAN
Cj4gIAlod3NbSU1YOE1RX0NMS19NNF9DT1JFXSA9DQo+IGlteDhtX2Nsa19od19jb21wb3NpdGVf
Y29yZSgiYXJtX200X2NvcmUiLCBpbXg4bXFfYXJtX200X3NlbHMsIGJhc2UNCj4gKyAweDgwODAp
Ow0KPiAgCWh3c1tJTVg4TVFfQ0xLX1ZQVV9DT1JFXSA9DQo+IGlteDhtX2Nsa19od19jb21wb3Np
dGVfY29yZSgidnB1X2NvcmUiLCBpbXg4bXFfdnB1X3NlbHMsIGJhc2UgKw0KPiAweDgxMDApOw0K
PiAtLQ0KPiAyLjE2LjQNCg0K
