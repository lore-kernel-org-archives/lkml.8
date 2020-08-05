Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D40122CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="s6cqgses"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHEU2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:28:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:62028 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgHEU23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:28:29 -0400
IronPort-SDR: jt+LOXaxoIIA81zdQfI0IG5Tovpzj70fVt4C4pgVltm1urlfa1AeBDEMY8t6eFgINFgwU3+e9Z
 qutVBu6FmhOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="237507099"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="237507099"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:28:28 -0700
IronPort-SDR: 88hppxm4wL9aGr7Lwkd5tQvB/wp1cII76d2XrM/+Fb9X20oSwiXEFMRHF2MhYI9U8Hgj9bIrBI
 ZljT78AFFkQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="331031412"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2020 13:28:28 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 13:28:28 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 13:28:28 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 5 Aug 2020 13:28:27 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 5 Aug 2020 13:28:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV8SmIXut/H/Mu4ikwriZnh8ydUIrRHNIsX1FK1N7KR8Leub8FowKI/5fic4KHUvy8A40FsdJe7HvREhelaqgUie+t+vIyVog1OhyUN3Ug1Q6/S9kJd9xfDgMTWBHQt92DhHakxEmsNssG6zHDvetGY1xJIN+1UHTcFgE9qHbrsAL4VfC/hi8LyWnetalEsD0YTFknrbKIvaUUfR4hkrIiNsNLkuhUmflkWEzl0t2rSw9+OK14RXFhrf4kAcFsBL2aK9ljBWXp1NGIeS5oFKjA8168iTiOeFuGp6dPI0Zzpd7ww/1PVWwiSAA9Je8WjU9cohbA3dQ2CTtLRcH4/zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuJxM0D5tR2Y47ltOHD1ekrXak8S+6HAjLf8hnMTV5s=;
 b=bPvYHDtjAm4utHtg6soyLC8gKh8UPaEI9raXF2tMbFUCLbsUpyRDO/3kMjHZAQBu3+hJcQx9HBHconmjAjAPCFEbUtmzO0+c8IUVjPrdYP2aIOUHQtt11Zl9Bo29LGLswZRU5hG5f4OqC4NMHJHcqgs5wguvvBcYUmdSt+PZWlnPrjlTY4bVFIjIWyY+hAgII9em3pPHpHFXxOvoXCSdOCg4w4+nyQlU7sZAHZ5HiSIhGcKUy57fxZBJqa42e3uLA1wqBOK9YLHPeUoWZAxHWlpP9bkyghYOEB8THEcofLqpnxlTDJh59Uzy48/hsGm3vTTWLYJkF72uYAkfDkg8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuJxM0D5tR2Y47ltOHD1ekrXak8S+6HAjLf8hnMTV5s=;
 b=s6cqgsesWCSkbT7FGzKpUM6UJL/3PQi82c+pGTr66MSrGbZ2axOuTKGBCgXNyvrv92c/0nONfnGXU6pffo+MmFD+G6Qfs6Tul7yZhq2TCqc28llK+Lbc4+vguCco8hYgL4wc3+x3IETxwvK3W/RAfOSAZSHyOzrvRVbb9qyaWjY=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MWHPR11MB2062.namprd11.prod.outlook.com (2603:10b6:300:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 5 Aug
 2020 20:28:22 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32%10]) with mapi id 15.20.3261.017; Wed, 5 Aug 2020
 20:28:22 +0000
From:   "Shaikh, Azhar" <azhar.shaikh@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Thread-Topic: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Thread-Index: AQHWZsWN7jOrHrKgC0yTlu91mzQVjakgvc/QgAAF9ACACSlQYIAABQUAgAALj3A=
Date:   Wed, 5 Aug 2020 20:28:22 +0000
Message-ID: <MWHPR11MB151843C494EAFDAD0DE6BA81914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com>
 <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730232504.GG3145664@google.com>
 <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
 <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com>
