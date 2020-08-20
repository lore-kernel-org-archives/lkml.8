Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA12C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A401720758
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ayv7x0Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgHTSFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:05:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:33790 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHTSE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:04:56 -0400
IronPort-SDR: XVjFLoEDWHv4C5Fb8Li4eEqeBMnlqTEklmVuE+xFaHE6b/aNprS4hrt2CBkC77A15koJfbLBGy
 qQRkjTDZ+2rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="240195230"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="240195230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 11:04:53 -0700
IronPort-SDR: 9wWhABkMNenv5gJY8gQathjiDfL62yrItTb6RtAnZuMWYyr+fQE17ArgeZIa6J0yqx7ZhwscDr
 hdAf/0u77dPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="498239673"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2020 11:04:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 11:04:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 11:04:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 20 Aug 2020 11:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHpWRYw+7Bv+ic6RozvUOmUmHEhAktJYNT8Hyjlmy243RpBZsUlchoyIyO9OWloLNhZqDLMqWmBXGUqUzEoBZ5KfOO4W/mjyGXieTc8lI5VfMKhNvBFzvtaJT3qkAi/KFiUZlljoJpUnAwoYjIPgnQr1/jVePIaM3uLKaQy5l39uTWJ72utLgHF7w7+cRXfcC0ds1yUZlyya9iQKpTDfsesmZBE7TvH/GNRDVa3CxksH1N1F8ciuJf5EuJc5nMt7YD85t8OuwqzHFcvRrkHvDTTANf0kyachGqN2hgJ4WqXAvp9s7CTkZv0kwAAQtZKVWvo1ulV7ZbAlXBmOdZLVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDLNFBgYuUqYLo82bS5RkfQnZvgCdbeMGXXBf/URUwg=;
 b=WywYh9bWenv/oZc+g+gAkMqprCUvLCTJ57Yjlj1R6vXrGZAQqtN8GGq4Js+xMpyClzLQaXkzPCGyU/p1sakeXmGbM2zmBZCJ+CinwzfiTj9VPrWsL5gPgZF3n6tntqfMhJ1mHJP8/QtuiS9d61A/MUPyr3X78VW0dTNVkrcbORi/cH5dUF86N8pGyCJ3JeIZ2aMlsx7DshacPoCfy0Q4bX0U8PdmGqlfwd7mh2Hh1rKKm68/Tdef/jnom2ZLSrDiKxRl9ViMpNftvr830/KjVaVEivg+s2A5Z7BrBPHohSphEQsuHe0AfnUrYGyBBEpwjWLVZjPD1ckqlIaLWB+fbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDLNFBgYuUqYLo82bS5RkfQnZvgCdbeMGXXBf/URUwg=;
 b=ayv7x0Sqa6osoXR65q1QbZ4uHOW97YU8+0cG/gBjiKesainz+oc4RwVvOn8Q6LSfAMNY3GTQtWw3VTIIZY18NAtZEaCp2s+8grz5CM5fEx9cgqVomTlrSIqRbOseHrGMiPBiS+umoKpQwox83PZ+kBR+A+yrntZGD44cwC8xprw=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4404.namprd11.prod.outlook.com (2603:10b6:a03:1c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:04:50 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::b8cb:b59f:8cbb:75a7]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::b8cb:b59f:8cbb:75a7%6]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:04:50 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/entry/64: Add an LFENCE after SAVE_AND_SET_GSBASE
