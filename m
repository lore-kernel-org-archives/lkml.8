Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE50D2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DceBcZ1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgFIWnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:43:41 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:32847
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728108AbgFIWnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETtyLwsIxfBLQU0eF9kTzBMlzO6fzf8+J+v39M42MNQ7Haz0+fs08qrmWkdNIyqqSj+d6mDiKFe6Eo0RdHBF5v0jeKwfbLSeCcXKInVcdkA6B6rXPo1vTdEUt8bIt31nJl8sX+66kCSq48Sa6BFGyFLLUPncMp7JuM/TmN8zAdY0tMVU7qyLi/wxYy+OVIEV4zEs9hTzBiTzIRMp08uvMmCRsgWXWcOZfdkhU+xxFaPG9iX1KyaXCa2IBJRvmVuiIcATmYWFh4uGCU1LkPQMnPhuSm03ECCApqbAOhccbwNz/ny2uehZrG5l09hKuGXX4OyBLfT2fYfBC36uuNyAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76pythL2MHjwVGj0gi9EC9u+OlMwtLiL3GKiFmOdKVs=;
 b=MIOi6Zf5z8MryG4uMva7+wPeeJrQFjwvbxXElB1gCYUs7YzsWTiREr4bR+F3njzp/9xxher5gEv/nhea3kHv9NFFaRx8YGzkvXjmbB4Xoh3gPOYeX0jtckyI9mas4yK0EIy96Wau0Kalf1aS86KhHUWagLgzmHNAlUAbrKSjPxRywF1nFWGDCbVVUvo9dCW+HtfgsT+90EscLvv5cVYaVk1mwl9zU8Xch2L9uw+/sQalhhSM8xJEf9ePX2CBAxq9RrfJsTl7htFJyUARYm2cALX7Ex2H77fMw69WUoAXGGih+yYjPJN0zf1U2Jn95hXD980P5ul+PVKgCBttwe24KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76pythL2MHjwVGj0gi9EC9u+OlMwtLiL3GKiFmOdKVs=;
 b=DceBcZ1RaOpDsWWTZAZ10fSWql7PPVlJBWuwvf4lIKMi317ojh55zl/CAVutTGvxqs5vxvc/DMdNEZWunf6dtHThOI+WxQwtv/X1YHWYfig6hbvvlnPXu3rOaWhWn8EQUmfd3KAmIQgN06ILl2a2zkid3WwEU1BV9it7Nfok0vw=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by AM0PR0402MB3924.eurprd04.prod.outlook.com (2603:10a6:208:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 22:43:37 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::bde6:6e57:8c23:79ae]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::bde6:6e57:8c23:79ae%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 22:43:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>,
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
Subject: RE: [PATCH] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Topic: [PATCH] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Index: AQHWPmGaLCVYIW/uG0iQCSK/g/UPiajQZy+AgAB5hxA=
Date:   Tue, 9 Jun 2020 22:43:36 +0000
Message-ID: <AM0PR0402MB3905F42A025BF12B1D6B26A0F5820@AM0PR0402MB3905.eurprd04.prod.outlook.com>
References: <1591708550-14058-1-git-send-email-Anson.Huang@nxp.com>
 <7a4091c5-dc57-31c3-3445-c6b16a565928@nxp.com>
