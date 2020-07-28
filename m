Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5305C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16BC207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rjRTu8n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgG1Jiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:38:52 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:39910
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728197AbgG1Jiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:38:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btZXzeGu7hs4cD1wyY0p5v9suHqjsJhiUi0LrXF+Vm58Qc8pLuHhfDiM7UflZxRZ+NW9NfzdUDeJgObUB9tylSkkPbLoOA7hfNAmx/APmM8Wu+aBEW5A8eQKwO0u24g1dCjMhUPop7jr00vbeAfPzspyKrwSYmqNoKomrxi9Q3wwKhLEgwIhUOOpaO8Iput/3ymI0yTwT0jzbaLl6BwMDoAKXrfEjg7juk4/ZDNVS5KUp8awHYTy4USMYWiR0rIN9hb+dt24K4X7ej28o0M6OGGqkIJzVtdEYoTXMZIqpqhVvwqJy4YRnyrTHKzCGMmcWJOx2zWIkziGXEG8giTm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDTWwRnOKNC7pE3YLwUlic9piSVNUIkVzQaeA2WCV0U=;
 b=cY6/Ugx/S7h0EYRAP8n3l30+IQmPlyX18qWwQlkQWirZMUGSDS4jQ96rNYOY4ppOVCRzwvh+Z1fV4WD5sOh4QxdQHzmIY8gnW/wXlK4xg1RjtbH7BbgBb9PJvyPCTb05OibjoseyslCeaN+bl4mJZbjf8ew9VteDkamlN0i4rg2PDG5Ozv2LBCvMXEzw6QlVMXdONLeGgRYW4Ov8zdXXmFWUo3KuT4ivgLy0u/wWt6jTEgwW7sjLSc2FYQ1rdHSBpWl3UGnNZTnvB/IGIPcO7zDGOnEz6y1bMBz3t/+YSEjkq6TeanUIpWT8VlOD2lrie3SIuDOmFTnvIZmMZcpjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDTWwRnOKNC7pE3YLwUlic9piSVNUIkVzQaeA2WCV0U=;
 b=rjRTu8n/uWIJ2edyqFdXdEDA+EZV9wPLwhvWUxkAsv7jXc85ZWuxLEr76D2JroOwgxy1cRGq50+sBKbD4tlztN/69lPEGhpc+e6XA147iWC02resQkvte7MnKtzmFqkaRHbqtRxr5V1mYGWmOxwbjTZGkw1hsF8TEautAxFHefw=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2375.eurprd04.prod.outlook.com (2603:10a6:4:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Tue, 28 Jul
 2020 09:38:47 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:38:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] clk: imx: imx8m: avoid memory leak
Thread-Topic: [PATCH 1/2] clk: imx: imx8m: avoid memory leak
Thread-Index: AQHWZIsWjqNjGtx9OEGBS5Z3R+RZIKkcqZOAgAATAjA=
Date:   Tue, 28 Jul 2020 09:38:47 +0000
Message-ID: <DB6PR0402MB2760219561CFE80301DDD66588730@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1595904889-30811-1-git-send-email-peng.fan@nxp.com>
 <159592502171.1360974.3210900566276289684@swboyd.mtv.corp.google.com>
In-Reply-To: <159592502171.1360974.3210900566276289684@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20e3f817-b8b2-4ad9-7596-08d832da06df
x-ms-traffictypediagnostic: DB6PR0401MB2375:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2375F5989C8A35CE0B4D51D488730@DB6PR0401MB2375.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrYk92unENfmfYkIO5eKbueXn9cALDzqrmcoa4pBVmH3qHyyfRicEtWCqfJnjdevBFec8yk8WE+DEylrX0PN2W5iZz3zRuKquFOpC3StL2YYOCbZ/+EGyNyDrXtd5ZHQVtHj8hHKwRVirOg9ClWbjF92U0cUYV2ZyBrcrmw+1dpF4mbJZFhLbkuoY1jwLY11l4DusMMy8SyFEsDTu8uIi7W21AfUzIQyBaCUfp/kVAtDmExXHdX8xafDfFBmvgcDjPTwFa3iKnLuAEXsdhHKOfgrIld4TmUDfVek4Z6xiEKXCY/lJMCFE+cb3HYd6Q4Ud5QyYaCSJwDTp38CRRJTWKhDqdVEqKx9rmdZwzk3E1P7NKyGNtAGBTQtT/mY6kTF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(2906002)(8936002)(186003)(54906003)(44832011)(6506007)(71200400001)(76116006)(66446008)(110136005)(64756008)(9686003)(66946007)(55016002)(66476007)(66556008)(316002)(33656002)(26005)(478600001)(52536014)(4744005)(8676002)(4326008)(5660300002)(86362001)(7696005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KvTVEeiq7j7o2EGWcrezQH5K73Pb4TJnML/diOi6WHaVsISxuzNdnAiLy8aS8YViyspFr9psXGBYKbIjNwMEJ3EEiuR2FS48HXpn4+u2bpImoJl7YvJgUU0/Tr3P+BPyNN83Xp6sIV/lJnZ70z77jygF2wrG+xAHBSxo4tNBVNvDyNaPWx4QAEm/Jji44OAS4uo6vlraf62Kaw9pceUBAedi1+J1snLkNO/g/X0rGiADpt/h3fzTcyGGeceVrvStlNYpUg9ZITKABuOvH0R8rnmAKQR1sBbAxMC4Jmn+Rr3DZlfk0w3s4vngzZ8NaavvOTyyjLKn4R6HYIY4NI4fpyZicft7QHv0/1Zt7iDsFVXjBB0Q+AtrFe7wHm2VlrwnKid+ZH7OjLphQmwEHgTfjAFq+1+NfBIoGq4UjLeAWyledBa2M8JZ69Hfz8diK2LnuDg6tZ6EsWjz7MPNaFC68HnENK6TI6/+GRkMUUy/KsKKRfRtx4rh9/Nhu1uKJKD0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e3f817-b8b2-4ad9-7596-08d832da06df
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 09:38:47.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEOITqE2WR6koBMjh3g4TWJsBzTPQqUf4OCm724pUO889Omw/wr36J8N7Xh6K0pjt8g+gHiDwqUqcgx5wy35Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gY2xrOiBpbXg6IGlteDhtOiBhdm9pZCBtZW1vcnkg
bGVhaw0KPiANCj4gUXVvdGluZyBwZW5nLmZhbkBueHAuY29tICgyMDIwLTA3LTI3IDE5OjU0OjQ4
KQ0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVXNlIGRl
dm1fa3phbGxvYyB0byBhdm9pZCBtZW1vcnkgbGVhayB3aGVuIHByb2JlIGZhaWwuDQo+IA0KPiBQ
bGVhc2UgYWRkICgpIHRvIGZ1bmN0aW9ucyBpbiBjb21taXQgdGV4dC4NCg0KVjIgaXMganVzdCBv
dXQsIHBsZWFzZSBoZWxwIHJldmlldyB0aGVyZS4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
