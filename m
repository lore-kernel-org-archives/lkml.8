Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4545C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792A921927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HiYHM0E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgBZB4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:56:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:52481 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbgBZB4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:56:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 17:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; 
   d="scan'208";a="271550870"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2020 17:56:13 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 17:56:12 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX161.amr.corp.intel.com (10.22.240.84) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 17:56:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 17:56:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F54x7kUzP0peArthYsXGPNHxpNV57S9HtUsTvvFUAor9lUgkqKtFOJAomRlROcqe7PzzDoPsoCioFS3YcYnKXZHVNFtSvlVxBt/ZS6JkG0BcUhNWVF+DxdaGsCyL+/imx3hNq6KGzLnviOzxh6oxb+PmnQAmlRVmNIr0sGOS3L1fxyOLcG08QyqqZ7ip0vI853a90b0FoX6qjfLbiUueX4m0hveIkV9tZi86taAm/4MTfHN/i4gPk3n5uSbhP+Thn/E2GjXnEK6fLfsIuUBiAwQky5+ADWJiXXm9VlVyJEKieunvDLDvivOLReB5asI4B5V5orD5d3VVPmA5Z9qEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScVGhp1MnsiQJByJnOpzXlnlaXX/cpXf8oRPKxgKqWM=;
 b=Yf8DbtS4XtLJoTe1/WIHFxrj1jgfOPjx0XCoe9C5fbnlap22GSw7vFpq4ZCF5jmtb64gvaaloIEkUz8PdD6TzURU/ow7OT+fKsqsq/RYwt4NqCFx1P0TzcU9pc+AUTPdK8HkK2DaieyqGuTldNb+ycmAGZ6fRAkR6bXlnJPUDiVuo2rKzXb7Qk+n9OY0s5FmcQMcDnq6TFO1oI0wnoH1ODpHeveWhkoNMMLgyB/mBlWbdCeMad1rPRg/TAG9n03w5FCCUUmFxqaO5mPN6TYUNRkEGlaMjXopKKXQ53g4gVIlkCEK1zJnC8GxUrJkxspC80lGuGbVSmKSCtr6Axp6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScVGhp1MnsiQJByJnOpzXlnlaXX/cpXf8oRPKxgKqWM=;
 b=HiYHM0E1lDSMn2/01onQdQTUYSIfcsThU5o0AC2WAZse9CEttEDdCdsyb/Yl+r7+z5tXS9m6qpbcw4GpvVK/+jbahV5LK/bHqp8qgaUrRz54JpZOFqdR3LiRtNvJS6r8cC25W8vaXqGkHf2Ilk6uUljabxM9i4SBMym22Ojkm4A=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB3656.namprd11.prod.outlook.com (2603:10b6:a03:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 01:56:11 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 01:56:11 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Zhou <chenzhou10@huawei.com>
CC:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] platform/x86: intel_pmc_core: fix build error
 without CONFIG_DEBUG_FS
Thread-Topic: [PATCH -next] platform/x86: intel_pmc_core: fix build error
 without CONFIG_DEBUG_FS
Thread-Index: AQHV68RKgRwSmpVnSkSIUUllmPImR6gsJDPAgACInvA=
Date:   Wed, 26 Feb 2020 01:56:11 +0000
Message-ID: <BYAPR11MB3624FB3A1FC8F5C43D8F6DC4F2EA0@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <20200220033335.106963-1-chenzhou10@huawei.com>
 <CAHp75Vf3Bsjj+0ebkxMatZfUGDJ=upOHBFHfOs_PDOnFTnRJYQ@mail.gmail.com>
 <BN8PR11MB362069564569B69E42C00086F2ED0@BN8PR11MB3620.namprd11.prod.outlook.com>
