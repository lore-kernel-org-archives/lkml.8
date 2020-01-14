Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C65C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7592072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="sY55AYus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgANPu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:50:26 -0500
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:34529
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbgANPu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:50:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRZTThC6Q3XNurCqbD31vCRJ4LibatzkdFguWnikcvr26f+5yVUS5hwSyfPLUUx9W+TusNU4whoUNAYp58B2qtsyMV/Yx4ZMWmLAxOqzsIT0j0ejmFONtddoIG5YG9k9+6BKR1tnyqAT3HX29XL++uNaih+O19Ml3NATmPkza2i9k/pU+8Yn4cR47PTdZ+nYJP+uN/n3/GzvyNnTLRHmsheY1Op+1K6brdiHYfAfGxFsfKZXLE2knPeXXz3DTVDbs6LLDtxHMfVttBmZpjZAjrtf0nUSPiQJU3m4f+arQvRrSiAR03UPBxYT+vqI3b2RdAwjFz0Me6/cWsIN4gAFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNSSkFgpoKbc2ONZH1qRFjTrq2JGXe5sX/UD6hO+1w8=;
 b=VgiOzcU9HXRwwtA/3+PYbqWESnPH1JlGbMxn84aX0rfG1HFe6OWXx7sY9Rt1fZFnS1mxtpqJkyllBM/Btrbz4igvMfnWLHnO7mzjkK5riUj2MEhNvJ/blB5kjxEEYrRMeJGpTi4J9mtFfg1e/zWAXA7qdu6KjnRtX/RuJgx5WERpNvMM/FOgdUcIokjJ58yw82Z4rNID+NPsh3s+w9bhKaF5HIrfC2xfGNbwcfBOEdCy7KzM6c54Gz7mG6kHaF6D7TGjwLKDo3nF/UhBGCUgI/9H9hMQm3YLOY7yEurEOz49kR2K69dZheosICDDeHbwpECBaUdvGfH8daAM8wWIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNSSkFgpoKbc2ONZH1qRFjTrq2JGXe5sX/UD6hO+1w8=;
 b=sY55AYuskC+VPZbJLHAeLjwHrOEdyfN7pi/GdnchJneyO+nTG33FlKM29pX7fXHQpV9Lw/vSnm4EBwDADdMkeqOzM7HC0IYo7pGqgYnuKUjAQzRS76+vDJeKnVV78Fm5qopAr7KbXWiyiio9aZt+lOYc9YL/NRBQpUyAB1VNVKw=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2727.eurprd05.prod.outlook.com (10.172.225.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 15:50:22 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::9477:3768:6a86:a578]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::9477:3768:6a86:a578%10]) with mapi id 15.20.2623.017; Tue, 14 Jan
 2020 15:50:22 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     Colin King <colin.king@canonical.com>,
        Corey Minyard <cminyard@mvista.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] drivers: ipmi: fix off-by-one bounds check that
 leads to a out-of-bounds write
Thread-Topic: [PATCH][next] drivers: ipmi: fix off-by-one bounds check that
 leads to a out-of-bounds write
