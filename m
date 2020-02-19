Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ADAC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF7824656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OD2mC7fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBSMkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:40:25 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:13441
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727263AbgBSMkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:40:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvTBH5O6NyIVJwuHJ8GTPQJ15FMAjrM3XHy+pjedIm7TaCIBGwr0045LBh9f27mzPuupVNcM/2ugtmFgQW9YJOS/glLukJCjt5Q5G/AAB8/EexQTrlCQFxF2OYvf/kriOnuWkjSTPdqwS474p46xoQs8jT8iRIVdw2/XwPKjT3/jH2xJUWm6iiOVHrGnLWwBwWcmGzG96IermsQG6zX6wDcxwZBAgXtMoijj/bueLsG6weOz1yjmETN9G+z1T85Na13t6UYEHK6WSTbbBcc0QV66398+JLd2+Th+xownifJWR5v559SSuDJtCcb2CM8v1dtldQOaHZgEJ4BboPLvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhrJJsVHM62MaZVXf4L3d/ND4/PIqzppZgkeGiVeRqY=;
 b=TP2HpBoymYbWvcfd9tkWj3d76n26/h9NMagkYSqD5DUno6GjBc0OaIKT7kyOVy/D9I+j1zK6Trvr50zCORgY6Bk1TTGfeuWFgefz76PvMdLpxxxnIyOzm3YyApXquCh0Rwap9n/NQGp/jb7EEscMu4YC09dFDhFfwYXixSxwxJPw2yaoysotNJMVx3gsTFyLjHEY+T35p5W1GnC7jay7T8Km+vmFdwoenJDzjXxGNIkUcYngYIfb75Wmv21GNFT65rrK2fX/bSGuOXaukU7IdZ5AHzj7fQNkrJcAYxpL4THu8ZdzkqgCXRVE0w2mPVjunKG7bDVbaShCG98KCUWF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhrJJsVHM62MaZVXf4L3d/ND4/PIqzppZgkeGiVeRqY=;
 b=OD2mC7fwFuxMgFXxnFiHO28YxgdpGo0HoVltcenJBmP44WkAKORG4eImW69b3Dl5K2YEJ8BUZcMF5f9BN+Zf8qqc5jIH2o3zEld24N1M2IQpsI8J1LOUPbDmBkH+V+wK9zvhJZxBuFohwo4lIxu340WtdanVaJu/fPn5NpfmxLs=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5401.eurprd04.prod.outlook.com (20.178.104.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 12:40:17 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 12:40:17 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: RE: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
Thread-Topic: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
Thread-Index: AQHV5nc2eARks93Kg0mXKllKiXweZKghLweAgAAOKwCAAAQfgIAAdZ8QgAB9owCAAEDm0A==
Date:   Wed, 19 Feb 2020 12:40:17 +0000
Message-ID: <DB7PR04MB46184AA7765C2393E2BE241CE6100@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <20200218125707.GB20212@willie-the-truck>
 <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
 <20200218133943.GF20212@willie-the-truck>
 <627cbc50-4b36-7f7f-179d-3d27d9e0215a@huawei.com>
 <20200218170803.GA9968@lakrids.cambridge.arm.com>
 <cb004f43-b2a4-ae23-9fd3-0f70bd69701b@huawei.com>
 <20200218181331.GB9968@lakrids.cambridge.arm.com>
 <DB7PR04MB46188F06D6CEA1430712E648E6100@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <b6781341-3d28-bda8-621b-aeca413dc8ae@huawei.com>
In-Reply-To: <b6781341-3d28-bda8-621b-aeca413dc8ae@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [222.93.234.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4e0dfda-5661-4728-f55a-08d7b538dffe
x-ms-traffictypediagnostic: DB7PR04MB5401:
x-microsoft-antispam-prvs: <DB7PR04MB540120179233667287D61440E6100@DB7PR04MB5401.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(7696005)(26005)(52536014)(8936002)(71200400001)(186003)(8676002)(81166006)(81156014)(7416002)(55016002)(9686003)(4326008)(86362001)(5660300002)(53546011)(6506007)(64756008)(66446008)(66556008)(2906002)(478600001)(33656002)(316002)(110136005)(66476007)(76116006)(54906003)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5401;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: du7fQXGNugjsRMDvnbxTZE1DopCFeoFU0UndBB14egTu6mSg3fMxzW3iFmG7xJyREkGevTsVPaoNni+A3i+zB3jL3TnQRNZ4OVOUFzHIpGJul/ypN7ComX1UOup3Sr8wWUDcTz46ud4QePFZy6brUdBk0El4i8aISKO+f9Zo3jyui1T/QRN9ytYa+0Mv2PkckmIfqK+RRfEXg//8ar7R6lH7Yv2VLHc0+nIvv5Cu/ZEuq79pEzsWFCHs6zR5A32Sz/Le3P9uWSLwDwTt+KwzId+QgGuavY/7fJEc95RCvyFIHzFAxCFR3k1cTwKJc+bLa2g4RFFknCzX/WPXBNeklsepuF9+RezoZrqDfl2Vhhu+nx+HAXe2yB9X0iF8vyfCBXUPn2WbbweVKT/GqzYkxOFDBetepZP2+WHzAJY2YNgsgvzOjgApjpDY2NZBngIG
x-ms-exchange-antispam-messagedata: tsVDW9791xJbytAkihWPKQTcZQ9G++cP/XBO6m6B8cICOZwJ2lRhfUFS3zzojdtygI5pYfQr4f57mElnQDmpwCJKDvV+LT/AoySp5e5cZCpvupX/XliMs9N/rj+i+lYivpg5DSLbK6S6Z40xpGVDag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e0dfda-5661-4728-f55a-08d7b538dffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 12:40:17.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZsrANpSmqFwYHkaQvCixqr9To1Sa4bY5B82PLfuJ7vvKN77ypySrlNWCQnLvfi6Nqhr74L5i5p8i4tV31CMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMMTqMtTCMTnI1SAxNjo0NA0KPiBUbzogSm9h
a2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IE1hcmsgUnV0bGFuZA0KPiA8bWFy
ay5ydXRsYW5kQGFybS5jb20+DQo+IENjOiBha0BsaW51eC5pbnRlbC5jb207IHN1enVraS5wb3Vs
b3NlQGFybS5jb207IHBldGVyekBpbmZyYWRlYWQub3JnOyBXaWxsDQo+IERlYWNvbiA8d2lsbEBr
ZXJuZWwub3JnPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0KPiBhY21lQGtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFpoYW5nc2hhb2t1bg0KPiA8emhh
bmdzaGFva3VuQGhpc2lsaWNvbi5jb20+OyBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwu
Y29tOw0KPiBtaW5nb0ByZWRoYXQuY29tOyBqYW1lcy5jbGFya0Bhcm0uY29tOyBuYW1oeXVuZ0Br
ZXJuZWwub3JnOw0KPiBqb2xzYUByZWRoYXQuY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IHJvYmluLm11cnBoeUBhcm0uY29tOyBTdWRlZXAgSG9sbGEgPHN1ZGVl
cC5ob2xsYUBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyAwLzddIHBlcmYgcG11
LWV2ZW50czogU3VwcG9ydCBldmVudCBhbGlhc2luZyBmb3INCj4gc3lzdGVtIFBNVXMNCj4gDQo+
IE9uIDE5LzAyLzIwMjAgMDE6NTUsIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0
bGFuZEBhcm0uY29tPg0KPiA+PiBTZW50OiAyMDIwxOoy1MIxOcjVIDI6MTQNCj4gPj4gVG86IEpv
aG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4gPj4gQ2M6IGFrQGxpbnV4LmludGVs
LmNvbTsgSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47DQo+ID4+IHN1enVr
aS5wb3Vsb3NlQGFybS5jb207IHBldGVyekBpbmZyYWRlYWQub3JnOyBXaWxsIERlYWNvbg0KPiA+
PiA8d2lsbEBrZXJuZWwub3JnPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBhY21l
QGtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFpoYW5nc2hh
b2t1bg0KPiA+PiA8emhhbmdzaGFva3VuQGhpc2lsaWNvbi5jb20+OyBhbGV4YW5kZXIuc2hpc2hr
aW5AbGludXguaW50ZWwuY29tOw0KPiA+PiBtaW5nb0ByZWRoYXQuY29tOyBqYW1lcy5jbGFya0Bh
cm0uY29tOyBuYW1oeXVuZ0BrZXJuZWwub3JnOw0KPiA+PiBqb2xzYUByZWRoYXQuY29tOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IHJvYmluLm11cnBoeUBhcm0u
Y29tOyBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPiA+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIFJGQyAwLzddIHBlcmYgcG11LWV2ZW50czogU3VwcG9ydCBldmVudCBhbGlhc2lu
Zw0KPiA+PiBmb3Igc3lzdGVtIFBNVXMNCj4gPg0KPiA+IFsuLi5dDQo+ID4+PiBBbmQgdHlwaWNh
bGx5IG1vc3QgUE1VIEhXIHdvdWxkIGhhdmUgbm8gSUQgcmVnLCBzbyB3aGVyZSB0byBldmVuIGdl
dA0KPiA+Pj4gdGhpcyBpZGVudGlmaWNhdGlvbiBpbmZvPyBKb2FraW0gWmhhbmcgc2VlbXMgdG8g
aGF2ZSB0aGlzIHByb2JsZW0NCj4gPj4+IGZvciB0aGUgaW14OCBERFJDIFBNVSBkcml2ZXIuDQo+
ID4+DQo+ID4+IEZvciBpbXg4LCB0aGUgRFQgY29tcGF0IHN0cmluZyBvciBhZGRpdGlvbmFsIHBy
b3BlcnRpZXMgb24gdGhlIEREUkMNCj4gPj4gbm9kZSBjb3VsZCBiZSB1c2VkIHRvIGltcGx5IHRo
ZSBpZC4NCj4gPg0KPiA+IEhpIE1hcmssDQo+ID4NCj4gPiBZZXMsIGFjdHVhbGx5IHdlIGNhbiBl
eHBvc2Ugc29tZXRoaW5nIGxpa2UgRERSQ19JRCB0byBpbmRpY2F0ZSBlYWNoIHNwZWNpZmljDQo+
IEREUiBjb250cm9sbGVyLCB0byBwb2ludCBvdXQgdGhlIGZpbHRlciBmZWF0dXJlLg0KPiA+IEJ1
dCwgZXZlbiB0aGUgU29DcyBpbnRlZ3JhdGVkIHRoZSBzYW1lIEREUkNfSUQsIGp1c3Qgc2F5IHRo
YXQgdGhleSBoYXZlIHRoZQ0KPiBzYW1lIEREUkMgY29udHJvbGxlci4NCj4gPg0KPiA+ICBGcm9t
IHVzZXIgc3BhY2UsIHRoZSB1c2FnZSBpcyBkaWZmZXJlbnQsIGZvciBleGFtcGxlOg0KPiA+DQo+
ID4gaS5NWDhNTSBhbmQgaS5NWDhNTiwgdGhleSB1c2UgdGhlIHNhbWUgZHJpdmVyKEREUkNfSUQp
IGFuZCBjb3J0ZXgtYTUzDQo+IGludGVncmF0ZWQuDQo+ID4NCj4gPiBJZiB3ZSB3YW50IHRvIG1v
bml0b3IgVlBVLCB0aGVpciAqbWFzdGVyIGlkKiBpcyBkaWZmZXJlbnQgZnJvbSBTb0NzLg0KPiA+
IE9uIGkuTVg4TU0sIGV2ZW50IGlzIGlteDhfZGRyMC9heGlkLXJlYWQsYXhpX2lkPTB4MDgvIE9u
IGkuTVg4TU4sDQo+ID4gZXZlbnQgaXMgaW14OF9kZHIwL2F4aWQtcmVhZCxheGlfaWQ9MHgxMi8N
Cj4gPg0KPiA+IEkgdHJ5IHRvIHdyaXRlIGEgSlNPTiBmaWxlIHRvIHVzZSB0aGVzZSBldmVudHMs
IGZvciBub3csIEkgb25seSBjYW4NCj4gPiBsb2NhdGUgdGhlIGZpbGUgYXQgdGhlIGRpcmVjdG9y
eToNCj4gPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9hcm0vY29ydGV4LWE1My8N
Cj4gPg0KPiA+IFBlcmYgdG9vbCBsb2FkcyBhbGwgZXZlbnRzIHdoZW4gQ1BVSUQgbWF0Y2hlZCwg
d2hpY2ggaXMgbm93IHVucmVhc29uYWJsZSwNCj4gd2Ugd2FudCByZWxhdGVkIGV2ZW50cyBhcmUg
bG9hZGVkIGZvciBzcGVjaWZpYyBTb0MuDQo+IA0KPiBzbyB3ZSBjb3VsZCBoYXZlIGEgZm9sZGVy
IGxpa2UgLi4uL2FyY2gvYXJtNjQvbnhwL3N5c3RlbSBmb3IgdGhlc2UgSlNPTnMuIFRoZQ0KPiBw
ZXJmIHRvb2wgY2FuIGJlIHVwZGF0ZWQgdG8gaGFuZGxlIENQVSBhbmQgc3lzdGVtIGV2ZW50cyBp
biBzZXBhcmF0ZSBmb2xkZXJzLg0KPiANCj4gPg0KPiA+IEFsbCBldmVudHMgd2lsbCBhbHNvIGJl
IGxvYWRlZCBpZiB3ZSB1c2UgRERSQ19JRCB0byBtYXRjaCBpbiB0aGUgZnV0dXJlLCB0aGlzDQo+
IHNlZW1zIHRvIG5vdCBiZSBhIGdvb2QgaWRlYWwuDQo+IA0KPiBUaGUgaW1wb3J0YW50IHBhcnQg
aXMga25vd2luZyB3aGljaCBldmVudHMgYXJlIHN1cHBvcnRlZCBwZXIgaW1wbGVtZW50YXRpb24u
DQo+IElzIHRoZXJlIGFueSBtZXRob2QgaW4gdGhlIGRyaXZlciBvZiBrbm93aW5nIHRoZSBzcGVj
aWZpYyBpbXBsZW1lbnRhdGlvbiwgbGlrZQ0KPiBhbnkgRFQgY29tcGF0IHN0cmluZz8gTGVhc3Qg
cHJlZmVycmVkIG9wdGlvbiB3b3VsZCBiZSBEVCBtYWNoaW5lIElELg0KDQpJIHRoaW5rLCBOTywg
bWFzdGVyIGlkIGNvdWxkIGJlIGRpZmZlcmVudCBldmVuIHRoZXkgdXNlIHRoZSBzYW1lIERUIGNv
bXBhdGlibGUgc3RyaW5nLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gPg0KPiAN
Cj4gSm9obg0K