In-Reply-To: <BN8PR11MB362069564569B69E42C00086F2ED0@BN8PR11MB3620.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7968c93f-e736-4709-64c5-08d7ba5f0de5
x-ms-traffictypediagnostic: BYAPR11MB3656:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB36562AD6C2F0A9D63631D15DF2EA0@BYAPR11MB3656.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(71200400001)(55016002)(316002)(7696005)(9686003)(64756008)(66556008)(66446008)(5660300002)(33656002)(76116006)(52536014)(6506007)(8936002)(186003)(53546011)(54906003)(2906002)(86362001)(26005)(4326008)(8676002)(110136005)(66946007)(478600001)(81156014)(81166006)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3656;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rNmU6iWQ0XdJaTtQNg7vDNHWs26lXME5Xl6T2CTzIY3Z1WHEHCAMrKnUCV41V90Ypb0WrXMUk4wM7PW7ItI0PIhzahQcXYu3oJTFYXkdHYieshkJmzxFcmAvwxCj8GS6cFKY7gT240mOGJ0Tzpj/V9Mu7ASmzI7fUeQP/eAzH+1fJQd2IY6yDiImBAYDAtE6NBLAYxFKCopopVoEKDB54olBc4ztOvyD5QwogtUc+9c/kSNBMwho8HUkXtKW17SEiTVr+UJRBPCtxYKKLjNby2IDxMw4oO907WEJQPiBmiAVTWkX+O4OeExnDlYWK6pZvKMfI9yC7xa+vPz1QBr0aYG4fYyUSoEFKKeWPwTbiW7nyl5aY2WXXfzHxKvLMqLDxXqfFucb5Pn54RvFpk5/nXTCeQIIvG6pU0mHCmlNedwJ1x8OsqGYdWRjsfetHp/
x-ms-exchange-antispam-messagedata: 1ZJX1LF1Q9/Fd5gQzZtrLdXLuP8AUeIc/vtoITcHtzU7q7zYwCTIVYszRC4ZQS2eH4EFmNpIcI6y90iYbMKOD5GznQkHIb4Q5Dgr3bYfkiFJt7kF32Efda/syh7zjPwGlA36dOFBJQY7XqGTYGycVw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7968c93f-e736-4709-64c5-08d7ba5f0de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 01:56:11.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhvxNrrIHiTd3iS3q7sMTPvLYAmXfYjftcadDEfYSLOqmv+LiCEqW1FS2VSd2I8y3noen4tMiC1mD1BMoSsHiGAarPppN/JshN4OTFscgTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3656
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYW1tZWxhLCBHYXlhdHJpDQo+
IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDI1LCAyMDIwIDk6MTEgQU0NCj4gVG86IEFuZHkgU2hl
dmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IENoZW4gWmhvdQ0KPiA8Y2hlbnpo
b3UxMEBodWF3ZWkuY29tPg0KPiBDYzogUmFqbmVlc2ggQmhhcmR3YWogPHJham5lZXNoLmJoYXJk
d2FqQGludGVsLmNvbT47IFNvbWF5YWppLA0KPiBWaXNod2FuYXRoIDx2aXNod2FuYXRoLnNvbWF5
YWppQGludGVsLmNvbT47IERhcnJlbiBIYXJ0DQo+IDxkdmhhcnRAaW5mcmFkZWFkLm9yZz47IEFu
ZHkgU2hldmNoZW5rbyA8YW5keUBpbmZyYWRlYWQub3JnPjsNCj4gUGxhdGZvcm0gRHJpdmVyIDxw
bGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5n
DQo+IExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJFOiBb
UEFUQ0ggLW5leHRdIHBsYXRmb3JtL3g4NjogaW50ZWxfcG1jX2NvcmU6IGZpeCBidWlsZCBlcnJv
cg0KPiB3aXRob3V0IENPTkZJR19ERUJVR19GUw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWls
LmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNSwgMjAyMCAyOjEzIEFNDQo+ID4g
VG86IENoZW4gWmhvdSA8Y2hlbnpob3UxMEBodWF3ZWkuY29tPjsgS2FtbWVsYSwgR2F5YXRyaQ0K
PiA+IDxnYXlhdHJpLmthbW1lbGFAaW50ZWwuY29tPg0KPiA+IENjOiBSYWpuZWVzaCBCaGFyZHdh
aiA8cmFqbmVlc2guYmhhcmR3YWpAaW50ZWwuY29tPjsgU29tYXlhamksDQo+ID4gVmlzaHdhbmF0
aCA8dmlzaHdhbmF0aC5zb21heWFqaUBpbnRlbC5jb20+OyBEYXJyZW4gSGFydA0KPiA+IDxkdmhh
cnRAaW5mcmFkZWFkLm9yZz47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBpbmZyYWRlYWQub3JnPjsN
Cj4gUGxhdGZvcm0NCj4gPiBEcml2ZXIgPHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwu
b3JnPjsgTGludXggS2VybmVsIE1haWxpbmcNCj4gPiBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggLW5leHRdIHBsYXRmb3JtL3g4Njog
aW50ZWxfcG1jX2NvcmU6IGZpeCBidWlsZA0KPiA+IGVycm9yIHdpdGhvdXQgQ09ORklHX0RFQlVH
X0ZTDQo+ID4NCj4gPiBPbiBUaHUsIEZlYiAyMCwgMjAyMCBhdCA1OjQwIEFNIENoZW4gWmhvdSA8
Y2hlbnpob3UxMEBodWF3ZWkuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IElmIENPTkZJ
R19ERUJVR19GUyBpcyBuLCBidWlsZCBmYWlsczoNCj4gPiA+DQo+ID4gPiBkcml2ZXJzL3BsYXRm
b3JtL3g4Ni9pbnRlbF9wbWNfY29yZS5jOiBJbiBmdW5jdGlvbiBwbWNfY29yZV9yZXN1bWU6DQo+
ID4gPiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNfY29yZS5jOjEzMjc6MzogZXJyb3I6
IGltcGxpY2l0DQo+ID4gPiBkZWNsYXJhdGlvbg0KPiA+IG9mIGZ1bmN0aW9uIHBtY19jb3JlX3Ns
cHMwX2Rpc3BsYXk7IGRpZCB5b3UgbWVhbg0KPiA+IHBtY19jb3JlX2lzX3BjMTBfZmFpbGVkPyBb
LVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiA+ICAgIHBtY19jb3Jl
X3NscHMwX2Rpc3BsYXkocG1jZGV2LCBkZXYsIE5VTEwpOw0KPiA+ID4gICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fg0KPiA+ID4NCj4gPiA+IEZ1bmN0aW9uIHBtY19jb3JlX3NscHMwX2Rpc3Bs
YXkoKSBpcyByZXNwb25zaWJsZSBmb3IgZGlzcGxheWluZw0KPiA+ID4gZGVidWcgcmVnaXN0ZXJz
LCB3aGljaCBpcyB1bmRlciBDT05GSUdfREVCVUdfRlMuDQo+ID4gPg0KPiA+ID4gUHJvdmlkaW5n
IHRoZSBzdGF0aWMgaW5saW5lIHN0dWIgd2hlbmV2ZXIgQ09ORklHX0RFQlVHX0ZTIGlzDQo+ID4g
PiBkaXNhYmxlZCB0byBmaXggdGhpcy4gRnVuY3Rpb24gcG1jX2NvcmVfbHBtX2Rpc3BsYXkoKSBp
cyB0aGUgc2FtZS4NCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLCBidXQgSSB0aGlu
ayBpdCdzIG5vdCB0aGUgcmlnaHQgYXBwcm9hY2guDQo+ID4gQmFzaWNhbGx5IHdlIG5lZWQgdG8g
bW92ZSB0aG9zZSBmdW5jdGlvbnMgb3V0c2lkZSBvZiAjaWYNCj4gPiBJU19FTkFCTEVEKENPTkZJ
R19ERUJVR19GUykuDQo+ID4gKE1vdmUgdGhlbSB1cHBlcikuDQo+IEFncmVlZA0KPiA+DQo+ID4g
QWxzbyBJIGhhdmUgbm90aWNlZCBhbm90aGVyIGlzc3VlIGluIHBtY19jb3JlX2xwbV9kaXNwbGF5
KCkuIEl0IHVzZXMNCj4gPiB0Z2xfbHBtX21hcHMgZGlyZWN0bHkuIEl0IHNob3VsZG4ndC4NCj4g
Pg0KPiA+IENjOiBHYXlhdHJpLg0KPiA+DQo+ID4gR2F5YXRyaSwgY2FyZSB0byBmaXg/DQo+IEhp
IEFuZHksIGNhdWdodCB0aGlzIGJ1ZyBpbiBvdXIgaW50ZXJuYWwgcmVncmVzc2lvbiB0b28uIEkg
d2lsbCBzZW5kIHRoZSBwYXRjaA0KPiBzaG9ydGx5LiBUaGFua3MhDQoNClVwZGF0ZTogQW5keSwg
SSBoYXZlIDQgc21hbGwgZml4ZXMgZm9yIHRoZSBwYXRjaCBzZXJpZXMgbWVyZ2VkIGluIGZvci1u
ZXh0IGJyYW5jaC4gSSBhbSB3b25kZXJpbmcgaWYgSSBzaG91bGQgc2VuZCB0aGUgZml4dXAgcGF0
Y2hlcyBvciBpZiB5b3UgZHJvcCB0aGUgcGF0Y2ggc2VyaWVzIGZyb20gZm9yLW5leHQgYnJhbmNo
LCBJIGNhbiBzZW5kIG91dCB0aGUgbmV3IHZlcnNpb24gdGhhdCBpbmNsdWRlcyBhbGwgdGhlc2Ug
Zml4ZXMuIFBsZWFzZSBzdWdnZXN0LiBUaGFua3MhDQoNCj4gPg0KPiA+ID4gUmVwb3J0ZWQtYnk6
IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hl
biBaaG91IDxjaGVuemhvdTEwQGh1YXdlaS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJz
L3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNfY29yZS5jIHwgMTQgKysrKysrKysrKysrKysNCj4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNfY29yZS5jDQo+ID4gPiBiL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2ludGVsX3BtY19jb3JlLmMNCj4gPiA+IGluZGV4IGY0YTM2ZmIuLjkz
OWY4ZTAgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNf
Y29yZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNfY29yZS5j
DQo+ID4gPiBAQCAtMTExNyw2ICsxMTE3LDIwIEBAIHN0YXRpYyB2b2lkIHBtY19jb3JlX2RiZ2Zz
X3JlZ2lzdGVyKHN0cnVjdA0KPiA+IHBtY19kZXYgKnBtY2RldikNCj4gPiA+ICAgICAgICAgfQ0K
PiA+ID4gIH0NCj4gPiA+ICAjZWxzZQ0KPiA+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBwbWNfY29y
ZV9zbHBzMF9kaXNwbGF5KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYsDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2LA0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzZXFf
ZmlsZSAqcykgeyB9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGlubGluZSB2b2lkIHBtY19jb3Jl
X2xwbV9kaXNwbGF5KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYsDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNlcV9maWxlICpz
LCB1MzIgb2Zmc2V0LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBjaGFyICpzdHIsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBwbWNfYml0X21hcA0KPiA+ID4gKyoqbWFwcykgeyB9
DQo+ID4gPiArDQo+ID4gPiAgc3RhdGljIGlubGluZSB2b2lkIHBtY19jb3JlX2RiZ2ZzX3JlZ2lz
dGVyKHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYpDQo+ID4gPiB7IH0NCj4gPiA+IC0tDQo+ID4gPiAy
LjcuNA0KPiA+ID4NCj4gPg0KPiA+DQo+ID4gLS0NCj4gPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4g
PiBBbmR5IFNoZXZjaGVua28NCg==
