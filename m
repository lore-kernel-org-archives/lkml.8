Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F3420657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lCsU6ZQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGOI2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:28:51 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:28035
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727104AbgGOI2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:28:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXMUTAvBpcbMD2giBmaAjizAwt5m8sbiVQXgwhinmazmkK2J9qNTMsQSAGyjSA+dbLB35oRQqQfOWnZjlc9zvxoCkQ37RMJPI6ijs36fbET88+lejVablZH1RPz6ewti5W5yqPmkAMc1J74u6CGIbpz8GSe4ukijpZsmzdCyF095uFRAkfPrqB2Vm1YEo/eLvSutgzwATa19sD1eBpWRtBZXwsqm+6ffpdYOwz0aWu6A/IiSqJw56LAzxl+cNlLmwnpWMTVEjH7QsPlijMMYMxEzhB77JtvWaoBm5UFbjYWhmpPXTB2wZi+x3WVXEE82wq/r7UZ+jH5hyby6LVGO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uIBomvTec/wY5plplc5997Bj6U6XLfZszNDs6518PI=;
 b=VfK7P0NTgoEFPrOIT1HOFzISBgK5Mqq+H/Ts5000rqgYDCS87CG1NlosAT1K3P5WgqlGXQ2jQ+7EkCU0TOXPS+6AiKnUWTYGiiqmK0HAVgC1liD0BxtmsZ6/q7maW0vzY8hzDLADbLkGltEs4FWWpMJ4qis+EAvwToOeF6oIiksh7YtAo1gIQ0pNHu9pGvlhZPRzi/E0+7k+eXEo0xNqHhpZ37Dbw0mcIMPIbOFdTEk7nFZX+7tHz5E0gM36JMAS8bjPV14Vpwdyegxs58LpiBgEHOwiKiVJ/yM/mywwU7sKWOY6s9FA7PPskifhig0czO/HIvklIlmKyf5NseOdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uIBomvTec/wY5plplc5997Bj6U6XLfZszNDs6518PI=;
 b=lCsU6ZQUoXWyAdcn7GqLSDAixBq7eGPlVwqjWdsYZ3PT0Awfjtqvg8vPQOKOyv2WkehwMNsrMvaflqzojwZvAWc/TaqxPowK4er+zT2ll+JKbzYzQa7Svyi91SCPfNpBnfpvUsvMxXabDycjvEfySRInqpy/xJsZ2jtgWmb2QTg=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5787.eurprd04.prod.outlook.com (2603:10a6:10:ac::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 08:28:46 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066%9]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 08:28:46 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
CC:     "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH] drivers/perf: hisi: Add identifier sysfs file
Thread-Topic: [PATCH] drivers/perf: hisi: Add identifier sysfs file
Thread-Index: AQHWRKh+R5kcV6bnPUCHdbQXIl+kO6kG6T4AgAGP1ICAAAEwsA==
Date:   Wed, 15 Jul 2020 08:28:46 +0000
Message-ID: <DB8PR04MB6795A40A0FA16B7153819384E67E0@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1592399111-134786-1-git-send-email-john.garry@huawei.com>
 <20200714083216.GD4516@willie-the-truck>
 <67db3c30-5aaf-ac17-0256-950494f5ba88@huawei.com>
