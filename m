Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6ED2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TMtzwdkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbgFXDqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:46:31 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:39343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388609AbgFXDqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S06smsl3gPWrVEnKJV3T06MYr4sSqCYqM9ugybbISHMgbOZ8pKo2lm0RcL6c2iCrSWA7O4XAvMvxgShl3SeHWbhGDKZO8s3VQQCy1toXROvV/zL2kBBg0qopsVdvSQzU/SAAvjQPJk0dDTOdItkNGhUFqVPagASMJfBLpVekctNiZkgA7JJO1thzW5mctXIB4ytoNdiJ6899bj2dFfXGZjBCUNCmc4W8gxsubg1viwrLtf5VtClXCZUjzyMKfjnyz0T2YiXg+8nkabpoZD5JKOnN/o2XwLytxiknkrSrLCVPV3NPomwn7Jvl3L3OEb4AaXrMWLS4ty9IzLJ0o53fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/wuBF6NmcFM7/N00M1lSShlUvLlH3JwH5nYwqobnLU=;
 b=i97r2sPDuMRiRhCDDS8M32aYZsP2lzy1Gk75S2C9qxZGNm7nz6K42gzLvgM5w83fl7qeLnweXwI0hLUobkzJ9eXg9PMe3mdmtgq1BG5qqVANSm198DVaa2p+lfv0zRkWL7yD+AGqeSNet7DtGZbvjvweF/Z7fsQndlp/I++k5maRj1qAD8VbVocKVij0ZeS6CATa9Fpp7Pmz6Phij0qHUcNqR0a8JGFo9ojlEnncm+8j/48u5WjPHdqSnJyxqauXSnbOwZlJtteUct+XjD7pP5yKI5JQ4rmEX9+xcjYEfA+Z1hgewau0dp67eo5qAU5a9yh761VULZ1bc1gWU7FNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/wuBF6NmcFM7/N00M1lSShlUvLlH3JwH5nYwqobnLU=;
 b=TMtzwdkPFS7QkZSRh5njFD3sbrtbNonXhQSOZviXt6p+2GTAw5VQScsnxGKhY5Y0Ek9YF42uyH71qPKfV9tCLKnuGxNaLiJxhK726N4tIqZP/Y0hIAj4E49bRR32oR+44LSmo6jBrhJTqL66s+EcTqzJVKrjLIWRbFyMXDtTjwQ=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM5PR04MB3073.eurprd04.prod.outlook.com
 (2603:10a6:206:9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 03:46:24 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 03:46:24 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
Thread-Topic: [EXT] Re: [PATCH v1] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
Thread-Index: AQHWSVTyt8Q1j3Wp3UC7ZOoTU+UqLKjm/ZhwgAAV0oCAAA1w0A==
Date:   Wed, 24 Jun 2020 03:46:24 +0000
Message-ID: <AM6PR0402MB3607491734698C7841884EF2FF950@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200613201703.16788-1-TheSven73@gmail.com>
 <20200623115335.GC30139@dragon>
 <AM6PR0402MB3607AD6AA7968D3A93D93007FF950@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiWJ+0PVyNcvTSX+MXdKnO-=_w=jPtoaKZoAAExrXwxOyQ@mail.gmail.com>
In-Reply-To: <CAGngYiWJ+0PVyNcvTSX+MXdKnO-=_w=jPtoaKZoAAExrXwxOyQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ee590ce-7359-4cae-d018-08d817f12b06
x-ms-traffictypediagnostic: AM5PR04MB3073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB30734E819E9FAEC5E3C619D2FF950@AM5PR04MB3073.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2KRk8DHP/2GE1kSHL01CoHqLlf6n31tvSYGyJW7IhaNEmHw5dCaJll1tswLD7noVpw//Ul/pryoNhG1EhNjBnxtJbFOXDpiL6QPy7dl9Q653gBZO6+3e16B0imdO7e8gSqHyAgBNmMhFPTq498f0x5tOwxn3njhkTcqS1DWUSerKrSwj1JgMVd7qJcdu96XQMVZYkFsgdKY47hZx8zU+VNW6pQRZp4gkEkXqFGWtYigOwmlZTB+PZ4eKKy2FPXhuSMGsYLwPYc+Lr16VuhpDxH8kvzHQV3RXDdNGIGfZSyJsHipKHs2pGcuw+UZbEOPgYrm8YK5nVCHmNbzSXZfOGNz1mI2RuEV1CSIGI/DMwcLAcQv6N9vvoa3h5gu0HdK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(55016002)(9686003)(4326008)(53546011)(6506007)(71200400001)(7696005)(26005)(2906002)(8936002)(54906003)(186003)(8676002)(5660300002)(52536014)(4744005)(478600001)(86362001)(316002)(33656002)(66556008)(64756008)(66476007)(66946007)(66446008)(76116006)(6916009)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rwZY5E/ZcBnWTmCgDI0YRhs+uAzkqxqE9UG+1EKEnBrVipS384mo+e8y93/aTwkJ/QLD6WiwhF9S15tTbjH3IpCCG1l6bbYpB3dpFUeR6FyQc4sB95v/HBEgTB00GtBSGFoWVm+C5CYcRpbweJMWPm/DA6uAOtLS83xqW5T3gPLwbdPBc2QsSYl5OJAyKDtdvbB/gcDGbA8lMM15Qb344RPz2k8rZ5pq0EZVABriL4IwIMKoTwNaiztyURoNFDocAmFkSJkKSrnmdlXQCXaKpN8Wu+dQDbMKRh6KEoW2OApDdJBfDofWIgJqBo/v9XIXa8DFTOtNnHU3G8aUxN9o/48raecX25c2BnNQlUQUZMu8ihzlNN23cErlzhdaVMJ/aoqQxtfsgpvIDW5dgaQ5Bpjy5XtckGGwbWarOy8bLb8EzMJ8WvZcE9W+b+zIwthyQwuyYLSOZ9dxmAdwazwK+dfcMxSiembtfS8aH49/eDo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee590ce-7359-4cae-d018-08d817f12b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 03:46:24.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSdgSugLM11C7C5F6OORb/zvY70LXdrT30oDX0yNVDiG5O5tPtYLQapaXIg1uL2YheKRSbQe1oj0oQw6COMkMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3ZlbiBWYW4gQXNicm9lY2sgPHRoZXN2ZW43M0BnbWFpbC5jb20+IFNlbnQ6IFdlZG5l
c2RheSwgSnVuZSAyNCwgMjAyMCAxMDo1NiBBTQ0KPiBIaSBBbmR5LA0KPiANCj4gT24gVHVlLCBK
dW4gMjMsIDIwMjAgYXQgOTo0MCBQTSBBbmR5IER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gVGhlIHBhdGNoIGxvb2tzIGdvb2QuDQo+ID4gUmV2aWV3ZWQtYnk6IEZ1
Z2FuZyBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPg0KPiANCj4gVGhhbmsgeW91ICENCj4gDQo+
IFRvIGNoZWNrIHdlJ3JlIG9uIGEgcGx1cywgdGhlIHBhdGNoIHVzZXM6DQo+IGNwdV9pc19pbXg2
cSgpICYmIGlteF9nZXRfc29jX3JldmlzaW9uKCkgPj0gSU1YX0NISVBfUkVWSVNJT05fMl8wDQo+
IA0KPiBGYWJpbyBFc3RldmFtIHN1Z2dlc3RlZCB0aGF0IHBlcmhhcHMgY2hlY2tpbmcNCj4gb2Zf
bWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14NnFwIikNCj4gbWlnaHQgYmUgcHJlZmVyYWJs
ZS4gV2hhdCBpcyB5b3VyIG9waW5pb24gb24gdGhpcz8NCg0KWWVzLCBJIGFsc28gdGhpbmsgb2Zf
bWFjaGluZV9pc19jb21wYXRpYmxlKCkgaXMgbXVjaCBiZXR0ZXIuDQpUaGFua3MuDQo=
