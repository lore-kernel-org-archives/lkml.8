Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561F8C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E79B2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="SB/c4L7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBLKRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:17:01 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:49308 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgBLKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:17:00 -0500
Received: from [100.113.7.232] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 4E/23-52742-890D34E5; Wed, 12 Feb 2020 10:16:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJsWRWlGSWpSXmKPExsWSoc9qpjvjgnO
  cwZSNohZXLh5isljT3MFkMfXhEzaLE4cbmS2+XQFyL++aw2ax498mNotf/58xWdzb8IzZ4u66
  vywWG76vZXTg9tjwuYnNY+esu+weCzaVeize85LJY9OqTjaPeScDPdZvucri8XmTXABHFGtmX
  lJ+RQJrxpR5x1kK7ktXvFpwm7WBcYN0FyMXB6PAUmaJk53P2CGcYywSZ1fvZ4JwNjNK/O79yQ
  bisAicYJZ4/r+BpYuRk0NIoJ9J4sZlEZCEkMBdRomNf7tYQRJsAhYSk088YAOxRQRKJH7u+go
  2l1ngP7PEo4+vgRwODmGBYImJKzggakIk/k1vZoKwkyXmnz3FDFLCIqAqMa1NB8TkFYiVOHkh
  AGLVLBaJrsVtjCDlnALOEofXfGIGsRkFZCW+NK4Gs5kFxCVuPZkPNlJCQEBiyZ7zzBC2qMTLx
  /9YIepTJU423WCEiOtInL3+BMpWlNhzbiFUr6zEpfndUHFfia9931ghbC2JX3NeQdkWEku6W1
  lA7pQQUJH4d6gSIpwj8aP5NlSrukTLx3lQ5TISq2eug7J/MEtc+Kk9gdFgFpKrZwFNYhbQlFi
  /Sx8irCgxpfshO4jNKyAocXLmE5YFjCyrGC2TijLTM0pyEzNzdA0NDHQNDY11TXSNTE31Eqt0
  k/RSS3WTU/NKihKBsnqJ5cV6xZW5yTkpenmpJZsYgekvpZDl/w7GLWvf6x1ilORgUhLl/bDPO
  U6ILyk/pTIjsTgjvqg0J7X4EKMMB4eSBG/SeaCcYFFqempFWmYOMBXDpCU4eJREeOVB0rzFBY
  m5xZnpEKlTjMYcE17OXcTMcWTu0kXMQix5+XmpUuK8vSClAiClGaV5cINgOeISo6yUMC8jAwO
  DEE9BalFuZgmq/CtGcQ5GJWHeCyBTeDLzSuD2vQI6hQnolOsmDiCnlCQipKQagPkofvMtY+7+
  zzod+24bcSj8d42w8BKTM+hXvxTDOCPo7cMJXp1ZXy61vl1a+HLmmfpDyW8KPISDrGMkmy3tR
  P9ohKpGJnT9Wax1z72ytY8p0PBOp7+tnITVfs9JHqKxHvJs1UI3hCPu2pV/PMFl072QcZZwuM
  z78MPC0y5Y+JxhON8+07p+pdmkxLMeedc1Jmk/sl5zO0HFafWVTTXffRS8F2+9WfjMvtV2puA
  Sxfus8xff/egZoHPvztHsw6u5055bNX9Y3WSW9ml3P6cnt7fAhkO6+48IrQ/l/SSY4MTJ8GXS
  JeVlycnBBbVH93t9nslxbXlx8YZvN1bG5qZtflwZXnziTPD82AWhl6KUWIozEg21mIuKEwFLE
  hJKjAQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-239.messagelabs.com!1581502615!1837697!1
