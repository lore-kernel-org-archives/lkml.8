Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5E2C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D66920736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TZEg8AJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgCKS6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:58:51 -0400
Received: from mail-eopbgr690071.outbound.protection.outlook.com ([40.107.69.71]:42830
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730734AbgCKS6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS8XvPO5QmXItMSuDBT0EL+ChtrhTBtOqX0qBcmcKPGfUs1CSoIJmHT6XPnGM9PX3x87R3NC0HzjLcMjUiIRDnoDiIb/zqzk2pzzIzkdkYy3IuxiRgXSMNOMEpWH71d6Dy5AS/pnKs+cgf5zAmebg+r1bE7wwCbik22k2M0K+xmJ4hyGTfDPkYF4NiguAB5xySnBxqsV7TW6UOqjNub+ga/Je3wJCuwLdPDCqcsrfGWWvd1a6PfXFJC3cckzTZ/1LrbOn0KLYcL6j5acDg3QvEu8BkS75PzjBUBdkQofnwtyhWqhZmxo4cSCqmZlCZOJGI+ylOLsuGWkafp5brDKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkK+K/Ywk92epmU3JHAJ7WyswuhUK4h0VFLrRbHFoiQ=;
 b=m2oxH9Bm44psDanu8Y0KtrxWBXIte4cpVNzN9ny16D5soXSwbQ1iJLU0n5Z//IYTeeJJvwuZAMyON/t7sA6758K9gy2sqAS+0G525X1D2AK1pMGAZPZ1AvU3B63YpUWQZ2t803grFiUzay+s+dk31azszrXQC+rEz+HkJ6Bg8QDHFvJxXaypB/I2GM34UndyCQmAnPojMwmO1JhfVVBmeREMSVyotPA3liOaFB6AZQbafYWPAntsGpdzPXMVrn6IWvrnM4hCR8JVkn4Bf7/Fq/v6xmEg052uAmiRdStwMivyZfr/8K81NQyMMYL/EqY1DXnilkSQC2CCEaClS0rAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkK+K/Ywk92epmU3JHAJ7WyswuhUK4h0VFLrRbHFoiQ=;
 b=TZEg8AJ6VxCXBhEelpf7Ku4u7x/Z68hUYrN8W3D55jOvzRtJmuPD0vVkHMQtE1dTvZip+ZrfEHXjaKxpDCdpA/ASakD+CdZHZ4+HXti8l/EXdUEOV7lhkCc4WqyK/SU5MXe+tTD3i34OD97m6EkNoLyoCf9pMK7DhV3spW3N8Kc=
Received: from MN2PR12MB3232.namprd12.prod.outlook.com (2603:10b6:208:ab::29)
 by MN2PR12MB3789.namprd12.prod.outlook.com (2603:10b6:208:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 18:58:47 +0000
Received: from MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::d8f:800:975a:b8c]) by MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::d8f:800:975a:b8c%6]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 18:58:46 +0000
From:   "Nath, Arindam" <Arindam.Nath@amd.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
Thread-Topic: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
Thread-Index: AQHV9x46fcHb8CAMpEy5Z6V8Vk8yLqhCWDIAgAFURNCAABBOgIAAAo4w
Date:   Wed, 11 Mar 2020 18:58:46 +0000
Message-ID: <MN2PR12MB323290836319B3E7032D91369CFC0@MN2PR12MB3232.namprd12.prod.outlook.com>
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
 <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
 <3c350277-8fe6-04b2-673e-7d4c8fb6ce24@deltatee.com>
 <MN2PR12MB3232AD3D784F07645D7115609CFC0@MN2PR12MB3232.namprd12.prod.outlook.com>
 <214f3ef3-853d-6b0d-0fed-5bb6c1f1de1f@deltatee.com>
