Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F0C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C0uIsHlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgHTGW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:22:58 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:35590
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgHTGW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:22:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0Sjz/T9UsOPV6ouY/sApM84JC4BoVzUFwNDCpLm3vky+3smH+dZx2ZHCwhIPLSMRgVCQlXTNKo437klXCdfyttA7xOCB1dXocLrf6uFX8dKcz7/ukEwuOgleYhNo9KqM6Kcy5XOxkLenp6AGNJ29MaO1hxzjT7+EhI5ZtQDhgDW9P/X8He0DHgSA6wNLmUZcTKgOzw0hwXFVlNMp+gAx4kR1/NJAs9vGqJVMbcMW2i+e1tdpiZtgCZXJO7kX/G+3Bhq+NXfNjM7Y+EHbqapdjUXoI19CaERD8H5/Bx1dqa+BYNIeTxHc7eiPXV9iBgDHdyGO7JL1KiJxsNwYFnlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX6VwN2gZ69qHCrxt/LPnEBf/m+TIpuS5dn8gDwW29M=;
 b=VJBgu7U8E5Zxu1WOAmiduWtAhlwtWzqUvCJkG8bi/uk0O6o2mMHdC8vbLjDlOAaOtBqFpB//W11ILJ7ADQVpfZ0AkKqcWHW9mQq+p/Oe03mkKU9lk5ADYRLh6ya/XECO/0QHNlgIrEuM7yTqMRzO7wY3lt5A6avD2US8W5aZCnEFHzcbu8LnCki5rarVbOGgdY1VLJ1YIOzGct+4g7gqZPOtf+FwKDjpKmHO+1i7GkHsC592AJjztxQgAPdH3tm8+bYD/ro8ia00wH55wwruM4qBxBn2YjoU/tFSaaDHNrDtLUVknIfuVyp4F1QwtTFZ23Rorg8hz/4U16qgY2fzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX6VwN2gZ69qHCrxt/LPnEBf/m+TIpuS5dn8gDwW29M=;
 b=C0uIsHlBnl1hR1oA5MYEaU3y7uQ38eLK7CGGi9/2pCwMF0cb8tOxpRMloxX7E/BzFN3w71LOrwS9TRNqyrEHR6zlpQHoc/QesyP2khzGD77zXkAQY+sXdBnqndSCAxQI/M9BB1fPCO+Pdfew48AAbVNUFbOHTsecsJkH30SdF6w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 06:22:53 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8db5:8715:8570:1406]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8db5:8715:8570:1406%7]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 06:22:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/2] arm64: imx: Select TPM driver by default
Thread-Topic: [PATCH V2 2/2] arm64: imx: Select TPM driver by default
Thread-Index: AQHWVNaSTYw8gdoKrE6gOePX2hHQl6lAyuWg
Date:   Thu, 20 Aug 2020 06:22:53 +0000
Message-ID: <DB3PR0402MB3916E48F0528FA57A4B13EB7F55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1594178168-13007-1-git-send-email-Anson.Huang@nxp.com>
 <1594178168-13007-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1594178168-13007-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.18.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a93baa87-97ea-4ff5-a0ee-08d844d178c6