In-Reply-To: <67db3c30-5aaf-ac17-0256-950494f5ba88@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96b2cbc4-4ca8-4fff-33c0-08d828991776
x-ms-traffictypediagnostic: DB8PR04MB5787:
x-microsoft-antispam-prvs: <DB8PR04MB5787C55253EDAD1BA6644222E67E0@DB8PR04MB5787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ApMUEdR20+2HDRBG7+mcMhbQexn6eDBAhsLeEe352lmD4CfEESnnPJhlroM34RMVQnY/q2wbk6H2nkVaDSGdfAcMOLnfHl8UfFrJvD3INTOIQV0XssEDpbOi1tI0cK6pg4TIHt4DqV8VfbxqmPZ7kFBNwvwyt2Pagle9BubPSt2mn15n9nQf0NYmwtjbM6Sj7XDtgZLf6SPRuUgJJMhxi7lphqCacc8+bKNABwR8BbL9ItUKZkLWOC5J75oJ3EBSFijHpYL0UY+QJcEhOy5M/x8PlEczpuDvjpFqXLL3nrjPHelR4QALQ8HhvNu9B+VFVCydKknEoEka9cgFSJ5Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(55016002)(6506007)(83380400001)(8676002)(9686003)(54906003)(478600001)(52536014)(2906002)(7696005)(53546011)(71200400001)(8936002)(4326008)(316002)(86362001)(76116006)(33656002)(66556008)(66946007)(64756008)(66476007)(66446008)(26005)(5660300002)(186003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: X6iSEhABUSQSeuXK69OXAwQg3dzCrOOjCX5wqVfAdFIyw8O9xnJy2XzPENbUPYZ1lfUZgYeXAlN8MqtZmlcDR3/BfLv6im6VuNkj1uQYSrk/1rxKA0e5Z/YH29MnDkrKg358Q0vP+g6b+OgSna9LsSTdiOs2YkdVTrDcXDfS/jPyl+r2K0N6za56+Lmt1G0PdzecCX7bcEkQ6OE8domDdQYawphnwXTERuXwhSp4nKR8xPFbK3dp7qa7BT4D4HeL3OqsFTSSpvA7oQqd3rj0RhVNvOO5rDoxhI9hrZMBPZEdrt/Gg3RJioAiaz7ml5WLJ/bY0s64NkpJGWSz1+eWx4U4eA2hEWKNiP2MehvhYMJfiRDl5vodFUAonJukY6ZTMjyMDZZASRrball+BbCfL5DGQ5P26435LcZLtnan+vXhRG7tf6psppxRCeMO3ZYE7tAbPMJl8N4WvBOiWwC6dJK8v4Yl7mOtVcGs6+DXq0g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b2cbc4-4ca8-4fff-33c0-08d828991776
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 08:28:46.1236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7g1qyOTLgfzoDtADDyniK6ZTPUlUIGmHNwoei6vCZppGkIqHTpdESeGeQeEHop+dh/cYu8Iww7rEsvh6YfD+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMOW5tDfmnIgxNeaXpSAxNjoyMw0KPiBUbzog
V2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4gQ2M6IHpoYW5nc2hhb2t1bkBoaXNpbGlj
b24uY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKb2FraW0NCj4gWmhh
bmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgam9sc2FAcmVkaGF0LmNvbTsNCj4gbGludXhh
cm1AaHVhd2VpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcml2ZXJzL3BlcmY6IGhpc2k6
IEFkZCBpZGVudGlmaWVyIHN5c2ZzIGZpbGUNCj4gDQo+IEhpIFdpbGwsDQo+IA0KPiA+DQo+ID4g
T24gV2VkLCBKdW4gMTcsIDIwMjAgYXQgMDk6MDU6MTFQTSArMDgwMCwgSm9obiBHYXJyeSB3cm90
ZToNCj4gPj4gVG8gYWxsb3cgdXNlcnNwYWNlIHRvIGlkZW50aWZ5IHRoZSBzcGVjaWZpYyBpbXBs
ZW1lbnRhdGlvbiBvZiB0aGUNCj4gPj4gZGV2aWNlLCBhZGQgYW4gImlkZW50aWZpZXIiIHN5c2Zz
IGZpbGUuDQo+ID4+DQo+ID4+IEVuY29kaW5nIGlzIGFzIGZvbGxvd3M6DQo+ID4+IGhpMTYyMDog
MHgwCShha2EgaGlwMDgpDQo+ID4+IGhpMTYzMDogMHgzMA0KPiA+Pg0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo+ID4NCj4gPiBJJ20gc3Ry
dWdnbGluZyBhIGJpdCB0byB0cmFjayB0aGlzLiBJZiB5b3Ugc3RpbGwgdGhpbmsgaXQncyB3b3J0
aA0KPiA+IHB1cnN1aW5nLCBwbGVhc2UgY291bGQgeW91IHBvc3QgYSBzZXJpZXMgd2l0aCBhIGNv
dmVyLWxldHRlcg0KPiA+IGRlc2NyaWJpbmcgd2hhdCB0aGlzIGlzIGZvciwgYSBsaW5rIHRvIHRo
ZSB1c2Vyc3BhY2UgY2hhbmdlcyBhbmQgdGhlbg0KPiA+IHBhdGNoZXMgZm9yIGFsbCB0aGUgUE1V
IGRyaXZlcnMgdGhhdCBuZWVkIHVwZGF0aW5nPw0KPiANCj4gVGhlcmUgaXMgbm8gaGkxNjMwIHVz
ZXJzcGFjZSBzdXBwb3J0IHlldC4NCj4gDQo+IFNvIHdoYXQgSSBjYW4gZG8gaXMgcG9zdCB1cGRh
dGVkIHVzZXJzcGFjZSBzdXBwb3J0IChpbmNsdWRpbmcgaGkxNjMwKSwgYW5kDQo+IHRoZW4gcG9z
dCBrZXJuZWwgcGFydHMgdG9nZXRoZXIgZm9yIGFsbCBkcml2ZXJzIHdlIGNvdWxkIGluaXRpYWxs
eSBzdXBwb3J0Lg0KPiANCj4gQEpvYWtpbSwgSSdsbCBwaWNrIHlvdXIgaW14IGRyaXZlciBjaGFu
Z2VzIGhlcmUsIGlmIHlvdSBkb24ndCBtaW5kLg0KDQpPZiBjb3Vyc2UgeW91IGNhbi4NCg0KQmVz
dCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+IFRoZXJlIHdhcyBhbiBSRkMgZnJvbSB5b3UgZm9y
IHRoZSBTTU1VdjMgUE1VIGFzDQo+ID4gd2VsbCwgYW5kIGFsc28gc29tZSBvdGhlciAiYXJtNjQi
IGNoYW5nZXMuDQo+ID4NCj4gDQo+IEkgaG9wZSB0byBkcm9wIHRoYXQgUkZDIGlmIGFuIHVwZGF0
ZWQgU01NVXYzIHNwZWMgaGVscHMgdXMgb3V0Lg0KPiANCj4gQ2hlZXJzLA0KPiBKb2huDQoNCg==
