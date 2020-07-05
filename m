Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 10:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722302075D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 10:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Mi7GHKQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGEKk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 06:40:56 -0400
Received: from mail-eopbgr150122.outbound.protection.outlook.com ([40.107.15.122]:61024
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbgGEKkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 06:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3ql24Dj0PH5F3tugc5XzAxsX5yCDFGOfhcqPp35OtigaxeUAOAs9TlI7cJBJEOrbf81puSvBLR+lki9g8D12jhg/I/dtnX+9JGIJbiyghozUAzY4JwSX0Zy0ZB3SmRSpFgoWJQF9xWPtJFxn1Hqd1hSe5Vu9zdDPiIVnd8vYYuI/gZ3NQlYSLvWP85Z+efcu9gq+S1dkJ2vzeuiA8SM30Z7djMt9RqPkutK+6/iAE9fjX6XCtVh1Xl4u46Rid02oUx00zwOFTZ99khfa0bvNaP7DEHLRmlnroLMGaYOiboqyhPZmOK8wB5jh3igayM7EaVNpMgQQrwtzvzNc/BURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVjeYVMOEoYBXJ2jonu4H5xh2PU5CaGELN5oqD6ahBs=;
 b=JtGeq17Pyiv6ZWTQC5m7NiWyV2Uz3eySr+i/LqqUpg9cVjiT3VByEGGLthfLDbnHF1sYPsRKxqZs8mWLCGbF0G0mZoMYBLH522bVohr8pYmQ+e4xuAiY0teWvQWtT7TE6824M7ufAJzFK9GhHep1UyH+8Hmx6/jQDHC5A8nvL4THBGIZv5aU/v6z8vI0107ZNVR4eA7oCeTIqEdQfXHU5l03qsIIdxSLI8J2nd2A3st++UpoyOrzFO+/OiT6mF/Ti1Dp2Z95xQP7JafkNTnZhRSHdLo56oBvLsQLOybPH0myflzRLQLgygGPPNqghEqQ9wc9iZWFzuDAWMQJhbuJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVjeYVMOEoYBXJ2jonu4H5xh2PU5CaGELN5oqD6ahBs=;
 b=Mi7GHKQEvOeYNJdUTxo4A2zjdM/456x1jIOVgSYz5o7vYnt6uhY4y+QYwQktlayJaEyMQyf/gUM6vuCBgyISfGRhCkeutD2feUlhq5nJBVm3xXSFN0FDEvHxmLMRD/Uz/G7yLsY8OuuxSgwsVs/iwj3qdfws9TikYGSrphVEKZU=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM4PR02MB3059.eurprd02.prod.outlook.com (2603:10a6:205:4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sun, 5 Jul
 2020 10:40:51 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3153.029; Sun, 5 Jul 2020
 10:40:51 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/2] habanalabs: set clock gating per engine
Thread-Topic: [PATCH 2/2] habanalabs: set clock gating per engine
Thread-Index: AQHWUkpBF/8pxaGMlUK9jlBVVWpnB6j4zJOw
Date:   Sun, 5 Jul 2020 10:40:51 +0000
Message-ID: <AM0PR02MB55237F3AB0B0BC2BFD15123EB8680@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200704212951.20062-1-oded.gabbay@gmail.com>
 <20200704212951.20062-2-oded.gabbay@gmail.com>
In-Reply-To: <20200704212951.20062-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [94.230.83.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7a2a379-d66f-4d05-37f6-08d820cfe372
x-ms-traffictypediagnostic: AM4PR02MB3059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR02MB3059DA4A1F8517D0BCC05437B8680@AM4PR02MB3059.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 045584D28C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfBimon93S261IjCVOBDBFnrSXpKi6avBA+IkYFRxDhZ7Mkl5TFiJY+bQN6HaqJLfOji1triQ/mJ37Gpn3S+aklwKH7HKIIPf7YGWmdvnfYe0l7aitMsbQLQPKFft5Fdf/yKgBVa6XmZ+6WclUapAejr6wLmAqAr6b5S9KfqOlpgPBZuvxzRntLbHBwbdmjncnWa2wl0nAcP+mPmuIJLHsT73yuoY3dBk9vErhyQg7coBY0FxH7WnHY82lBulFqJuGP3ik8C6JNugmUf0TBEyGhd2wTd99WNUdAznpvQHU9Yuoqdg3PjkU/WplanOJkE4xM6XwHZYa8/BQ++LkMAIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(376002)(136003)(346002)(366004)(186003)(33656002)(316002)(83380400001)(4326008)(110136005)(478600001)(64756008)(4744005)(66946007)(76116006)(66556008)(8936002)(66476007)(66446008)(26005)(71200400001)(86362001)(52536014)(8676002)(5660300002)(55016002)(6636002)(7696005)(9686003)(53546011)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IgXA4+/3FKtONc+4jCtFctJPo8rdqVMBMWDfyIz9b/dl3IZwrXA7MMzl9bUh8MyB56Z9FnXAhpwR+xDRC4DQwpTeZPI9p1ixYw3WxaeM2lGKwVco3dsD0R97xLJXtBY5D4Hulud0i0ViFtp5QpKeQWPQ231V1tMm+XYwWhXjMaVl7dyoQOECrRLueK4brjuReu/0/4TAMLlVvbeUizUB8LHqpoZv4N/8A9LmF0cwpKn6JlPRrPTJrvKTsDZY+60NzaMOq5FrY9NGfj1vuiv5h1Fn1Zt+QbocjO4Hre+ENciWgxTsfnE3u3ZfR/Gh9hiM+sxE1nRs4dlKI/QCQeSml0MjRm6AF1Y2JhqTXCdKlm/ACXH6O2cb/mtM1Vj3QD8Vy4OucXZ03g96sNVcsoGmBQzUNdIG2wlqwOevKzurtAHGi5TsWpy92GFcGqHUcyhLND3GuufBr+8w8i3LSq3dbclJRfY0iPhidqHWLnKhkrw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a2a379-d66f-4d05-37f6-08d820cfe372
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2020 10:40:51.8688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kI3bdqdNdSqnctzDPgPULq5+22Ab+2BGwy2u08XPyGg322EJTqvTs65hDgMP9OKfapOVTKlyW3U5WiKpK4Wug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB3059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgNSwgMjAyMCBhdCAwMDozMCBBTSwgT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IEZvciBkZWJ1Z2dpbmcgcHVycG9zZXMsIHdlIG5lZWQgdG8g
YWxsb3cgdGhlIHJvb3QgdXNlciBiZXR0ZXIgY29udHJvbCBvZiB0aGUNCj4gY2xvY2sgZ2F0aW5n
IGZlYXR1cmUgb2YgdGhlIERNQSBhbmQgY29tcHV0ZSBlbmdpbmVzLiBUaGVyZWZvcmUsIGNoYW5n
ZQ0KPiB0aGUgY2xvY2sgZ2F0aW5nIGRlYnVnZnMgaW50ZXJmYWNlIHRvIGJlIGJpdG1hc2sgaW5z
dGVhZCBvZiB0cnVlL2ZhbHNlLg0KPiBFYWNoIGJpdCByZXByZXNlbnRzIGEgZGlmZmVyZW50IGVu
Z2luZSwgYWNjb3JkaW5nIHRvIGdhdWRpX2VuZ2luZV9pZCBlbnVtLg0KPiANCj4gU2VlIGRlYnVn
ZnMgZG9jdW1lbnRhdGlvbiBmb3IgbW9yZSBkZXRhaWxzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
T2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE9tZXIg
U2hwaWdlbG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
