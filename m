Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A419AC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D662168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="YL+u5To7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgBMHK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:10:56 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:42564 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbgBMHK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:10:56 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D75ufS016987;
        Thu, 13 Feb 2020 02:09:50 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-00128a01.pphosted.com with ESMTP id 2y1u0s2m9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 02:09:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoRa6BVF43Z4JDcyKH6wbf1xzYRmrfeSxc3m4qWT2GUA8IqCCU3FFFI15aSlmtyQzEGvsVNoeU71iLkC3tc+6bNGwy6cf7ZY8M05W70KaotJNf/Pg0Ie9i7IlxfhzEvqOLW6GnAPpREAE95j2WT4y4rLH1CQpWOxk6z7XBzAPYEXvrW8iYPt5tzhocRt5WLdYR8+esfo453cFfS26z4hL8uVcHUwJO82F3j/Qigj4uZWfeQp7AvGV1P9rNOY3ly5HcP66freOVsfJbHqjBtBRoqXmRjQVGtvLJwx/aLwQz0zfVklFbggMxWX8OewnRkq4ls0EVLHNszDMoG3UDmdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOOeT2SRs6OGQVOquBFsjOtuSASpnKMDPaR+ge7mjx4=;
 b=OsxpT+Diwb7dy0eIMSWIWaV3EoANrNenauX/b1oVZKzVSTlTSZCj9uTFeiE2ljC79VpeKMcO6qDkYkzwFLhJS8lL7dx63gFZJ9ZwHaIOGbTBEOVBojxmCrv+Tfgy8kgz/Q8nqyCjsXqbCU6QBEHD7cpmkX8eLvj0bT2tdn+wyB9f8UIY8B/vxJNsAXNwpl+HfEnibTCL3SyHlzc113wST3CHekqQglIu0y22Z6LdzR1mxYqXJPp5PTcus7iIJu3E8Ht4cVCDLcYuWie0HMJiBvf2HYitIEsAKMzYK958y1wbC3CXG1rj78wYrEiTdX0SdMp0/GGPHz3lDaqRvO5CNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOOeT2SRs6OGQVOquBFsjOtuSASpnKMDPaR+ge7mjx4=;
 b=YL+u5To7FiXnf7bN7hlemrgtOfvNza3FSRbCztuggwzWFGc38b6moNCpMAgM8yTpN1ufJV8xbDUTrWp0/ZxQON0SbqjMKyjflPMo2NZ8Bd//iTrjzzT87Gi9j5LLkFq57tsE5XsTh19xOHggvHArc5a1nzyU5TknoKWuMAhKKcA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5222.namprd03.prod.outlook.com (20.180.15.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 13 Feb 2020 07:09:49 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 07:09:49 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tobin@kernel.org" <tobin@kernel.org>
Subject: Re: [PATCH] lib/string: update match_string() doc-strings with
 correct behavior
Thread-Topic: [PATCH] lib/string: update match_string() doc-strings with
 correct behavior
Thread-Index: AQHV4bNaSkKVafbdwE+hztW4MlEVLKgXxIiAgADx/AA=
Date:   Thu, 13 Feb 2020 07:09:49 +0000
Message-ID: <27677d8f08e1d9c1327b9771a9b93c99661ed2d0.camel@analog.com>
References: <20200212144723.21884-1-alexandru.ardelean@analog.com>
         <20200212164627.GU10400@smile.fi.intel.com>