In-Reply-To: <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [71.236.160.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e3ab656-1b2e-45d4-4038-08d8397e195a
x-ms-traffictypediagnostic: MWHPR11MB2062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB20627A2D35E06D6AFF510423914B0@MWHPR11MB2062.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9egoEjVA5eF4jmRhSpsx8jU5/F/o0nILSJEYyej5V7MsVRSVlSftVhQ3EA7S+4FnuzQNg7gIogOlFWshoYoOQKsLUFeYhBBPja/Fm2mDD3hOIHiAVvSthA4KVl/Ug7ZHbdQif1AL5i0qhe/qry2DUxYvwu37GV9XWSsNjl8+fk05QkpyyzpFWuLFKlQK2Q1MifxcS30tMNj8gAu0/klTDLxXnZA5XIk3qjS4eTC9JDDg+ecs0DZBtsch7CoSiK2372omfxnwj4EkUlZ3oFTmcrlmh8xcw2RZNtS4QAPa5qs7vN4kowOEPD6ASpe2AsWEYbWmw0I049BWzG6jTgK5By7WC3Xj1FlC9oWFBJFu6Fo6kPKstdnPKVY6iLXSJ40DP+CcGWHiNdfkbdHNq7NTiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(66446008)(66556008)(64756008)(7696005)(9686003)(5660300002)(66476007)(186003)(83380400001)(966005)(66946007)(26005)(71200400001)(76116006)(4326008)(86362001)(8936002)(33656002)(6916009)(8676002)(478600001)(316002)(55016002)(6506007)(2906002)(53546011)(54906003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Urn1zjq6DbAnVPaFP4ENPZrI8qc2MXYvc8nCLL/Xr7KRChFobs46iRofsLK8MZ2Nz6tEPdv6R6qxqCcoS13WhXkpMyG1F7bnxWYHv+xdTzYdOzYneVlEwUaY4daWLG5s2nBhPWzpZlUIQ3NxlLdUyx8ba2n2i5BjQ99NS9OM/R3x14RSrECn4gDppAcdzTkmZNMlAMiu2nrL1uhw9HKY2FFUMzoLmIH+CGPBU5dFNecGfXyZDElW5xoSarYYF7kZWFElj/NnpL/YSOy9NnebNnyIXdvd64BRMyg7Qq7vV95VOPe3djfySKkmzUhMa4nwBNxVxT4nZaSHuOZPtAhVs37C7yeGSk8oYJHKpLR3I9M+BGeOLFnDbETvXh4AzPXQZKQVPvLnKSc971VyAQROf2sKh34ddCljcSmac3P43Ssrnjr6l/M3Zbh0XEJOJBygx19jQB4wtTlWPyov2B14dLtMT+CPnmfvgJOnXetWGeQzzWbuP3q5r3CQcW4UUtEKMes/fms1hx5zhPz7iv+MRQnVqUIs5q03FDwz2TMpq0/lp7+/hA+LrHTkMKDkWPxR52b1rpo20V2yOoXOa0hl1YBaKQcEKiWctAhX4aVmqc+TZ1q40s7s0WVpyVq/f+yD6pkSPos2wR6aH24W5uIRHw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3ab656-1b2e-45d4-4038-08d8397e195a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 20:28:22.5673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dD8JXeDWyObYPMIIR4lp4r9hwZt/NqBQwXP3y/a4a/pZFqhPaEDgqOdBNN1vNysUW9CDhtjjxGlVqRuB1fefKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2062
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhc2hhbnQsDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQ
cmFzaGFudCBNYWxhbmkgPHBtYWxhbmlAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEF1Z3VzdCA1LCAyMDIwIDEyOjM3IFBNDQo+IFRvOiBTaGFpa2gsIEF6aGFyIDxhemhhci5zaGFp
a2hAaW50ZWwuY29tPg0KPiBDYzogYmxldW5nQGNocm9taXVtLm9yZzsgZW5yaWMuYmFsbGV0Ym9A
Y29sbGFib3JhLmNvbTsNCj4gZ3JvZWNrQGNocm9taXVtLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gaGVpa2tpLmtyb2dlcnVzQGxpbnV4LmludGVsLmNvbTsgUGF0ZWwsIFV0
a2Fyc2ggSA0KPiA8dXRrYXJzaC5oLnBhdGVsQGludGVsLmNvbT47IEJvd21hbiwgQ2FzZXkgRw0K
PiA8Y2FzZXkuZy5ib3dtYW5AaW50ZWwuY29tPjsgTWFuaSwgUmFqbW9oYW4NCj4gPHJham1vaGFu
Lm1hbmlAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gcGxhdGZvcm0v
Y2hyb21lOiBjcm9zX2VjX3R5cGVjOiBBdm9pZCBzZXR0aW5nDQo+IHVzYiByb2xlIGR1cmluZyBk
aXNjb25uZWN0DQo+IA0KPiBIaSBBemhhciwNCj4gDQo+IA0KPiBPbiBXZWQsIEF1ZyA1LCAyMDIw
IGF0IDEyOjIyIFBNIFNoYWlraCwgQXpoYXIgPGF6aGFyLnNoYWlraEBpbnRlbC5jb20+DQo+IHdy
b3RlOg0KPiA+DQo+ID4gSGkgUHJhc2hhbnQsDQo+ID4NCj4gPiA+IElzIHRoaXMgZG9jdW1lbnRl
ZCBhbnl3aGVyZT8gS2luZGx5IHByb3ZpZGUgdGhlIGxpbmtzIHRvIHRoYXQgaWYgc28uDQo+ID4g
PiBJIHdhc24ndCBhd2FyZSBvZiBhbnkgb3JkZXJpbmcgcmVxdWlyZW1lbnRzIChidXQgSSBtYXkg
YmUgbWlzc2luZw0KPiBzb21ldGhpbmcpLg0KPiA+DQo+ID4gVGhlIGNvbmZpZ3VyYXRpb24gb2Yg
dGhlIGNvbm5lY3RvciBzaG91bGQgYWx3YXlzIGhhcHBlbiBpbiB0aGUgb3JkZXINCj4gPiBkZWZp
bmVkIGluIHRoZSBVU0IgVHlwZS1DIHNwZWNpZmljYXRpb24uIENoZWNrIGNoLiAyLjMgKFVTQiBU
eXBlLUMgU3BlYw0KPiBSMi4wKS4gU28gdGhhdCB3aWxsIGJhc2ljYWxseSBnaXZlIHlvdToNCj4g
Pg0KPiA+IDEuIG9yaWVudGF0aW9uDQo+ID4gMi4gcm9sZShzKQ0KPiA+IDMuIHRoZSByZXN0Lg0K
PiANCj4gVGhhbmtzIGZvciB0aGUgbGluay4gQXJlIHlvdSByZWZlcnJpbmcgdG8gU2VjdGlvbiAy
LjMgKENvbmZpZ3VyYXRpb24NCj4gUHJvY2VzcykgPyBJIGNvdWxkbid0IGZpbmQgYW55dGhpbmcg
dGhlcmUgd2hpY2ggaW1wbGllZCBhbnkgcmVxdWlyZWQgb3JkZXJpbmcNCj4gKEknbSByZWFkaW5n
IFJlbGVhc2UgMi4wLCBBdWcgMjAxOSwgc28gSSBkb24ndCBrbm93IGlmIHNvbWV0aGluZyBoYXMg
YmVlbg0KPiBhZGRlZCBzaW5jZSkuDQo+IENvdWxkIHlvdSBraW5kbHkgcG9pbnQgbWUgdG8gdGhl
IGFwcHJvcHJpYXRlIHN1YnNlY3Rpb24/DQoNClRoYXQgaXMgdGhlIHNlY3Rpb24gSSB3YXMgcmVm
ZXJyaW5nIHRvLg0KDQo+IA0KPiBBZGRpdGlvbmFsbHksIEkgdGhpbmsgYW55IG9yZGVyaW5nIHJl
cXVpcmVtZW50cyB0aGVyZSBhcmUgYWxyZWFkeSBoYW5kbGVkIGJ5DQo+IHRoZSBUQ1BNIGluIHRo
ZSBDaHJvbWUgT1MgRUMuDQo+IA0KPiA+DQo+ID4gQWxzbyBJIHNlZSBpbiBVU0IgVHlwZS1DIFBv
cnQgTWFuYWdlciBkcml2ZXIgdGhlIGFib3ZlIG1lbnRpb25lZA0KPiA+IHNlcXVlbmNlIGJlaW5n
IGZvbGxvd2VkDQo+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3Nv
dXJjZS9kcml2ZXJzL3VzYi90eXBlYy90Y3BtLw0KPiA+IHRjcG0uYyNMNjY0DQo+IA0KPiBJbiBh
ZGRpdGlvbiB0byB0aGUgYWJvdmUsIG5vdGUgdGhhdCB0aGlzIGlzIGEgVENQTSBpbXBsZW1lbnRh
dGlvbiAob24NCj4gQ2hyb21lIE9TIHRoZSBUQ1BNIGltcGxlbWVudGF0aW9uIGlzIGluIHRoZSBF
QyksIHNvIHdoYXQgaXMgZG9uZSB0aGVyZQ0KPiBkb2Vzbid0IG5lY2Vzc2FyaWx5IGFwcGx5IHRv
IGNyb3MtZWMtdHlwZWMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IA0KPiAtUHJhc2hhbnQNCj4g
DQo+ID4NCj4gPg0KPiA+ID4gPiA+IC1QcmFzaGFudA0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBB
emhhcg0K
