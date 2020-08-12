Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8386C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03AF20768
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="zvU5C6VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHLEuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:50:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:17123 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgHLEuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:50:21 -0400
IronPort-SDR: Cts5OjN+LIdp5hnn7nJ5FK7bSboPtIaSBUSrEgjWDRrhNuReJvgkQSgEipwGLeHn0I/q9bJHrx
 NqMkUji4zIkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="141499117"
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="141499117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 21:50:20 -0700
IronPort-SDR: OrYZ+XP6MJdV+n/Qmsxp/ZYBV3pIN5DxqE/15d/zy3kC0qoLCWSw+qHZC6OkYMME3abqmfxPeQ
 JTSfoQtWgyFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="317963806"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 21:50:20 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Aug 2020 21:50:20 -0700
Received: from fmsmsx108.amr.corp.intel.com (10.18.124.206) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Aug 2020 21:50:20 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Aug 2020 21:50:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 11 Aug 2020 21:50:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHjYNaOpjfcFL5j+IAiVQ3oHIL+hgOIo8EwRegP6yi2nmnnYfVFVe1zaeOZ91CUKzADalguXlsuckI5JBDqnd/hobgGuxE4UGhJOo75P8M5PTA/ETbga6wjzCgvOsGy11DX6N1hyHo4xo1sWbJulHA0cgmUBo6g6lZqnAgYQst7ZIdy+qJ0AdwPPccnYU8xYgeMcEr+ODwH1egbFQ1rq8Jc/3QEA/OyCjFGeZoPLfAB2nfJSA96KD0P85dftI4jXbHUsPqNVRfjSFjhwYtaHQjoJ2somze+JowdLhc6trhJKdw07BULtAl+CmksDYz+jZIWabpbkgbsBd61PkXqZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFPY84x6iPJk+XFoPz5DjtD3pNMohFGwU3OKm8gXdNA=;
 b=cts5Y2Eqhyse25q9TOl8cSEkGMQAabdpo/qzVi+44uj+p3/pfdAprP/ZL1AmxxlJrnz7YTw94CEM2fdAe97TDDVImausaKThzWA/hpswWxrouaJWCjZtdnmtJLRBRiAJBhbNEahvQqJKnGpS4aaJyQl+rBDNSI5V7aheqxFNuYBADJLzbqo0Vc2zIogcOVvNWe3UrVzBWrdT2a/jn/gZqRhw5mPSI/Yy60tg6GephcsbFYVAcbhWSOyuYhoMd2+azFfe+DZSUOFLNyw/2XNWyRjY1Dl81PJDkVnFchCxNyvB5GulLTI86NvRUMZlc65GljddLMlkZ75n/yCjMADSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFPY84x6iPJk+XFoPz5DjtD3pNMohFGwU3OKm8gXdNA=;
 b=zvU5C6VW6GbdqDM0dFLstGP+Ugm0J0pkMo4VDV0J4iu10WodOL5nnbKXBBptCVF6vzixhAc9CuhOtNtTvaIS0z7unTh/vnE9AXwTz80s5LGVuO3MuOCQc1zhIoGj6OVuJCn0/5amiM+AQJ7AVhRGEY4/m2hrp9Z5fOzgyysEwFA=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB3471.namprd11.prod.outlook.com (2603:10b6:805:c1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Wed, 12 Aug
 2020 04:50:17 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::9487:a78f:bfd5:3b66]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::9487:a78f:bfd5:3b66%4]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 04:50:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "frank.scheiner@web.de" <frank.scheiner@web.de>,
        "jrtc27@jrtc27.com" <jrtc27@jrtc27.com>,
        "slyfox@gentoo.org" <slyfox@gentoo.org>,
        "matorola@gmail.com" <matorola@gmail.com>
Subject: Re: "mm/vmalloc: Add flag for freeing of special permsissions" broke
 udev on ia64
Thread-Topic: "mm/vmalloc: Add flag for freeing of special permsissions" broke
 udev on ia64
