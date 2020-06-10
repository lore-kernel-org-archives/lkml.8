Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6861C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18AF20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sdUBp91z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgFJKNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:13:05 -0400
Received: from mail-db8eur05on2052.outbound.protection.outlook.com ([40.107.20.52]:8509
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbgFJKNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:13:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnOtelpKpjbUvCUsRbjPZDfmo3jefmtdPa/ieUZtfjPF5OPG5hwz8PJWdY7aPldRMf960wSh0yDZ59BMbSCzyW9/MK/gDHx36FjEiEB5t7fsQmCVmtvX7CoyoHgGEpEhKV5FTobohutGVj7ceto9i6etzJlpvsP6TX8NyHB/i0T3beY1h928D55V25D3I9gvtf8je4b/NM3yD+DTLIxMWW//ig0X6o0RW2Sa0Ahf4hYIfB56ZYD6c8vZD43SXuvw9/wahuPL6lwOc8K09B8Se6mXv4uBJOzQWruIwF6pfdHR7MCUqG9UxvycDCUFd6rYCvsgQMTwbKxwYsgLu06M0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6f1RGokw1hv0lmYvbyzCy9DD4GnOC82wQjVxiW/Cvc=;
 b=L+fM17PJmmrRfLYm34CKeJANYs7AwgIj3p0AmpOInufJsDYBZGlgJYuFwX4GKnL4CJSOZYi2d7pIiiDIdfcHgm6NEZ+RBmXB0eArq6NWFe+b7bz6oSF0D7rHrO8PndATanZkKU1ldvvXZvR/62978W/PTk4GFPbnFQsJ6N1mNAwRw5u2Feihc7CXN/sq97oSPjgyPm06hpaysHtPwFXkcHIldyOquHZKqLTjbgOSzg31wkZ/ihTj2Tqt3s9VfCcRehwrlHp+T/oTzioJ9mAMb4MyJ12hL9hnxQ9/ar2b3ij4qxIyoFispITW30fHiEP/JeLOSEs+Nt7pXi++JMBGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6f1RGokw1hv0lmYvbyzCy9DD4GnOC82wQjVxiW/Cvc=;
 b=sdUBp91zM3LszwlbETMcDHaCGLZ8l5C1t6Ve47xp/0I56U58fZXXgbjs6GgpIOVAEs2euvihlakDBBgFCGwxGYkIJpKOEJzEhG1X0O/zWeVf5eaD57ohNfCYJA0RTrA25v5xHWRer1LfawfQ8C09voNWzTVsqn2f+2fRvTlxcD8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3673.eurprd04.prod.outlook.com (2603:10a6:8:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 10:12:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 10:12:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Topic: [PATCH V2] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Index: AQHWPrCw0WB/imHNuUG5ox2m9H66cKjRezCAgAAAlhCAAA03gIAAGNmQ
Date:   Wed, 10 Jun 2020 10:12:57 +0000
Message-ID: <DB3PR0402MB3916DB340C8BC6BC38035B2BF5830@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1591742515-7108-1-git-send-email-Anson.Huang@nxp.com>
 <DB7PR04MB4972E7B649B935B1EFE6469880830@DB7PR04MB4972.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F5F4C797595437D5FBE5F5830@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <552e1ae9-8b28-a462-5ee8-3e5bd6821c90@nxp.com>
In-Reply-To: <552e1ae9-8b28-a462-5ee8-3e5bd6821c90@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22ecf110-13ff-45ab-facc-08d80d26d949
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3673BFBCC74B1C3CB3488C7AF5830@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4lx+raO2/zvQJ348ZnX+t0i5u1icpVVNm5uP/6gaBbj2W6zyojPflLmmn/cgF6zE2WLClvpJTvJYx0A+SClueLkIFegCVnKcBTkbmoNvMf/lKvLFZFJBLGh6dKxwRDQy5ElCHjK5/OMzsD4Gyk6T/a2Rzlt0S2SlLYCaAoh0GJxofG14RfwJuqAHDPMXGewjMMd1C6k2oBqE+ZT/WYLDwnZ3Pk9th2Bq4A3UCHC13WsjDBTlSd+JYt1MQwPTAkH+bHtOwTA5IDJnP+Yy6R/lI7IhJyxhNM8AVeO5nB9eilWNQWfBxkjQPYYOJ3E6SgOZZ2kkz1gTDKraOHP5E/lfv5TliYw8vttUcsM9uJr5F/Piaa/XkSssO7NqXbIig9SQkA3RIt4tnwjDSKHB07olDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(316002)(55016002)(8676002)(26005)(8936002)(33656002)(110136005)(4744005)(71200400001)(9686003)(86362001)(2906002)(4326008)(64756008)(7696005)(52536014)(53546011)(6506007)(478600001)(66556008)(66476007)(44832011)(186003)(66446008)(76116006)(66946007)(5660300002)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vLae4oBVihueWyzUP3jlDq/fui6VIW5EYrAnBfWHUSzULw9Zr8qJuk2Q8JHoPbgzX6GsKE9Yz/7RKl6U1LoQ2YjnSbEO69lDtdJeOE/6VsuAQZr/ItSUeEp49ietlZlFJW6j3FqWdkZNerHMDGc+YkIsXvLLd8+30uoAMJo245TdMoNQ8mOOjDHmnI+CN4EBHxGyHkTRKVVNZpJVHs0Tr/7Rxu9VEIhm3g9rpTsYwwSRYl55Tn9YqdJZNjhhm4lDLR+3f0mGnjt/ylyhbQFMMByIS8MoQsBkoeZJM13WF+3FEBSvPxGA83IBwBPeUA2hLqgdTpB7BWmFfX2M30W07znU261ewtapSxkVukiYmMItdYoDI2fJPIUFFq5RZLCW/6khVw6HNKyQrJ525LnEvOULzBL8BojM8neW5iou7ss7vS3QDPBDa6GPf+VkS8g3WQrzVwPkp577Z2G5BFx+4NmAOO/rVeDuaHeUyePzMHH1t1YE4v4JIW6eNdLnFtEa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ecf110-13ff-45ab-facc-08d80d26d949
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 10:12:57.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysBB6X5I7d3MBXJ7msBTTqTai/gS2B9U0jKQwyjmvZbn1Bryuz+2Zo5B558Bp9Mk3ksHLOPkCxeWz7feNedong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1bGlhbmENCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBzb2M6IGlteDhtOiBDb3Jy
ZWN0IGkuTVg4TVAgVUlEIGZ1c2Ugb2Zmc2V0DQo+IA0KPiANCj4gDQo+IE9uIDYvMTAvMjAyMCAx
MDo1NyBBTSwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4NCj4gPj4gU3ViamVjdDogUkU6IFtQQVRD
SCBWMl0gc29jOiBpbXg4bTogQ29ycmVjdCBpLk1YOE1QIFVJRCBmdXNlIG9mZnNldA0KPiA+Pg0K
PiA+Pj4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4+PiBTZW50
OiBXZWRuZXNkYXksIEp1bmUgMTAsIDIwMjAgNjo0MiBBTQ0KPiA+Pj4NCj4gPj4+IENvcnJlY3Qg
aS5NWDhNUCBVSUQgZnVzZSBvZmZzZXQgYWNjb3JkaW5nIHRvIGZ1c2UgbWFwOg0KPiA+Pj4NCj4g
Pj4+IFVJRF9MT1c6IDB4NDIwDQo+ID4+PiBVSURfSElHSDogMHg0MzANCj4gPj4+DQo+ID4+PiBG
aXhlczogZmM0MDIwMGViZjgyICgic29jOiBpbXg6IGluY3JlYXNlIGJ1aWxkIGNvdmVyYWdlIGZv
ciBpbXg4bQ0KPiA+Pj4gc29jDQo+ID4+PiBkcml2ZXIiKQ0KPiA+Pg0KPiA+PiBBRkFJSyAiRml4
ZXM6IiBzaG91bGQgcG9pbnQgdG8gdGhlIG9yaWdpbmFsIHBhdGNoIHdoaWNoIGludHJvZHVjZWQg
dGhlIGlzc3VlLg0KPiA+PiBOb3QgdGhlIG9uZSBjaGFuZ2luZyBmaWxlIG5hbWUuDQo+ID4NCj4g
PiBCdXQgdGhlIHBhdGNoIGNhbiBOT1QgYmUgYXBwbGllZCB0byB0aGUga2VybmVsIHZlcnNpb24g
d2l0aCBvcmlnaW5hbA0KPiA+IGZpbGUsIGhvdyB0byBmaXggaXQ/DQo+ID4NCj4gSSBiZWxpZXZl
IHlvdSBjYW4gYWRkIHR3byAiRml4ZXM6IiB3aXRoIHRoZSB0d28gY29tbWl0czogdGhlIG9uZSBp
bnRyb2R1Y2luZw0KPiB0aGUgaXNzdWUgYW5kIHRoZSBvbmUgY2hhbmdpbmcgdGhlIGZpbGUgbmFt
ZS4NCg0KVGhhbmtzLCB3aWxsIGFkZCBvbmNlIG1vcmUgZml4IHRhZywgcGxlYXNlIGhlbHAgcmV2
aWV3IFYzLg0KDQpBbnNvbg0K
