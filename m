Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2444C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EF3206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="WCsQ/8Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGXFP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:15:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:30134 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgGXFP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:15:26 -0400
IronPort-SDR: K7hQwhxQOWBiqg1w3v6JwlICDbF9huXb9BNL8dnaFdufLF4RXJuL3Xybf3Tbn+gWt1D5UAmUgZ
 uMCJJKQFP9GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168791670"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="168791670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 22:15:25 -0700
IronPort-SDR: 55mDJ9CJN4wz7kMAVtUUP7jW8WNy2Odo4YiX+htWwVp9uCWPj7EVmfgGnpAtjmtxR1FgZ1tZaH
 o4GRzWdR3spw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="489084188"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 22:15:25 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Jul 2020 22:15:25 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Jul 2020 22:15:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 23 Jul 2020 22:15:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqpq1G+nShmveTMKRFLQKkHZleWrCLXrK70BgYEtDnA0scjZmzixwipOoi7feijnzf+wYF/r130sid80kSMnRQE6OSRBWmvpHzW6KztvZ6i7/vSlrafn08B9xDa4LB45DxKX2LgJc1rdKlDy+r7A1H1omzjf8HCZwdhmU5e5LW635x/L3m+Pvfm3r3Na/0xmE81Ii5bb2SSSg9cSblB9UhbWk9HLRRZlSwXwYYS4O2XcK6WVkndw0LHPZ2EdfGuafakuNMMsJzoMMTlWvVYu7fi9qjQfSdWLEBUjrhwF40SCo6LBhGbhyrIljD4J/ye6YRQ/kKY4c/+YO2+J5CRd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UGPAg6i1vnm8QU4ERb3VlQF+9lyLEaIVqF13u/ROLA=;
 b=Mzkb6ffYna/dGGPu/OeKaQE3sq1qXYgph+mQ9oS0kBugJUFtRmO1zmpP9m2YFsz7724U0uBrjj+VhN2ouGG2q9+jJyo19F/+ih7+HU/TYDpUoIF/+W8RKsUqKuMPS0GGPzXC0OjguhnOQms8L+qbZL9HJK7L1l9g4VVM9CqWS6RkIhU1Co5JVo9ULWjqRqmwMqwR9PrESEsB0ilTNuMj/5bD9BTQLFXX73zkiLggmKZxZgwQi8i0LzEW2wPcHPi7XJYiSmyzBqOqAjN3fhmDWxeXrwQLr10FyeBp3r5rRQHt9dSqHsGHJnoPG/hEgCEoPMKwfNY8s+GZzfkX8uQhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UGPAg6i1vnm8QU4ERb3VlQF+9lyLEaIVqF13u/ROLA=;
 b=WCsQ/8XrdTr0py0g4+TA3UUrQqm82EeAgWqiI/TDQlqS+TTurNy7q3c8mvx6jgVmpof2d5J9PYo364uBXA/gXRIj/Wtv6IsNc7AEJxeRlXydSsBMh4MmxUdHtU0oqQ1cjUqUf+YldkM3pTDaXDUzKBLs9DO3GOzee8Iuj+VOqcw=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM5PR11MB1834.namprd11.prod.outlook.com (2603:10b6:3:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 05:15:21 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::714f:fa64:4fd8:c9df]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::714f:fa64:4fd8:c9df%6]) with mapi id 15.20.3216.020; Fri, 24 Jul 2020
 05:15:21 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4gSHJhc3RuaWs=?= <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Topic: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Index: AQHWWwsaPBfYigwTQE+Q2/IuyVCXHakJyhoAgAFtwuCAABYxgIAK6i3g
Date:   Fri, 24 Jul 2020 05:15:21 +0000
Message-ID: <DM6PR11MB39635AB6EE1C6454BFC8874BF6770@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
 <20200716003310.26125-2-rajmohan.mani@intel.com>
 <20200716070950.GC962748@kroah.com>
 <DM6PR11MB39632BD9A5A0DF4A9EAB351CF67C0@DM6PR11MB3963.namprd11.prod.outlook.com>
 <20200717061821.GA3237166@kroah.com>