Thread-Index: AQHWcCoF2T3injmqtEiejhdDIjaPeqkz59AA
Date:   Wed, 12 Aug 2020 04:50:17 +0000
Message-ID: <8ae8c65f4c66dbb4469939963741801c24ce22ce.camel@intel.com>
References: <460f2393-8603-cbda-9bab-4bd24d0c41ed@physik.fu-berlin.de>
In-Reply-To: <460f2393-8603-cbda-9bab-4bd24d0c41ed@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: physik.fu-berlin.de; dkim=none (message not signed)
 header.d=none;physik.fu-berlin.de; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe8aecf9-dba6-41d3-bcd3-08d83e7b35e2
x-ms-traffictypediagnostic: SN6PR11MB3471:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB347127B645F19AD22C1E6545C9420@SN6PR11MB3471.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S0iArpZ9ei5tPdAK36No4vtQM3MdbPXQCeLcp8yLrpy0J9VAOKfxOHQ9+CjDs1Nuus1MuAeC1nKp64IKnPKbqDH0HvMCwT/T3ea/yzNXl80Dq/4wCbwZjzLpfnvLHAZ+BIEz6YFAu/ScLWQ/TkMOiX1PAUMgL7QkY7HTDk/6xKMBBeN2VGCMcPkmRCFSPdeD5o1ZV31Ch73Tzi2krVw4WN9k4WhUmqjz4Dy6zkpZqqzgwmh9YHer0oJXq+b6fp/GuqZSv4+2ZYJnuiwboIGGXd0dc6Zjsm14RN+bcZa2rG78YIIZYnNZDqj9mWIqqMxE8H0LN3lBFo3RdxE+qComwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(8676002)(478600001)(6486002)(5660300002)(86362001)(8936002)(6512007)(6506007)(2616005)(83380400001)(71200400001)(4326008)(26005)(66946007)(2906002)(186003)(6916009)(316002)(76116006)(91956017)(36756003)(66476007)(64756008)(66556008)(54906003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zYGhbZFFuwbUsf390uDyFysZxuwgEihD4DBo7vI8uDk0PJIZCoST/KKweNWffPRxg+i+awAidXjMB36VuS762wdsgsPNUIH3xemMGn63OJef4CUkxttyYagosDzzoxcPNJUZjNFuVAG9a5GFd3kcRNR4EjARyrVUy/FBgerksjPeiT9LWQ7tHZd9O2HOdcOxzLNpNAKny6bIHiU/q+E9JNqVB+CWP1VAJ0Qllqq0K2o25rf4ov1f4AbDh3CWwIaxu1eVmpMK7jU+bQnCBjcbCH9zQxv0JZ4eG+RHg0oA3KWm8vAtrRvlM48cNbI5EOupupxRwaf5x0n9zI3pI10JVkLMcekQA5QzAhGqChf6ebDTptO664BdiobKexi1NWFsUbR1oI2w/1fBekhOeucOKe2Tf8f3y+YTAZ64nmuuxGXzHto6NT/0HiEmr3qzoF0+B84mKtBfd6S89WMPDw0ZbrQ47QaYsSxTtOpGuyDJEU9tx/ShR1lZ5mhMvp6ip/QzZHxbaZRmJLwnI+scaz7lbX4j7hBrAQHKSbQk/kfbvjWVJheG9NLgQwdP2O7qwT15BrSD4u8/ZM4hg9T0htopTDIL3fgtRToGk5ZPU5PbXJRd7Er/1zn7OHaEgnFxspCfIowPWeyeFx9pNoH4DkLfVA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C13065D56D54F4A8F3D91F358B895A0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8aecf9-dba6-41d3-bcd3-08d83e7b35e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 04:50:17.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EY1Mk2CS9zSpSrSRA7MKxszCxTmyc2+3VIG2ycFPWolNeFRWjImS2d4CoQZ5XzhBk9lwD3qy3Zp1yGo1Px5apZv2CNaNeB63UPwkLULyXNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3471
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTExIGF0IDIzOjU0ICswMjAwLCBKb2huIFBhdWwgQWRyaWFuIEdsYXVi
aXR6IHdyb3RlOg0KPiBIaSBSaWNrIQ0KPiANCj4gSSBoYXZlIGJlZW4gYmlzZWN0aW5nIHNvbWUg
cmVncmVzc2lvbnMgb24gaWE2NCBhbmQgb25lIHByb2JsZW0gSSByYW4NCj4gaW50byBpcyB0aGF0
DQo+IHVkZXYgaXMgY2F1c2luZyB0aGUga2VybmVsIHRvIGNyYXNoIGFmdGVyIHRoZSBmb2xsb3dp
bmcgY2hhbmdlIGZyb20NCj4gMjAxOToNCj4gDQo+IGNvbW1pdCA4NjhiMTA0ZDczNzllMjgwMTNl
OWQ0OGJkZDJkYjI1ZTBiZGNmNzUxDQo+IEF1dGhvcjogUmljayBFZGdlY29tYmUgPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPg0KPiBEYXRlOiAgIFRodSBBcHIgMjUgMTc6MTE6MzYgMjAxOSAt
MDcwMA0KPiANCj4gICAgIG1tL3ZtYWxsb2M6IEFkZCBmbGFnIGZvciBmcmVlaW5nIG9mIHNwZWNp
YWwgcGVybXNpc3Npb25zDQo+IA0KPiBXaXRoIHlvdXIgcGF0Y2ggYXBwbGllZCwgdWRldiBjcmFz
aGVzIG9uIGlhNjQgd2hlbiB0cnlpbmcgdG8gbG9hZA0KPiBtb2R1bGVzLCBJJ20gcGFzdGluZw0K
PiB0aGUgd2hvbGUgYm9vdCBtZXNzYWdlIHNlcXVlbmNlIGJlbG93Lg0KPiANCj4gQW55IGlkZWEg
d2hhdCBjb3VsZCBjYXVzZSB0aGlzIHByb2JsZW0gb24gaWE2ND8NCj4gDQo+IFRoYW5rcywNCj4g
QWRyaWFuDQo+IA0KDQpIaSwNCg0KT24gbm9uLXg4NiwgdGhpcyBwYXRjaHNldCBzaG91bGRuJ3Qg
aGF2ZSBjaGFuZ2VkIG11Y2gsIGp1c3QgYWx3YXlzDQpmbHVzaCB0aGUgVExCIGFuZCBwdXJnZSB0
aGUgdm1hbGxvYyBhcmVhIGluIGNhc2VzIHdoZXJlIHByZXZpb3VzbHkgdGhpcw0Kd291bGQgb25s
eSBoYXBwZW4gaW50ZXJtaXR0ZW50bHkuIERlc3BpdGUgdGhpcywgaXQgYWxzbyBjYXVzZWQgYQ0K
cHJvYmxlbSBvbiBzcGFyYy4gSW4gdGhlIGVuZCB0aGUgc3BhcmMgaXNzdWUgdHVybmVkIG91dCB0
byBiZSBhbiBpc3N1ZQ0Kd2l0aCBzcGFyYydzIGtlcm5lbCByYW5nZSBUTEIgZmx1c2ggaW1wbGVt
ZW50YXRpb24gdGhhdCB3YXMganVzdCBub3cNCmJlaW5nIGhpdCBlYXJsaWVyIGR1cmluZyBib290
IGluc3RlYWQgb2YgYWZ0ZXIgdGhlIHN5c3RlbSBoYWQgYmVlbiB1cA0KZm9yIHNvbWUgdGltZS4g
U28gSSdtIGF0IGZpcnN0IHdvbmRlcmluZyBpZiB0aGVyZSBtaWdodCBiZSBzb21ldGhpbmcNCmxp
a2UgdGhhdCB1bmNvdmVyZWQgaGVyZS4NCg0KVW5mb3J0dW5hdGVseSwgaXQncyB1bmxpa2VseSB0
aGF0IEkgY2FuIGdldCBhY2Nlc3MgdG8gaWE2NCBoYXJkd2FyZSBpbg0KdGhlIG5lYXIgdGVybSB0
byBkZWJ1Zy4gV291bGQgeW91IGJlIGFibGUgdG8gdGVzdCBzb21lIGRlYnVnIHBhdGNoZXM/DQpB
bHNvLCBjYW4geW91IHBvc3QgeW91ciBjb25maWc/DQoNClRoYW5rcywNCg0KUmljaw0K
