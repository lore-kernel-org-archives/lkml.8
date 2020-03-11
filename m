Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEE8C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F28206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="adiNR2Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgCKSLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:11:14 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:14675
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730468AbgCKSLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:11:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vpra7Nh4QiRrOBoTT0+c0sKPyjXAy6SQuglwZokvojD+/I2Nf6oEeKc9AIZv1yot8x1MKJwhGxcIK0X4LXG751faGru8Zxm15gbaNCjso07OMz05L76TszhySaTSGxrHQeEzq2eEu8/WN2qXwGcBK3IMeq7+8d0dR/N0mdIwmW7V0Li2x3gdE+3vIUqq4v7VrkzBB6cYaj2ms4xu/MdzwlzsfdluJiWo7BwMrAmEBoWJu2RYi3GD1Py58VJf686hUTW/+ldKpVRKF/rNWQ0onP8lspqc1gFbLZ3dySQVnigEJGJjtA6VTqgyiMGOw134heSJ2VdnpK7mXPxk0mtlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBf/+UcSxg9thL7vvogIaYnuRSiVy3bv4mroSGQI6sc=;
 b=nCY1b9e7NwZRP+mzRhNLbaqRhkA/2HMMOU99yPIhVphA90VWieOwLuvo7UqMdv1CFWVsCU3AZ2meg0OCaQU4PXlXe2U0L3A2e08PKPD6POL8N670ek90hBSEsVuQJTGaF3VxDPj9VASfNfm10HiKXzM/89n4Qzj8+BSST546MyTbe8Mn7ygLNjN+/2/IxTAWZJrJ7XKEjn9AMsKqSH6BRdpPtBQcGEqp5hzWQ2x8OMUqA2+IBV2sYgZJWVMmagIXAR+fgF+oxw1yaTxGEvE0WsJehbPMIIY019c52qP4x8Dnfi7ag0NA9pkdtBv6txng69dXj0jbTKReihLZNG/EHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBf/+UcSxg9thL7vvogIaYnuRSiVy3bv4mroSGQI6sc=;
 b=adiNR2Y6qqcOdzV3PW29MsU7iTBdosIh+v5oTzWxhmdWwlhsrCyUh/x9PQeOIXkuvyk6YY+4sYDLK2P2t1cOPgV0pkvfrU6vygPSs96jt9Fq9LBCMXrVhJIk2T4uDvnHvGSJGVmukAx+vC3q+rk+Kc6TFzg3Udrkg6Qt3UfNGGY=
Received: from MN2PR12MB3232.namprd12.prod.outlook.com (2603:10b6:208:ab::29)
 by MN2PR12MB3919.namprd12.prod.outlook.com (2603:10b6:208:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 18:11:06 +0000
Received: from MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::d8f:800:975a:b8c]) by MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::d8f:800:975a:b8c%6]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 18:11:06 +0000
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
Thread-Index: AQHV9x46fcHb8CAMpEy5Z6V8Vk8yLqhCWDIAgAFURNA=
Date:   Wed, 11 Mar 2020 18:11:06 +0000
Message-ID: <MN2PR12MB3232AD3D784F07645D7115609CFC0@MN2PR12MB3232.namprd12.prod.outlook.com>
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
 <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
 <3c350277-8fe6-04b2-673e-7d4c8fb6ce24@deltatee.com>