In-Reply-To: <20200717061821.GA3237166@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80991998-5f12-4c76-cf5b-08d82f909039
x-ms-traffictypediagnostic: DM5PR11MB1834:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB18347B5EBC08D2990292E089F6770@DM5PR11MB1834.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESJUoZqQ0mB1MnGP9ONzouEocyDwY3ZYrWCNZm1s7SoZpjYosgozEwxm/o9Ct1AYyRVTstj2C9z882oUCESKJ75zg/hAIE9yOQ7cZKazJQ5fV4pnZZCSu+vov7VI8j8/iet2i97laoVnjPUYDUmmZytxSsrAOoIqWYhNaR6eC44GGMaWr1H8WMss2tiYH4Q2DFd07Ozjv8+WTKHujb2MSAUMrXPvZ/P1nYpgmw6tnOH2UE5hPjtUV5hBYfth7HqVpkRQ8E9PTRELM7rg5m/uUV/JTGt/MEfHmUOgEMv209IUT7eX8zUxCmAdF7FKlxpJGVcozhpeZaPDAzg6JLpyzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(8936002)(6916009)(83380400001)(186003)(26005)(86362001)(9686003)(4326008)(7696005)(2906002)(33656002)(76116006)(52536014)(8676002)(71200400001)(64756008)(6506007)(55016002)(478600001)(7416002)(66476007)(66556008)(66446008)(66946007)(316002)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: smoTiX0XGi+HBOvhYS78f6tXkAQwiXJcW1KeNFgNptzH/tqtUxPWt1WmxuTAL0E3gw9Gm9nf5Jpne7kwBZSSJw+6XSkbzYEdPkdANQlhnAqVNlZBLBjGUL25rwsD4beDTSgSJvLIdLK5Rrlanc9UBL3K1whabl8XnvNvpOWfeNsOIq/WHeATY86zjUfkuThv4EnP01/jW9x/MsUUDbn0zMGtfHlXEzF+EwakKfHh7LysZkvHyEegW+YoeWhruAhb6k9iqv/FP/W5AdScQYOebtr44pMn9bdJC0MOjxFnBldakhnFmXWo3zFilDogLfwM+5Gi2j009coF9a4gkF1N4b2n+PFKfuPaTlZ1AbWW8itmKJCg0rDq6AOOgIxNQSYofg5nazp/il4QsshUD2m07qUBX2zqNpGUkx+6JS8m7lCjx+N3szACfJt5oZjvGiGp7418rLFH9/1Q2u1oKzKevsCRlct3chVLr5CS7R0PiMrweo0szQBRCCM0kloRmQ6F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80991998-5f12-4c76-cf5b-08d82f909039
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 05:15:21.2769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAxJFb6zyRJd4lsvE2aO7wCjKJMEinxs0rMwhTiXRws96hpg2I8XSnKEONumOdFQ8FRJeysfh8no1o6bfeFFuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1834
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gcGxhdGZvcm0veDg2OiBBZGQg
SW50ZWwgSW5wdXQgT3V0cHV0IE1hbmFnZXIgKElPTSkNCj4gZHJpdmVyDQoNCi4uLg0KDQo+ID4g
PiA+ICtzdHJ1Y3QgaW50ZWxfaW9tIHsNCj4gPiA+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+
ID4gPiA+ICsJdm9pZCBfX2lvbWVtICpyZWdiYXI7DQo+ID4gPiA+ICt9Ow0KPiA+ID4gPiArDQo+
ID4gPiA+ICtzdGF0aWMgc3RydWN0IGludGVsX2lvbSBpb21fZGV2Ow0KPiA+ID4NCj4gPiA+IFdo
eSBqdXN0IG9uZT8gIFdoeSBpcyB0aGlzIHN0YXRpYz8NCj4gPiA+DQo+ID4NCj4gPiBUaGVyZSBp
cyBqdXN0IG9uZSBJT00gZGV2aWNlIGluIHRoZSBzeXN0ZW0uDQo+IA0KPiBGb3IgdG9kYXksIHll
cywgbm8gbmVlZCB0byBmb3JjZSB5b3Vyc2VsZiB0byBoYXZlIHRvIGNoYW5nZSB0aGlzIGluIHRo
ZSBmdXR1cmUuDQo+IEp1c3QgdXNlIGEgbm9ybWFsIHBlci1pbnN0YW5jZSB2YXJpYWJsZSBpbnN0
ZWFkIHBsZWFzZSwgaWYgeW91IHJlYWxseSBuZWVkIGl0Lg0KPiANCg0KQWNrDQoNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArCS8qIFByZXZlbnQgdGhpcyBkcml2ZXIgZnJvbSBiZWluZyB1bmxvYWRlZCB3
aGlsZSBpbiB1c2UgKi8NCj4gPiA+ID4gKwlpZiAoIXRyeV9tb2R1bGVfZ2V0KGRldi0+ZHJpdmVy
LT5vd25lcikpIHsNCj4gPiA+DQo+ID4gPiBXaHkgYXJlIHlvdSBwb2tpbmcgYXJvdW5kIGluIGEg
cmFuZG9tIGRldmljZSdzIGRyaXZlcidzIG93bmVyPw0KPiA+ID4NCj4gPiA+IFRoYXQncyBub3Qg
b2suICBBbmQgcHJvYmFibHkgdG90YWxseSByYWN5Lg0KPiA+ID4NCj4gPiA+IEhhbmRsZSBtb2R1
bGUgcmVmZXJlbmNlIGNvdW50cyBwcm9wZXJseSwgbm90IGxpa2UgdGhpcy4NCj4gPiA+DQo+ID4N
Cj4gPiBBY2suIFdpbGwgdXNlIFRISVNfTU9EVUxFIGhlcmUuDQo+IA0KPiBObywgdGhhdCBpcyBu
b3QgdGhlIGFuc3dlciwgYW5kIGlzIGFsd2F5cyB3cm9uZyB0byB1c2UgOigNCj4gDQoNClRoaXMg
c2hvdWxkIG5vdCBtYXR0ZXIgYW55bW9yZSwgYXMgSSBmaW5kIHJlZmVyZW5jZSBjb3VudGluZyBt
YXkgbm90IGJlIG5lZWRlZC4NCg0KPiA+ID4gQW5kIHdoeSBkb2VzIGl0IGV2ZW4gbWF0dGVyIHRo
YXQgeW91IGluY3JlbWVudGVkIHRoZSBtb2R1bGUNCj4gPiA+IHJlZmVyZW5jZSBjb3VudD8gIFdo
YXQgaXMgdGhhdCAicHJvdGVjdGluZyIgeW91IGZyb20/DQo+ID4gPg0KPiA+DQo+ID4gVG8gcHJl
dmVudCB0aGlzIGRyaXZlciBmcm9tIGJlaW5nIHVubG9hZGVkLCB3aGlsZSBpdCBpcyBiZWluZyB1
c2VkLg0KPiANCj4gV2h5IGRvZXMgdGhhdCBtYXR0ZXI/ICBTaG91bGRuJ3Qgbm9ybWFsIHJlZmVy
ZW5jZSBjb3VudGluZyBhbmQNCj4gZGVwZW5kYW5jaWVzIGJlIGFsbCB0aGF0IHlvdSBuZWVkPw0K
PiANCg0KSSBmaW5kIGp1c3QgZGVwZW5kZW5jaWVzIGFyZSBlbm91Z2ggdG8gcHJldmVudCB0aGUg
ZHJpdmVyIGZyb20gYmVpbmcgdW5sb2FkZWQuDQoNCldpdGggSW50ZWwgUE1DIFVTQiBtdXggY29u
dHJvbCBkcml2ZXIsIG5vdCB1c2luZyBpbnRlbF9pb21fZ2V0KCkvaW50ZWxfaW9tX3B1dCgpLA0K
anVzdCBpbnZva2luZyBpbnRlbF9pb21fcG9ydF9zdGF0dXMoKSBpcyBlbm91Z2ggZm9yIHJtbW9k
IHRvIHJlcG9ydCBmYWlsdXJlDQooY2l0aW5nIHRoZSB1c2UgYnkgaW50ZWxfcG1jX211eCkgaW4g
dW5sb2FkaW5nIHRoZSBJT00gZHJpdmVyLg0KDQo+ID4gPiA+ICsJCXB1dF9kZXZpY2UoaW9tX2Rl
di5kZXYpOw0KPiA+ID4gPiArCQlyZXR1cm4gRVJSX1BUUigtRUJVU1kpOw0KPiA+ID4gPiArCX0N
Cj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldHVybiAmaW9tX2RldjsNCj4gPiA+ID4gK30NCj4gPiA+
ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGludGVsX2lvbV9nZXQpOw0KPiA+ID4NCj4gPiA+IFdobyBj
YWxscyB0aGlzIGZ1bmN0aW9uPw0KPiA+ID4NCj4gPg0KPiA+IEludGVsIFBNQyBVU0IgbXV4IGNv
bnRyb2wgZHJpdmVyLCBpbiB0aGlzIGNhc2UuDQo+ID4gVGhlIGNhbGxlcnMgYXJlIGV4cGVjdGVk
IHRvIGNhbGwgaW50ZWxfaW9tX2dldCgpIGJlZm9yZSB1c2luZyB0aGUNCj4gPiBpbnRlbF9pb21f
cG9ydF9zdGF0dXMoKSwgYWZ0ZXIgd2hpY2ggaW50ZWxfaW9tX3B1dCgpIGNhbiBiZSBjYWxsZWQg
dG8NCj4gPiByZWxlYXNlIHRoZSBJT00gZGV2aWNlIGluc3RhbmNlLg0KPiANCj4gV2h5IG5vdCBq
dXN0IGhhdmUgYSBzaW5nbGUgY2FsbCBpZiBhbGwgdGhpcyBkcml2ZXIgZG9lcyBpcyBzdXBwb3J0
IG9uZSB0aGluZy4gIFRoZQ0KPiByZWZlcmVuY2UgY291bnRpbmcgc2hvdWxkbid0IGJlIG5lZWRl
ZCBhdCBhbGwsIHJpZ2h0Pw0KPiANCg0KQWNrLiBUaGF0IGxvb2tzIHRvIGJlIHRoZSBjYXNlLCBi
YXNlZCBvbiBteSBmaW5kaW5ncy4NCg0KPiA+ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBpbnRlbF9p
b21fcHV0KCkgLSBQdXQgSU9NIGRldmljZSBpbnN0YW5jZQ0KPiA+ID4gPiArICogQGlvbTogSU9N
IGRldmljZSBpbnN0YW5jZQ0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFRoaXMgZnVuY3Rpb24g
cmVsZWFzZXMgdGhlIElPTSBkZXZpY2UgaW5zdGFuY2UgY3JlYXRlZCB1c2luZw0KPiA+ID4gPiAr
ICogaW50ZWxfaW9tX2dldCgpIGFuZCBhbGxvd3MgdGhlIGRyaXZlciB0byBiZSB1bmxvYWRlZC4N
Cj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBDYWxsIGludGVsX2lvbV9wdXQoKSB0byByZWxlYXNl
IHRoZSBpbnN0YW5jZS4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArdm9pZCBpbnRlbF9pb21fcHV0
KHN0cnVjdCBpbnRlbF9pb20gKmlvbSkgew0KPiA+ID4gPiArCWlmICghaW9tKQ0KPiA+ID4gPiAr
CQlyZXR1cm47DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwltb2R1bGVfcHV0KGlvbS0+ZGV2LT5kcml2
ZXItPm93bmVyKTsNCj4gPiA+DQo+ID4gPiBBbmQgaWYgdGhlIGRldmljZSBkb2Vzbid0IGhhdmUg
YSBkcml2ZXI/ICBib29tIDooDQo+ID4gPg0KPiA+ID4gRG9uJ3QgZG8gdGhpcy4NCj4gPiA+DQo+
ID4NCj4gPiBBY2suIFdpbGwgdXNlIFRISVNfTU9EVUxFIGhlcmUuDQo+IA0KPiBBZ2Fpbiwgbm8s
IHRoYXQgd2lsbCBiZSBldmVuIG1vcmUgaW5jb3JyZWN0Lg0KPiANCg0KVGhpcyBzaG91bGRuJ3Qg
YmUgcmVsZXZhbnQgYW55bW9yZS4NCg0KPiA+ID4gPiArCXB1dF9kZXZpY2UoaW9tLT5kZXYpOw0K
PiA+ID4gPiArfQ0KPiA+ID4gPiArRVhQT1JUX1NZTUJPTF9HUEwoaW50ZWxfaW9tX3B1dCk7DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogaW50ZWxfaW9tX3BvcnRfc3RhdHVz
KCkgLSBHZXQgc3RhdHVzIGJpdHMgZm9yIHRoZSBUeXBlLUMgcG9ydA0KPiA+ID4gPiArICogQGlv
bTogSU9NIGRldmljZSBpbnN0YW5jZQ0KPiA+ID4gPiArICogQHBvcnQ6IFR5cGUtQyBwb3J0IG51
bWJlcg0KPiA+ID4gPiArICogQHN0YXR1czogcG9pbnRlciB0byByZWNlaXZlIHRoZSBzdGF0dXMg
Yml0cw0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCBlcnJv
ciBvdGhlcndpc2UuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK2ludCBpbnRlbF9pb21fcG9ydF9z
dGF0dXMoc3RydWN0IGludGVsX2lvbSAqaW9tLCB1OCBwb3J0LCB1MzINCj4gPiA+ID4gKypzdGF0
dXMpIHsNCj4gPiA+ID4gKwl2b2lkIF9faW9tZW0gKnJlZzsNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
CWlmICghaW9tKQ0KPiA+ID4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArCWlmICghc3RhdHVzIHx8IChwb3J0ID4gSU9NX01BWF9QT1JUUyAtIDEpKQ0KPiA+ID4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJlZyA9IGlvbS0+cmVnYmFy
ICsgSU9NX1BPUlRfU1RBVFVTX09GRlNFVCArIElPTV9SRUdfTEVOICoNCj4gPiA+IHBvcnQ7DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKwkqc3RhdHVzID0gaW9yZWFkMzIocmVnKTsNCj4gPiA+ID4gKw0K
PiA+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArRVhQT1JUX1NZTUJPTF9H
UEwoaW50ZWxfaW9tX3BvcnRfc3RhdHVzKTsNCj4gPiA+DQo+ID4gPiBTbyB0aGUgd2hvbGUgZHJp
dmVyIGlzIGhlcmUganVzdCB0byByZWFkLCBkaXJlY3RseSBmcm9tIG1lbW9yeSwgYQ0KPiA+ID4g
c2luZ2xlDQo+ID4gPiAzMiBiaXQgdmFsdWU/DQo+ID4NCj4gPiBZZXMuDQo+IA0KPiBPaywgdGhl
biB0aGlzIHdob2xlIGRyaXZlciBjb3VsZCBiZSBhYm91dCA5MCUgc21hbGxlciBhbmQgbW9yZSBv
YnZpb3VzLg0KPiBEb24ndCBhZGQgdGhlIHJlZmVyZW5jZSBjb3VudGluZywgdGhlIHN0YXRpYyB2
YXJpYWJsZXMgYW5kIGFsbCB0aGUgb3RoZXIgc3R1ZmYNCj4ganVzdCB0byBnZXQgYSAzMmJpdCBu
dW1iZXIuDQo+IA0KDQpBY2sNCg==
