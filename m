Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AE7C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFF4222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="BlYzvDMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgCJNXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:23202 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728725AbgCJNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:16 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ADF4TL024236;
        Tue, 10 Mar 2020 09:22:54 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yp90bgjhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Mar 2020 09:22:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N51ImwFi4hwuRVPTl+98JcgneTKS8PXSLkE1yJIjycIprSyVPnzlwrGFuHDn25f8QjugCkxor9AiUT25UtsOfW2/NIMpQmL3x0vB/5jx08dqKTuBGnOQ0rKLiBQwi8gUX0dKu0+IOrOVm2sHvYIRXC2zdabyj5ethMOu95G6RlmsMHkAUYIAThipthvTAwz4p2UJYgxu/AJUo77+8Y5Ta7LrXAxzXG/BEIUr0NyjT+GA3wrZZhV92tvOmpo/ZkuB8YSBsd2DGBtJxMetkDy60jF4kdHNj4r6NQpvnKuiJwgPdOIEtedBYDUCOewk45Yl20QM4UHKzN445L6WxjdmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rzO9dRQjNZyc/oNMSxFymm67Ieorb+vdItlJC3EpR0=;
 b=NeGApeMr2pFK6mTMwd9QF+xBdcF69IxsLXk5Vq+C+rxqUDfvt3VUOmHev0TPWwoe6GHQOAXeI13zDarOA87nBUwzANSesIvCLrwhWuaiS3EvtJHIynVPAFJhFSgksREN7kik90iR2K1ZUzLazBRTnjaH3vdJ62JD7MS2RV45E4a8eoT65MtxowmTAuBtPmXnDQ1AkjTbBkNldA1fw1YSyKFDP0FJ+Pc6HjAjUwhqk3z5Xfgwmuk/m4zhiaAI0woS8qzOH9s0CSOgKOsEfzF/X88e6Jls9cK2Yi82meeMzqY994m+W8Gfv/kIouFK8iLW1bAQAfZLl6RaYwjORRuRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rzO9dRQjNZyc/oNMSxFymm67Ieorb+vdItlJC3EpR0=;
 b=BlYzvDMfVbI3nwcdHO44Q0+vN3md+tFaIZbcA4x1UaxGvKk9YN4gy4ttHEVLNwM8eGUO8swoFT+GiLr29W++ktaDBkVAnQnnCrBcc548YTHOrpusKjI3i+j4Wi7u5e/XHknVoi6pgbJlnwNJKxmxsIxNnNlyBetLzfFMjSROa4M=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3497.namprd03.prod.outlook.com (2603:10b6:5:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 13:22:52 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f8c4:f7f2:c7a0:cc19]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f8c4:f7f2:c7a0:cc19%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 13:22:52 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "m.olbrich@pengutronix.de" <m.olbrich@pengutronix.de>
Subject: Re: [PATCH][RESEND] usb: dwc3: gadget: Handle dequeuing of non queued
 URB gracefully
Thread-Topic: [PATCH][RESEND] usb: dwc3: gadget: Handle dequeuing of non
 queued URB gracefully
Thread-Index: AQHVzHAaGZ1hPlQHvkuQvTjD39kOvagDMU2AgD7z0wA=
Date:   Tue, 10 Mar 2020 13:22:52 +0000
Message-ID: <5313c926109f39699e63342b4ff71102d3cfa495.camel@analog.com>
References: <20191106144553.16956-1-alexandru.ardelean@analog.com>
         <20200116132459.22383-1-alexandru.ardelean@analog.com>
         <87d0b1885e.fsf@kernel.org>
