Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC53C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACA2206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LcCVV+5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIAKSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:18:20 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:7854
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbgIAKSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnaynPn6pNmKMz7jWkTtPvkhYcChXd7MWqxs9WcX3xWWn8Dnk6dHHlKTzeg37eo5ZZa7c6f0QUoS7WPGnZDTzsm1oWtHvfSl/QD/1zEJ2MzO0zltvQR6qCGh7ZL2vYfjDnuE3W34ifUY2bCPlWKMEyZ1dRai3NHG1cYDJZcKsizeol7nERh8OrUORmZ0vyBVK3b0biVkiDbOq0fTMWlsTGJ74ogxHCdZuo3JdP78I3xqTMhdzAkoDj4xSJXrDrBE4jnfYOnJkdghRKHaFWFKOT/zKzJBNEyUh/V6y76+FvH5nc7ECl9Taur4hMjNnrNx5NuiWh7CflI8AKA9UIduVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvZn0t9/tiB9frY0EPG+SqBpJrvC8L5C9ilgujnxpYc=;
 b=nLJwcATJA4uLB3BGG7jGT1ZmgxsRPfZUx7GRKTctKSGQOqWuBXQk3xHSUTzSM9tnmV2wIShvJCZbC4y9bX/nqgFcAbr8xxHUswQ5fZBAEQNdP4klo+Di6dZoWMlTT8unrNiiERCi+Wj9z9d66XCqwBnA6aVxlvgpZth+3PnJaCWJRQicR8Wvmk/Cs+TE2rqHPPXMRQEf9nqJXIJAWdBw7LGlwnE5GhFnJ1XUdO/1PlrZUu1NbNUdDo+deWLzds6Sa7V/5d6pPQEBden1erxtRh7bxkoDyv0X36k4CJZcpB4tDpMZeXsor9nXijOZJNs/drUh7gPo0Av3WoBmyyCkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvZn0t9/tiB9frY0EPG+SqBpJrvC8L5C9ilgujnxpYc=;
 b=LcCVV+5zFdpAd901ce9IyTqnUhP+l3/+ByyvWLbmbDcKr9AKFpotqhNSZUojQeVYJvCluPIcZX7NNEYoUZxOfez45swzuoJq80QW8IT+u1q5txk7UMzOWKIXSBv0QkHxGdyMIcwGmseU4NJpOLWchLKJAuEwR1cULje56KbTIDE=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 10:18:15 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68%8]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 10:18:15 +0000
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
Thread-Index: AQHWRKh+R5kcV6bnPUCHdbQXIl+kO6kG6T4AgAGP1ICAS48gEA==
Date:   Tue, 1 Sep 2020 10:18:14 +0000
Message-ID: <DB8PR04MB67958EC5610A5AE4E7B0AB1AE62E0@DB8PR04MB6795.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 5289cb41-e96d-4068-b93f-08d84e6056f9
x-ms-traffictypediagnostic: DBAPR04MB7431:
x-microsoft-antispam-prvs: <DBAPR04MB74312EF0B18FA988FF6FC3A7E62E0@DBAPR04MB7431.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnaYxfopEkVtOddjfByumkZrSs9ptNrZmUrwli2gIAMUCKBFs4ulWTVCGumOJcwclnoZBq2VUKJdSpOuf4HGCguuLXJDaSY7J7z58Q3Xk5qOyzmi5loQQkmBL5WPLqWxseC6tjZV1DnFxmrn6oJtaFtysVJGX9a4P9psI90tbRSKFdbzMp00sTaa+/ww0+AnZpTD8q/OhMvG0HPsM+ti7tzLUNmBzpcjzXWusF4SB66g02+mEHDmZj14k7a0biX9YW3KIqXOx2Cq/VyZrcyNy5lZ8YzSbF3+eVnwXNWEz3mEjVWUePPKr7Su8UZN+XES1RqmKQPUTbVKxwKCH2QL6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(8936002)(33656002)(76116006)(55016002)(66946007)(110136005)(71200400001)(316002)(2906002)(86362001)(4326008)(66556008)(66476007)(54906003)(64756008)(66446008)(186003)(83380400001)(26005)(53546011)(7696005)(9686003)(8676002)(52536014)(6506007)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uW53tChcgMWkRmC5GQKgEFEoPHuBNiHCX6b7UIRwcpw1ChcyPAIGgXnt5+8W4b0dJyH7Y/m6Ao8Ad4H085rS5VrhR1jxuCEC/HnbfcAyXvkt/SG5OYTpMZVpeuiNp/Bz5sKqptytiGVaIdsgUm7ureGnnygUC4F+5Yddv159gPTdigtyEjetH+PI7159Uvfsk0Yjt1fKq4PoJhFqJx+mTM4jXzeNsN3sJUuGCG+2WrjKZOV1mR3O0bFhnZU/MEB51Ddf7ruPW5Z1OzLsh0YzARTyTmxa5PLMAF0K8zC4itpUiYuTzd17jzNV05lRY5LjUbA/6DLYit7/wmHdRdDJX1zbI8cSlHDYpptpYfaRkoRDpo+Cm1oFWHU74A9JluPkgM5mEutaTm+//GSvALOn848WY9tZxht3z9HNDkecTnn2pMsWHziaxm52S0pBzBA3jXa5H+hN2KOqcUnNtCDsaTjWHXHtVu67Exs+jQxcRK7tpoReiRv7Y2ZYCTRzkx8af0gfWTdAZayO3UanuBQzbrT1fb9NN12P++/Lp2znG/MJTs9ZlCrwp9PIFVBNt9WfCucAM8H43Rmew4jXBRGSexPFeed4LYPcfe7JYcyRap3kBeyfRMIpnfTvYyzLiM2TGnh96VG6N/v0IgpO/OaCBQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5289cb41-e96d-4068-b93f-08d84e6056f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 10:18:15.4534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2Rsj99AMlJLlRABas/+Dodpam5HoY5ExGU8mc6jCwpABOwwRbFAvzThOivmNdUVV6ARKUyVgLvPeYijjKq8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
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
dGVkIHVzZXJzcGFjZSBzdXBwb3J0IChpbmNsdWRpbmcgaGkxNjMwKSwgYW5kIHRoZW4NCj4gcG9z
dCBrZXJuZWwgcGFydHMgdG9nZXRoZXIgZm9yIGFsbCBkcml2ZXJzIHdlIGNvdWxkIGluaXRpYWxs
eSBzdXBwb3J0Lg0KPiANCj4gQEpvYWtpbSwgSSdsbCBwaWNrIHlvdXIgaW14IGRyaXZlciBjaGFu
Z2VzIGhlcmUsIGlmIHlvdSBkb24ndCBtaW5kLg0KDQpIaSBKb2huLA0KDQpBbnkgdXBkYXRlIGFi
b3V0IGFkZGluZyBzeXN0ZW0gcG11IHN1cHBvcnQgaW4gcGVyZiB0b29sPyBXaWxsIHlvdSBjb250
aW51ZSB1cHN0cmVhbWluZyBpdD8gRmVlbCBmcmVlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIEkg
ZG8gdGhlIHRlc3QuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0K
