Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7A9207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NmX7BM/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgG2XvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:51:12 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:30467
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726876AbgG2XvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:51:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+1UNMTGO/hitByClA9pLYqnvFuSiKMVFjTZjvjAMqFktmp01aFs2RFeeauvf79qXpM+nZLSCMCZgHOZ76KOc+UgppeuMjnSNgJN4T+ZY63U/Y4+pn7vdxc3oAxzxzGsHOy6hwDkJXdQlZ6zyY0a4xyslOU4Aw7fBK5oZuspTFb4VKfhfMbpCcoqOw3rfcMvLqgf4Vc3mgL4shXImwFW9AKC73ywPOmd5mDLhlDKqU4m/PBIpkv2ZegNPYQp+TedGfGLOlyCJoVOWlXYnYtfY0Z6bYupWFMI0DzIcpjXfr3gO4w58e2PxRsU1U/VhGM15600494+P+bMVdLs/IQNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+Q7O0x4R2XnVyY/meEyQk+e1m9Ia8FTzFiwCSObr94=;
 b=VYZ+fIjG22D0LnmP6rMDlYfPK3mcRMTYKS24Z9jZtNDTDlNWO0vTFeEakq4l7v2DxR3uB7H9aF8O1UmhE1TQkxFdauvP306nh1wzRBYFSUNIC5V8elwuNyCc8K8Ou5z3UPR6StGFjnqbvHCEgpYrR9pJpiNDSbWTDQUWebeAe80ALLZEvjgj2ExL4uSwFY5lBv6i1pFTAZ4C8ALj0d9PAg6nVdkH1rIE3Ku1qzxnRf75OymZ37SXkdBJboq6bve5ush4p4yi2QaDoPg+Eq760lJIVUYZkhyDF0/4bOfYyzp1E2GHY+sdm/F+titblWlkdQhpIF2Y4msmKrNJ2iaf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+Q7O0x4R2XnVyY/meEyQk+e1m9Ia8FTzFiwCSObr94=;
 b=NmX7BM/TcDAw7aX4nxHw5k9xvRt42Snse3eOYfVEGnrSipimi5wCJYvcBYI4P0XGTcA6wTBGDQi692TDOk54apb6DHWaynVT9RN4sQcXl3ZtNLS//sW+J7Dwe1YD5fQAuMJKxLQlp1nsjBfmJ6p6uBocUKx523GVuo0oidae/YY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR04MB3125.eurprd04.prod.outlook.com (2603:10a6:6:11::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 23:51:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3%6]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 23:51:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
 32-bit value by 31 bits
Thread-Topic: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
 32-bit value by 31 bits
Thread-Index: AQHWZbf31I7BtnmqO0Gipqqw0aCR4aketDaAgACFjvA=
Date:   Wed, 29 Jul 2020 23:51:06 +0000
Message-ID: <DB3PR0402MB3916559F7E1908D76B47FE66F5700@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
 <1596034117-24246-2-git-send-email-Anson.Huang@nxp.com>
 <86ae1d4e-27c9-07e4-73be-37d490cb0063@infradead.org>
