Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A951C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2968206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxxxXinN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFAJox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:44:53 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:13634
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgFAJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+TUGOY5AJEO2bwFAAQt3R1sT/IQvVU2Ee8yYB6KGUBoT6dQ+bpOW0hUThJIY/PqLKZgRjLBULb55pewSXUKqiH5gsO9upXHl3P5Yz1LGsEq0nWCcLE7suaoU6o7qL+eTZqu1EjQfdqGjdZhdgbSgZp6mrK7x/kzHXiajjvaGfiZyG5VlCaZlXUwXvH7HMLJ0x3iWfkqHKp1noISAybWHPIzxqU/SKAsjHXtyLNwqpxGdQdlfbn6VubmmIMgYknF1uWlCHIPX9TNiQFXe++rlcb5ZvfgokzG8pVdsVbR35WzeTW3w++5RPS0cPGuST72kduT3/Eza8vxIAp/jE0lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNVCvnknVIbsRvH0a4C7yLhWuewAZIr4dOtFK3VKzUA=;
 b=ip3JoXxr7FLyV231eoa69PY9peiz2v3TH1mgPBC/amkZo7hUNv7Sq8BLDUdPBuHPfuyskpB+y5o5WXn7CB0KY8Ce3regtU0u0LlRQfy+Ji/TZ3QQjfmkpeL8DtjIngdQh9c/G8wGlEtHke+j8HH6SRpZmZEZTd4nY4HjY9pj8ag3bShruvnC4YDtAQ81Pk9SVHqdOZtCqv+AHKNWtkDxWtANh7/nzAV1IxwXzmeN8JChioNQ6YbdHvCrwcoY0C7tBfiqN7Kvuhx6ErmXCXryyIZ+TxpZk3zp38beM9W8QzPzsYOX1rtB2OWQfbPHo6uwzdHktDhrjcfnDwKv+bYifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNVCvnknVIbsRvH0a4C7yLhWuewAZIr4dOtFK3VKzUA=;
 b=TxxxXinNRD7f2C2ucanU/KSiXKqDVniwUhdkxfHgTaZ57ZgMWx3rG2fVKZDG57TUXDGaqxfY2iieZdeKnjQPuNdRJfQxKAfNrgjzoi3okscvFc6BOlInzEOHFzQ+lAMeu5yrEZ08yqxer9e0F1G5WxzfKO4QE4sOzECLT/2N0G4=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4888.eurprd04.prod.outlook.com (2603:10a6:20b:12::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 09:44:48 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 09:44:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
Subject: RE: [PATCH V3 2/3] arm64: dts: imx8m: add mu node
Thread-Topic: [PATCH V3 2/3] arm64: dts: imx8m: add mu node
Thread-Index: AQHWN+7u7ougiNgAe0WWy8Mq+xUtFKjDgpXA
Date:   Mon, 1 Jun 2020 09:44:48 +0000
Message-ID: <AM6PR04MB49667751EEAF5D3AE1199C01808A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
 <1590999602-29482-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1590999602-29482-3-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23769fe4-7f07-4292-b7ef-08d806106c99
x-ms-traffictypediagnostic: AM6PR04MB4888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB48885C2A519C7B5B2B515EA0808A0@AM6PR04MB4888.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hxts2vYuEYG+ZMC5/u3cWDArXFOfH0TTrBQRIN7rmb7NQgnx0AoMpqfUOX1qb8Ms0Sy+eZobiRcBfcx6WHuxdOBIxNuw/xkqxFei/L2OWGfCk/xcIAFbCCO4to3/YximdOrcbTYTqIbdHMS2UpGuGKtkHXAQUewvwjwlbDMzzGKJzhvvFB00onNSrJW+7x5p9lZu4NPQeVekSl/3YfHOYepcGqll5Zjk9hDuWO7C5tpm6u8xUcl/CeeMG0HoSdom5LG+uAZo8ZsKJ4u4qyl5iH9Rg3U6uHzVmZDhF2qbpmP+g4m7d6wftJVTzRBczFyuhMSw27qVoWbj5+2QZmMQmBLjjOFCezwAkPQ3ay492GjMJgNkynfObgPT9Vs5hWHV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(44832011)(71200400001)(86362001)(2906002)(316002)(55016002)(9686003)(4326008)(5660300002)(64756008)(7416002)(66476007)(66556008)(110136005)(54906003)(66446008)(26005)(478600001)(186003)(7696005)(66946007)(76116006)(6506007)(558084003)(33656002)(8936002)(52536014)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NREo4XqbnpE7/bBbY0Pmdax/9HWwm9RnpqKtumDbTzPR2Rk80lSdN70BRxSvlY3gva8MqV5sAmrN5UN61ksesal3+O53eiAxlQ7+c8NG07cGcr5Ep9m63ES5akhF1tCMBUxFxIGcMpOv9xpNcjfF99cVR5ViO9lBYR9z4dtM59pMJyl8NzBMo1Ld0n2jLIwTzR9wFodkb4UkHeiMj2abCWvL5oeEtkeXQ09me2+iD0xBz5WVVQ+4MANQiKm+HLlfiaGw8RPw2jXY3cLGS+73ZUi1HKengQsvYdXUkVHR+NCBYIDgNBUzwHXbXTf5FavTLJfiWVMIUCufK1hETvqKXuA/5eriJBod4I5It4y0G51teouA4Z5pTR8C2UiaPytourMpPI2bZ2u281uIzwNvA6Q8mW8OKGpQNTa0JGx2+lwkifFjC3Ce9hRAzoMkQTovctEGrYXxbWxjwcWHUXC7xqkQEOTpnrqEEePxgejWINA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23769fe4-7f07-4292-b7ef-08d806106c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 09:44:48.3212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Th/mVdywt824pEQ3/XyShbQYkEOtP//0pk6VxW1RxO4apV99jxFWncGfKlHFG8qrufYzb5XIHxXhLp779WJ7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4888
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5l
IDEsIDIwMjAgNDoyMCBQTQ0KPiANCj4gQWRkIG11IG5vZGUgdG8gbGV0IEE1MyBjb3VsZCBjb21t
dW5pY2F0ZSB3aXRoIE0gQ29yZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