In-Reply-To: <87d0b1885e.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a17c7c87-b8ce-42ca-7663-08d7c4f62347
x-ms-traffictypediagnostic: DM6PR03MB3497:
x-microsoft-antispam-prvs: <DM6PR03MB3497E733ABBAA7E49CA5C6A3F9FF0@DM6PR03MB3497.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(66946007)(26005)(4326008)(36756003)(66476007)(91956017)(66446008)(2616005)(8676002)(66556008)(64756008)(6512007)(81166006)(76116006)(81156014)(6506007)(110136005)(54906003)(316002)(2906002)(71200400001)(8936002)(966005)(5660300002)(6486002)(86362001)(186003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3497;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ugYOkGnRSFPj6Dr7YdrKOMbpJ8g3Hj96JASXpsloKuoTb+6ZIuKVZOczDN1sEcwotUyYy90mb4CWXS/nCBK9BBbhB5RIq7PZuvhJXFGMd036hRvu3TPHpwucl6xVlKBj92U4fPmcgithJwbI8nk9NjWEezs2izKzIxt63WXOrL22EcYxXP/COaPgidM+/FNaQOIPpBOPhjTn4FrW1VhSLEJKDPKs2tdS5/4lKiZUgaVwo7JpOCH3cmcwH4BY41xOcqQSZjReV0HLIoieIobblzSjSni4CYMCbn+Gs3sRXODFeLbOB8HMkyYX8vobP4IZ4IXQEGcmF3hPhMfpCsBOS+i98Cb7ZRUIf2kEXK6cOgVS/KPwOdHv74jGYhG3QDzlapxk40Ik7V1B+ygh5G7Oo+wHkq5YvGh5CXs+apjHevEaIYLe9rg1ftstNd5CBrZSAgMXZ3QsRqHnuEGVCDAUOYpWDgxVgmfLnsfmIv39L0RARVXoD013yj8KJLpXjrUbBb+fRekvhgpahUihib6voA==
x-ms-exchange-antispam-messagedata: +SJ8QrGg9sapaBhKlNw/XvGdIsef76Lz1xVpW0bTwqsTczpheMh8FkPIjgKCZKJ4n53BwiURWsxkTbosyAL18emH/+NPwwCQdWzpcLPudSjt00fbGBlSSas3O11aytGjJPlfgXjL2jeB9kKscoGJ5g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFD178829CF36E4CB4EE738B6E612317@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17c7c87-b8ce-42ca-7663-08d7c4f62347
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 13:22:52.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j40Qh9nq7HBuB3bvk48qAAZtza1bBI9SROr9uhQBkMcZU96VEAGcnsuU7ur1TmFp6ct6qRmgdhTe0juwSAvFWmfKznSNa8t3shBsrzCofjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3497
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_06:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTMwIGF0IDE0OjAyICswMjAwLCBGZWxpcGUgQmFsYmkgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBIaSwNCj4gDQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxl
eGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyaXRlczoNCj4gDQo+ID4gRnJvbTogTGFycy1Q
ZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gDQo+ID4gVHJ5aW5nIHRvIGRlcXVl
dWUgYW5kIFVSQiB0aGF0IGlzIGN1cnJlbnRseSBub3QgcXVldWVkIHNob3VsZCBiZSBhIG5vLW9w
DQo+ID4gYW5kIGJlIGhhbmRsZWQgZ3JhY2VmdWxseS4NCj4gPiANCj4gPiBVc2UgdGhlIGxpc3Qg
ZmllbGQgb2YgdGhlIFVSQiB0byBpbmRpY2F0ZSB3aGV0aGVyIGl0IGlzIHF1ZXVlZCBvciBub3Qg
YnkNCj4gPiBzZXR0aW5nIGl0IHRvIHRoZSBlbXB0eSBsaXN0IHdoZW4gaXQgaXMgbm90IHF1ZXVl
ZC4NCj4gPiANCj4gPiBIYW5kbGluZyB0aGlzIGdyYWNlZnVsbHkgYWxsb3dzIGZvciByYWNlIGNv
bmRpdGlvbiBmcmVlIHN5bmNocm9uaXphdGlvbg0KPiA+IGJldHdlZW4gdGhlIGNvbXBsZXRlIGNh
bGxiYWNrIGJlaW5nIGNhbGxlZCB0byB0byBhIGNvbXBsZXRlZCB0cmFuc2ZlciBhbmQNCj4gPiB0
cnlpbmcgdG8gY2FsbCB1c2JfZXBfZGVxdWV1ZSgpIGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0KPiBX
ZSBuZWVkIGEgbGl0dGxlIG1vcmUgaW5mb3JtYXRpb24gaGVyZS4gQ2FuIHlvdSBmdXJ0aGVyIGV4
cGxhaW4gd2hhdA0KPiBoYXBwZW5zIGFuZCBob3cgeW91IGNhdWdodCB0aGlzPw0KDQpBcG9sb2dp
ZXMgZm9yIHRoZSBkZWxheSBbb2YgdGhpcyByZXBseV0uDQpJdCdzIGJlZW4gYSB3aGlsZSBzaW5j
ZSB0aGlzIHBhdGNoIHdhcyBjcmVhdGVkLCBhbmQgaXQgd2FzIG9uIGEgNC4xNCBrZXJuZWwuDQpM
YXJzIHdhcyB0cnlpbmcgdG8gZml4IHZhcmlvdXMgY3Jhc2hlcyB3aXRoIFVTQiBEV0MzIE9URyAr
IHNvbWUgWGlsaW54IHBhdGNoZXMuDQpJIGRpZCBub3QgdHJhY2sgdGhlIHN0YXR1cyBvZiB0aGUg
T1RHIHN0dWZmIHVwc3RyZWFtLiBJIHRoaW5rIGl0J3MgYSBsb3Qgb2YNCnBhdGNoZXMgaW4gdGhl
IFhpbGlueCB0cmVlLg0KDQpUaGUgY29udGV4dCBoYXMgY2hhbmdlZCBmcm9tIDQuMTQgW29idmlv
dXNseV0sIGFuZCB0aGVyZSB3ZXJlIG1hbnkgdGhpbmdzIHRoYXQNCmNvdWxkIGhhdmUgaW5mbHVl
bmNlZCB0aGluZ3MuDQpJJ3ZlIGJlZW4gdHJ5aW5nIHRvIFJGQyBzb21lIG9mIHRoZXNlIHBhdGNo
ZXMgbm93Lg0KWyB5ZWFoIEkga25vdzogbWF5YmUgSSBzaG91bGQgaGF2ZSBbcHJvYmFibHldIGFs
c28gYWRkZWQgYW4gUkZDIHRhZyA6KSBdDQpTb21lIG9mIHRoZSBwYXRjaGVzIFtpbmNsdWRpbmcg
dGhpcyBvbmVdIHNlZW1lZCB0byBtYWtlIHNlbnNlLCBldmVuIG91dHNpZGUgb2YNCnRoZSBjb250
ZXh0IG9mIHRoZSBjcmFzaGVzIHRoYXQgd2VyZSBoYXBwZW5pbmcgb24gNC4xNC4NCkF0bSwgd2Un
cmUgYXQgNC4xOSBhbmQgd2UgZG9uJ3Qgc2VlIGlzc3VlcywgYnV0IHdlIHN0aWxsIGhhdmUgdGhp
cyBwYXRjaC4NCldlIG1heSBkcm9wIGl0IGFuZCBzZWUgd2hhdCBoYXBwZW5zLg0Kwq9cXyjjg4Qp
Xy/Crw0KDQpCdXQgaW4gYW55IGNhc2UsIGl0IGRvZXMgcmVxdWlyZSBhIGJpdCBtb3JlIHJlLWlu
dmVzdGlnYXRpb24uDQpBcG9sb2dpZXMgZm9yIHRoZSBub2lzZSB0aGF0IHRoaXMgcGF0Y2ggY3Jl
YXRlZCA6KQ0KDQo+IA0KPiA+IFRlc3RlZC1ieTogTWljaGFlbCBPbGJyaWNoIDxtLm9sYnJpY2hA
cGVuZ3V0cm9uaXguZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxs
YXJzQG1ldGFmb28uZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxh
bGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiAqIEFkZGVk
IE1pY2hhZWwgT2xicmljaCdzIFRlc3RlZC1ieSB0YWcNCj4gPiAgIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXVzYi8yMDE5MTExMjE0NDEwOC5HQTE4NTlAcGVuZ3V0cm9uaXguZGUvDQo+
ID4gDQo+ID4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA3ICsrKysrKy0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiA+IGluZGV4IDFiODAxNGFiMGIyNS4uMjJhNzhlYjQxYTViIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+ID4gQEAgLTE3Nyw3ICsxNzcsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dh
ZGdldF9kZWxfYW5kX3VubWFwX3JlcXVlc3Qoc3RydWN0DQo+ID4gZHdjM19lcCAqZGVwLA0KPiA+
ICB7DQo+ID4gIAlzdHJ1Y3QgZHdjMwkJCSpkd2MgPSBkZXAtPmR3YzsNCj4gPiAgDQo+ID4gLQls
aXN0X2RlbCgmcmVxLT5saXN0KTsNCj4gPiArCWxpc3RfZGVsX2luaXQoJnJlcS0+bGlzdCk7DQo+
IA0KPiB0aGlzIHNob3VsZCAqbm90KiBiZSBuZWNlc3NhcnkuIE5laXRoZXIgdGhlIElOSVRfTElT
VF9IRUFEKCkgYmVsb3cuDQo+IA0KPiA+ICAJcmVxLT5yZW1haW5pbmcgPSAwOw0KPiA+ICAJcmVx
LT5uZWVkc19leHRyYV90cmIgPSBmYWxzZTsNCj4gPiAgDQo+ID4gQEAgLTg0Nyw2ICs4NDcsNyBA
QCBzdGF0aWMgc3RydWN0IHVzYl9yZXF1ZXN0DQo+ID4gKmR3YzNfZ2FkZ2V0X2VwX2FsbG9jX3Jl
cXVlc3Qoc3RydWN0IHVzYl9lcCAqZXAsDQo+ID4gIAlyZXEtPmVwbnVtCT0gZGVwLT5udW1iZXI7
DQo+ID4gIAlyZXEtPmRlcAk9IGRlcDsNCj4gPiAgCXJlcS0+c3RhdHVzCT0gRFdDM19SRVFVRVNU
X1NUQVRVU19VTktOT1dOOw0KPiA+ICsJSU5JVF9MSVNUX0hFQUQoJnJlcS0+bGlzdCk7DQo+ID4g
IA0KPiA+ICAJdHJhY2VfZHdjM19hbGxvY19yZXF1ZXN0KHJlcSk7DQo+ID4gIA0KPiA+IEBAIC0x
NTQ5LDYgKzE1NTAsMTAgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9lcF9kZXF1ZXVlKHN0cnVj
dCB1c2JfZXAgKmVwLA0KPiA+ICANCj4gPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ss
IGZsYWdzKTsNCj4gPiAgDQo+ID4gKwkvKiBOb3QgcXVldWVkLCBub3RoaW5nIHRvIGRvICovDQo+
ID4gKwlpZiAobGlzdF9lbXB0eSgmcmVxLT5saXN0KSkNCj4gPiArCQlnb3RvIG91dDA7DQo+IA0K
PiBUaGUgbG9vcCBiZWxvdyBpcyBhY3R1YWxseSBsb29raW5nIGZvciB0aGUgcmVxdWVzdCBpbiBv
dXIgbGlzdHMuIFlvdQ0KPiBqdXN0IG1hZGUgdGhlIGVudGlyZSBsb29wIGJlbG93IHVubmVjZXNz
YXJ5LCBidXQgeW91IGRpZG4ndCBjaGFuZ2UgaXQNCj4gYWNjb3JkaW5nbHkuIE1vcmVvdmVyLCBJ
IHRoaW5rIHRoYXQgYSB1c2VyIGRlcXVldWVpbmcgYSByZXF1ZXN0IHRoYXQNCj4gd2Fzbid0IHF1
ZXVlZCBmb3IgdGhlIGN1cnJlbnQgZW5kcG9pbnQgaW5kaWNhdGVzIGEgcG9zc2libGUgYnVnIGlu
IHRoZQ0KPiBnYWRnZXQgZHJpdmVyIHdoaWNoIG5lZWRzIHRvIGJlIGZpeGVkLg0KPiANCg0KWWVh
aCwgdGhhdCBjb3VsZCBiZS4NCldpbGwgc2VlIGFib3V0IHJldmVydGluZyB0aGUgcGF0Y2ggb24g
b3VyIGVuZCwgYW5kIHRyeWluZyB0byB0cmFjayB0aGlzIGFnYWluLg0KDQpUaGFua3MNCkFsZXgN
Cg0KPiBJZiB5b3UgcmVhbGx5IGRpc2FncmVlLCBzdWZmaWNlIHRvIGNoYW5nZSAicmV0ID0gLUVJ
TlZBTDsiIHRvICJyZXQgPQ0KPiAwOyIgYW5kIHlvdSB3b3VsZCBnZXQgd2hhdCB5b3Ugd2FudCwg
d2l0aG91dCBhbnkgb2YgdGhlIGV4dHJhIGNydWZ0Lg0KPiANCj4gY2hlZXJzDQo+IA0K
