Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A6C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AA3206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nQVMiFoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgELIC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:02:28 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:1039
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbgELIC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF9LnRV0uKyF685CXiHtTcPkjLjqaN0dg2f//SfadUWEQerNqeVaGToLIe4wqkKV+6AWh3CVMeGj7jjHI+H72JaRo6if2nhybcg0UxwZfNjIutboQEMZD5gXCN2p8A7VM6w6o5yB6Na8Ts/cJluXopHJRo6FP0soyoYrQle43nrOVt+9oEbACTYRh9R6gDnZGopC7W7exmJGjnjCZSYlZVQz5uSFcJqf+MHRy56B7e02e0L7o9GxjIApBPtFdu+sAUfcDLfbag8Xshx7uei+JkgtId/BBeElecp2TFDsIT80cceV143SwSGTklCKnXVBM82rgyVvT6/BC9kW+mw0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImA2sK5M8Lr87nb3UN71ZNESiq6VY/BSX/dj+vpVmFU=;
 b=Be3RX4OKKfhduvuPs0VGzsSlL7hZYbPYg8PYLUIYQMi8YYc4+iZJjPN8rUDu/GD0YuUCSxxt2Haacx2SOLpFVykvlNAsAZgr6mg+ZixqloMBsplrY/xRX5iZNuwsYXcOqwcAsM9CFI7O5zoI+y0C//lYGWfGo/JSEdLRmenos63FSUgjCAkJ0UwwgytqBWGew25GDgaFdVFJRrCP9up2EZms/3O5COCQTQ350IVfLRXRGj+JZBqwXLhrkDHb76fFp0AWxWMH3qniZABEkLM9BgWAzK1Cqb5mW1OdUktgkR8N3R+mBs3h6/aZcEFvDU5gxtytGy17+XcyxeZTfqLwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImA2sK5M8Lr87nb3UN71ZNESiq6VY/BSX/dj+vpVmFU=;
 b=nQVMiFoz+yUAMzyfLecRGAIKx1yARL+JMNOafLRPGJwQ9Qr6za7IqDxYdfwREAcBzoB+U4Y+ChA1A1W8Kf2Ur3e3uYGL7g8X3g+fskWSzK2yjLc+v8Fg+zKQulStI/GWBcE6gq4lmyiff6/CzP/xABIymsYlpl4CaKdkDhm6HKY=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6378.eurprd04.prod.outlook.com (2603:10a6:10:3d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 08:02:22 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 08:02:22 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH RFC v3 00/12] perf pmu-events: Support event aliasing for
 system PMUs
Thread-Topic: [PATCH RFC v3 00/12] perf pmu-events: Support event aliasing for
 system PMUs
