Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57392C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9992072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="qRBBH7cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgCINJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:09:16 -0400
Received: from mail-eopbgr20054.outbound.protection.outlook.com ([40.107.2.54]:31710
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgCINJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:09:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJOzMYQxobZws0/hmGEk3wtnnLpc4K3fK05EolOm+wGwQ3KtEz0Be+qiYgYjPo1HAHThhn8sm2yUb9sRxFpQcTYbXXCNzgbwj/sep7TUqTHPMbr4eSADEKPMiF/8S9IYrxTNiv0xe+6Xfe3ScZRiaMeVd/1wUonrgAC/Cl1Riyi9U96r1GTdG1FaHFU4k5w3X+mPX3g69c5kYiLxLJ+UlrBIxiszBOVHqky3sdVfq74AteLNvZlXh4DKuWEkoT00D53WxFbBph5iQjfYtLFobbqy6iSgIXHZbBQzeJOZt7tngFGLvIaOwfF6L4hYBkZ5MbsoW7oPvcFvsdW5abVeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLzB3FlKkqy9ldCZ8rzjO8jpiBiomBz5TeQD+Kw1RUk=;
 b=hmgEaqqIAO97//ds1XeEPKsR8onErXTU93TPcyeJ7mdFAuoz9Ru1JNQRig7dDZ11gcCVLOeOGoABJKx/5PEhG1K/ko4tOnFEkKIa1p5zLH+L1aUXKriuC4xIgx781TH3PD9zXfzryhT1FxnfEggNrBxFiqw/T+CTT+mkZaygpfTwvkKhvmI832cTWyXlVNKzbkZeV9b4rdXSoibFTiTrgNuM8PhZEv++S9CFVor7jVBlfwK1Y4TpnYEQMgx7Xp5KUuyk31fZht/if4+DtVesjb1+LcIUIZbDqZ0ZFo1lGw2Lgq2UXbCcIZt6exJyfYzSvBXIIbhn2VTa73wMbFNArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLzB3FlKkqy9ldCZ8rzjO8jpiBiomBz5TeQD+Kw1RUk=;
 b=qRBBH7cQescJQgGiNuKOHQ1lXS2AdS9tAfaGNzRGQYLzG8rKkbWh0Kphpe5BAIuMeMTwJL6pTPoh3xBS68t902FQ+lod8lzlVNGXMSMkuCYm+Z7qxCg13CV0K6MIyPXwm48y8Wb7Rmeykd5vKbHUJ4VuDfYNrr5fvT2mB4Hi9i0=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2790.eurprd05.prod.outlook.com (10.172.227.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 13:09:10 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::58ec:69b7:ac09:8614]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::58ec:69b7:ac09:8614%11]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 13:09:10 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/1] gpio: add driver for Mellanox BlueField 2 GPIO
 controller
Thread-Topic: [PATCH v4 1/1] gpio: add driver for Mellanox BlueField 2 GPIO
 controller
Thread-Index: AQHV8NY8VXV4Ki1b70ySYSUxgqoYrKg//WIAgABHbfA=
Date:   Mon, 9 Mar 2020 13:09:09 +0000
Message-ID: <DB6PR0501MB271230CE2A6C9EB528A1F8BBDAFE0@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <cover.1583182325.git.Asmaa@mellanox.com>
 <1680de9eb6d2b8855228dde9a2dd065f0dcbe1fb.1583182325.git.Asmaa@mellanox.com>
 <CACRpkda_8Y6FOM=KokOD=p5Nhrqfw6MdOmcem3JEh+8ERiP0hA@mail.gmail.com>
In-Reply-To: <CACRpkda_8Y6FOM=KokOD=p5Nhrqfw6MdOmcem3JEh+8ERiP0hA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 080b6cb7-c2e0-4a65-7ce9-08d7c42b0e71
x-ms-traffictypediagnostic: DB6PR0501MB2790:
x-microsoft-antispam-prvs: <DB6PR0501MB2790600A698CA342A0F19454DAFE0@DB6PR0501MB2790.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(186003)(55016002)(26005)(9686003)(4326008)(478600001)(2906002)(86362001)(316002)(54906003)(6916009)(33656002)(7696005)(52536014)(5660300002)(66446008)(66556008)(66476007)(81166006)(8676002)(4744005)(76116006)(64756008)(81156014)(66946007)(6506007)(71200400001)(8936002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2790;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QTqjEmJzvW/+hARzGE07ePWY7XLwTQNE2sHerrx9oPXmuZZWG0TBrTR5DBgZNTScItT6B2YGV+Dkyipt8+uhSSa0vmAxJ6bnxrPEm0BwVziIdbwEF22vMg75tDpAJnZdhWcQYU+7b7Dm04F2UF3FxaA4WR/uvXvRNCoPprLSstt52YdgH3RAz5xD+WbOqIE48+xilbCekWDc9hBkrUwhG5wOMIL1V+ijgc2JHepbmnoPcnWLkxzv7wL2UXua//bSrQHvBTSwbNPqtkFuIS61eM/iOAX3iXAVfI8usBnzl+hNuS95Tq/aNOmPr8Xm0XsuEJAUmMNp0GaUuBy5bxw/AD6amHKmg0ur/SxuEr2fjPPfEtVuZPGTBMaGWN/YdJjBHX70UcUU5ESjSvv0fgHYkc46Q3qW+P0TDmILsjAJWKa5ujYoGPVGBZ0Lh24+9S4b
x-ms-exchange-antispam-messagedata: m0zxvrRVMV57zs46scw08KpPpoGXnsRIMffxELkelb3BGe4UnPZ09eOEnkWntJjK6CaM47sXaQWnDE8M+8qRHZdvbspCafcuCSULjRfW4fcx4V12CpiQOCssu+CdrFTbYp6FYIC5vJPuix7FIwx6uQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080b6cb7-c2e0-4a65-7ce9-08d7c42b0e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 13:09:09.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+u9M39cugs4qL6Gs5elym7+2J88sCFJ2Pvk9iihBm5w9LTVVN1y/CwYciHT7ocWRDYyUfcKkHHAZxtAeFpCpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIExpbnVzISDwn5iKDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBM
aW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+IA0KU2VudDogTW9uZGF5LCBN
YXJjaCA5LCAyMDIwIDQ6NDkgQU0NClRvOiBBc21hYSBNbmViaGkgPEFzbWFhQG1lbGxhbm94LmNv
bT4NCkNjOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzFd
IGdwaW86IGFkZCBkcml2ZXIgZm9yIE1lbGxhbm94IEJsdWVGaWVsZCAyIEdQSU8gY29udHJvbGxl
cg0KDQpPbiBNb24sIE1hciAyLCAyMDIwIGF0IDEwOjA0IFBNIEFzbWFhIE1uZWJoaSA8QXNtYWFA
bWVsbGFub3guY29tPiB3cm90ZToNCg0KPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgdGhl
IEdQSU8gY29udHJvbGxlciB1c2VkIGJ5IE1lbGxhbm94IA0KPiBCbHVlRmllbGQgMiBTT0NzLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBBc21hYSBNbmViaGkgPEFzbWFhQG1lbGxhbm94LmNvbT4NCg0K
VGhpcyBpcyBub3cgYSB2ZXJ5IG5pY2UgZHJpdmVyIQ0KDQpQYXRjaCBhcHBsaWVkLg0KDQpZb3Vy
cywNCkxpbnVzIFdhbGxlaWoNCg==