x-ms-traffictypediagnostic: DB8PR04MB7177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB717758B4232A1F1A999A455DF55A0@DB8PR04MB7177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNtRxrkpH4X097jPcntRahSqf/LZi+bHAVT/Y5ZMp62vNjQxe6985IxDR6SCpQiDoWXODgCPEaxna+8rvu/mqcZK5cIe0u7uY+rfunq/edGOEu8kJopvlkf33OA8WleBRNS5Id9qx3fBjKE5drResW6/G7PX77Y8juMHVoUdh2AdLwt6PB1dXbg9M5y56BIE27h487DIRdWvCLfPkjVVHhpZqTV+gIoQ3HnRecm8/7SopXVZUrOeIcq3gC7x18ub9b+WNXrtV4NyLG1Hs7bFaNP/8fI7cPLc3C/lPuGKlZW9ox9QRGQyONwO45fcgnLXSJSFIBYMQ9EI/Gufny8aRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(7696005)(4744005)(66446008)(2906002)(9686003)(64756008)(66476007)(76116006)(66946007)(55016002)(6506007)(4326008)(66556008)(53546011)(5660300002)(52536014)(110136005)(86362001)(186003)(8676002)(316002)(44832011)(71200400001)(8936002)(83380400001)(26005)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FvuLJnM0CyW0StcrFN/2TciOcTbwPtghoilNcbZ85IYMTqEaioeFSkCJg1vc7wMbQGUU/qUlxiDKUhGAWbzcsVrRDAHBXMzg9950qdEuY3HFL7rob0viZ+o2wxC+PzMUT+Bo1fho2FWyu1aUbQk2SpH6tu+gI+bsvr2p46R3q4Nh8EmNg16IAIuVixrhtwXkSHz3knhSBwwKAqs7r3ffAO40EwKgmTKBCcluYI+5k5BMLYLuIcP0YqjzRcINxePUC0GCi/FPN240+MajYjejXTJxWKW3aw2e7ezs2qq2KczrHb+DwnVyIOXeS9fOM7LQTEJ/02Lx6Y1R7YHNhH+4aGZ15R2X3b9bmPAh7vB8p6hpmCAtBI9PYf2KjBAv1xipLBCI+5gwf3Ot5gdHiF1ldfyRi8EV5tC9bnOOCVsWsd0hBo1z4QBt1HI529z2CxqrvdOJaKHmheJ1ffGFpqbMPAevKgVpwDWSvZa57EqezD2lMmK1DQ8jhGSY6pyMq7cXt1h0EA9RGouRnqCPPmvQ50TIbxyKRzxVGKhTStjH41SloHQUd61ieUSDkymN0KayZTE6Zl6olNjqdERw5CoqxgRRJF6m/30McFKuNpoR+W6kBbowu47MNq2BhQmA63mT84iflaVMmJCnhdS4E94qtg==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93baa87-97ea-4ff5-a0ee-08d844d178c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 06:22:53.7252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0fs4rOjEeGrIO4sout35TwsOwgd/X9dRBNVCBFRe9TbTRFLdRCnIHHiGtMHdlYz/enyIqG6I3Jx34XEkMTHFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBB
bnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogMjAyMMTqN9TCOMjVIDEx
OjE2DQo+IFRvOiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOyBkYW5p
ZWwubGV6Y2Fub0BsaW5hcm8ub3JnOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIFYyIDIvMl0gYXJtNjQ6IGlteDogU2VsZWN0IFRQTSBkcml2ZXIgYnkgZGVmYXVsdA0KPiAN
Cj4gU2VsZWN0IENMS1NSQ19JTVhfVFBNIGZvciBBUkNIX01YQyBieSBkZWZhdWx0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0K
PiBObyBjaGFuZ2UuDQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3JtcyB8IDEg
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3JtcyBiL2FyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9y
bXMNCj4gaW5kZXggOGRkMDViMi4uYzUyYjdhMCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9L
Y29uZmlnLnBsYXRmb3Jtcw0KPiArKysgYi9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zDQo+
IEBAIC0xNjksNiArMTY5LDcgQEAgY29uZmlnIEFSQ0hfTVhDDQo+ICAJYm9vbCAiQVJNdjggYmFz
ZWQgTlhQIGkuTVggU29DIGZhbWlseSINCj4gIAlzZWxlY3QgQVJNNjRfRVJSQVRVTV84NDM0MTkN
Cj4gIAlzZWxlY3QgQVJNNjRfRVJSQVRVTV84NDU3MTkgaWYgQ09NUEFUDQo+ICsJc2VsZWN0IENM
S1NSQ19JTVhfVFBNDQo+ICAJc2VsZWN0IElNWF9HUENWMg0KPiAgCXNlbGVjdCBJTVhfR1BDVjJf
UE1fRE9NQUlOUw0KPiAgCXNlbGVjdCBQTQ0KPiAtLQ0KPiAyLjcuNA0KDQo=
