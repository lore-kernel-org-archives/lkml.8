Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD5DC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43AFB2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvw9DG7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgEFLDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:03:01 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:58115
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727893AbgEFLDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+cpHhmxdXhqf2ix2MGeXk62rf8n4KSt+0lQsm1NjINd/ha9T39dkErBGZkIsfWj+uoMTGH1U6GBd3OV0BjbXaQo6v9R418bFCrPUDjeGnGUGeO2xQVvrkUsqYqWDvsCYWj1HWXgiOCr3pwxQQaLTnneTDXo0FC5bDEaO5xsn7BHk2KXxwt56sFwlsK2k7OdUIe9TIsR7l8KZ+gqXdf+Xb2mnt9z2kOrckpr9UTAReVpUEsPQNBBVsqTqOAvDwZ68tnV1FUYR1RtFcoCI8quMxq57XGkTEckVk22SiwuPAsrRI4XJ1K0cBX9rAFYw5tB35bJKxHaha3Bdli38kzPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKg7MJxy/TlIWN/F2OSKOVjHChMZ864nWVbBSD4A/W0=;
 b=n29pSpJQGKeS6D3Mo8KALshksk94Gc/J9FPuA3yGUKit50IWPS30OwZ2LsGJ7AhSrM1sLTgqmw9qHDW62eXHDKDLtOXbsPyfKiCCEybqHk47/wm+f7eSzCedpOmEC4R18sFZNcfYjKU/K2m5cuZfnJ1bbe0w/db2hyete7zKdclyfzgzakE0UAV4sNqhFgNoZ981dT+E+pqRuX/oSx+DaM4QQrTOPv+H88HF+21ZQqzTZ7qpWmFY56icFX5PFkVZLAzNMoaKHukOs3vznnBXyMgP0tn3cCxCl9iIuJ7TNF38VrV3RaKe3znY+z3C13Yj7gj3keXK2AcGrW2Gyotjxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKg7MJxy/TlIWN/F2OSKOVjHChMZ864nWVbBSD4A/W0=;
 b=hvw9DG7N00jWlsO315BNBE5mN+0t5SyVchzo7hERCSKCbIpAkvb6ZME+J8TwxlYdDvNxmH36OXgUSHgs6FftIm6oSmxE+CCD9SEb+2cwdTmlBhDiFFNAxSLPF8o4XdHDF3nmLrAoSowzw2itBwGBowl3FGX/UkW7eXX5CqDNa5o=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5783.eurprd04.prod.outlook.com (2603:10a6:20b:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Wed, 6 May
 2020 11:02:57 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 11:02:57 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] firmware: imx: scu: Fix possible memory leak in
 imx_scu_probe()
Thread-Topic: [PATCH -next] firmware: imx: scu: Fix possible memory leak in
 imx_scu_probe()