Thread-Topic: [PATCH] x86/entry/64: Add an LFENCE after SAVE_AND_SET_GSBASE
Thread-Index: AQHWdtLbeqAZ5Csf50qk2LcZJtnsXqlBSySA
Date:   Thu, 20 Aug 2020 18:04:50 +0000
Message-ID: <6236F23E-B26A-4141-AD2E-9403CFF726D3@intel.com>
References: <20200820091544.26564-1-bp@alien8.de>
In-Reply-To: <20200820091544.26564-1-bp@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.93.155.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82cae64e-1ca2-465f-2854-08d84533887e
x-ms-traffictypediagnostic: BY5PR11MB4404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB44043446013FA9597AA831BAD85A0@BY5PR11MB4404.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6c3xj/K0yOCgnsNML5r2XhFzTwA8xEc7h9DBBrnQCWwlWy4fIsTi43lrUhagTKiINUl25FIJFsjvIHZMl5R4U3EpgrEFKLSOIsAEPNALw09IEmYrD4GLkXhiySJXr0H7NsXpVuk53aiHFwFuX/Jt1nMxDSIsv7ZyGEPpeZMX73NlgWBBoNo1XbmzAVBgoJA0nGDaUQC4PTdG6Ah5ob6r3qcwzA/q0ab7MybdBzNDVzkdb5wgDlJa1jx2L6p5SKva4/X+0OHbpbk0INHgjQHwhBhkzJkq+TrcDqBoa7qEwdEckSzWFK14YuuGxGMAhD9q2GxzOY/sLN6hwZ+HbbDZdwmJwTHXFwBlpOLUJSMYXqS0waJFzaIdR5TCJ5CJRaxlWJVXo48htuv/biEXCgcYfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(33656002)(86362001)(186003)(54906003)(6506007)(26005)(36756003)(5660300002)(316002)(6512007)(2906002)(76116006)(8936002)(966005)(8676002)(2616005)(64756008)(66446008)(66556008)(66476007)(71200400001)(66946007)(53546011)(478600001)(4326008)(83380400001)(6486002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZUlC8sFjmSeHd5F3rOl87VGFIVPFtPR9CeMKxZRsychhyYRISM7mm/2vVqof2GsbK9h0OJiOtsPa7jq4paIk5DulvqSS/gGx+P8oU8GsV0rAfr+IJEmWbXIfHpszWfMY2rYPccf3ZdzzWcgY1RVJNr2j7m4R36NwCkSJExIVXVGEktOGkgxuDMrzDvwC9bVsIevihU9BUDQ9QR6R5RvtpUmUXM6+mhPiTuik90yXhoycIaVZF5Vk3cNysu+JZ+QG/BwmxBN4N3HkosL+qR9VfKRTB78VExuzY4F6h0WJqEGSclcJrPOczA0cqTZwBj4b/lOFfNZEO+lTQCFvsS08bM9w1oV5d18b3VTonB5+GJx6A9lWtOGW0mDwRYnGk1mF0ZL9Jo817GWZYTAVi5fIzxqn1yWnNL/Z8mU6ASjCyIKMij6aKusGRoQsvOzhMAkd5VQKs4Xiep8Hk50sR5CLJI3Q5dxbkrOUmE7YimCt3QANF5h0veZRRXODPWeFGZ8popuXGJ0T46RUI2rWF47PKPIbyrvDAIURb97/Ay+/x4XUi32dmmoRjVoIfQGs9sGo+0KnEzZR2g1OI9nJViZQRL7gkvxnyStoBrHhBoFhahcxfsM/yZgo8gAuTK16kLqABnYpRMYAbCeVaqKYv9rsRg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <68E05FD59FE5E24EAA5A5E209797F7DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cae64e-1ca2-465f-2854-08d84533887e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 18:04:50.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYhLcNB/tUdbg0ZcdnpR3tQKbDK1ZGsArthH6vQrt7eDhuv+4M92WseRDpiM6hjYCGZmDv1XuBwY2x/qVK5OslflnPVnlpObsDhmvi7/TqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4404
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEF1ZyAyMCwgMjAyMCwgYXQgMDI6MTUsIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPiB3cm90ZToNCj4gDQo+IEZyb206IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4g
DQo+IFRoZSBGU0dTQkFTRSBtYWNybyB0byBzd2FwIGN1cnJlbnQgR1NCQVNFIHdpdGggdGhlIGtl
cm5lbCBHU0JBU0UNCj4gcHJvYmFibHkgaGFkIGEgc3BlY3VsYXRpb24tc3RvcHBpbmcgTVNSIHdy
aXRlIGF0IHNvbWUgcG9pbnQgYnV0IG5vdA0KPiBhbnltb3JlLg0KDQpObywgdGhlIG1hY3JvIGhh
cyBub3QgYW55IE1TUiB3cml0ZSBldmVyIGJlZm9yZS4NCg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvZW50cnkvZW50cnlfNjQuUyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMNCj4gaW5kZXgg
MjZmYzliNDJmYWRjLi4zOTMxZDQ3Y2RkODMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2VudHJ5
L2VudHJ5XzY0LlMNCj4gKysrIGIvYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUw0KPiBAQCAtODM5
LDExICs4MzksOSBAQCBTWU1fQ09ERV9TVEFSVF9MT0NBTChwYXJhbm9pZF9lbnRyeSkNCj4gCSAq
IFJlYWQgdGhlIGN1cnJlbnQgR1NCQVNFIGFuZCBzdG9yZSBpdCBpbiAlcmJ4IHVuY29uZGl0aW9u
YWxseSwNCj4gCSAqIHJldHJpZXZlIGFuZCBzZXQgdGhlIGN1cnJlbnQgQ1BVcyBrZXJuZWwgR1NC
QVNFLiBUaGUgc3RvcmVkIHZhbHVlDQo+IAkgKiBoYXMgdG8gYmUgcmVzdG9yZWQgaW4gcGFyYW5v
aWRfZXhpdCB1bmNvbmRpdGlvbmFsbHkuDQo+IC0JICoNCj4gLQkgKiBUaGUgTVNSIHdyaXRlIGVu
c3VyZXMgdGhhdCBubyBzdWJzZXF1ZW50IGxvYWQgaXMgYmFzZWQgb24gYQ0KPiAtCSAqIG1pc3By
ZWRpY3RlZCBHU0JBU0UuIE5vIGV4dHJhIEZFTkNFIHJlcXVpcmVkLg0KDQpUaG9tYXMgbG9va3Mg
dG8gYWRkIHRoaXMgdGV4dCB3aGVuIGhlIHBpY2tlZCB2NyBbMV0uDQoNCkZXSVcsIHdlIGFkZGVk
IG91ciB0ZXh0IGZyb20gdjgsIGFmdGVyIHJldmlld2VkIHRoZSBzcGVjdWxhdGlvbiBpbXBhY3QN
Cm9uIHRoaXMgc2VyaWVzOg0KCVRoaXMgdW5jb25kaXRpb25hbCB3cml0ZSBvZiBHUyBiYXNlIGVu
c3VyZXMgbm8gc3Vic2VxdWVudCBsb2FkIA0KCWJhc2VkIG9uIGEgbWlzcHJlZGljdGVkIEdTIGJh
c2UuDQoNCkkgdGhpbmsgc29tZWhvdyB0aGUg4oCcTVNSIHdyaXRl4oCdIG1hZGUgY29uZnVzaW9u
LiBPdXIgY29uY2x1c2lvbiB3YXMgdGhlIA0Kc2FtZSBhcyBUaG9tYXMnIHRoYXQgbm8gRkVOQ0Ug
aXMgbmVlZGVkIGhlcmUuDQoNClRoYW5rcywNCkNoYW5nDQoNClsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzE1NTczMDk3NTMtMjQwNzMtNS1naXQtc2VuZC1lbWFpbC1jaGFuZy5zZW9r
LmJhZUBpbnRlbC5jb20vdC8jbTQ1ZjM4MGEyMzIzMWI4NzQ5OGI0MGI3MDhmMDQwMTE0N2YzYjAy
NzgNCg0KPiAJICovDQo+IAlTQVZFX0FORF9TRVRfR1NCQVNFIHNjcmF0Y2hfcmVnPSVyYXggc2F2
ZV9yZWc9JXJieA0KPiArCUZFTkNFX1NXQVBHU19LRVJORUxfRU5UUlkNCj4gCXJldA0KPiANCj4g
LkxwYXJhbm9pZF9lbnRyeV9jaGVja2dzOg0KPiAtLSANCj4gMi4yMS4wDQo+IA0KDQo=