In-Reply-To: <214f3ef3-853d-6b0d-0fed-5bb6c1f1de1f@deltatee.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2020-03-11T18:56:34Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=bdd72418-470b-430a-b19a-000077161765;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_enabled: true
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_setdate: 2020-03-11T18:58:43Z
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_method: Privileged
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_name: Non-Business
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_actionid: 24b98547-7f7c-4e75-a9ed-00006e09ab9a
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Arindam.Nath@amd.com; 
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c996abd-7c36-427e-dc17-08d7c5ee3a76
x-ms-traffictypediagnostic: MN2PR12MB3789:|MN2PR12MB3789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37898BF44EE0E30CF74F83629CFC0@MN2PR12MB3789.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(26005)(186003)(76116006)(2906002)(66946007)(7696005)(71200400001)(9686003)(6506007)(53546011)(4326008)(81166006)(55016002)(54906003)(6636002)(110136005)(8676002)(81156014)(86362001)(52536014)(66446008)(66556008)(478600001)(316002)(64756008)(33656002)(66476007)(5660300002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3789;H:MN2PR12MB3232.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taifC88R4y1Qo4jLLOwq+BWQxtSVnY0AttchPO2K9U3nFGem4FDNyB1daXeZkX07diYp7G1kPkI5kIvQXuW0b648vKrvRnU6u837uINIcAJGEmIUnct11m6wGTJ8bfPzAQRVP+p/mtR4pe8l4QbIp70SqF/YUHp+2JxYA0D77mlcJJBfLRNj/NRrqw/U6MOvPjHYMjnlwxBZ1T2Skjurciij3kKGwM75f+PM4y2QeNqO/jq4Y9CqnZ0vMhvKpIBqvZ2XXugurBx3Ho3hAQ2C0fABJJkpZZ14YfXqgHpmWe1s1NJPvXqZRN10awYlB7c2JYwcXTkEgLeNkoVKqGqiCNsFSUgAmxo3+1ePm2wR4vi3jgZywpK8vbUvRzajsI2+1r3X5jznMA0A2nZR3/PY4YJNrWToYB4LAQbbJYfaaRV1Ff3Ji5x/9ehp/Zepfmuz
x-ms-exchange-antispam-messagedata: 3a4DGhdau1vY11zToDYJFFMwIt/lLc/8Y6sZrMTfd2iqaW3lfPE80/B7lIIbF4g8yb7UqcO4lIfX5cRyod605Y0fYj7QPdshdyVGUAfrEkg+Kb8m4E9AVoCQuUpMKPfVLHKnHhYNQa5tzjs8a0MG1Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c996abd-7c36-427e-dc17-08d7c5ee3a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 18:58:46.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWqbPxgmyiPOuLBLrT/X7gexF7EcJYPti8rCth9V1Jo7FnRV5qj0xGI6xZ4xghms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2dhbiBHdW50aG9ycGUgPGxv
Z2FuZ0BkZWx0YXRlZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMiwgMjAyMCAwMDox
Nw0KPiBUbzogTmF0aCwgQXJpbmRhbSA8QXJpbmRhbS5OYXRoQGFtZC5jb20+OyBNZWh0YSwgU2Fu
anUNCj4gPFNhbmp1Lk1laHRhQGFtZC5jb20+OyBqZG1hc29uQGt1ZHp1LnVzOyBkYXZlLmppYW5n
QGludGVsLmNvbTsNCj4gYWxsZW5iaEBnbWFpbC5jb207IFMtaywgU2h5YW0tc3VuZGFyIDxTaHlh
bS1zdW5kYXIuUy1rQGFtZC5jb20+DQo+IENjOiBsaW51eC1udGJAZ29vZ2xlZ3JvdXBzLmNvbTsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIv
NV0gbnRiX3BlcmY6IHNlbmQgY29tbWFuZCBpbiByZXNwb25zZSB0byBFQUdBSU4NCj4gDQo+IA0K
PiANCj4gT24gMjAyMC0wMy0xMSAxMjoxMSBwLm0uLCBOYXRoLCBBcmluZGFtIHdyb3RlOg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBMb2dhbiBHdW50aG9ycGUg
PGxvZ2FuZ0BkZWx0YXRlZS5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTEsIDIw
MjAgMDM6MDENCj4gPj4gVG86IE1laHRhLCBTYW5qdSA8U2FuanUuTWVodGFAYW1kLmNvbT47IGpk
bWFzb25Aa3VkenUudXM7DQo+ID4+IGRhdmUuamlhbmdAaW50ZWwuY29tOyBhbGxlbmJoQGdtYWls
LmNvbTsgTmF0aCwgQXJpbmRhbQ0KPiA+PiA8QXJpbmRhbS5OYXRoQGFtZC5jb20+OyBTLWssIFNo
eWFtLXN1bmRhciA8U2h5YW0tc3VuZGFyLlMtDQo+ID4+IGtAYW1kLmNvbT4NCj4gPj4gQ2M6IGxp
bnV4LW50YkBnb29nbGVncm91cHMuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi81XSBudGJfcGVyZjogc2VuZCBjb21tYW5kIGlu
IHJlc3BvbnNlIHRvDQo+IEVBR0FJTg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyMDIwLTAz
LTEwIDI6NTQgcC5tLiwgU2FuamF5IFIgTWVodGEgd3JvdGU6DQo+ID4+PiBGcm9tOiBBcmluZGFt
IE5hdGggPGFyaW5kYW0ubmF0aEBhbWQuY29tPg0KPiA+Pj4NCj4gPj4+IHBlcmZfc3BhZF9jbWRf
c2VuZCgpIGFuZCBwZXJmX21zZ19jbWRfc2VuZCgpIHJldHVybg0KPiA+Pj4gLUVBR0FJTiBhZnRl
ciB0cnlpbmcgdG8gc2VuZCBjb21tYW5kcyBmb3IgYSBtYXhpbXVtDQo+ID4+PiBvZiBNU0dfVFJJ
RVMgcmUtdHJpZXMuIEJ1dCBjdXJyZW50bHkgdGhlcmUgaXMgbm8NCj4gPj4+IGhhbmRsaW5nIGZv
ciB0aGlzIGVycm9yLiBUaGVzZSBmdW5jdGlvbnMgYXJlIGludm9rZWQNCj4gPj4+IGZyb20gcGVy
Zl9zZXJ2aWNlX3dvcmsoKSB0aHJvdWdoIGZ1bmN0aW9uIHBvaW50ZXJzLA0KPiA+Pj4gc28gcmF0
aGVyIHRoYW4gc2ltcGx5IGNhbGwgdGhlc2UgZnVuY3Rpb25zIGlzIG5vdA0KPiA+Pj4gZW5vdWdo
LiBXZSBuZWVkIHRvIG1ha2Ugc3VyZSB0byBpbnZva2UgdGhlbSBhZ2FpbiBpbg0KPiA+Pj4gY2Fz
ZSBvZiAtRUFHQUlOLiBTaW5jZSBwZWVyIHN0YXR1cyBiaXRzIHdlcmUgY2xlYXJlZA0KPiA+Pj4g
YmVmb3JlIGNhbGxpbmcgdGhlc2UgZnVuY3Rpb25zLCB3ZSBzZXQgdGhlIHNhbWUgc3RhdHVzDQo+
ID4+PiBiaXRzIGJlZm9yZSBxdWV1ZWluZyB0aGUgd29yayBhZ2FpbiBmb3IgbGF0ZXIgaW52b2Nh
dGlvbi4NCj4gPj4+IFRoaXMgd2F5IHdlIHNpbXBseSB3b24ndCBnbyBhaGVhZCBhbmQgaW5pdGlh
bGl6ZSB0aGUNCj4gPj4+IFhMQVQgcmVnaXN0ZXJzIHdyb25nZnVsbHkgaW4gY2FzZSBzZW5kaW5n
IHRoZSB2ZXJ5IGZpcnN0DQo+ID4+PiBjb21tYW5kIGl0c2VsZiBmYWlscy4NCj4gPj4NCj4gPj4g
U28gd2hhdCBoYXBwZW5zIGlmIHRoZXJlJ3MgYW4gYWN0dWFsIG5vbi1yZWNvdmVyYWJsZSBlcnJv
ciB0aGF0IGNhdXNlcw0KPiA+PiBwZXJmX21zZ19jbWRfc2VuZCgpIHRvIGZhaWw/IEFyZSB5b3Ug
cHJvcG9zaW5nIGl0IGp1c3QgcmVxdWV1ZXMgaGlnaA0KPiA+PiBwcmlvcml0eSB3b3JrIGZvcmV2
ZXI/DQo+ID4NCj4gPiBUaGUgaW50ZW50IG9mIHRoZSBwYXRjaCBpcyB0byBoYW5kbGUgLUVBR0FJ
Tiwgc2luY2UgdGhlIGVycm9yIGNvZGUgaXMNCj4gPiBhbiBpbmRpY2F0aW9uIHRoYXQgd2UgbmVl
ZCB0byB0cnkgYWdhaW4gbGF0ZXIuIEN1cnJlbnRseSB0aGVyZSBpcyBhIHZlcnkNCj4gPiBzbWFs
bCB0aW1lIGZyYW1lIGR1cmluZyB3aGljaCBudGJfcGVyZiBzaG91bGQgYmUgbG9hZGVkIG9uIGJv
dGggc2lkZXMNCj4gPiAocHJpbWFyeSBhbmQgc2Vjb25kYXJ5KSB0byBoYXZlIFhMQVQgcmVnaXN0
ZXJzIGNvbmZpZ3VyZWQgY29ycmVjdGx5Lg0KPiA+IEZhaWxpbmcgdGhhdCB0aGUgY29kZSB3aWxs
IHN0aWxsIGZhbGwgdGhyb3VnaCB3aXRob3V0IHByb3Blcmx5IGluaXRpYWxpemluZyB0aGUNCj4g
PiBYTEFUIHJlZ2lzdGVycyBhbmQgdGhlcmUgaXMgbm8gaW5kaWNhdGlvbiBvZiB0aGF0IGVpdGhl
ciB1bnRpbCB3ZSBoYXZlDQo+ID4gYWN0dWFsbHkgdHJpZWQgdG8gcGVyZm9ybSAnZWNobyAwID4g
L3N5cy9rZXJuZWwvZGVidWcvLi4uL3J1bicuDQo+ID4NCj4gPiBXaXRoIHRoZSBjaGFuZ2VzIHBy
b3Bvc2VkIGluIHRoaXMgcGF0Y2gsIHdlIGRvIG5vdCBoYXZlIHRvIGRlcGVuZA0KPiA+IG9uIHdo
ZXRoZXIgdGhlIGRyaXZlcnMgYXQgYm90aCBlbmRzIGFyZSBsb2FkZWQgd2l0aGluIGEgZml4ZWQg
dGltZQ0KPiA+IGR1cmF0aW9uLiBTbyB3ZSBjYW4gc2ltcGx5IGxvYWQgdGhlIGRyaXZlciBhdCBv
bmUgc2lkZSwgYW5kIGF0IGEgbGF0ZXINCj4gPiB0aW1lIGxvYWQgdGhlIGRyaXZlciBvbiB0aGUg
b3RoZXIsIGFuZCBzdGlsbCB0aGUgWExBVCByZWdpc3RlcnMgd291bGQNCj4gPiBiZSBzZXQgdXAg
Y29ycmVjdGx5Lg0KPiA+DQo+ID4gTG9va2luZyBhdCBwZXJmX3NwYWRfY21kX3NlbmQoKSBhbmQg
cGVyZl9tc2dfY21kX3NlbmQoKSwgaWYgdGhlDQo+ID4gY29uY2VybiBpcyB0aGF0IG50Yl9wZWVy
X3NwYWRfcmVhZCgpL250Yl9tc2dfcmVhZF9zdHMoKSBmYWlsIGJlY2F1c2UNCj4gPiBvZiBzb21l
IG5vbi1yZWNvdmVyYWJsZSBlcnJvciBhbmQgd2Ugc3RpbGwgc2NoZWR1bGUgYSBoaWdoIHByaW9y
aXR5DQo+ID4gd29yaywgdGhhdCBpcyBhIHZhbGlkIGNvbmNlcm4uIEJ1dCBpc24ndCBpdCBzdGls
bCBiZXR0ZXIgdGhhbiBzaW1wbHkgZmFsbGluZw0KPiA+IHRocm91Z2ggYW5kIGluaXRpYWxpemlu
ZyBYTEFUIHJlZ2lzdGVyIHdpdGggaW5jb3JyZWN0IHZhbHVlcz8NCj4gDQo+IEkgZG9uJ3QgdGhp
bmsgaXQncyBldmVyIGFjY2VwdGFibGUgdG8gZ2V0IGludG8gYW4gaW5maW5pdGUgbG9vcC4NCj4g
RXNwZWNpYWxseSB3aGVuIHlvdSdyZSBydW5uaW5nIG9uIHRoZSBzeXN0ZW0ncyBoaWdoIHByaW9y
aXR5IHdvcmsgcXVldWUuLi4NCj4gDQo+IEF0IHRoZSB2ZXJ5IGxlYXN0IHNjaGVkdWxlIGEgZGVs
YXllZCB3b3JrIGl0ZW0gdG8gdHJ5IGFnYWluIGluIHNvbWUNCj4gbnVtYmVyIG9mIHNlY29uZHMg
b3Igc29tZXRoaW5nLiBFc3NlbnRpYWxseSBqdXN0IGhhdmUgbW9yZSByZXRpcmVzLA0KPiBwZXJo
YXBzIHdpdGggbG9uZ2VyIGRlbGF5cyBpbiBiZXR3ZWVuLg0KDQpTb3VuZHMgbGlrZSBhIGdvb2Qg
aWRlYS4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KQXJpbmRhbQ0KDQo+IA0KPiBGYWxs
aW5nIHRocm91Z2ggYW5kIGNvbnRpbnVpbmcgd2l0aCB0aGUgd3JvbmcgdmFsdWVzIGlzIGNlcnRh
aW5seSB3cm9uZy4NCj4gSSBkaWRuJ3Qgbm90aWNlIHRoYXQuIElmIGFuIGVycm9yIG9jY3Vycywg
aXQgc2hvdWxkbid0IGNvbnRpbnVlLCBpdA0KPiBzaG91bGQgcHJpbnQgYW4gZXJyb3IgdG8gZG1l
c2cgYW5kIHN0b3AuDQo+IA0KPiA+DQo+ID4+DQo+ID4+IEkgbmV2ZXIgcmVhbGx5IHJldmlld2Vk
IHRoaXMgc3R1ZmYgcHJvcGVybHkgYnV0IGl0IGxvb2tzIGxpa2UgaXQgaGFzIGENCj4gPj4gYnVu
Y2ggb2YgcHJvYmxlbXMuIFVzaW5nIHRoZSBoaWdoIHByaW9yaXR5IHdvcmsgcXVldWUgZm9yIHNv
bWUgbG93DQo+ID4+IHByaW9yaXR5IHNldHVwIHdvcmsgc2VlbXMgd3JvbmcsIGF0IHRoZSB2ZXJ5
IGxlYXN0LiBUaGUgc3BhZCBhbmQgbXNnDQo+ID4+IHNlbmQgbG9vcHMgYWxzbyBsb29rIGxpa2Ug
dGhleSBoYXZlIGEgYnVuY2ggb2YgaW50ZXItaG9zdCByYWNlIGNvbmRpdGlvbg0KPiA+PiBwcm9i
bGVtcyBhcyB3ZWxsLiBZaWtlcy4NCj4gPg0KPiA+IEkgYW0gbm90IHZlcnkgc3VyZSB3aGF0IHRo
ZSBkZXNpZ24gY29uc2lkZXJhdGlvbnMgd2VyZSB3aGVuIGhhdmluZw0KPiA+IGEgaGlnaCBwcmlv
cml0eSB3b3JrIHF1ZXVlLCBidXQgcGVyaGFwcyB3ZSBjYW4gYWxsIGhhdmUgYSBkaXNjdXNzaW9u
DQo+ID4gb24gdGhpcy4NCj4gDQo+IEknZCBjaGFuZ2UgaXQuIFNlZW1zIGNvbXBsZXRlbHkgd3Jv
bmcgdG8gbWUuDQo+IA0KPiBMb2dhbg0K