In-Reply-To: <20200212164627.GU10400@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf2aa567-331f-4993-fde7-08d7b053b6de
x-ms-traffictypediagnostic: CH2PR03MB5222:
x-microsoft-antispam-prvs: <CH2PR03MB52222E354606FE571EF147AFF91A0@CH2PR03MB5222.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(36756003)(8936002)(91956017)(66476007)(4326008)(66556008)(316002)(8676002)(66946007)(81166006)(6486002)(76116006)(186003)(2616005)(64756008)(66446008)(81156014)(2906002)(6512007)(5660300002)(6506007)(478600001)(6916009)(71200400001)(15650500001)(86362001)(966005)(54906003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5222;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXUj6SYtfiP8uRVmlbrMJwBNvVPo2K8WPFad05LJVauhiHCZfKGX5utK34Dg/ORC3GgCD0udaqiG6rRfQY8TX3M5aQMijFya6RK7lmnLRQ3dVxbsyroanBXQkBKFt+aoY5v8u7u0srg81vV4zQ6Sxnts4XQyED22e0k0NQZfPN2Wh85/qJpSbeCT6Irs/7ZicMJuVSy59hnwZZD2YtypXm9AwezSWQ2CyAXfDGCBhelS1rcu3v3PJPE8TvPj+DU3pbq89WfyBAXUXd30W4TjN/G3aDJdvhINCuPyjLkVwAatSs5gi5W7YSzjAa8XZRXKUt9fDBSbDcsB/ltbUuxqzA5wbiqfwIef6qbOSzdOS4TOwYm6BPnfY4XqWYPQTNY30oDi62vgLeAfgayx7hze4gIVgSG5XV6xxlIbv3gqI47gRnt/RRJtPSJKKbIFiZuWvxzNuKh9rAKBzDbWHPTR3jSh+1j7ovepmryBQSNZTVLJi0AVq3nMG/DwxH7CWaMPo62tHtIsyo1Vi9PjTbCC3g==
x-ms-exchange-antispam-messagedata: lN6W8sp95QV09z2TYMVrh5i21tHMeh4GXJLc8pWYjYnvsx+BzogD1zHWwyj8MK/vbWobuoNdAiB9TWWwXgZO2XkhRNCD3yPOtstqSPYWq+jw2dAOPTQMofWQy1dbl6T+C3TW/vprfZsxIBI+cDuk/w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6194BE153BC754C8215D541DCD83DD2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2aa567-331f-4993-fde7-08d7b053b6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 07:09:49.0905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWPEtMEvkf2vgmLA8kTgq+9/pd/cvinh+4fJa/Gtv9d0QgQHDvsiT4x5i579sxC/8mKwByK77gIlujIyh2vP3jPnx9iDXV4zIJpt9dwJWjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5222
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=848 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTEyIGF0IDE4OjQ2ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFdlZCwgRmViIDEyLCAyMDIwIGF0IDA0OjQ3OjIzUE0g
KzAyMDAsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4gPiBUaGVyZSB3ZXJlIGEgZmV3IGF0
dGVtcHRzIGF0IGNoYW5naW5nIGJlaGF2aW9yIG9mIHRoZSBtYXRjaF9zdHJpbmcoKQ0KPiA+IGhl
bHBlcnMgKGkuZS4gJ21hdGNoX3N0cmluZygpJyAmICdzeXNmc19tYXRjaF9zdHJpbmcoKScpLCB0
byBjaGFuZ2UgJg0KPiA+IGV4dGVuZCB0aGUgYmVoYXZpb3IgYWNjb3JkaW5nIHRvIHRoZSBkb2Mt
c3RyaW5nLg0KPiA+IA0KPiA+IEJ1dCB0aGUgc2ltcGxlc3QgYXBwcm9hY2ggaXMgdG8ganVzdCBm
aXggdGhlIGRvYy1zdHJpbmdzLiBUaGUgY3VycmVudA0KPiA+IGJlaGF2aW9yIGlzIGZpbmUgYXMt
aXMsIGFuZCBzb21lIGJ1Z3Mgd2VyZSBpbnRyb2R1Y2VkIHRyeWluZyB0byBmaXggaXQuDQo+ID4g
DQo+ID4gQXMgZm9yIGV4dGVuZGluZyB0aGUgYmVoYXZpb3IsIG5ldyBoZWxwZXJzIGNhbiBhbHdh
eXMgYmUgaW50cm9kdWNlZCBpZg0KPiA+IG5lZWRlZC4NCj4gPiANCj4gPiBUaGUgbWF0Y2hfc3Ry
aW5nKCkgaGVscGVycyBiZWhhdmUgbW9yZSBsaWtlICdzdHJuY21wKCknIGluIHRoZSBzZW5zZSB0
aGF0DQo+ID4gdGhleSBnbyB1cCB0byBuIGVsZW1lbnRzIG9yIHVudGlsIHRoZSBmaXJzdCBOVUxM
IGVsZW1lbnQgaW4gdGhlIGFycmF5IG9mDQo+ID4gc3RyaW5ncy4NCj4gPiANCj4gPiBUaGlzIGNo
YW5nZSB1cGRhdGVzIHRoZSBkb2Mtc3RyaW5ncyB3aXRoIHRoaXMgaW5mby4NCj4gPiANCj4gPiBT
b21lIHJlZmVyZW5jZXMgdG8gdGhlIHByZXZpb3VzIGF0dGVtcHRzIChpbiBubyBwYXJ0aWN1bGFy
IG9yZGVyKToNCj4gPiAgIA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTA1
MDgxMTE5MTMuNzI3Ni0xLWFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tLw0KPiA+ICAgDQo+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDYyNTEzMDEwNC4yOTkwNC0xLWFs
ZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tLw0KPiA+ICAgDQo+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDE5MDQyMjA4MzI1Ny4yMTgwNS0xLWFsZXhhbmRydS5hcmRlbGVhbkBh
bmFsb2cuY29tLw0KPiANCj4gLi4uDQo+IA0KPiA+ICAvKioNCj4gPiAgICogbWF0Y2hfc3RyaW5n
IC0gbWF0Y2hlcyBnaXZlbiBzdHJpbmcgaW4gYW4gYXJyYXkNCj4gPiAgICogQGFycmF5OglhcnJh
eSBvZiBzdHJpbmdzDQo+ID4gLSAqIEBuOgkJbnVtYmVyIG9mIHN0cmluZ3MgaW4gdGhlIGFycmF5
IG9yIC0xIGZvciBOVUxMIHRlcm1pbmF0ZWQNCj4gPiBhcnJheXMNCj4gPiArICogQG46CQludW1i
ZXIgb2Ygc3RyaW5ncyBpbiB0aGUgYXJyYXkgdG8gY29tcGFyZQ0KPiANCj4gQnV0IHRoaXMgY2hh
bmdlIHdvbid0IGJlIGhlbHBmdWwsIGl0IGFjdHVhbGx5IGhpZGVzIHRoZSBwYXJ0IG9mIGJlaGF2
aW91ciB0aGF0DQo+IGlzIGJlaW5nIHVzZWQuDQo+IA0KPiA+ICAgKiBAc3RyaW5nOglzdHJpbmcg
dG8gbWF0Y2ggd2l0aA0KPiA+ICAgKg0KPiA+ICsgKiBUaGlzIHJvdXRpbmUgd2lsbCBsb29rIGZv
ciBhIHN0cmluZyBpbiBhbiBhcnJheSBvZiBzdHJpbmdzIHVwIHRvIHRoZQ0KPiA+ICsgKiBuLXRo
IGVsZW1lbnQgaW4gdGhlIGFycmF5IG9yIHVudGlsIHRoZSBmaXJzdCBOVUxMIGVsZW1lbnQuDQo+
ID4gKyAqDQo+IA0KPiBQZXJoYXBzIHRoaXMgbmVlZHMgdG8gYmUgcmVwaHJhc2VkLiBCZWNhdXNl
IG5vdyBpdCBoYXMgY29tcGxldGVseSBoaWRkZW4gdGhlDQo+IC0xIGNhc2UuDQoNCkhtbSwgaXQg
ZG9lcyBtYWtlIHNlbnNlIHRvIHNwZWNpZnkgdGhlIC0xIGJlaGF2aW9yIHB1cmVseSBmb3IgaGlz
dG9yaWNhbA0KcHVycG9zZXMuDQpPdGhlcml3c2UsIEkgZG9uJ3QgZmVlbCBpdCdzIHRoYXQgaW1w
b3J0YW50IHRvIG1lbnRpb24gaXQsIHNpbmNlIHlvdSBjb3VsZA0KdGVjaG5pY2FsbHkgc3BlY2lm
eSBVSU5UX01BWCBbb3Igc2ltaWxhcl0gYW5kIGdldCB0aGUgc2FtZSBiZWhhdmlvci4NCg0KPiAN
Cj4gPiAgICogUmV0dXJuOg0KPiA+ICAgKiBpbmRleCBvZiBhIEBzdHJpbmcgaW4gdGhlIEBhcnJh
eSBpZiBtYXRjaGVzLCBvciAlLUVJTlZBTCBvdGhlcndpc2UuDQo+ID4gICAqLw0KPiANCj4gRGl0
dG8gZm9yIHRoZSBzZWNvbmQgcGFydC4NCj4gDQo=