Thread-Index: AQHWJGgyaiXsow/hjEO3MgQOuZnxW6ikFvuw
Date:   Tue, 12 May 2020 08:02:22 +0000
Message-ID: <DB8PR04MB6795D56E9EC43949E5F40465E6BE0@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c089227b-85cc-4077-7f2e-08d7f64acd08
x-ms-traffictypediagnostic: DB8PR04MB6378:
x-microsoft-antispam-prvs: <DB8PR04MB6378C27B9C9FD48C52E7D257E6BE0@DB8PR04MB6378.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DU6XJjEvU+EFlNLCIg9dLzYDM/KqRiMae7LChQ7pLPKrGGEa8GKEvsE1qsQp6JugkpFf2HoNVURCNqnVP8SQ7gXxnzt52XupfKKPeITijKjCwA0uqpWt+yc4oI+2b3EGOZ88E70seQ4SrUPnfl18Dtki8Ze4enj4JkayTPEqG3ujjVtDwf9LW+RKX4pNKZi+TZP1A/67OOD6jlQYbeKhsKVI8ZBR6Sjaykf7zkDj791TM9MgsMkIFFXHlBIbyXtGVMN5xeYCQPdUEHIUhkqa8XSOulR6buZmPrf7847Ju1nYcGJVjM6mh29n+zJ38xmgjdQ3czLZP3CVcV34vDh+hfZmvWHZC4FxCAyGcBhLRb5zzq0EMEtNx9k36ubnFUk1+V/Hclc2RCLBHxj9O4in/Ewi2qBz3k6lbMBYxS4JSYySjmoqGmRrx3Esu5MpeKrOa3W1/FacqtF7dyXJ4YSFdWg+8A1JgrS/T44PeKYOT88NayKVhYX41IXHbQulogN/2/1fYnMIASOOG0NblLNjwkOJt/49TCK75wMmQc2ol4O0gfEu+0A73yJp5mrz3+/10log1VGgQZe+bSj/X7i3AW7drbvz4Z5bJ/4QrxT0KUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(33430700001)(66476007)(966005)(316002)(5660300002)(55016002)(7696005)(7416002)(8676002)(86362001)(9686003)(33440700001)(76116006)(8936002)(45080400002)(2906002)(83080400001)(4326008)(186003)(66446008)(6506007)(53546011)(26005)(52536014)(54906003)(110136005)(64756008)(33656002)(66556008)(478600001)(71200400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uxRJ05Lhvzt+3YiRo7QlvkUblbkPBYHMbKUOS7PANCwKkANDeqtl/z0X+BEO+4K+wmGAV6v3bfS/bDiw0Yqu538gLqhLWeEXT5Re1tCbCe2HBxqaVb6+f3hyFMQWY5umJkbBDzmsAnNszPFbbxuUyoJn+Sm5ZfVJu7UTZNy+YTU1JxiEXng0MWMdsUdZxStrurgHByvQTkLa7/KXMc8GFYBm6/2tBh8g4iip7KKV5pxZOjcrSAVN74ADBlLl7+PkKx8YqvG2Q+DxA5Obr+8IQJjKB8QnmgS6Jn5lvndtZqCufUOxSt5gAap1sYggLKFdJ5ZIAcO79XDmL3Vl7jHixnvNVtHDybgxULKOYRDiAftJ+z6rGjoTPjab27OVqrjomeRzM+bFN5QcV8KYziAtmniLKlVSG0dM1CTlg1uQygASXA9Bcy5GWMrw9GyzJDlZMq/d0H25MP9yVYl+HyIbsffX+pWHD/auxQl1TOPdzOuDb2rlXg1rXvzcqc01viMy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c089227b-85cc-4077-7f2e-08d7f64acd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 08:02:22.2381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OB1Wck2amcZxgPaBiB6gaX153lwqE2vdptClI5/Tca8gzrnIlopj2v/a50zOhgMUZQAd1iMJpPp5NTUICfuuog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMMTqNdTCN8jVIDE5OjU4DQo+IFRvOiBwZXRl
cnpAaW5mcmFkZWFkLm9yZzsgbWluZ29AcmVkaGF0LmNvbTsgYWNtZUBrZXJuZWwub3JnOw0KPiBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsgYWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbTsN
Cj4gam9sc2FAcmVkaGF0LmNvbTsgbmFtaHl1bmdAa2VybmVsLm9yZw0KPiBDYzogd2lsbEBrZXJu
ZWwub3JnOyBha0BsaW51eC5pbnRlbC5jb207IGxpbnV4YXJtQGh1YXdlaS5jb207DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54
cC5jb20+Ow0KPiBpcm9nZXJzQGdvb2dsZS5jb207IHJvYmluLm11cnBoeUBhcm0uY29tOyB6aGFu
Z3NoYW9rdW5AaGlzaWxpY29uLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCBSRkMgdjMgMDAvMTJdIHBlcmYgcG11LWV2ZW50czogU3VwcG9ydCBldmVudCBhbGlhc2lu
ZyBmb3INCj4gc3lzdGVtIFBNVXMNCj4gDQo+IEN1cnJlbnRseSBldmVudCBhbGlhc2luZyBmb3Ig
b25seSBDUFUgYW5kIHVuY29yZSBQTVVzIGlzIHN1cHBvcnRlZC4gSW4gZmFjdCwNCj4gb25seSB1
bmNvcmUgUE1VcyBhbGlhc2luZyBpcyBzdXBwb3J0ZWQgZm9yIHdoZW4gdGhlIHVuY29yZSBQTVVz
IGFyZSBmaXhlZCBmb3INCj4gYSBDUFUsIHdoaWNoIG1heSBub3QgYWx3YXlzIGJlIHRoZSBjYXNl
IGZvciBjZXJ0YWluIGFyY2hpdGVjdHVyZXMuDQo+IA0KPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBv
cnQgZm9yIFBNVSBldmVudCBhbGlhc2luZyBmb3Igc3lzdGVtIGFuZCBvdGhlciB1bmNvcmUNCj4g
UE1VcyB3aGljaCBhcmUgbm90IHRpZWQgdG8gYSBzcGVjaWZpYyBDUFUuIE9yLCBtb3JlIHNwZWNp
ZmljYWxseSwgQ1BVcyB3aGljaA0KPiBub3QgdGllZCB0byB0aG9zZSBQTVVzLg0KPiANCj4gRm9y
IHRoaXMsIHdlIGludHJvZHVjZSBzeXN0ZW0gZXZlbnQgdGFibGVzIGluIGdlbmVyYXRlZCBwbXUt
ZXZlbnRzLmMsIHdoaWNoDQo+IGNvbnRhaW4gYSBwZXItU29DIHRhYmxlIG9mIGV2ZW50cyBvZiBh
bGwgaXRzIHN5c3RlbSBQTVVzLiBFYWNoIHBlci1QTVUgZXZlbnQgaXMNCj4gbWF0Y2hlZCBieSBh
ICJDT01QQVQiIHByb3BlcnR5Lg0KPiANCj4gV2hlbiBjcmVhdGluZyBhbGlhc2VzIGZvciBQTVVz
LCB3ZSB0cmVhdCBjb3JlL3VuY29yZSogYW5kIHN5c3RlbSBQTVVzDQo+IGRpZmZlcmVudGx5Og0K
PiANCj4gLSBGb3IgQ1BVIFBNVSwgd2UgYWx3YXlzIG1hdGNoIGZvciB0aGUgZXZlbnQgbWFwZmls
ZSBiYXNlZCBvbiB0aGUgQ1BVSUQuDQo+ICAgIFRoaXMgaGFzIG5vdCBjaGFuZ2VkLg0KPiANCj4g
LSBGb3IgYW4gdW5jb3JlIG9yIHN5c3RlbSBQTVUsIHdlIGl0ZXJhdGUgdGhyb3VnaCBhbGwgdGhl
IGV2ZW50cyBpbiBhbGwNCj4gICAgdGhlIHN5c3RlbSBQTVUgdGFibGVzLg0KPiANCj4gICAgTWF0
Y2hlcyBhcmUgYmFzZWQgb24gdGhlICJDT01QQVQiIHByb3BlcnR5IG1hdGNoaW5nIHRoZSBQTVUg
c3lzZnMNCj4gICAgaWRlbnRpZmllciBjb250ZW50cywgaW4gL3N5cy9idXMvZXZlbnRfc291cmNl
L2RldmljZXMvPFBNVT4vaWRlbnRpZmllcg0KPiANCj4gKiB1bmNvcmUgUE1VcyBtYXkgYWxzbyBi
ZSBtYXRjaGVkIGJ5IHN5c3RlbSBQTVVzIGV2ZW50IHN1cHBvcnQuDQo+IA0KPiBJbml0aWFsIHJl
ZmVyZW5jZSBzdXBwb3J0IGlzIGFsc28gYWRkZWQgZm9yIEFSTSBTTU1VdjMgUE1DRyAoUGVyZm9y
bWFuY2UNCj4gTW9uaXRvciBFdmVudCBHcm91cCkgUE1VIGZvciBIaVNpbGljb24gaGlwMDggcGxh
dGZvcm0gd2l0aCBvbmx5IGEgc2luZ2xlIGV2ZW50DQo+IHNvIGZhciAtIHNlZSBkcml2ZXIgaW4g
ZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMgZm9yIHRoYXQgZHJpdmVyLg0KPiANCj4gSGVy
ZSBpcyBhIHNhbXBsZSBvdXRwdXQgd2l0aCB0aGlzIHNlcmllcyBvbiBIdWF3ZWkgRDA2Q1MgYm9h
cmQ6DQo+IA0KPiByb290QHVidW50dTovIyAuL3BlcmYgbGlzdA0KPiAgICBbLi4uXQ0KPiANCj4g
c21tdSB2MyBwbWNnOg0KPiAgICBzbW11djNfcG1jZy5jb25maWdfY2FjaGVfbWlzcw0KPiAgICAg
ICAgIFtDb25maWd1cmF0aW9uIGNhY2hlIG1pc3MgY2F1c2VkIGJ5IHRyYW5zYWN0aW9uIG9yKEFU
UyBvcg0KPiAgICAgICAgIG5vbi1BVFMpdHJhbnNsYXRpb24gcmVxdWVzdC4gVW5pdDogc21tdXYz
X3BtY2ddDQo+ICAgIHNtbXV2M19wbWNnLmNvbmZpZ19zdHJ1Y3RfYWNjZXNzDQo+ICAgICAgICAg
W0NvbmZpZ3VyYXRpb24gc3RydWN0dXJlIGFjY2Vzcy4gVW5pdDogc21tdXYzX3BtY2ddDQo+ICAg
IHNtbXV2M19wbWNnLmN5Y2xlcw0KPiAgICAgICAgIFtDbG9jayBjeWNsZXMuIFVuaXQ6IHNtbXV2
M19wbWNnXQ0KPiAgICBzbW11djNfcG1jZy5sMV90bGINCj4gICAgICAgICBbU01NVXYzIFBNQ0cg
TDEgVEFCTEUgdHJhbnNhdGlvbi4gVW5pdDogc21tdXYzX3BtY2ddDQo+ICAgIHNtbXV2M19wbWNn
LnBjaWVfYXRzX3RyYW5zX3Bhc3NlZA0KPiAgICAgICAgIFtQQ0llIEFUUyBUcmFuc2xhdGVkIFRy
YW5zYWN0aW9uIHBhc3NlZCB0aHJvdWdoIFNNTVUuIFVuaXQ6DQo+IHNtbXV2M19wbWNnXQ0KPiAg
ICBzbW11djNfcG1jZy5wY2llX2F0c190cmFuc19ycQ0KPiAgICAgICAgIFtQQ0llIEFUUyBUcmFu
c2xhdGlvbiBSZXF1ZXN0IHJlY2VpdmVkLiBVbml0OiBzbW11djNfcG1jZ10NCj4gICAgc21tdXYz
X3BtY2cudGxiX21pc3MNCj4gICAgICAgICBbVExCIG1pc3MgY2F1c2VkIGJ5IGluY29taW5ndHJh
bnNhY3Rpb24gb3IgKEFUUyBvciBub24tQVRTKQ0KPiB0cmFuc2xhdGlvbg0KPiAgICAgICAgICBy
ZXF1ZXN0LiBVbml0OiBzbW11djNfcG1jZ10NCj4gICAgc21tdXYzX3BtY2cudHJhbnNfdGFibGVf
d2Fsa19hY2Nlc3MNCj4gICAgICAgICBbVHJhbnNsYXRpb24gdGFibGUgd2FsayBhY2Nlc3MuIFVu
aXQ6IHNtbXV2M19wbWNnXQ0KPiAgICBzbW11djNfcG1jZy50cmFuc2FjdGlvbg0KPiAgICAgICAg
IFtUcmFuc2FjdGlvbi4gVW5pdDogc21tdXYzX3BtY2ddDQo+IA0KPiANCj4gcm9vdEB1YnVudHU6
LyMgLi9wZXJmIHN0YXQgLXYgLWUgc21tdXYzX3BtY2cubDFfdGxiIHNsZWVwIDENCj4gVXNpbmcg
Q1BVSUQgMHgwMDAwMDAwMDQ4MGZkMDEwDQo+IFVzaW5nIFNZU0lEIEhJUDA4DQo+IC0+IHNtbXV2
M19wbWNnXzIwMDEwMDAyMC9ldmVudD0weDhhLw0KPiAtPiBzbW11djNfcG1jZ18yMDAxNDAwMjAv
ZXZlbnQ9MHg4YS8NCj4gLT4gc21tdXYzX3BtY2dfMTAwMDIwL2V2ZW50PTB4OGEvDQo+IC0+IHNt
bXV2M19wbWNnXzE0MDAyMC9ldmVudD0weDhhLw0KPiAtPiBzbW11djNfcG1jZ18yMDAxNDgwMjAv
ZXZlbnQ9MHg4YS8NCj4gLT4gc21tdXYzX3BtY2dfMTQ4MDIwL2V2ZW50PTB4OGEvDQo+IHNtbXV2
M19wbWNnLmwxX3RsYjogMCAxMDAxMjIxNjkwIDEwMDEyMjE2OTANCj4gc21tdXYzX3BtY2cubDFf
dGxiOiAwIDEwMDEyMjAwOTAgMTAwMTIyMDA5MA0KPiBzbW11djNfcG1jZy5sMV90bGI6IDEwMSAx
MDAxMjE5NjYwIDEwMDEyMTk2NjANCj4gc21tdXYzX3BtY2cubDFfdGxiOiAwIDEwMDEyMTkwMTAg
MTAwMTIxOTAxMA0KPiBzbW11djNfcG1jZy5sMV90bGI6IDAgMTAwMTIxODM2MCAxMDAxMjE4MzYw
DQo+IHNtbXV2M19wbWNnLmwxX3RsYjogMTM0IDEwMDEyMTc4NTAgMTAwMTIxNzg1MA0KPiANCj4g
UGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoNCj4gDQo+ICAgICAg
ICAgICAgICAgICAyMzUgICAgICBzbW11djNfcG1jZy5sMV90bGINCj4gDQo+ICAgICAgICAgMS4w
MDEyNjMxMjggc2Vjb25kcyB0aW1lIGVsYXBzZWQNCj4gDQo+IHJvb3RAdWJ1bnR1Oi8jDQo+IA0K
PiBTdXBwb3J0IGlzIGFsc28gYWRkZWQgZm9yIGlteDhtbSBERFIgUE1VLg0KPiANCj4gU2VyaWVz
IGlzIGhlcmU6DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1Yi5jDQo+IG9tJTJGaGlzaWxpY29uJTJGa2VybmVs
LWRldiUyRnRyZWUlMkZwcml2YXRlLXRvcGljLXBlcmYtNS43LXN5cy1wbXUtZXZlbnQNCj4gcy12
MyZhbXA7ZGF0YT0wMiU3QzAxJTdDcWlhbmdxaW5nLnpoYW5nJTQwbnhwLmNvbSU3QzdkYTgzM2Vm
ZDIyYg0KPiA0MzlhMTMxYjA4ZDdmMjdmNTNiYyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVj
MzAxNjM1JTdDMCU3QzAlDQo+IDdDNjM3MjQ0NTAwOTk2MjgzMDgzJmFtcDtzZGF0YT1hMFc5WGs3
Z01MR3RvVTFWbGNYQUtGM3gxZUslMkJKDQo+IG9DZjAlMkZmU0F6eENucFUlM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gDQo+IERpZmZlcmVuY2VzIHRvIHYyOg0KPiAtIGZpeHVwcyBmb3IgaW14OG1tIEpT
T05zDQo+IC0gZml4IGZvciBtZXRyaWNzIGJlaW5nIHJlcGVhdGVkIHBlciBQTVUNCj4gLSB1c2Ug
c3lzZnNfX3JlYWRfc3RyKCkNCj4gLSBmaXggdHlwbyBpbiBQTUNHIEpTT04NCj4gLSBkcm9wIGV2
c2VsIGZpeCwgd2hpY2ggc29tZW9uZSBlbHNlIGZpeGVkDQo+IA0KPiBEaWZmZXJlbmNlcyB0byB2
MToNCj4gLSBTdG9wIHVzaW5nIFNvQyBpZCBhbmQgdXNlIGEgcGVyLVBNVSBpZGVudGlmaWVyIGlu
c3RlYWQNCj4gLSBBZGQgbWV0cmljIGdyb3VwIHN5cyBldmVudHMgc3VwcG9ydA0KPiAgICAtIFRo
aXMgaXMgYSBiaXQgaGFja3kNCj4gLSBBZGQgaW14OG1tIEREUiBQZXJmIHN1cHBvcnQNCj4gLSBB
ZGQgZml4IGZvciBwYXJzZSBldmVudHMgc2VsDQo+IAktIHdpdGhvdXQgaXQsIEkgZ2V0IHRoaXMg
c3Bld2VkIGZvciBtZXRyaWMgZXZlbnQ6DQo+IA0KPiAJYXNzZXJ0aW9uIGZhaWxlZCBhdCB1dGls
L3BhcnNlLWV2ZW50cy5jOjE2MzcNCj4gDQo+IFBhdGNoZXMgc3RpbGwgbmVlZCB0byBiZSBzZW50
IHRvIHN1cHBvcnQgcGVyLVBNVSBpZGVudGlmZXIgc3lzZnMgZmlsZQ0KPiBpbiB0aGUga2VybmVs
Lg0KDQpIaSBKb2huLA0KDQpJIGhhdmUgYW4gYXNpZGUgcXVlc3Rpb24sIGRvIHlvdSBoYXZlIGFu
eSBpZGVhPyBUaGFua3MgYSBsb3QhDQoNCkZvciBERFIgUE1VLCBJIHdhbnQgdG8gYWRkIGJhbmR3
aWR0aCB1c2FnZSBtZXRyaWMsIGJ1dCBpdCBkZXBlbmRzIG9uIEREUiBjb250cm9sbGVyIGNsb2Nr
IGZyZXF1ZW5jeS4NCkZvciBleGFtcGxlLCB3ZSBoYXZlIGkuTVg4TU0gTFBERFI0IGJvYXJkIHdo
aWNoIEREUiBjb250cm9sbGVyIGNsb2NrIGlzIDgwME1IWiwgYW5kIGkuTVg4TU0gRERSNCBib2Fy
ZCB3aGljaCBERFIgY29udHJvbGxlciBpcyA2MDBNSFosIGJ1dCB0aGUgU29DIGlzIHRoZSBzYW1l
Lg0KDQpTbyB0aGV5IGNhbiBzaGFyZSBhbGwgSlNPTiBtZXRyaWNzIHdpdGggaWRlbnRpZmllciAi
aS5teDhtbSIsIGV4Y2VwdCBiYW5kd2lkdGggbWV0cmljLiBJZiBJIGFkZCBzZXBhcmF0ZSBKT1NO
IG1ldHJpY3MgZmlsZXMgZm9yIGlkZW50aWZpZXIgImkubXg4bW0tbHBkZHI0IiBhbmQgaWRlbnRp
ZmllciAiaS5teDhtbS1kZHI0IiwgdGhlbiBpdCdzIGdvaW5nIHRvIGJlIHZlcnkgcmVkdW5kYW50
LCBzaW5jZSBtb3N0IG1ldHJpY3MgYXJlIHNhbWUganVzdCB0aGUgaWRlbnRpZmllciBpcyBkaWZm
ZXJlbnQuDQoNCkRvIHlvdSBrbm93IGhvdyBwZXJmIHRvb2wgaGFuZGxlIHN1Y2ggY2FzZT8NCg0K
QmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+IFRoYW5rcywNCj4gSm9obg0KPiANCg==
