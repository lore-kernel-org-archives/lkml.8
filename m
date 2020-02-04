Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE341C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8677020732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="exGcrwo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBDEAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:00:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:2258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgBDEAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:00:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 20:00:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="431382273"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 03 Feb 2020 20:00:45 -0800
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 3 Feb 2020 20:00:45 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 3 Feb 2020 20:00:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 3 Feb 2020 20:00:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ+rVb18Ad9zlAjVpTYdJVeso9X2SY4mgwkrIj1g+VPtC8iStMv6k62J8vG8qqYQP16TIipO8g1HiOXTpq3/GRM9UF6y3jEaxOjcnFuymYqcbsZqFFoOycDzsEFxSqhWXbu3SanYCOxtB8nOEtB+o2JTiXEDNSISHnF6GtzkxFeBAIf+4aB8s2ocAexwi5IGafiwm5ueKlgnx2AJhst4fdlohWHHQhJ1EvC1niEN+YdzIIyJ5MZa+caW53qq2kPbzngizoxWcPtGw0FnogtdBvoFPgUTOFKfEocqY55OFFwN0zPhJ3rktqfboWg+NnMatIR8F8/ifguDXcVDT6pHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOYMqMqUhLt3Uq/w9vubVKSXZVCBvzW0uJFmvK+3RGw=;
 b=I0jFy8EsExoJSQ7XGFRve2lVNfaz+g462Ubn8MwfY9aowCQ7ujz5v9U6AWBxmgVkIjGaBZPYdr0UwAMvDCZqselVZ/kqvo6UvjhR3ljNlZFKnrO0Aa2lGaBo4TQB8bL3IkxZZIBf/+eOcrvfz9UO/cwbDoaWaaLR0lcnLFmdskXjR0UWz2qfJnc+8rvGhTrfp0buP3GwZpgSgsGi6/VAdWj/fSv6zAOF4gi578N19S9y/T64vFDuyUBOaJRoOThRwTCGZJ+jEz4z2E6E8SkX+lP7Iyv/epPWNjE9uRz9ZWNUd9KR9XgEe0bt+o/BG1SPP3L5ZQ3uVSugys5CxGTF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOYMqMqUhLt3Uq/w9vubVKSXZVCBvzW0uJFmvK+3RGw=;
 b=exGcrwo/+rEJ1jzjRQW+auiwyYE4UwUjR5EQN4R3EnwS3ne0PxcLpBAJFPg4kge3XalTXMs6rW3LVJzK4KBsyl56IfFbwDUCCRiPlERuMunNuxA3CEggtX1yjBpndKXgArea/SFTeCYVn72Ll+zLmoBJ6Y/3W8WzsbxYFMdaJuY=
