Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5CEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F55208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s9+ktiS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFQKKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:10:09 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:48057
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbgFQKKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEoAmhAjrMj3MIi2Qx0nhwWzgI7VL3e5fopTenAhbhOl35C2vESrNKBxq/JEZX7GwcrekUZ9sdZF/DR9LIcVJE6XPqRVAhWva2wexZeDgZTMnTSzetCoB4k3DPuqZv4ZmcJ1YsRvzKYi7JeSoXuPPQT9joiTpUB7GXXyiOYYAN6kjabLsfMMkT7EZeQkshNTcKN/EMxE+tlGfg3HEqMeqNu4HM5L/F9FHD46TRRMpnJHB+cmC2ehPrcPPUZUi6m7ToG4TFOf48Qea4xxXnvGwrNNhRzY+JK7VhtHAak87VBakApgJEpeJi7GjsHc18vPMQrw2I17R0ZA3r8H/UhAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxf64OgTaC6lcGbbEbfInvceM1/NZWp8oGEn0hoBSSY=;
 b=P8hujXGguVYL84Guu76gzsqLOXKLa7B5EQSpVjkzmK0QUtO4nd5YpUtzHZXhssKRATysZVALolnuUdqQzVf9gl6SGxMPw/9kutwbpCkvnzwFnG89xep3f5wu7si44okXmzcqrGEX5mJDU8/X/J9SjbtfG43q0Hvy11T6inYxqLdn9f5D+/UBuZrNOWSfSv4AvdaX4EE/4d/M/GVEeC6p8EgQympuCzIpPK923tmOZ7t+ryLvMrQHFnftWVThRm0PHfC/KA/fG/DMjUpJ+JJAcHf75iK9opt9BeLGfp+qPwTibOx+eU20Lp0dXlzB8XFb6XEM1xpkXlbJi/F6wWXvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxf64OgTaC6lcGbbEbfInvceM1/NZWp8oGEn0hoBSSY=;
 b=s9+ktiS/AhpGvy3cVYS7pTs93yGqPGxp7L9NEezk9ffvnDmGh511Siz0cnmUsa0A1PaU6UZeZgM+3fijYjD7PlzdtnO9MtG3iI9/0toR1solPRGd9vDWtlHTOaHBtOPlxmd9dWgaakuAfvpQ8pEtDma75O/PteM1fyP21VqgBUQ=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5432.eurprd04.prod.outlook.com (2603:10a6:20b:93::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 10:10:02 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 10:10:02 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/9] clk: composite: Export clk_hw_register_composite()
Thread-Topic: [PATCH V2 1/9] clk: composite: Export
 clk_hw_register_composite()
