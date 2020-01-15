Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FCAC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A5624658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/kIVoZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAOBgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:36:22 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:6077
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728874AbgAOBgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:36:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NktNuNMT3Ju/Gey53gyRigi8VkAqhHjzDGSQDuczQe8qnKzlqm9giYKyB7Tq43mIBKGAObRrhQAz5r1STkhH10GCzdsYgCcikrFbxIXUAg4X7vzYxMxp8RwCOKHPlBbRUt1f3d9VAeS78q5nyBloLkGK/S2mSleNgV/rrW03kxrkbpAQJRhCAh7myGYkPZaDw/f1S5w46peKEfBq9JacqKzFXt8WKExDqOgHdAzNkeug1vjKX9OUSlE7HeE9+PHjb0nlC0uq+2V/YYhoJw+HI7Ftfo4GiB02Qj3FlDNMRKpAem8/r5frTArDvNYebfd6U3er4vqw1Qs2Vc4nVZ6/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1nuxrESq7fkePB1iArpnxeF3UxPzHURQEWTSAgH+qM=;
 b=HhSTE8VgqYCAj8u60xTANR5uMaPurC6hBPvulGCNyu8P/l9yoV9Ouun7yt1liiey+M2q2pAP5rccim1H4UsJsiwa+J7mGwSPLp17w5bt/k8DtTfGLTyhXavdXOqi6/doMSOXSJntJSXQFdrjbdkorM1Mqv/qACnePRlaAQbnY9n2M/JUa3xU3b8zdr+rfg6Bg/btpmsvBYpFamBHJ4lqwHsjWIOcuODtKzG7DXm26z3QkZb1UYI7sx5Bp+EYpUM835TL3pInsBr+cOhAtBOzJj4Ve/MdSxTTg47aYOevn6LFIShtWoZaLC/RXjvQd7ylucEHaVYflOMrbquWD+k+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1nuxrESq7fkePB1iArpnxeF3UxPzHURQEWTSAgH+qM=;
 b=O/kIVoZSNfbi2++9KXkZ51J+/9iWCQL4ix3RRWlzvuYoUCgF67jP7vYhleAJi/CPUIMo5TswM+mdkrh3MrCGQrsTrYz2IRIBwfTQ38ZPYph7USTMMoJznUMwO4n2pXFm+ZnuOwjfEH9RhZ7RoxqOSnteBE/VIM6ZtBCZ8TKB30M=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4329.eurprd04.prod.outlook.com (52.135.128.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Wed, 15 Jan 2020 01:36:17 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 01:36:17 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Will Deacon <will@kernel.org>
CC:     Frank Li <frank.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] perf/imx_ddr: Fix cpu hotplug state cleanup
Thread-Topic: [PATCH v2] perf/imx_ddr: Fix cpu hotplug state cleanup
Thread-Index: AQHVyxlAKwPV4QR1v06yTm+gg+XVJqfq8ayg
Date:   Wed, 15 Jan 2020 01:36:17 +0000
Message-ID: <DB7PR04MB4618A6E19B905A0E19E3B316E6370@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <ed960d212fb6bec383c7cdfc73362e5770bda9cd.1579033493.git.leonard.crestez@nxp.com>
In-Reply-To: <ed960d212fb6bec383c7cdfc73362e5770bda9cd.1579033493.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bf563c8-29bd-40dd-7f98-08d7995b512b
x-ms-traffictypediagnostic: DB7PR04MB4329:|DB7PR04MB4329:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB43293DBD400C135D563567E6E6370@DB7PR04MB4329.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(189003)(199004)(54906003)(71200400001)(2906002)(33656002)(4326008)(5660300002)(110136005)(66556008)(66476007)(81166006)(64756008)(86362001)(52536014)(66446008)(26005)(66946007)(81156014)(186003)(8936002)(9686003)(8676002)(478600001)(55016002)(53546011)(4744005)(316002)(76116006)(6506007)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4329;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETefVQ4neMTBR0K5wnPFrnvLJgV4kgQRXb7wlKj6+iEVG904+fnE1GHhMAwqT6Lib8LwVrOk58GXn7NdCKLJQQX19voCMm2fp5AyFdzAwPM9YSQ5iA21cjVAF09YpRRUwMzHaBuUQcnM8EJ7YCWRGLkjYpWlu3VaAhcmvcF0EEEQMYQ9kD0GKvyU4H5wZ+DzzDdTmPhtOb2/RyO0g1S3OHcVqK7KQBGMGMTdFHVjvfYTqpHitwCEYWBNy6djumfyaPBPi4LNstPDei9vs5rG9Jw0gDglnyzhmgi3j7AYwUzt+Muav6V1IgEWMYt/uwsKo9/cfwO4h6CmGpeQuNVoBQ5IuTuEfZDeIJQVk/nA6wx90UguxZpyUCd9gM1rWd9Fc4LOvbF3WYfphmw82cp2HZO8pR2+Bv4zNE0GC94NKr45gHJleI6sUiOL61fT1PNr
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf563c8-29bd-40dd-7f98-08d7995b512b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 01:36:17.7714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QHDZyF9P/Zhaeo0IYlRg/745lllQ8bvO83qOGT+cL+MqLlCDoL6rPx5i2kxkYzasSdH68MqgGHi6vC1pFmfew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExlb25hcmQgQ3Jlc3RleiA8
bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+DQo+IFNlbnQ6IDIwMjDE6jHUwjE1yNUgNDoyNg0KPiBU
bzogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IFdpbGwgRGVhY29uIDx3
aWxsQGtlcm5lbC5vcmc+DQo+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IE1hcmsg
UnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+Ow0KPiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47DQo+IEFybmFs
ZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBrZXJuZWwub3JnPjsgQWxleGFuZGVyIFNoaXNoa2lu
DQo+IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xz
YUByZWRoYXQuY29tPjsNCj4gTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIHBlcmYvaW14
X2RkcjogRml4IGNwdSBob3RwbHVnIHN0YXRlIGNsZWFudXANCj4gDQo+IFRoaXMgZHJpdmVyIGFs
bG9jYXRlcyBhIGR5bmFtaWMgY3B1IGhvdHBsdWcgc3RhdGUgYnV0IG5ldmVyIHJlbGVhc2VzIGl0
Lg0KPiBJZiByZWxvYWRlZCBpbiBhIGxvb3AgaXQgd2lsbCBxdWlja2x5IHRyaWdnZXIgYSBXQVJO
IG1lc3NhZ2U6DQo+IA0KPiAJIk5vIG1vcmUgZHluYW1pYyBzdGF0ZXMgYXZhaWxhYmxlIGZvciBD
UFUgaG90cGx1ZyINCj4gDQo+IEZpeCBieSBjYWxsaW5nIGNwdWhwX3JlbW92ZV9tdWx0aV9zdGF0
ZSBvbiByZW1vdmUgbGlrZSBzZXZlcmFsIG90aGVyIHBlcmYgcG11DQo+IGRyaXZlcnMuDQo+IA0K
PiBBbHNvIGZpeCB0aGUgY2xlYW51cCBsb2dpYyBvbiBwcm9iZSBlcnJvciBwYXRoczogYWRkIHRo
ZSBtaXNzaW5nDQo+IGNwdWhwX3JlbW92ZV9tdWx0aV9zdGF0ZSBjYWxsIGFuZCBwcm9wZXJseSBj
aGVjayB0aGUgcmV0dXJuIHZhbHVlIGZyb20NCj4gY3B1aHBfc3RhdGVfYWRkX2luc3RhbnRfbm9j
YWxscy4NCj4gDQo+IEZpeGVzOiA5YTY2ZDM2Y2M3YWMgKCJkcml2ZXJzL3BlcmY6IGlteF9kZHI6
IEFkZCBERFIgcGVyZm9ybWFuY2UgY291bnRlcg0KPiBzdXBwb3J0IHRvIHBlcmYiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KQWNr
ZWQtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQoNCkJlc3QgUmVn
YXJkcywNCkpvYWtpbSBaaGFuZw0K