Thread-Index: AQHVyuiVmzgaQueLj0y17rR9L9rt1afqTq+w
Date:   Tue, 14 Jan 2020 15:50:22 +0000
Message-ID: <DB6PR0501MB2712BEBCF959566EAB063769DA340@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20200114144031.358003-1-colin.king@canonical.com>
In-Reply-To: <20200114144031.358003-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c856f1c5-b437-4680-e249-08d799097717
x-ms-traffictypediagnostic: DB6PR0501MB2727:|DB6PR0501MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0501MB2727751E677732E186094C82DA340@DB6PR0501MB2727.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(189003)(199004)(86362001)(33656002)(26005)(52536014)(9686003)(55016002)(478600001)(4326008)(53546011)(66946007)(8676002)(110136005)(64756008)(66476007)(66556008)(316002)(66446008)(81156014)(81166006)(186003)(6506007)(76116006)(8936002)(54906003)(2906002)(5660300002)(7696005)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2727;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KFBMJu6B9u/oMNtlgYdZKyt3VFXf4wosQWC3LmA+UPQk4rENeuQL7//CW+gYifoNSVepHc/ENCnrWCqzEiptYhR4N0N0rfDWFM0y3LYSH77ppvm1H0p91iKsKw9qMXeL4bz6bqBASI0+IGjI8321toH4+R8tSvgjoagtHJr2rcdbDgqte7myqUXMWKUfcC1SRJ2ytqMwQT0tto2snzrhAZ45SHtM47aQFGxYLnnyM7wlywIQx0QJ6nByh1jTmmmSPRjIcKnKdMrxV2kYkBMCywfeZjnT4zS+UbwYMv2OBmgdWyogfKafQuX4DRM8Vcj+If2aZfDqUGN5uaGztCgxbmp3Z1KE4o1/FmiKw0CASAG0A/RfBKddcxmMbfLSESTQfeg2IMwCK+wpMJdVL2Dn9Rpv4n6BwWf+KE9EO4bWLkeU4oDu9XTVxdpEpGGfW0h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c856f1c5-b437-4680-e249-08d799097717
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 15:50:22.6834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZInj7s8Oro9skoyIuM2w/Oztcntc5stBsAD5sWPKRbHsYfxz8RGlnKjHg1Ygdfk1uIo1YK7HU4l8GM9xojOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEFzbWFhIE1uZWJoaSA8YXNtYWFAbWVsbGFub3guY29tPg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ29saW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPiANClNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTQsIDIwMjAgOTo0MSBBTQ0KVG86IENv
cmV5IE1pbnlhcmQgPGNtaW55YXJkQG12aXN0YS5jb20+OyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47
IFZhZGltIFBhc3Rlcm5hayA8dmFkaW1wQG1lbGxhbm94LmNvbT47IEFzbWFhIE1uZWJoaSA8QXNt
YWFAbWVsbGFub3guY29tPjsgb3BlbmlwbWktZGV2ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dA0KQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNClN1YmplY3Q6IFtQQVRDSF1bbmV4dF0gZHJpdmVyczogaXBtaTogZml4IG9m
Zi1ieS1vbmUgYm91bmRzIGNoZWNrIHRoYXQgbGVhZHMgdG8gYSBvdXQtb2YtYm91bmRzIHdyaXRl
DQoNCkZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQoNClRo
ZSBlbmQgb2YgYnVmZmVyIGNoZWNrIGlzIG9mZi1ieS1vbmUgc2luY2UgdGhlIGNoZWNrIGlzIGFn
YWluc3QgYW4gaW5kZXggdGhhdCBpcyBwcmUtaW5jcmVtZW50ZWQgYmVmb3JlIGEgc3RvcmUgdG8g
YnVmW10uIEZpeCB0aGlzIGFkanVzdGluZyB0aGUgYm91bmRzIGNoZWNrIGFwcHJvcHJpYXRlbHku
DQoNCkFkZHJlc3Nlcy1Db3Zlcml0eTogKCJPdXQtb2YtYm91bmRzIHdyaXRlIikNCkZpeGVzOiA1
MWJkNmYyOTE1ODMgKCJBZGQgc3VwcG9ydCBmb3IgSVBNQiBkcml2ZXIiKQ0KU2lnbmVkLW9mZi1i
eTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2lw
bWkvaXBtYl9kZXZfaW50LmMgYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KaW5k
ZXggOWZkYWU4M2U1OWUwLi4zODJiMjhmMWNmMmYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NoYXIv
aXBtaS9pcG1iX2Rldl9pbnQuYw0KKysrIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50
LmMNCkBAIC0yNzksNyArMjc5LDcgQEAgc3RhdGljIGludCBpcG1iX3NsYXZlX2NiKHN0cnVjdCBp
MmNfY2xpZW50ICpjbGllbnQsDQogCQlicmVhazsNCiANCiAJY2FzZSBJMkNfU0xBVkVfV1JJVEVf
UkVDRUlWRUQ6DQotCQlpZiAoaXBtYl9kZXYtPm1zZ19pZHggPj0gc2l6ZW9mKHN0cnVjdCBpcG1i
X21zZykpDQorCQlpZiAoaXBtYl9kZXYtPm1zZ19pZHggPj0gc2l6ZW9mKHN0cnVjdCBpcG1iX21z
ZykgLSAxKQ0KIAkJCWJyZWFrOw0KIA0KIAkJYnVmWysraXBtYl9kZXYtPm1zZ19pZHhdID0gKnZh
bDsNCi0tDQoyLjI0LjANCg0K
