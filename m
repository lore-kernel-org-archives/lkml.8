Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B94C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C1620732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iO9HLIob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgBYRLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:11:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:27836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbgBYRLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:11:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 09:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="284724704"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Feb 2020 09:10:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 09:10:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 09:10:57 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Feb 2020 09:10:57 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 25 Feb 2020 09:10:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyk/Qf06T0TaRrUOhaX57wSqLDJzL7LzkoO3wx1Z2eFnPgu/t+Qtj136aJ6lWM6+swD1RlOidYzr4mu8ggVt4Izsudl9VHYPgNzABesbCqOHCl+bHbUN3jrXa+Xgas/rF+F8BukvM3NYdDwAZu/0j7kgaLo9a+gIlDwLfTFKdbB1bZU6oxzz0KqUxUhvTFXCXXEzP/jnkQIBNWorUiLWoTWF5jU+QNASYbW+C2VtjMpwgvtjMQxOmlwPD7yw4bLQo+3F0k5cCgb16JOijBlV0vaWYGWHNdcCwuMuGzoung3oEMjsfY+qZBHc2YZNSZwSsAStFtAO1hd1GzusTVioww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmR68crhoG2HPKEezNaoOCxU8kgOyTp9c5O+zKn31d4=;
 b=Ju+Ki6JwRgKzG46LR7btenGJ/+JYix4eNbOZAB4zV7apqxwCaNbDmkWaVNwdPTrExfeDR4PJdM3pQkcGkhdsUwNnRGICr33LbBPrHbcVxfKbftQrVIQQVl9/lvy0CF+/h2r5y/Lv/+VKMdEAahhB7rXLFfN7FvNP3DZ8oYTNl5UYWtytQ8adv97WzfimB9y+4+g23U7/r0kmAWE2wQddxGjkvlTKtIXDFn/ptM1dl2VrJegQ3QOV6+DcCMPUCbZCWVrE4NSVj9D/zhFYD3w6KZgYyYW0t/2A6a1iCPIvYJ4faDkAcJqlLSaEWXYAslnBJAmrtMGmTV1bo7fcYcMgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmR68crhoG2HPKEezNaoOCxU8kgOyTp9c5O+zKn31d4=;
 b=iO9HLIobn2F6sVZc6Yuw3mjK+k/NcjOxZNTe00pQd71umW3vb0CBhsVoQpWTW6SGKCaSaVGof3yFSRm/Cb6tO2iQa3070uaC0r6seI7gXW76kE4M+i4nKNeNixw4w2tNw1g3VaTeSgas33F/6ao5T38LehI0hSQcLLZhXqKjESc=