Thread-Index: AQHWPjGiuQ2F29kQlUqqseTZxooV6ajcol7g
Date:   Wed, 17 Jun 2020 10:10:02 +0000
Message-ID: <AM6PR04MB49665E5D93C2FFA8221F8660809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1591687933-19495-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e55bc7bb-174f-4b33-1859-08d812a699be
x-ms-traffictypediagnostic: AM6PR04MB5432:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB54321C5852F49E5F4BC2CF8C809A0@AM6PR04MB5432.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tu70eWASn20Vf/QKebEZt/mSIDsicYAMAAFenYmfViUkDxEFHAq2wQHMhB2nDzh34t80Jd/K+CtUwdSSwD+gaSC/RiZb2F+oCTlZt81b3d+fKjbCHI7aDvx2HYpXpoSeyx5/jzjD/SAsAbP3ZsHMWUX6cjUVMoB+X7L/+hyLlVLNMuW0lYVfpFUwMP6ornPU1QDmfXhuepcXAf0H9ySMEogf8road7Co/tesjXZpOCZUMPce8cPztHd+YFzZmp2xaAJSisTQ5tJUaIky0ibxBdVj3FFAVUw0exXj/HIkrgevIMJVEhDVF8qdI7iZDw9+q39oAQ2P2N+zhIbmUqVp6BiVMoEirnIQ5Qxo5WcO2NlIEp5iumkvQU4Rn18VNhG6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(7696005)(26005)(186003)(33656002)(44832011)(86362001)(316002)(6506007)(8936002)(478600001)(71200400001)(52536014)(7416002)(8676002)(110136005)(5660300002)(2906002)(4326008)(55016002)(9686003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /ZaNTPM8n/ngMzHoV9eanEI4hx5rJ+SjwkICBx11RiytKCQTZbFOB47Fkb+KhOHV8D4BRJMJjIl9InL/Cg9Ypfx3BsJoI9+WrHjO5KR5Qu1eaM7TgPTx1sQTyWPoV+1eqKC9lBT5ICgnsgieQfnCk7meTMv5CG44jyfwGtIuw5qzUuky7zINpUq1kQENQ/xP0D8cUM2IYwoE6H+y9kdK1m37Xw7hDBMXoNZwoHxpO0AumEfb97OWCG3LOgggirWF3cQgtAvFEB50AKLPZGo2Id7+sCcqEHXQNCy+uVIzJGWyXXiCqS+UeZs6In3VE0CMICmiBIR4/iGu3Qn7gwLI2LU/t6V5imf/prV6pglq+QsW0znhwbQp4ktjPiZuhlfraaOFG0HJgSPEpn0eS+ut7U4xwSZdp90HnP5+umjn9esv+jp68zjNBmj+Dy50aj4bUYcNnhEdqFR5/w5Fxsg1H0sUXYS6bUYp1UNUsU+6Tc6EOFgGuaO39xG60quMLPVZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55bc7bb-174f-4b33-1859-08d812a699be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 10:10:02.5338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JFEvABr4bHcfbs7nF/TSlw++b7BPAoR5At2XfbMuHufSm6DxHjj5yzPvzOBYJA1AA5W7mhcV7QTLrS6UKKJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSnVuZSA5LCAyMDIwIDM6MzIgUE0NCj4gDQo+IEV4cG9ydCBjbGtfaHdfcmVnaXN0ZXJfY29t
cG9zaXRlKCkgdG8gc3VwcG9ydCB1c2VyIGJ1aWx0IGFzIG1vZHVsZS4NCj4gDQo+IEVSUk9SOiBt
b2Rwb3N0OiAiY2xrX2h3X3JlZ2lzdGVyX2NvbXBvc2l0ZSIgW2RyaXZlcnMvY2xrL2lteC9teGMt
Y2xrLmtvXQ0KPiB1bmRlZmluZWQhDQo+IHNjcmlwdHMvTWFrZWZpbGUubW9kcG9zdDoxMTE6IHJl
Y2lwZSBmb3IgdGFyZ2V0ICdNb2R1bGUuc3ltdmVycycgZmFpbGVkDQo+IG1ha2VbMV06ICoqKiBb
TW9kdWxlLnN5bXZlcnNdIEVycm9yIDENCj4gbWFrZVsxXTogKioqIERlbGV0aW5nIGZpbGUgJ01v
ZHVsZS5zeW12ZXJzJw0KPiBNYWtlZmlsZToxMzg0OiByZWNpcGUgZm9yIHRhcmdldCAnbW9kdWxl
cycgZmFpbGVkDQo+IG1ha2U6ICoqKiBbbW9kdWxlc10gRXJyb3IgMg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiBObyBjaGFu
Z2UuDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvY2xrLWNvbXBvc2l0ZS5jIHwgMSArDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9jbGstY29tcG9zaXRlLmMgYi9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMgaW5kZXgNCj4g
NzM3NmY1Ny4uMmRkYjU0ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLWNvbXBvc2l0
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYw0KPiBAQCAtMzI4LDYgKzMy
OCw3IEBAIHN0cnVjdCBjbGtfaHcgKmNsa19od19yZWdpc3Rlcl9jb21wb3NpdGUoc3RydWN0DQo+
IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KPiAgCQkJCQkgICByYXRlX2h3LCByYXRl
X29wcywgZ2F0ZV9odywNCj4gIAkJCQkJICAgZ2F0ZV9vcHMsIGZsYWdzKTsNCj4gIH0NCj4gK0VY
UE9SVF9TWU1CT0xfR1BMKGNsa19od19yZWdpc3Rlcl9jb21wb3NpdGUpOw0KPiANCj4gIHN0cnVj
dCBjbGtfaHcgKmNsa19od19yZWdpc3Rlcl9jb21wb3NpdGVfcGRhdGEoc3RydWN0IGRldmljZSAq
ZGV2LA0KPiAgCQkJY29uc3QgY2hhciAqbmFtZSwNCg0KSSBndWVzcyB5b3UnZCBiZXR0ZXIgYWRk
IHRoaXMgb25lIGFzIHdlbGwuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLQ0KPiAyLjcuNA0K
DQo=