X-Originating-IP: [104.47.5.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13186 invoked from network); 12 Feb 2020 10:16:56 -0000
Received: from mail-he1eur02lp2054.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.54)
  by server-18.tower-239.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2020 10:16:56 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNzhalljz30VyKNMwHYAexgSGWHckR+WV6drhUaYfL+nP/0Wz+PoVfzwDjKA+B1qfBF4XYdlFOKYGihFWUQK+e/bpBT6Y12ny6K3hBOKEbOKsHrCMQoE7hiUHJXcJqvbovK7jafpBGy17LCoDsSEAjFHokV5loOHXWHvbOlmdJmucY34CTzBbniGId1uE2sAUAvgIYx7toszDdiFrJ7yY8YJ8KKmgf8qheCMjtKt9aX451Nu0C4hA8hZfKVd5iwdMyxp+xWhOFwhD25epwtCav8345mOQkb6qLCLQD+tW6DF2tzIlVeJo2tTWRopzubz0f3gUQHo7WTLWXFlJiHSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL5z0IQN8nPjfLa7y55pd4S/swq1/i7vszDW4b9nwQw=;
 b=d0ywPr1CiuCvNQnXLkQCjR35tsluE1zWdBz3TTmVhFw15aIjqQCSJ1m7MwG3VSALQtBj+n3nv3CVwJuxOXiPvpN1iWtnMryYDjLFH0M8Q8REuMa9Sp00S1eMUVaWFAMTYaD9L+3hGNDwXj2oWDJWVS6et30gWcUYe0KWaK/PtjK1+4/A0+tc1laC4EcqMZSqKlQYGX8GlML0GmmkVo8l2OgmPct601waNWB4m4ZMw8cEeugNk0FKodpw+x0e8DZVUPs4UZERltugMwA3iCUSnNqU0cC/MT/06SBJUaHa/lremjUa1+Ii46wXPh8mZ+4Gw4+E8ea3lnYbh43OCcTVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL5z0IQN8nPjfLa7y55pd4S/swq1/i7vszDW4b9nwQw=;
 b=SB/c4L7qy5SijWh+/mT0TPf7ACpnjuUjS1ueAZyy7PU3UzRBDWcAU8xNuF0Dp4a8p/AYVGwxiPQWtSEaF877VGBq0zrBzdNESQs6GZktOdq3pgQCoNUc4O3VolPZE60C9XZeM1+xc1S33W/b6dgS2ywIolrgS9QHHqbfmQXnwrA=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2840.EURPRD10.PROD.OUTLOOK.COM (20.179.1.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 10:16:54 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 10:16:54 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        "cychiang@google.com" <cychiang@google.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
Thread-Topic: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
Thread-Index: AQHV3+t05QGFzNuez06VZ5VdF8K2kqgUfAmAgAFKeYCAAGrTgIAARPoAgAAJp4CAAAclgIAAAzgAgADQubA=
Date:   Wed, 12 Feb 2020 10:16:54 +0000
Message-ID: <AM6PR10MB22630C79D08CE74878A6A096801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
 <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
 <CAFQqKeWHDyyd_YBBaD6P2sCL5OCNEsiUU6B7eUwtiLv8GZU0yg@mail.gmail.com>
 <2eeca7fe-aec9-c680-5d61-930de18b952b@linux.intel.com>
 <CAFQqKeXK3OG7KXaHGUuC75sxWrdf11xJooC7XsDCOyd6KUgPTQ@mail.gmail.com>
 <c9dbcdd8-b943-94a6-581f-7bbebe8c6d25@linux.intel.com>
In-Reply-To: <c9dbcdd8-b943-94a6-581f-7bbebe8c6d25@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 520edca1-b7b5-4cf1-7d28-08d7afa4af2a
x-ms-traffictypediagnostic: AM6PR10MB2840:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2840244A60E937396B10D2D4A71B0@AM6PR10MB2840.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(66556008)(66946007)(66446008)(5660300002)(64756008)(66476007)(52536014)(4326008)(55016002)(9686003)(76116006)(54906003)(7416002)(110136005)(81166006)(86362001)(26005)(81156014)(71200400001)(55236004)(498600001)(6506007)(53546011)(7696005)(33656002)(2906002)(8676002)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2840;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IMRHB8pDhfjP97XwRhrZPYLuTzYuLaE0bhJMtsaqP+NrO8imWj/XOhn8Th7U2QmmDQxLCQv4ECrRfHDhkd9b2Nu9LnG18ozjJqAxzH6wFYsHheAaU1jvV3qaSpZtYfjAXeKm01iyZPtQ4zYZKvZf0YE8TZ+G2iH8FsvIvi8dMLL+OBgyXbQjks+66YOiwWZ3WNNdNguwFOvjiirHUE5oGJPGyhYZMFdYKGumlvv5cWFaxO0EIk9mKJ30X+HhrgOfxS5NjGTx8vWioWTvLB7AGlnCewSo6zEvIvTmGNHjXpHfa36jaYs/q7P5/QLjrEgitp8xKg7hQC3Y7zK8jNSSA1KEUCpAc4w1MhSM0C6efteKV31mZDbWL/Jzkrhp8Zc33CMCDZeZfuVO0l1zsqMMZqRJq1N4kA1G2m9Fyo3zpdjs0u68thFWILduAbtrNA84
x-ms-exchange-antispam-messagedata: IJJPJx9rulvZPJI222pycdQSw1hvnkd7O8sKzyHARKORRxztwRKtFprM7KLTnVBpOrECqCNczLeRYc4uqiItxx8z1HQnXRVDaRZtcQRwQJQAcOrxi6YMgTdOTDxWzp0NGAOyCpEY9yDfaFCFmPYjFA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520edca1-b7b5-4cf1-7d28-08d7afa4af2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 10:16:54.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kN3T9E5OYpDcuFmvaWCAqztbgPnyu4bRnaFWNeu932hvt4sEHWnF9Qet260/yXKITBaLhBpFHRrxl2TyU7zV+nrLD2svtXNNbHeIOk3eOmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEgRmVicnVhcnkgMjAyMCAyMTo0OSwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6DQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGllcnJlLUxvdWlzIEJvc3Nh
cnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogMTEgRmVi
cnVhcnkgMjAyMCAyMTo0OQ0KPiBUbzogU3JpZGhhcmFuLCBSYW5qYW5pIDxyYW5qYW5pLnNyaWRo
YXJhbkBpbnRlbC5jb20+DQo+IENjOiBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IFN1cHBv
cnQgT3BlbnNvdXJjZQ0KPiA8U3VwcG9ydC5PcGVuc291cmNlQGRpYXNlbWkuY29tPjsgVGFrYXNo
aSBJd2FpIDx0aXdhaUBzdXNlLmNvbT47IExpYW0NCj4gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFp
bC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDaGlhbmcsIE1hYw0KPiA8bWFj
LmNoaWFuZ0BpbnRlbC5jb20+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBSYW5q
YW5pIFNyaWRoYXJhbg0KPiA8cmFuamFuaS5zcmlkaGFyYW5AbGludXguaW50ZWwuY29tPjsgQWRh
bSBUaG9tc29uDQo+IDxBZGFtLlRob21zb24uT3BlbnNvdXJjZUBkaWFzZW1pLmNvbT47IEx1LCBC
cmVudCA8YnJlbnQubHVAaW50ZWwuY29tPjsNCj4gY3ljaGlhbmdAZ29vZ2xlLmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW2Fsc2EtZGV2ZWxdIFtQQVRDSF0gQVNvQzogZGE3MjE5OiBjaGVjayBTUk0gbG9j
ayBpbiB0cmlnZ2VyIGNhbGxiYWNrDQo+IEltcG9ydGFuY2U6IEhpZ2gNCj4gDQo+IA0KPiANCj4g
Pj4+IEFyZSB5b3UgdGFsa2luZyBhYm91dCB0aGUgY2hhbmdlIGluIHRoaXMgY29tbWl0IGFjYmYy
Nzc0NmVjZmE5NmINCj4gPj4+ICJBU29DOiBwY206IHVwZGF0ZSBGRS9CRSB0cmlnZ2VyIG9yZGVy
IGJhc2VkIG9uIHRoZSBjb21tYW5kIj8NCj4gPj4+DQo+ID4+PiBXZSBtYWRlIHRoaXMgY2hhbmdl
IHRvIGhhbmRsZSB4cnVucyBkdXJpbmcgcGF1c2UvcmVsZWFzZSBwYXJ0aWN1bGFybHkgb24NCj4g
Pj4+IHRoZSBJbnRlbCBIREEgcGxhdGZvcm1zLg0KPiA+Pg0KPiA+PiB0aGlzIGNoYW5nZSB3YXMg
anVzdCB0byBtaXJyb3IgdGhlIGJlaGF2aW9yIGJldHdlZW4gc3RhcnQvc3RvcCwgSQ0KPiA+PiB0
aG91Z2h0IHRoZXJlIHdhcyBhIHBhdGNoIHdoZXJlIHdlIG1vdmVkIHRvIFRSSUdHRVJfUE9TVCBi
eSBkZWZhdWx0Pw0KPiA+Pg0KPiA+PiBXaGF0IEkgYW0gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaWYg
d2hldGhlciB1c2luZyBUUklHR0VSX1BSRSBpcyBvayBvciBub3QNCj4gPj4gZm9yIHRoZSBTT0Yg
ZmlybXdhcmUuDQo+ID4+DQo+ID4NCj4gPiBBaGggeWVzLCBpdCB3YXMgcGFydCBvZiB0aGUgc2Ft
ZSBzZXJpZXMgYXMgdGhpcyBvbmUuIGZkMjc0YzJiNzI2N2IgICJBU29DOg0KPiA+IFNPRjogdG9w
b2xvZ3k6IHNldCB0cmlnZ2VyIG9yZGVyIGZvciBGRSBEQUkgbGluayINCj4gPg0KPiA+IFRSSUdH
RVJfUFJFIHdvbid0IHJlYWxseSB3b3JrIGluIHRoZSBjYXNlIG9mIFNPRi4gV2UgbmVlZCB0aGUg
QkUgREFJIHRvIGJlDQo+ID4gdHJpZ2dlcmVkIGJlZm9yZSB0aGUgRkUgREFJIGR1cmluZyBzdGFy
dCB0byBwcmV2ZW50IHRoZSB4cnVucyBkdXJpbmcNCj4gPiBwYXVzZS9yZWxlYXNlLg0KPiANCj4g
VGhhbmtzIFJhbmphbmkuIFRoYXQgaW5mb3JtYXRpb24gY2xvc2VzIHRoZSBkb29yIG9uIHRoZSBp
ZGVhIG9mIHBsYXlpbmcNCj4gd2l0aCB0aGUgdHJpZ2dlciBvcmRlciBzdWdnZXN0ZWQgZWFybGll
ciBpbiB0aGUgdGhyZWFkLCBzbyBteSBndWVzcyBpcw0KPiB0aGF0IHdlIHJlYWxseSBuZWVkIHRv
IGV4cG9zZSB0aGUgTUNMSy9CQ0xLIHdpdGggdGhlIGNsayBBUEkgYW5kIHR1cm4NCj4gdGhlbSBv
bi9vZmYgZnJvbSB0aGUgbWFjaGluZSBkcml2ZXIgYXMgbmVlZGVkLiBJIGhvcGUgaXMgdGhhdCB3
ZSBkb24ndA0KPiBuZWVkIHRoZSBGU1lOQyBhcyB3ZWxsLCB0aGF0IHdvdWxkIGJlIHJhdGhlciBw
YWluZnVsIHRvIGltcGxlbWVudC4NCg0KQW0gbm90IGdvaW5nIHRvIG1ha2UgbXlzZWxmIHBvcHVs
YXIgaGVyZS4gSXQncyBNQ0xLIGFuZCBGU1lOQyAob3IgV0NMSyBhcyBpdCdzDQp0ZXJtZWQgZm9y
IG91ciBkZXZpY2UpIHRoYXQgaXMgcmVxdWlyZWQgZm9yIFNSTSB0byBsb2NrIGluIHRoZSBQTEwu
DQoNClNvIGZhciBJJ3ZlIG5vdCBmb3VuZCBhIHdheSBpbiB0aGUgY29kZWMgZHJpdmVyIHRvIGJl
IGFibGUgdG8gZ2V0IGFyb3VuZCB0aGlzLg0KSSBzcGVudCBhIHZlcnkgbG9uZyB0aW1lIHdpdGgg
U2F0aHlhIGluIHRoZSBlYXJseSBkYXlzIChBcG9sbG8gTGFrZSkgbG9va2luZyBhdA0Kb3B0aW9u
cyBidXQgbm90aGluZyB3b3VsZCBmaXQgd2hpY2ggaXMgd2h5IEkgaGF2ZSB0aGUgc29sdXRpb24g
dGhhdCdzIGluIHBsYWNlDQpyaWdodCBub3cuIFdlIGNvdWxkIHByb2JhYmx5IHJlZHVjZSB0aGUg
bnVtYmVyIG9mIHJlY2hlY2tzIGJlZm9yZSB0aW1lb3V0IGluIHRoZQ0KZHJpdmVyIGJ1dCB0aGF0
J3MgcmVhbGx5IGp1c3QgcGFwZXJpbmcgb3ZlciB0aGUgY3JhY2sgYW5kIHRoZXJlJ3Mgc3RpbGwg
dGhlDQpwb3NzaWJpbGl0eSBvZiBub2lzZSBsYXRlciB3aGVuIFNSTSBmaW5hbGx5IGRvZXMgbG9j
ay4NCg==