Received: from BN8PR11MB3620.namprd11.prod.outlook.com (2603:10b6:408:91::21)
 by BN8PR11MB3827.namprd11.prod.outlook.com (2603:10b6:408:90::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 17:10:47 +0000
Received: from BN8PR11MB3620.namprd11.prod.outlook.com
 ([fe80::c8:f6a0:1cf:c8d8]) by BN8PR11MB3620.namprd11.prod.outlook.com
 ([fe80::c8:f6a0:1cf:c8d8%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 17:10:47 +0000
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
Thread-Index: AQHV68RKgRwSmpVnSkSIUUllmPImR6gsJDPA
Date:   Tue, 25 Feb 2020 17:10:46 +0000
Message-ID: <BN8PR11MB362069564569B69E42C00086F2ED0@BN8PR11MB3620.namprd11.prod.outlook.com>
References: <20200220033335.106963-1-chenzhou10@huawei.com>
 <CAHp75Vf3Bsjj+0ebkxMatZfUGDJ=upOHBFHfOs_PDOnFTnRJYQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf3Bsjj+0ebkxMatZfUGDJ=upOHBFHfOs_PDOnFTnRJYQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 04fc7793-0c10-4940-24bc-08d7ba15a7ed
x-ms-traffictypediagnostic: BN8PR11MB3827:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB3827D5082B2FEFEFD627B444F2ED0@BN8PR11MB3827.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(54906003)(110136005)(316002)(52536014)(66946007)(6506007)(478600001)(53546011)(86362001)(76116006)(5660300002)(55016002)(81166006)(9686003)(2906002)(81156014)(4326008)(64756008)(8936002)(7696005)(71200400001)(33656002)(66476007)(66556008)(66446008)(26005)(8676002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR11MB3827;H:BN8PR11MB3620.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMFVtbV8kFSDfUC8gPiFzZLJGeBe0VFr1tOxx6tbtDQ0uyxo702SDElNMQxCVkjT5reQagsEYl+gWKPnnbiZ+7c0rQSjwUKKpwuNVbcPmk+ci57UwZDy3NJo6d7UX2Sfbbz7uSG/Wpky3W93q2F63prVnbwet3JIx0VSY7XdKiyu+jOgatl+f6qHLYDKHKgTeaJuvZH595L9FCijlkSIWjYes5afH3YYvobqW3m3rNuBDLVAH0xOitQLv8HxTrkoLvLUkgEufZPdn2PQikbaQZSFjAyWXk6zYIAKVfPdmDc0aBIdGQ1/3xYgicghu4q29IrbxrAeXyU6KsoOCXzihdRkf4CVB5RWGSLzFSRG6R7bzVt8sR85qSx8uLG0ByvuxyJHgiE91+ADcmHLtCUFk/3zuGKmJJYCanFgUo134sEy9h4FO4lli/ISikc8Dm/H
x-ms-exchange-antispam-messagedata: wuQylSLXZLv2z1aU6mzi8JZyoXs4XGgOqZCDZLPKLt1DabBSjb47Iz9EHdcj5kfS7gsYlLcLPSXXAfGOtzS97O4R3nq8KZnOG6qJCvYrDnL2gamMSj7icsylrxfa3B/Rzyo5WTm+YKPeOz0gHSlO0A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fc7793-0c10-4940-24bc-08d7ba15a7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 17:10:46.7282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7z61gNpPCqMlXuHJ4ayRdDalgHR227cDwZ5HY540z9lmv7R/pofLPcIdG0rvVdvGFYI3aYsUN4c8nO89j61MunpQJxBwPWxwUNSTzMd5enM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3827
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDI1LCAy
MDIwIDI6MTMgQU0NCj4gVG86IENoZW4gWmhvdSA8Y2hlbnpob3UxMEBodWF3ZWkuY29tPjsgS2Ft
bWVsYSwgR2F5YXRyaQ0KPiA8Z2F5YXRyaS5rYW1tZWxhQGludGVsLmNvbT4NCj4gQ2M6IFJham5l
ZXNoIEJoYXJkd2FqIDxyYWpuZWVzaC5iaGFyZHdhakBpbnRlbC5jb20+OyBTb21heWFqaSwNCj4g
VmlzaHdhbmF0aCA8dmlzaHdhbmF0aC5zb21heWFqaUBpbnRlbC5jb20+OyBEYXJyZW4gSGFydA0K
PiA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAaW5mcmFkZWFk
Lm9yZz47DQo+IFBsYXRmb3JtIERyaXZlciA8cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5l
bC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZw0KPiBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIC1uZXh0XSBwbGF0Zm9ybS94ODY6IGlu
dGVsX3BtY19jb3JlOiBmaXggYnVpbGQgZXJyb3INCj4gd2l0aG91dCBDT05GSUdfREVCVUdfRlMN
Cj4gDQo+IE9uIFRodSwgRmViIDIwLCAyMDIwIGF0IDU6NDAgQU0gQ2hlbiBaaG91IDxjaGVuemhv
dTEwQGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSWYgQ09ORklHX0RFQlVHX0ZTIGlz
IG4sIGJ1aWxkIGZhaWxzOg0KPiA+DQo+ID4gZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfcG1j
X2NvcmUuYzogSW4gZnVuY3Rpb24gcG1jX2NvcmVfcmVzdW1lOg0KPiA+IGRyaXZlcnMvcGxhdGZv
cm0veDg2L2ludGVsX3BtY19jb3JlLmM6MTMyNzozOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRp
b24NCj4gb2YgZnVuY3Rpb24gcG1jX2NvcmVfc2xwczBfZGlzcGxheTsgZGlkIHlvdSBtZWFuDQo+
IHBtY19jb3JlX2lzX3BjMTBfZmFpbGVkPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNs
YXJhdGlvbl0NCj4gPiAgICBwbWNfY29yZV9zbHBzMF9kaXNwbGF5KHBtY2RldiwgZGV2LCBOVUxM
KTsNCj4gPiAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4NCj4gPiBGdW5jdGlvbiBw
bWNfY29yZV9zbHBzMF9kaXNwbGF5KCkgaXMgcmVzcG9uc2libGUgZm9yIGRpc3BsYXlpbmcgZGVi
dWcNCj4gPiByZWdpc3RlcnMsIHdoaWNoIGlzIHVuZGVyIENPTkZJR19ERUJVR19GUy4NCj4gPg0K
PiA+IFByb3ZpZGluZyB0aGUgc3RhdGljIGlubGluZSBzdHViIHdoZW5ldmVyIENPTkZJR19ERUJV
R19GUyBpcyBkaXNhYmxlZA0KPiA+IHRvIGZpeCB0aGlzLiBGdW5jdGlvbiBwbWNfY29yZV9scG1f
ZGlzcGxheSgpIGlzIHRoZSBzYW1lLg0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2gsIGJ1
dCBJIHRoaW5rIGl0J3Mgbm90IHRoZSByaWdodCBhcHByb2FjaC4NCj4gQmFzaWNhbGx5IHdlIG5l
ZWQgdG8gbW92ZSB0aG9zZSBmdW5jdGlvbnMgb3V0c2lkZSBvZiAjaWYNCj4gSVNfRU5BQkxFRChD
T05GSUdfREVCVUdfRlMpLg0KPiAoTW92ZSB0aGVtIHVwcGVyKS4NCkFncmVlZA0KPiANCj4gQWxz
byBJIGhhdmUgbm90aWNlZCBhbm90aGVyIGlzc3VlIGluIHBtY19jb3JlX2xwbV9kaXNwbGF5KCku
IEl0IHVzZXMNCj4gdGdsX2xwbV9tYXBzIGRpcmVjdGx5LiBJdCBzaG91bGRuJ3QuDQo+IA0KPiBD
YzogR2F5YXRyaS4NCj4gDQo+IEdheWF0cmksIGNhcmUgdG8gZml4Pw0KSGkgQW5keSwgY2F1Z2h0
IHRoaXMgYnVnIGluIG91ciBpbnRlcm5hbCByZWdyZXNzaW9uIHRvby4gSSB3aWxsIHNlbmQgdGhl
IHBhdGNoIHNob3J0bHkuIFRoYW5rcyENCj4gDQo+ID4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3Qg
PGh1bGtjaUBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoZW4gWmhvdSA8Y2hlbnpo
b3UxMEBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRl
bF9wbWNfY29yZS5jIHwgMTQgKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9pbnRlbF9wbWNfY29yZS5jDQo+ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNf
Y29yZS5jDQo+ID4gaW5kZXggZjRhMzZmYi4uOTM5ZjhlMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNfY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wbGF0
Zm9ybS94ODYvaW50ZWxfcG1jX2NvcmUuYw0KPiA+IEBAIC0xMTE3LDYgKzExMTcsMjAgQEAgc3Rh
dGljIHZvaWQgcG1jX2NvcmVfZGJnZnNfcmVnaXN0ZXIoc3RydWN0DQo+IHBtY19kZXYgKnBtY2Rl
dikNCj4gPiAgICAgICAgIH0NCj4gPiAgfQ0KPiA+ICAjZWxzZQ0KPiA+ICtzdGF0aWMgaW5saW5l
IHZvaWQgcG1jX2NvcmVfc2xwczBfZGlzcGxheShzdHJ1Y3QgcG1jX2RldiAqcG1jZGV2LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBzZXFfZmlsZSAqcykgeyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgcG1j
X2NvcmVfbHBtX2Rpc3BsYXkoc3RydWN0IHBtY19kZXYgKnBtY2RldiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzZXFfZmlsZSAq
cywgdTMyIG9mZnNldCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKnN0ciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IHN0cnVjdCBwbWNfYml0X21hcA0KPiA+ICsqKm1hcHMpIHsgfQ0KPiA+
ICsNCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIHBtY19jb3JlX2RiZ2ZzX3JlZ2lzdGVyKHN0cnVj
dCBwbWNfZGV2ICpwbWNkZXYpICB7DQo+ID4gfQ0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0KPiAN
Cj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