In-Reply-To: <3c350277-8fe6-04b2-673e-7d4c8fb6ce24@deltatee.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2020-03-11T17:49:04Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=9bdf3feb-dc2b-4d9e-9d6d-00009732a996;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_enabled: true
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_setdate: 2020-03-11T18:11:04Z
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_method: Privileged
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_name: Non-Business
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_actionid: 078a4caf-6cae-4684-8cca-000024b16415
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Arindam.Nath@amd.com; 
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d9f5cec-2044-4d3d-bec6-08d7c5e791a2
x-ms-traffictypediagnostic: MN2PR12MB3919:|MN2PR12MB3919:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3919A933634C39FD1F29C1CD9CFC0@MN2PR12MB3919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(64756008)(4326008)(66476007)(66946007)(6506007)(53546011)(76116006)(8936002)(66556008)(66446008)(7696005)(316002)(55016002)(8676002)(110136005)(52536014)(5660300002)(9686003)(2906002)(6636002)(81166006)(81156014)(54906003)(86362001)(478600001)(186003)(33656002)(26005)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3919;H:MN2PR12MB3232.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4R6h2VbakjIm6WJ1zoT2uJpi7yUB19TFpzKp/uJO9JkKcQAnWdWC7ATqrQLlgKttZQcimf6L1T/+KdckNREWp4LJ/0bGSLhXPl+a5IRbbk3Vyo3fq2LVss0f9ObnQ7FlsDqixcEA5gMIBuw1jbztGVf5h66sShiezzom3yE6BhsZnQlcAHSaOYkYcW0+EXiR4L7QyL36AA+Igd47a3Izxpl4gkg6TWBkrw/9+Drno6XCs53yWgc4ECGgygbivyooZv5F6s9YxVcucOUApfby4LFGiP7CW/Uyj4jS+9EXcx6yuN+9xu21Mz5YXiqTHk6yWY1GjlLl4XKfNtsGjSxMjf2R3dfSsESoTyY8w61m9G5zsqWBIgZnCjhvvVtct9VuvbT1djb/L/eghuYFEzSKSm3mj1J/ZJBngLyG1tVHp1piV5tk5wlX7uZRmxJaDOpe
x-ms-exchange-antispam-messagedata: AStkzKUhD4IyCSw30bj6SEHbQ8PtN6Dp60EslDZ4/jIoe8hNPbm7tWwhM4d1DkUMjKwG4bRJSyIltmwKcDJkIKDj9KkCXRjWjp0wppIujZIIQJeLpKhWvpwYvx0DmgJUD8yBmvNnv6Ouc6WTlwjCmQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9f5cec-2044-4d3d-bec6-08d7c5e791a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 18:11:06.6474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcyDmPbnMp3zITWhaYzH+qz/eSD83HqjDUwfjk553CJrsfX0dRtGAMxshJMB+H3m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2dhbiBHdW50aG9ycGUgPGxv
Z2FuZ0BkZWx0YXRlZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTEsIDIwMjAgMDM6
MDENCj4gVG86IE1laHRhLCBTYW5qdSA8U2FuanUuTWVodGFAYW1kLmNvbT47IGpkbWFzb25Aa3Vk
enUudXM7DQo+IGRhdmUuamlhbmdAaW50ZWwuY29tOyBhbGxlbmJoQGdtYWlsLmNvbTsgTmF0aCwg
QXJpbmRhbQ0KPiA8QXJpbmRhbS5OYXRoQGFtZC5jb20+OyBTLWssIFNoeWFtLXN1bmRhciA8U2h5
YW0tc3VuZGFyLlMtDQo+IGtAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LW50YkBnb29nbGVncm91cHMu
Y29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMi81XSBudGJfcGVyZjogc2VuZCBjb21tYW5kIGluIHJlc3BvbnNlIHRvIEVBR0FJTg0KPiAN
Cj4gDQo+IA0KPiBPbiAyMDIwLTAzLTEwIDI6NTQgcC5tLiwgU2FuamF5IFIgTWVodGEgd3JvdGU6
DQo+ID4gRnJvbTogQXJpbmRhbSBOYXRoIDxhcmluZGFtLm5hdGhAYW1kLmNvbT4NCj4gPg0KPiA+
IHBlcmZfc3BhZF9jbWRfc2VuZCgpIGFuZCBwZXJmX21zZ19jbWRfc2VuZCgpIHJldHVybg0KPiA+
IC1FQUdBSU4gYWZ0ZXIgdHJ5aW5nIHRvIHNlbmQgY29tbWFuZHMgZm9yIGEgbWF4aW11bQ0KPiA+
IG9mIE1TR19UUklFUyByZS10cmllcy4gQnV0IGN1cnJlbnRseSB0aGVyZSBpcyBubw0KPiA+IGhh
bmRsaW5nIGZvciB0aGlzIGVycm9yLiBUaGVzZSBmdW5jdGlvbnMgYXJlIGludm9rZWQNCj4gPiBm
cm9tIHBlcmZfc2VydmljZV93b3JrKCkgdGhyb3VnaCBmdW5jdGlvbiBwb2ludGVycywNCj4gPiBz
byByYXRoZXIgdGhhbiBzaW1wbHkgY2FsbCB0aGVzZSBmdW5jdGlvbnMgaXMgbm90DQo+ID4gZW5v
dWdoLiBXZSBuZWVkIHRvIG1ha2Ugc3VyZSB0byBpbnZva2UgdGhlbSBhZ2FpbiBpbg0KPiA+IGNh
c2Ugb2YgLUVBR0FJTi4gU2luY2UgcGVlciBzdGF0dXMgYml0cyB3ZXJlIGNsZWFyZWQNCj4gPiBi
ZWZvcmUgY2FsbGluZyB0aGVzZSBmdW5jdGlvbnMsIHdlIHNldCB0aGUgc2FtZSBzdGF0dXMNCj4g
PiBiaXRzIGJlZm9yZSBxdWV1ZWluZyB0aGUgd29yayBhZ2FpbiBmb3IgbGF0ZXIgaW52b2NhdGlv
bi4NCj4gPiBUaGlzIHdheSB3ZSBzaW1wbHkgd29uJ3QgZ28gYWhlYWQgYW5kIGluaXRpYWxpemUg
dGhlDQo+ID4gWExBVCByZWdpc3RlcnMgd3JvbmdmdWxseSBpbiBjYXNlIHNlbmRpbmcgdGhlIHZl
cnkgZmlyc3QNCj4gPiBjb21tYW5kIGl0c2VsZiBmYWlscy4NCj4gDQo+IFNvIHdoYXQgaGFwcGVu
cyBpZiB0aGVyZSdzIGFuIGFjdHVhbCBub24tcmVjb3ZlcmFibGUgZXJyb3IgdGhhdCBjYXVzZXMN
Cj4gcGVyZl9tc2dfY21kX3NlbmQoKSB0byBmYWlsPyBBcmUgeW91IHByb3Bvc2luZyBpdCBqdXN0
IHJlcXVldWVzIGhpZ2gNCj4gcHJpb3JpdHkgd29yayBmb3JldmVyPw0KDQpUaGUgaW50ZW50IG9m
IHRoZSBwYXRjaCBpcyB0byBoYW5kbGUgLUVBR0FJTiwgc2luY2UgdGhlIGVycm9yIGNvZGUgaXMN
CmFuIGluZGljYXRpb24gdGhhdCB3ZSBuZWVkIHRvIHRyeSBhZ2FpbiBsYXRlci4gQ3VycmVudGx5
IHRoZXJlIGlzIGEgdmVyeQ0Kc21hbGwgdGltZSBmcmFtZSBkdXJpbmcgd2hpY2ggbnRiX3BlcmYg
c2hvdWxkIGJlIGxvYWRlZCBvbiBib3RoIHNpZGVzDQoocHJpbWFyeSBhbmQgc2Vjb25kYXJ5KSB0
byBoYXZlIFhMQVQgcmVnaXN0ZXJzIGNvbmZpZ3VyZWQgY29ycmVjdGx5Lg0KRmFpbGluZyB0aGF0
IHRoZSBjb2RlIHdpbGwgc3RpbGwgZmFsbCB0aHJvdWdoIHdpdGhvdXQgcHJvcGVybHkgaW5pdGlh
bGl6aW5nIHRoZQ0KWExBVCByZWdpc3RlcnMgYW5kIHRoZXJlIGlzIG5vIGluZGljYXRpb24gb2Yg
dGhhdCBlaXRoZXIgdW50aWwgd2UgaGF2ZQ0KYWN0dWFsbHkgdHJpZWQgdG8gcGVyZm9ybSAnZWNo
byAwID4gL3N5cy9rZXJuZWwvZGVidWcvLi4uL3J1bicuDQoNCldpdGggdGhlIGNoYW5nZXMgcHJv
cG9zZWQgaW4gdGhpcyBwYXRjaCwgd2UgZG8gbm90IGhhdmUgdG8gZGVwZW5kDQpvbiB3aGV0aGVy
IHRoZSBkcml2ZXJzIGF0IGJvdGggZW5kcyBhcmUgbG9hZGVkIHdpdGhpbiBhIGZpeGVkIHRpbWUN
CmR1cmF0aW9uLiBTbyB3ZSBjYW4gc2ltcGx5IGxvYWQgdGhlIGRyaXZlciBhdCBvbmUgc2lkZSwg
YW5kIGF0IGEgbGF0ZXINCnRpbWUgbG9hZCB0aGUgZHJpdmVyIG9uIHRoZSBvdGhlciwgYW5kIHN0
aWxsIHRoZSBYTEFUIHJlZ2lzdGVycyB3b3VsZA0KYmUgc2V0IHVwIGNvcnJlY3RseS4NCg0KTG9v
a2luZyBhdCBwZXJmX3NwYWRfY21kX3NlbmQoKSBhbmQgcGVyZl9tc2dfY21kX3NlbmQoKSwgaWYg
dGhlDQpjb25jZXJuIGlzIHRoYXQgbnRiX3BlZXJfc3BhZF9yZWFkKCkvbnRiX21zZ19yZWFkX3N0
cygpIGZhaWwgYmVjYXVzZQ0Kb2Ygc29tZSBub24tcmVjb3ZlcmFibGUgZXJyb3IgYW5kIHdlIHN0
aWxsIHNjaGVkdWxlIGEgaGlnaCBwcmlvcml0eQ0Kd29yaywgdGhhdCBpcyBhIHZhbGlkIGNvbmNl
cm4uIEJ1dCBpc24ndCBpdCBzdGlsbCBiZXR0ZXIgdGhhbiBzaW1wbHkgZmFsbGluZw0KdGhyb3Vn
aCBhbmQgaW5pdGlhbGl6aW5nIFhMQVQgcmVnaXN0ZXIgd2l0aCBpbmNvcnJlY3QgdmFsdWVzPw0K
DQo+IA0KPiBJIG5ldmVyIHJlYWxseSByZXZpZXdlZCB0aGlzIHN0dWZmIHByb3Blcmx5IGJ1dCBp
dCBsb29rcyBsaWtlIGl0IGhhcyBhDQo+IGJ1bmNoIG9mIHByb2JsZW1zLiBVc2luZyB0aGUgaGln
aCBwcmlvcml0eSB3b3JrIHF1ZXVlIGZvciBzb21lIGxvdw0KPiBwcmlvcml0eSBzZXR1cCB3b3Jr
IHNlZW1zIHdyb25nLCBhdCB0aGUgdmVyeSBsZWFzdC4gVGhlIHNwYWQgYW5kIG1zZw0KPiBzZW5k
IGxvb3BzIGFsc28gbG9vayBsaWtlIHRoZXkgaGF2ZSBhIGJ1bmNoIG9mIGludGVyLWhvc3QgcmFj
ZSBjb25kaXRpb24NCj4gcHJvYmxlbXMgYXMgd2VsbC4gWWlrZXMuDQoNCkkgYW0gbm90IHZlcnkg
c3VyZSB3aGF0IHRoZSBkZXNpZ24gY29uc2lkZXJhdGlvbnMgd2VyZSB3aGVuIGhhdmluZw0KYSBo
aWdoIHByaW9yaXR5IHdvcmsgcXVldWUsIGJ1dCBwZXJoYXBzIHdlIGNhbiBhbGwgaGF2ZSBhIGRp
c2N1c3Npb24NCm9uIHRoaXMuDQoNCkFyaW5kYW0NCg0KPiANCj4gTG9nYW4NCj4gDQo+IA0KPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBcmluZGFtIE5hdGggPGFyaW5kYW0ubmF0aEBhbWQuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNhbmpheSBSIE1laHRhIDxzYW5qdS5tZWh0YUBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMgfCAxOCArKysrKysrKysr
KysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5j
IGIvZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5jDQo+ID4gaW5kZXggNmQxNjYyOC4uOTA2OGU0
MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gPiArKysg
Yi9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gPiBAQCAtNjI1LDE0ICs2MjUsMjQgQEAg
c3RhdGljIHZvaWQgcGVyZl9zZXJ2aWNlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3Jr
KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcGVyZl9wZWVyICpwZWVyID0gdG9fcGVlcl9zZXJ2aWNl
KHdvcmspOw0KPiA+DQo+ID4gLQlpZiAodGVzdF9hbmRfY2xlYXJfYml0KFBFUkZfQ01EX1NTSVpF
LCAmcGVlci0+c3RzKSkNCj4gPiAtCQlwZXJmX2NtZF9zZW5kKHBlZXIsIFBFUkZfQ01EX1NTSVpF
LCBwZWVyLQ0KPiA+b3V0YnVmX3NpemUpOw0KPiA+ICsJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChQ
RVJGX0NNRF9TU0laRSwgJnBlZXItPnN0cykpIHsNCj4gPiArCQlpZiAocGVyZl9jbWRfc2VuZChw
ZWVyLCBQRVJGX0NNRF9TU0laRSwgcGVlci0NCj4gPm91dGJ1Zl9zaXplKQ0KPiA+ICsJCSAgICA9
PSAtRUFHQUlOKSB7DQo+ID4gKwkJCXNldF9iaXQoUEVSRl9DTURfU1NJWkUsICZwZWVyLT5zdHMp
Ow0KPiA+ICsJCQkodm9pZClxdWV1ZV93b3JrKHN5c3RlbV9oaWdocHJpX3dxLCAmcGVlci0NCj4g
PnNlcnZpY2UpOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPg0KPiA+ICAJaWYgKHRlc3RfYW5kX2Ns
ZWFyX2JpdChQRVJGX0NNRF9SU0laRSwgJnBlZXItPnN0cykpDQo+ID4gIAkJcGVyZl9zZXR1cF9p
bmJ1ZihwZWVyKTsNCj4gPg0KPiA+IC0JaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChQRVJGX0NNRF9T
WExBVCwgJnBlZXItPnN0cykpDQo+ID4gLQkJcGVyZl9jbWRfc2VuZChwZWVyLCBQRVJGX0NNRF9T
WExBVCwgcGVlci0+aW5idWZfeGxhdCk7DQo+ID4gKwlpZiAodGVzdF9hbmRfY2xlYXJfYml0KFBF
UkZfQ01EX1NYTEFULCAmcGVlci0+c3RzKSkgew0KPiA+ICsJCWlmIChwZXJmX2NtZF9zZW5kKHBl
ZXIsIFBFUkZfQ01EX1NYTEFULCBwZWVyLQ0KPiA+aW5idWZfeGxhdCkNCj4gPiArCQkgICAgPT0g
LUVBR0FJTikgew0KPiA+ICsJCQlzZXRfYml0KFBFUkZfQ01EX1NYTEFULCAmcGVlci0+c3RzKTsN
Cj4gPiArCQkJKHZvaWQpcXVldWVfd29yayhzeXN0ZW1faGlnaHByaV93cSwgJnBlZXItDQo+ID5z
ZXJ2aWNlKTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4NCj4gPiAgCWlmICh0ZXN0X2FuZF9jbGVh
cl9iaXQoUEVSRl9DTURfUlhMQVQsICZwZWVyLT5zdHMpKQ0KPiA+ICAJCXBlcmZfc2V0dXBfb3V0
YnVmKHBlZXIpOw0KPiA+DQo=