Received: from BL0PR11MB3107.namprd11.prod.outlook.com (20.177.205.12) by
 BL0PR11MB3074.namprd11.prod.outlook.com (20.177.206.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 04:00:44 +0000
Received: from BL0PR11MB3107.namprd11.prod.outlook.com
 ([fe80::1979:abd1:5faf:5611]) by BL0PR11MB3107.namprd11.prod.outlook.com
 ([fe80::1979:abd1:5faf:5611%3]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 04:00:43 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Box, David E" <david.e.box@intel.com>
Subject: RE: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
Thread-Topic: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
Thread-Index: AQHV0uehR65JqlDsd0qQ+gWeMY04Aqf+WQcAgAB1iqCAABOEAIALk8sw
Date:   Tue, 4 Feb 2020 04:00:43 +0000
Message-ID: <BL0PR11MB3107F8D50FCADD168EAA9E7BF2030@BL0PR11MB3107.namprd11.prod.outlook.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
 <CAHp75Vfb38BEh2OZkO2EoQgCyBxaLoiwh8S_qKiPQRX1g+ZA2Q@mail.gmail.com>
 <BL0PR11MB31071AD85775C09B8EC26608F20B0@BL0PR11MB3107.namprd11.prod.outlook.com>
 <CAHp75VeRAWsqxfjOxw97SBPRLvcyF=SGrN84hT=UUNC6yQ6-_A@mail.gmail.com>
In-Reply-To: <CAHp75VeRAWsqxfjOxw97SBPRLvcyF=SGrN84hT=UUNC6yQ6-_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62ca266f-784b-449a-8f18-08d7a926cec8
x-ms-traffictypediagnostic: BL0PR11MB3074:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB307421A685CE3A37E00A2E3BF2030@BL0PR11MB3074.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39860400002)(346002)(396003)(189003)(199004)(55016002)(478600001)(186003)(52536014)(66946007)(6506007)(53546011)(76116006)(71200400001)(26005)(2906002)(33656002)(54906003)(5660300002)(86362001)(316002)(7696005)(4326008)(81166006)(6916009)(9686003)(66446008)(64756008)(66556008)(66476007)(81156014)(8936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3074;H:BL0PR11MB3107.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4Om+E2JZJt7MYdvd1qhAZ2NUj5Prmt1tofbyY9X8cfrkqbeFRyOajooO7/v3BBwNAASu1DAGKkSbPu+5ixk4Pu3dh83cyhXbjEGFnmNfe9CsHdXnIh4L1Zk/Be7DmVPmYw+k2c/m8+m6MsREWRqV/2cg9YRltzzvpvwCMBrRa9dChY8iZLPrSjYYB1EXxUS7tzzwho+r16eWB8+12WHgSSR4QKObRFd3vkbXXFi3YOMnYu3XuHgqQR8KRcytosdlNWLt9YWSdFBq1p3xLxzj3HDxj1rSc0sfnbC1JCSzDDcbPtQZzIcBwTLL7bFdl7ZAZVib7QN0lft/XabevZSQPHrIHYYDeDyLJUQ7JvhpOlYlsg4o2tYdDLUTdYREVfR8nnYI7jkgFjlTdOJVRmPTFzMzjoyJXujoX9WQHK+QuwQZ+S14KDQ5Rk/RZtU/Xqs
x-ms-exchange-antispam-messagedata: dWMOIiE9VLTNDWca2QqycfG5cGvVoyGatFsw/ReF9C2QisAgYD8IOsIUeUbMD/lB9oGUUDcCbH4b0mYzr8UuFKfntVpeAb1v9AhmeWa6Pz1eZI3v0grarw0uRQUlg0wq86W3Fy024tZf+oahmGIZBQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ca266f-784b-449a-8f18-08d7a926cec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 04:00:43.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gpfnJGYMPuRmJq9lGO4P5OZVjWrYP3nzEcDHsL3MwO7Wf9pXPGwuA0+sCvu4lzQRqc9Ihb9dpCf+kj12ev0beKI68Pyk4y9UKyrPxBBxzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3074
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAyNywgMjAy
MCAxMTowMCBBTQ0KPiBUbzogS2FtbWVsYSwgR2F5YXRyaSA8Z2F5YXRyaS5rYW1tZWxhQGludGVs
LmNvbT4NCj4gQ2M6IFBsYXRmb3JtIERyaXZlciA8cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtl
cm5lbC5vcmc+OyBMaW51eCBLZXJuZWwNCj4gTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPjsgU29tYXlhamksIFZpc2h3YW5hdGgNCj4gPHZpc2h3YW5hdGguc29tYXlh
amlAaW50ZWwuY29tPjsgRGFycmVuIEhhcnQgPGR2aGFydEBpbmZyYWRlYWQub3JnPjsNCj4gV2Vz
dGVyYmVyZywgTWlrYSA8bWlrYS53ZXN0ZXJiZXJnQGludGVsLmNvbT47IFBldGVyIFppamxzdHJh
IChJbnRlbCkNCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgUHJlc3RvcGluZSwgQ2hhcmxlcyBE
DQo+IDxjaGFybGVzLmQucHJlc3RvcGluZUBpbnRlbC5jb20+OyBQYW5kcnV2YWRhLCBTcmluaXZh
cw0KPiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4g
PGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IEJveCwgRGF2aWQgRQ0KPiA8ZGF2
aWQuZS5ib3hAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAvN10gcGxhdGZv
cm0veDg2OiBpbnRlbF9wbWNfY29yZTogQWRkIGRlYnVnZnMNCj4gZW50cmllcw0KPiANCj4gT24g
TW9uLCBKYW4gMjcsIDIwMjAgYXQgODowMyBQTSBLYW1tZWxhLCBHYXlhdHJpDQo+IDxnYXlhdHJp
LmthbW1lbGFAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gPiBJdCBkb2Vzbid0IGFwcGx5IHRv
IG91ciBmb3ItbmV4dCBicmFuY2guDQo+ID4gU29ycnkgdG8gaGVhciB0aGF0LiBJJ3ZlIHJlYmFz
ZWQgdGhlIHNlcmllcyBvbiBtYWlubGluZSA1LjUtcmM3LiBTaG91bGQgSQ0KPiByZWJhc2UgaXQg
b24gZm9yLW5leHQgYnJhbmNoPw0KPiANCj4gWW91IHNob3VsZCBhbHdheXMgYmFzZSB5b3VyIGJy
YW5jaCBvbiB0aGUgZm9yLW5leHQgKHdoYXRldmVyIGl0J3MgYmVpbmcNCj4gY2FsbGVkKSBvZiB0
aGUgc3Vic3lzdGVtIHlvdXIgc2VyaWVzIGFnYWluc3Qgb2YuDQoNCkhpIEFuZHksDQoNClRoZSBj
dXJyZW50IHNlcmllcyBoYXMgYSBkZXBlbmRlbmN5IG9uIFRpZ2VyIExha2UgYW5kIEVsa2hhcnQg
TGFrZSBwYXRjaGUgd2hpY2ggaXMgbWVyZ2VkIGluIHRvIG1haW5saW5lLiANCg0KKDU1NGYyNjlm
MGYzOCBwbGF0Zm9ybS94ODY6IGludGVsX3BtY19jb3JlOiBBZGQgSW50ZWwgRWxraGFydCBMYWtl
IHN1cHBvcnQNCjQ5YTQzNzk0MWMzZiBwbGF0Zm9ybS94ODY6IGludGVsX3BtY19jb3JlOiBBZGQg
SW50ZWwgVGlnZXIgTGFrZSBzdXBwb3J0DQo2MjY4YzBiMjc4YjUgcGxhdGZvcm0veDg2OiBpbnRl
bF9wbWNfY29yZTogTWFrZSBkZWJ1Z2ZzIGVudHJ5IGZvciBwY2hfaXBfcG93ZXJfZ2F0aW5nX3N0
YXR1cyBjb25kaXRpb25hbA0KZTM5ODU0NzgxODMwIHBsYXRmb3JtL3g4NjogaW50ZWxfcG1jX2Nv
cmU6IENyZWF0ZSBwbGF0Zm9ybSBkZXBlbmRlbnQgYml0bWFwIHN0cnVjdHMNCmIxY2IzM2RhZTQx
NCBwbGF0Zm9ybS94ODY6IGludGVsX3BtY19jb3JlOiBDbGVhbiB1cDogUmVtb3ZlIGNvbW1hIGFm
dGVyIHRoZSB0ZXJtaW5hdGlvbiBsaW5lKQ0KDQpCdXQgdGhleSBhcmUgbm90IGF2YWlsYWJsZSBp
biBmb3ItbmV4dCBicmFuY2guIEkgYW0gY29uZnVzZWQsIGhvdyB0aGF0IGNvdWxkIGJlIHRoZSBj
YXNlLiBGb3IgbWUgdG8gYmFzZSB0aGUgY3VycmVudCBzZXJpZXMgb24gZm9yLW5leHQgYnJhbmNo
LCB0aGUgZGVwZW5kZW5jeSBwYXRjaCBzZXJpZXMgc2hvdWxkIGJlIGF2YWlsYWJsZSBpbiBmb3It
bmV4dCBicmFuY2guDQoNCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNo
ZXZjaGVua28NCg==