Thread-Index: AQHWI2SwIQ4b8mkgq0u0dmDTFjL/fKia5Kiw
Date:   Wed, 6 May 2020 11:02:57 +0000
Message-ID: <AM6PR04MB4966951644D380842EA80D9180A40@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20200506051410.27219-1-weiyongjun1@huawei.com>
In-Reply-To: <20200506051410.27219-1-weiyongjun1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c82e85d9-4b3c-4018-2c33-08d7f1ad08bd
x-ms-traffictypediagnostic: AM6PR04MB5783:|AM6PR04MB5783:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5783E63BCF0E60B2B86FDD6A80A40@AM6PR04MB5783.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYrOgY8o4QnmIN4CytDgMZIxiFhPAy8f1IGaFiw+mzVSe11diWmgoIQkM2dWasqH0t/nOEkAOzt+CkudDdl+TOdwLBWvzw0tmNh0dc6ecrpZSQgTnBZSrPRwt13cU6DsNY+3j9ypx81UmQ8IC03snq/AHjbyZXN6tgbtZD8SmsJecSyfRd/am+akwF4GS5B8Xt7qCu7OnAuaaiCjRKg+4E1UkCt2Os5SA3gMdJyrrc28C/LmQnX62xKv60a0czRcRmBt0yxjQ2wM2syMf/JEOlAyAv3XamWuMbc347U0n+Zkaz2phT70ZdqwIZCNsh7RekY2FzwCptQ41iO0qZoW2G9WMDaiR5pNTOV5CLdC/AlQCvYLY2cNcwG0PS/90fAQoAlTqvDsqgqRF7xFJvlF55qUm18R3Jst1CEbY3t7Zg+f1gZc3C76I5gGI/Mg1PgeZC20KqAWE+/XszEU5HVGHVb1M2UOREvy5OnnQfIyA1S4Y39KuoQhGBEaP/4c+63K7Mg47cWDVe5rR326fqA6rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(33430700001)(7696005)(8676002)(4326008)(44832011)(55016002)(52536014)(66946007)(6636002)(66446008)(64756008)(8936002)(66476007)(66556008)(71200400001)(33440700001)(76116006)(478600001)(4744005)(186003)(316002)(86362001)(5660300002)(26005)(110136005)(54906003)(6506007)(33656002)(2906002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7tFsmrmpYls/jHdLZfB/Zfm9g50l+kxYNupklRWraZPnGCLiBCxnrYCHa+RFA/M/BQIQxTtZyaCELcLyaiZOrqTrxhQKUKypGf9MEGBmcaFm/Tpl9+wzx/sRyTjGmRYqeMXPCvgpHLtJ13g1KKxCn8sFYIIYRazwVWUTzAbBfNqdvHOXJSGiEGRj72TkIYKrulehJoA6+3KieiCVT45pTT0oUVvvd0g9MY+ptGb8TQeUZPCEk57jSix88UdgtneG9DOd/lrRBCh2w9LmI90pz8av5m98Jz0abNfbWBZ2KKMk55HR+k3omPp7ABhJ1xVk7ZrY9TJPyQRCD7QZbmtjh7DKc6A6cTZbvMKa0d+v5Bnaz+Dc1INuUKN4PAktvxtspmGaMFW3W2KUTePTw0c06B8gNZukXvFpPFx40SzfNH03WlzPYbW4aqT81QVoAtBefnBvyAe0kiUyWt32OyaAaRNpgyOBygevjXY0neGTlS1eekumIsz5HkxGy2zrPLNsSPS5HDKIOhGjg6UunPYuegu5aYkBkBgSsZtYi7H4qwPv+SEsqEk1iQZihLf1ewJTc8q9mthWBMJaeXOpQxJLW2Y9nr88jQhOiOAhDJKrNLjslI0OpMO2L/7/7dfTE6FxZ80f+HGyEQVmsEnCuUshTF3Y7hUPIyaNg61Wtc9hkg+1i4QJs8+UYW5EED7N1JIDq/Is+JVXAsQmY6noilphaSUcXgg88gUPPOHaptVOh9KvnBgZJrc4i+Uvb96vknSG6Z5UVSrO71bfdUz37xzVoObrmoHnANoVPWHK9TFAtMM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82e85d9-4b3c-4018-2c33-08d7f1ad08bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 11:02:57.3606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3h7mEna0rjES9McivsU+1C1ry1Qdxd8MnWlAI25tfaGL5+LhonjEgqrejdjY48WnWltvV8IuWLcKe4CWJRfH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5783
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBXZWkgWW9uZ2p1biA8d2VpeW9uZ2p1bjFAaHVhd2VpLmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBNYXkgNiwgMjAyMCAxOjE0IFBNDQo+IA0KPiAnY2hhbl9uYW1lJyBpcyBtYWxsb2Nl
ZCBpbiBpbXhfc2N1X3Byb2JlKCkgYW5kIHNob3VsZCBiZSBmcmVlZCBiZWZvcmUgbGVhdmluZw0K
PiBmcm9tIHRoZSBlcnJvciBoYW5kbGluZyBjYXNlcywgb3RoZXJ3aXNlIGl0IHdpbGwgY2F1c2Ug
bWVtb3J5IGxlYWsuDQo+IA0KPiBGaXhlczogZWRiZWUwOTVmYWZiICgiZmlybXdhcmU6IGlteDog
YWRkIFNDVSBmaXJtd2FyZSBkcml2ZXIgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IFdlaSBZ
b25nanVuIDx3ZWl5b25nanVuMUBodWF3ZWkuY29tPg0KDQpUaGFua3MgZm9yIHRoZSBmaXguDQpS
ZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJk
cw0KQWlzaGVuZw0K