In-Reply-To: <7a4091c5-dc57-31c3-3445-c6b16a565928@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4c9a603-a203-4da8-5e1a-08d80cc68c4e
x-ms-traffictypediagnostic: AM0PR0402MB3924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB39242E70E461B1B83FA198CBF5820@AM0PR0402MB3924.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OcoR3ZrsVGs/tlHik9dXnnD40lF/3eNPV8sHqYGyFkxbLiMJQsTsIuXK9QQlB9iRoOVcEU0a9fCDKo1bh2zH5aat2JVU7fB1NrvjQpgy24DXm5R3EFhKlJlVEtcPKYK1IykzpbvxgHOZoV1dJgZBV+Jmt7XLXiacHWUhZOTLcVi1+AGJFVcpgcK+Z3uF2sGst0Wzup8IMMWfQInwOapEKRkmxJs3Q7ou0YAU+QGbpr4gEOoPUZDjD5tmv5aNYVH5aryK8qdAQOdiNWLghF1fk4wWYb2CJotSB1iVIU05RVtIRpXOp6HDMobltnbkiB4wL0SMGjpVZawR81BdRWEFtwaBcw8GUEml/A/nPmdiWMSnwvuoSIUIgeb69q+tb96uxWMM6JWGuLYPE1cu3ttZPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(478600001)(316002)(110136005)(71200400001)(33656002)(52536014)(2906002)(7696005)(66446008)(8936002)(4744005)(44832011)(66946007)(5660300002)(4326008)(8676002)(55016002)(6506007)(64756008)(86362001)(9686003)(26005)(186003)(53546011)(76116006)(66476007)(66556008)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uRwW5wXv0YFpFOTxecBEwmOa9EilqqfYEorYrZoaocl7yHgIbSYyx+ywt3EoNGJFZmdV8oelvCw09d5ehFzxtprpB6gKes3yNuobC/v0q21uoCX7zAbybpAAN9sg8rqUpaeO1rTlrlcdvQzyXucr+OiSX4TpbbYpEhASTS1+jyus0h+Ipb4mDT/MEqa8z7kOzkTQjTbp+KUVkVydOsudSpQ9Hch3WhssQnxLq1cceXycAnBe4Ii6hC2cNPdogboKDX9mEt4P75JhCH/snWZmWah5DiRlHUSJBoA7LraMCRg3Mnmlalbc/yp1LmBhHqT0NzE6BRzOrIHhLuquQ+h4Ql4vrLHWu4CyZs7JkjER080lTFlIXRk4WOFJkNAuTGQWxf4xX/7ynOdQKZnRKJbD0EASbW9YhhIxh9/zQdf9y7DQzpxrrkZlV/a4JMMak/YJKgbkw5Uyv/HYSwhHVbug0mOFS2iySMqLu1dCo5YBpbMCXi9QM7Sn6IKx1+C0u7EZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c9a603-a203-4da8-5e1a-08d80cc68c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 22:43:36.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWVskxgNnwuKfam1ZGQTAGEdkkzfu5hp32xs2pl4LbAmeXXPhXbprjacDTxy6/KX4AwRgh9rjQH42Oif/V+7NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3924
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1bGlhbmENCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNvYzogaW14OG06IENvcnJl
Y3QgaS5NWDhNUCBVSUQgZnVzZSBvZmZzZXQNCj4gDQo+IA0KPiANCj4gT24gNi85LzIwMjAgNDox
NSBQTSwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gQ29ycmVjdCBpLk1YOE1QIFVJRCBmdXNlIG9m
ZnNldCBhY2NvcmRpbmcgdG8gZnVzZSBtYXA6DQo+ID4NCj4gPiBVSURfTE9XOiAweDQyMA0KPiA+
IFVJRF9ISUdIOiAweDQzMA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFu
c29uLkh1YW5nQG54cC5jb20+DQo+IA0KPiBJZiB0aGlzIHBhdGNoIGNvcnJlY3RzIHRoZSBpbXg4
bXAgVUlEIHNob3VsZG4ndCBoYXZlIGEgRml4ZXMgdGFnPw0KDQpJIHRob3VnaHQgYWJvdXQgdGhp
cywgYnV0IEkgd2FzIGNvbmZ1c2VkIHRoYXQgdGhpcyBmaWxlIG5hbWUgaXMgY2hhbmdlZA0KYnkg
Y29tbWl0IGZjNDAyMDBlYmY4MiAoInNvYzogaW14OiBpbmNyZWFzZSBidWlsZCBjb3ZlcmFnZSBm
b3IgaW14OG0gc29jIGRyaXZlciIpLA0Kc28gaWYgdG8gYWRkIGZpeCB0YWcsIHNob3VsZCBJIGFk
ZCB0aGUgdGFnIHRvIHBvaW50IHRvIGZpcnN0IHBhdGNoIG9mDQpkcml2ZXJzL3NvYy9pbXgvc29j
LWlteDhtLmMsIG9yIHRoZSBvcmlnaW5hbCBjb21taXQgb2Ygc3VwcG9ydGluZyA4TVAgVUlEDQpp
biBkcml2ZXJzL3NvYy9pbXgvc29jLWlteDguYyB3aGljaCBpcyBubyBsb25nIHRoZXJlLg0KDQpU
aGFua3MNCkFuc29uDQo=