In-Reply-To: <86ae1d4e-27c9-07e4-73be-37d490cb0063@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.18.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03e93e7b-6960-4a22-1c9b-08d8341a42c3
x-ms-traffictypediagnostic: DB6PR04MB3125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3125741357FC849AFE9C8652F5700@DB6PR04MB3125.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7s/emRA2S5nu9HTz9cnefoVYWkIk4lxKL3MOq/JW+gQ0SsDfWjVdOhRMldK07tcI1LFhAd7j5rJ+NmDNokqqhgn4+b2Kf0xZmKHNGDHCaDQ9VZ1XttU0iR/x3ipSRPwYM5f9NU7D2pMHvUoUwOh9jgpKEYjC0sQY7fklS6EfLBRMVoKnYO+KGcrKIZGYpLYZmJh7PLOgs5P4RUhY8wNh4e23i1zhnaT7jwjzhVPpkuToxEz6I0J3yd3XWCF0ZHe1etvNW0LPII8l+0x4oblvhiy7veXFdmd9P0kZgZldTVWtAxczi9oerLYx2Ozmd+fJGHNVe0LegaqaQT7WHX8qHvK90Q5qgJHsk3s999XSAfc5vDJoydreE8JOlMbDZ6CPSCk4CpLDVCo0zy5AIEO9QQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(2906002)(66946007)(71200400001)(86362001)(76116006)(66476007)(66556008)(66446008)(64756008)(7416002)(83380400001)(44832011)(55016002)(7696005)(4326008)(52536014)(8936002)(53546011)(186003)(110136005)(5660300002)(316002)(33656002)(478600001)(8676002)(9686003)(26005)(6506007)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gGnZNYv32iRhNRu4urqVoCuGc4zsw6FsMSTuaom0A6nShoRGSime919uT8FgqNl6/OwFg1r8Ev6b++2t6+sbq+QY0lPOCxP7cockayE9mgIbY8oakM4KFI0G7Nuzx/7Z2QjkV05BthtJ5MtPqWl4zpsJXEKnQRL31Pn1Rvr6SRMcwwVwif9vnS6a7ng5hoA4su3eMRIp8fgLBgRL6plscs9aV0z7lV0qJD1MRFmBS+sURtcGFTr7Qf8fKwWasVxt7O4J/NyghRaIzHmk8K4gG12FQMW2rD0ukMFUggpiBmjfqxkTsA3Ij0o0qPmr8s4VKBJoi0AaoXK4a3APFVwMcacnBF9nx/a30OvWyk/lUYpRQKfK5uoFKr1b4WB8P33/z0AG5enqyjbtOOcJKw3/akIu/rgbjUoJKwleCNmjIFm9z1pvd5Nqgyc6x7fuZoimKXAIlgglwVlKP9AODdqDHKI6X1Qio1F1+rLy5gqzaP+pURZHHJTz/vb6zSsqHfX2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e93e7b-6960-4a22-1c9b-08d8341a42c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 23:51:06.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tp38rjm63Zk5ukwWdR4YA3yLvvdWaT2EZA+pwfXIySvhgKvne7VM0TNVpimqyLikTQp62oS4qNlQiy0u3rw69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJhbmR5DQoNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY3IDEvNl0gY2xrOiBpbXg2c2w6
IFVzZSBCSVQoeCkgdG8gYXZvaWQgc2hpZnRpbmcgc2lnbmVkDQo+IDMyLWJpdCB2YWx1ZSBieSAz
MSBiaXRzDQo+IA0KPiBPbiA3LzI5LzIwIDc6NDggQU0sIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IFVzZSByZWFkbF9yZWxheGVkKCkgaW5zdGVhZCBvZiBfX3Jhd19yZWFkbCgpLCBhbmQgdXNlIEJJ
VCh4KSBpbnN0ZWFkDQo+ID4gb2YgKDEgPDwgWCkgdG8gZml4IGJlbG93IGJ1aWxkIHdhcm5pbmcg
cmVwb3J0ZWQgYnkga2VybmVsIHRlc3Qgcm9ib3Q6DQo+ID4NCj4gPiBkcml2ZXJzL2Nsay9pbXgv
Y2xrLWlteDZzbC5jOjE0OTo0OTogd2FybmluZzogU2hpZnRpbmcgc2lnbmVkIDMyLWJpdA0KPiA+
IHZhbHVlIGJ5IDMxIGJpdHMgaXMgdW5kZWZpbmVkIGJlaGF2aW91ciBbc2hpZnRUb29NYW55Qml0
c1NpZ25lZF0NCj4gPiAgICAgIHdoaWxlICghKF9fcmF3X3JlYWRsKGFuYXRvcF9iYXNlICsgUExM
X0FSTSkgJg0KPiBCTV9QTExfQVJNX0xPQ0spKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5z
b24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2UgVjY6
DQo+ID4gCS0gaW1wcm92ZSB0aGUgc3ViamVjdC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg2c2wuYyB8IDE1ICsrKysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnNsLmMNCj4gPiBiL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14NnNsLmMgaW5kZXggMGY2NDdkMS4uZTY5ZGJhMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDZzbC5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg2
c2wuYw0KPiA+IEBAIC0zLDYgKzMsNyBAQA0KPiA+ICAgKiBDb3B5cmlnaHQgMjAxMy0yMDE0IEZy
ZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+ID4gICAqLw0KPiA+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9iaXRmaWVsZC5oPg0KPiANCj4gSGksDQo+IEkgdGhpbmsgeW91IHdhbnQNCj4gI2lu
Y2x1ZGUgPGxpbnV4L2JpdHMuaD4NCj4gDQo+IGZvciBCSVQoKSB1c2FnZS4NCg0KQWN0dWFsbHks
IHRoZSBsaW51eC9vZi5oIGFscmVhZHkgaW5jbHVkZXMgbGludXgvYml0b3BzLmggYW5kIGxpbnV4
L2JpdG9wcy5oIGluY2x1ZGVzDQpsaW51eC9iaXRzLmgsIHNvIEkgd2lsbCBqdXN0IGRyb3AgbGlu
dXgvYml0ZmllbGQuaCBhbmQgc2VuZCBhIFY4Lg0KDQpUaGFua3MsDQpBbnNvbg0KDQoNCg0KDQo=
