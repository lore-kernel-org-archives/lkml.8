Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF81C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591E52072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="TVOm3P1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGJFtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:49:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:52542 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgGJFtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:49:41 -0400
IronPort-SDR: mbBf5AXKa9UkIMOLVQNqHMsBi7NJTdiil3BiXlVApxgqF+I1p+2QKf4Np2d1+xOYMgouoWU/1N
 jV66mO546YMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="166245752"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="166245752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 22:49:39 -0700
IronPort-SDR: bchubPE4SMeVtG5TX4i3WiS+mcoC3Grj603ZOtbLvzLHQfKgWguMCoRDkWl5Pm3TxE4LHAb/Lm
 Q8q5SHM2O4Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="324495012"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 22:49:38 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 22:49:38 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 22:49:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jul 2020 22:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP45rpwchYjRUUvG9DVYdeUzqG1yNtyjEhQPlrdKZGOuC/wGg4vOZQSjpP0iVKCK5qAEgnq++LZlb3iMzv8CYTEK+xnAqu0mhbFml+/sAHyuePhIz+uBsgwZG4jPOFD4ss7D0k6sRMBzzpGodfVqcM9lD9SOTL7ebetsrGKhq6QS0mvcTeL6I+W00+KqtybqeHlFS9O8SC+BnLidkmXnu1m+rzzWt0PQ118uCwtwQ74STxn3ZuieJq8mqF9oY/C7KhiEfr+aEwT33h4ZMNeMzR3fRmqkNs8wmRIMLCfxUyZEYqb0rregPDN6y6V5arpcwA1zOSswOqM6CHkvNtKb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9If5RsxQ3u2i9WodtwoiHSv0PtR1ZoRMVd9OrdMKNc=;
 b=F+CY8NjsUJfWfeEQ46hZfDY9SzFHP3t9PARsPxAXg4jJVjrq/+ayG8fJOxGKWl0jnhgpD94c7/NYAIYiOY+TbIiX7f6qpD2VJQX0t5cIZZniCXDU49OEC6WYeRQ/98Z5iIBjk93wBL+qSSNdQRJ+ZYB22XRJP3O62HXJz2QvYF1AUV2gFryun9ZAHQj2bfXum65M3CwHqlIZYzgdI87XgEgDQ6J1xqYzTvwa17BVUFcUKBCFf5tWnsDsuaW69OY3eF5ho+B4b8nZnuedn9Z4Y2hj8zhJcdTfPkS7EIRYXrbIRR5Y6xnKZv3TZQ59XwtzOf/iUs4P7qkUKJ90jfh5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9If5RsxQ3u2i9WodtwoiHSv0PtR1ZoRMVd9OrdMKNc=;
 b=TVOm3P1qCFBv+PyqOJzPGtdTV1Tn0r+PenDCuMyXGug+3k3GsOw+lJ49VJ6w5mChV7GuDM7jgdNwI8Ihq8S4CimEMDJworTrpD4qMUwZNtpb+STRbG2dMSMum5UKQjFFgXwKdu6x/IkWUu1N3zdG1SlGlMiyL/6g7OcXRbBemtQ=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB2045.namprd11.prod.outlook.com (2603:10b6:300:29::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 05:49:35 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 05:49:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] iommu/vt-d: Add page response ops support
Thread-Topic: [PATCH v3 4/4] iommu/vt-d: Add page response ops support
Thread-Index: AQHWVcAM+avb7Y6qlkuRLGDQ/735sakAFvrQgAA1wACAAAGkcA==
Date:   Fri, 10 Jul 2020 05:49:35 +0000
Message-ID: <MWHPR11MB164513189877BD3734F589328C650@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200709070537.18473-1-baolu.lu@linux.intel.com>
 <20200709070537.18473-5-baolu.lu@linux.intel.com>
 <MWHPR11MB164546581C5F6B6B77AE28C88C650@MWHPR11MB1645.namprd11.prod.outlook.com>
 <cbf470fe-933a-54d5-e215-afb32d40165f@linux.intel.com>
In-Reply-To: <cbf470fe-933a-54d5-e215-afb32d40165f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccd2bf79-f24a-441e-ba20-08d8249506bb
x-ms-traffictypediagnostic: MWHPR11MB2045:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB20458172A7D3C2DB0C8076BA8C650@MWHPR11MB2045.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IX0QBCokXNGSN7ICEJTgFv8ZPBV68ZGKRq9+xdVTvhBLxXul3rzZGtUZmwioT0U89QaUFZd5bgkuF3VI8002aWmVI+LdIRPTl0xAfdc07ABFgwJ1plPi4BM1hAoLAMpPYflHwjQgXoKv85zijRtQle0p5L9quhWUoPkdbOFEWTDKp9O+ORp+tMu5F2PtHQrHbKcXyBPfjkbvIvgPv7kbzUVzETp93CqbQWDQpECm2xVy76yWyxhGpEgmjBZlyC0xc8Gs26GyJuICX/5ozIkI+/xVfAqaAfT+ICaYkHKsBMKU57RGzL7xaJ20/1nAvrGBTnrTh22CUIPHfxSKxgoUQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66946007)(76116006)(2906002)(71200400001)(26005)(8676002)(64756008)(66476007)(66556008)(52536014)(5660300002)(66446008)(186003)(33656002)(9686003)(8936002)(4326008)(53546011)(55016002)(54906003)(7696005)(110136005)(478600001)(86362001)(83380400001)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: N9LyF+QtwdC8W8aae8tmJv+M5iOw56/Be1fqVMh3bcFTtT7tTBQNPy3lFXoUZAO/YZVPHJ7ocbN6PMtNdO+iHkBKLtVZyKCz6+ac40hHqMY6Mv9tO4CivxRxoeU2kQHfmdr+q8jfpnD815DzwGlu6Ief2O2KZd0chVKGr3l1BNUqbcTQIfpS0xv3YU1fJ8SFtn6mREZpziDQPAwHfsElXxY2X4+hefVVzJxZjbTCqoe4ZQ3Lcg4TKAijWB18IkZp28Gn+kt/mot/E3YBOxcJ6uDqhVAGmpTODbp8pDuxTKRGfaqTWZ2ZNRENHwc+bNIcT419mQzotn2Kt/QQ85YBGu7qwQThn6DWMOd4A8MXQ6/LU8vbXRSj8e+Kfxwrx7raamEs81rA+tqVz1OG6q6FWL521r8xbbR9Qg5diCNX8jztBMOodMY2lvSY4kYNhaJ1UdxhmYPI5gDUxj+qtVArDy2+YKdyczQZBIe8CnKov6Xu9uDvRHk0i64EQ9kl4uPb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd2bf79-f24a-441e-ba20-08d8249506bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 05:49:35.3828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3YFldo8VF7/eJfPR6CnnXE38ewokTYa0LKUxvKFtknSbyDJOHyAk9Nh/lko9aLX0VRqPUpUvUZj338zw5kopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2045
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMTAsIDIwMjAgMTozNyBQTQ0KPiANCj4gSGkgS2V2aW4sDQo+IA0KPiBPbiAyMDIw
LzcvMTAgMTA6NDIsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFv
bHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgSnVseSA5LCAyMDIw
IDM6MDYgUE0NCj4gPj4NCj4gPj4gQWZ0ZXIgcGFnZSByZXF1ZXN0cyBhcmUgaGFuZGxlZCwgc29m
dHdhcmUgbXVzdCByZXNwb25kIHRvIHRoZSBkZXZpY2UNCj4gPj4gd2hpY2ggcmFpc2VkIHRoZSBw
YWdlIHJlcXVlc3Qgd2l0aCB0aGUgcmVzdWx0LiBUaGlzIGlzIGRvbmUgdGhyb3VnaA0KPiA+PiB0
aGUgaW9tbXUgb3BzLnBhZ2VfcmVzcG9uc2UgaWYgdGhlIHJlcXVlc3Qgd2FzIHJlcG9ydGVkIHRv
IG91dHNpZGUgb2YNCj4gPj4gdmVuZG9yIGlvbW11IGRyaXZlciB0aHJvdWdoIGlvbW11X3JlcG9y
dF9kZXZpY2VfZmF1bHQoKS4gVGhpcyBhZGRzDQo+IHRoZQ0KPiA+PiBWVC1kIGltcGxlbWVudGF0
aW9uIG9mIHBhZ2VfcmVzcG9uc2Ugb3BzLg0KPiA+Pg0KPiA+PiBDby1kZXZlbG9wZWQtYnk6IEph
Y29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4+IENvLWRl
dmVsb3BlZC1ieTogTGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPj4gU2lnbmVkLW9m
Zi1ieTogTGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
THUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJp
dmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgICAxICsNCj4gPj4gICBkcml2ZXJzL2lvbW11L2lu
dGVsL3N2bS5jICAgfCAxMDANCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4+ICAgaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oIHwgICAzICsrDQo+ID4+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAxMDQgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jDQo+ID4+IGluZGV4IDRhNmI2OTYwZmMzMi4uOTgzOTBhNmQ4MTEzIDEwMDY0NA0KPiA+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPj4gKysrIGIvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jDQo+ID4+IEBAIC02MDU3LDYgKzYwNTcsNyBAQCBjb25zdCBzdHJ1Y3Qg
aW9tbXVfb3BzIGludGVsX2lvbW11X29wcyA9IHsNCj4gPj4gICAJLnN2YV9iaW5kCQk9IGludGVs
X3N2bV9iaW5kLA0KPiA+PiAgIAkuc3ZhX3VuYmluZAkJPSBpbnRlbF9zdm1fdW5iaW5kLA0KPiA+
PiAgIAkuc3ZhX2dldF9wYXNpZAkJPSBpbnRlbF9zdm1fZ2V0X3Bhc2lkLA0KPiA+PiArCS5wYWdl
X3Jlc3BvbnNlCQk9IGludGVsX3N2bV9wYWdlX3Jlc3BvbnNlLA0KPiA+PiAgICNlbmRpZg0KPiA+
PiAgIH07DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5j
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYw0KPiA+PiBpbmRleCBkMjRlNzFiYWM4ZGIuLjgz
OWQyYWYzNzdiNiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYw0K
PiA+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jDQo+ID4+IEBAIC0xMDgyLDMgKzEw
ODIsMTAzIEBAIGludCBpbnRlbF9zdm1fZ2V0X3Bhc2lkKHN0cnVjdCBpb21tdV9zdmENCj4gKnN2
YSkNCj4gPj4NCj4gPj4gICAJcmV0dXJuIHBhc2lkOw0KPiA+PiAgIH0NCj4gPj4gKw0KPiA+PiAr
aW50IGludGVsX3N2bV9wYWdlX3Jlc3BvbnNlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4gKwkJ
CSAgICBzdHJ1Y3QgaW9tbXVfZmF1bHRfZXZlbnQgKmV2dCwNCj4gPj4gKwkJCSAgICBzdHJ1Y3Qg
aW9tbXVfcGFnZV9yZXNwb25zZSAqbXNnKQ0KPiA+PiArew0KPiA+PiArCXN0cnVjdCBpb21tdV9m
YXVsdF9wYWdlX3JlcXVlc3QgKnBybTsNCj4gPj4gKwlzdHJ1Y3QgaW50ZWxfc3ZtX2RldiAqc2Rl
diA9IE5VTEw7DQo+ID4+ICsJc3RydWN0IGludGVsX3N2bSAqc3ZtID0gTlVMTDsNCj4gPj4gKwlz
dHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11Ow0KPiA+PiArCWJvb2wgcHJpdmF0ZV9wcmVzZW50Ow0K
PiA+PiArCWJvb2wgcGFzaWRfcHJlc2VudDsNCj4gPj4gKwlib29sIGxhc3RfcGFnZTsNCj4gPj4g
Kwl1OCBidXMsIGRldmZuOw0KPiA+PiArCWludCByZXQgPSAwOw0KPiA+PiArCXUxNiBzaWQ7DQo+
ID4+ICsNCj4gPj4gKwlpZiAoIWRldiB8fCAhZGV2X2lzX3BjaShkZXYpKQ0KPiA+PiArCQlyZXR1
cm4gLUVOT0RFVjsNCj4gPj4gKw0KPiA+PiArCWlvbW11ID0gZGV2aWNlX3RvX2lvbW11KGRldiwg
JmJ1cywgJmRldmZuKTsNCj4gPj4gKwlpZiAoIWlvbW11KQ0KPiA+PiArCQlyZXR1cm4gLUVOT0RF
VjsNCj4gPj4gKw0KPiA+PiArCWlmICghbXNnIHx8ICFldnQpDQo+ID4+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiA+PiArDQo+ID4+ICsJbXV0ZXhfbG9jaygmcGFzaWRfbXV0ZXgpOw0KPiA+PiArDQo+
ID4+ICsJcHJtID0gJmV2dC0+ZmF1bHQucHJtOw0KPiA+PiArCXNpZCA9IFBDSV9ERVZJRChidXMs
IGRldmZuKTsNCj4gPj4gKwlwYXNpZF9wcmVzZW50ID0gcHJtLT5mbGFncyAmDQo+ID4+IElPTU1V
X0ZBVUxUX1BBR0VfUkVRVUVTVF9QQVNJRF9WQUxJRDsNCj4gPj4gKwlwcml2YXRlX3ByZXNlbnQg
PSBwcm0tPmZsYWdzICYNCj4gPj4gSU9NTVVfRkFVTFRfUEFHRV9SRVFVRVNUX1BSSVZfREFUQTsN
Cj4gPj4gKwlsYXN0X3BhZ2UgPSBwcm0tPmZsYWdzICYNCj4gPj4gSU9NTVVfRkFVTFRfUEFHRV9S
RVFVRVNUX0xBU1RfUEFHRTsNCj4gPj4gKw0KPiA+PiArCWlmIChwYXNpZF9wcmVzZW50KSB7DQo+
ID4+ICsJCWlmIChwcm0tPnBhc2lkID09IDAgfHwgcHJtLT5wYXNpZCA+PSBQQVNJRF9NQVgpIHsN
Cj4gPj4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ID4+ICsJCQlnb3RvIG91dDsNCj4gPj4gKwkJfQ0K
PiA+PiArDQo+ID4+ICsJCXJldCA9IHBhc2lkX3RvX3N2bV9zZGV2KGRldiwgcHJtLT5wYXNpZCwg
JnN2bSwgJnNkZXYpOw0KPiA+PiArCQlpZiAocmV0IHx8ICFzZGV2KSB7DQo+ID4+ICsJCQlyZXQg
PSAtRU5PREVWOw0KPiA+PiArCQkJZ290byBvdXQ7DQo+ID4+ICsJCX0NCj4gPj4gKw0KPiA+PiAr
CQkvKg0KPiA+PiArCQkgKiBGb3IgcmVzcG9uc2VzIGZyb20gdXNlcnNwYWNlLCBuZWVkIHRvIG1h
a2Ugc3VyZSB0aGF0IHRoZQ0KPiA+PiArCQkgKiBwYXNpZCBoYXMgYmVlbiBib3VuZCB0byBpdHMg
bW0uDQo+ID4+ICsJCSovDQo+ID4+ICsJCWlmIChzdm0tPmZsYWdzICYgU1ZNX0ZMQUdfR1VFU1Rf
TU9ERSkgew0KPiA+PiArCQkJc3RydWN0IG1tX3N0cnVjdCAqbW07DQo+ID4+ICsNCj4gPj4gKwkJ
CW1tID0gZ2V0X3Rhc2tfbW0oY3VycmVudCk7DQo+ID4+ICsJCQlpZiAoIW1tKSB7DQo+ID4+ICsJ
CQkJcmV0ID0gLUVJTlZBTDsNCj4gPj4gKwkJCQlnb3RvIG91dDsNCj4gPj4gKwkJCX0NCj4gPj4g
Kw0KPiA+PiArCQkJaWYgKG1tICE9IHN2bS0+bW0pIHsNCj4gPj4gKwkJCQlyZXQgPSAtRU5PREVW
Ow0KPiA+PiArCQkJCW1tcHV0KG1tKTsNCj4gPj4gKwkJCQlnb3RvIG91dDsNCj4gPj4gKwkJCX0N
Cj4gPj4gKw0KPiA+PiArCQkJbW1wdXQobW0pOw0KPiA+PiArCQl9DQo+ID4+ICsJfSBlbHNlIHsN
Cj4gPj4gKwkJcHJfZXJyX3JhdGVsaW1pdGVkKCJJbnZhbGlkIHBhZ2UgcmVzcG9uc2U6IG5vIHBh
c2lkXG4iKTsNCj4gPj4gKwkJcmV0ID0gLUVJTlZBTDsNCj4gPj4gKwkJZ290byBvdXQ7DQo+ID4N
Cj4gPiBjaGVjayBwYXNpZD0wIGZpcnN0LCB0aGVuIG5vIG5lZWQgdG8gaW5kZW50IHNvIG1hbnkg
bGluZXMgYWJvdmUuDQo+IA0KPiBZZXMuDQo+IA0KPiA+DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+
ICsJLyoNCj4gPj4gKwkgKiBQZXIgVlQtZCBzcGVjLiB2My4wIGNoNy43LCBzeXN0ZW0gc29mdHdh
cmUgbXVzdCByZXNwb25kDQo+ID4+ICsJICogd2l0aCBwYWdlIGdyb3VwIHJlc3BvbnNlIGlmIHBy
aXZhdGUgZGF0YSBpcyBwcmVzZW50IChQRFApDQo+ID4+ICsJICogb3IgbGFzdCBwYWdlIGluIGdy
b3VwIChMUElHKSBiaXQgaXMgc2V0LiBUaGlzIGlzIGFuDQo+ID4+ICsJICogYWRkaXRpb25hbCBW
VC1kIHJlcXVpcmVtZW50IGJleW9uZCBQQ0kgQVRTIHNwZWMuDQo+ID4+ICsJICovDQo+ID4NCj4g
PiBXaGF0IGlzIHRoZSBiZWhhdmlvciBpZiBzeXN0ZW0gc29mdHdhcmUgZG9lc24ndCBmb2xsb3cg
dGhlIHJlcXVpcmVtZW50Pw0KPiA+IGVuLi4uIG1heWJlIHRoZSBxdWVzdGlvbiBpcyByZWFsbHkg
YWJvdXQgd2hldGhlciB0aGUgaW5mb3JtYXRpb24gaW4gcHJtDQo+ID4gY29tZXMgZnJvbSB1c2Vy
c3BhY2Ugb3IgZnJvbSBpbnRlcm5hbGx5LXJlY29yZGVkIGluZm8gaW4gaW9tbXUgY29yZS4NCj4g
PiBUaGUgZm9ybWVyIGNhbm5vdCBiZSB0cnVzdGVkLiBUaGUgbGF0dGVyIG9uZSBpcyBPSy4NCj4g
DQo+IFdlIHJlcXVpcmUgYSBwYWdlIHJlc3BvbnNlIHdoZW4gcmVwb3J0aW5nIHN1Y2ggZXZlbnQu
IFRoZSB1cHBlciBsYXllcg0KPiAoSU9NTVUgY29yZSBvciBWRklPKSB3aWxsIGJlIGltcGxlbWVu
dGVkIHdpdGggYSB0aW1lciwgaWYgdXNlcnNwYWNlDQo+IGRvZXNuJ3QgcmVzcG9uZCBpbiB0aW1l
LCB0aGUgdGltZXIgd2lsbCBnZXQgZXhwaXJlZCBhbmQgYSBGQUlMVVJFDQo+IHJlc3BvbnNlIHdp
bGwgYmUgc2VudCB0byBkZXZpY2UuDQoNClllcywgdGltZXIgaGVscHMgd2hlbiB1c2Vyc3BhY2Ug
ZG9lc24ndCByZXNwb25kLiBUaGVuIEknbSBmaW5lIHdpdGgNCnRoaXMgcGF0Y2guDQoNClJldmll
d2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg0KYnR3IHdoZW4geW91
IHNheSBJT01NVSBjb3JlIG9yIFZGSU8sIGRvZXMgaXQgbWVhbiB0aGUgdGltZXIgbWVjaGFuaXNt
DQppcyBub3QgaW1wbGVtZW50ZWQgeWV0Pw0KDQpUaGFua3MNCktldmluDQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gYmFvbHUNCj4gDQo+ID4NCj4gPiBUaGFua3MNCj4gPiBLZXZpbg0KPiA+DQo+
ID4+ICsJaWYgKGxhc3RfcGFnZSB8fCBwcml2YXRlX3ByZXNlbnQpIHsNCj4gPj4gKwkJc3RydWN0
IHFpX2Rlc2MgZGVzYzsNCj4gPj4gKw0KPiA+PiArCQlkZXNjLnF3MCA9IFFJX1BHUlBfUEFTSUQo
cHJtLT5wYXNpZCkgfCBRSV9QR1JQX0RJRChzaWQpDQo+ID4+IHwNCj4gPj4gKwkJCQlRSV9QR1JQ
X1BBU0lEX1AocGFzaWRfcHJlc2VudCkgfA0KPiA+PiArCQkJCVFJX1BHUlBfUERQKHByaXZhdGVf
cHJlc2VudCkgfA0KPiA+PiArCQkJCVFJX1BHUlBfUkVTUF9DT0RFKG1zZy0+Y29kZSkgfA0KPiA+
PiArCQkJCVFJX1BHUlBfUkVTUF9UWVBFOw0KPiA+PiArCQlkZXNjLnF3MSA9IFFJX1BHUlBfSURY
KHBybS0+Z3JwaWQpIHwNCj4gPj4gUUlfUEdSUF9MUElHKGxhc3RfcGFnZSk7DQo+ID4+ICsJCWRl
c2MucXcyID0gMDsNCj4gPj4gKwkJZGVzYy5xdzMgPSAwOw0KPiA+PiArCQlpZiAocHJpdmF0ZV9w
cmVzZW50KQ0KPiA+PiArCQkJbWVtY3B5KCZkZXNjLnF3MiwgcHJtLT5wcml2YXRlX2RhdGEsDQo+
ID4+ICsJCQkgICAgICAgc2l6ZW9mKHBybS0+cHJpdmF0ZV9kYXRhKSk7DQo+ID4+ICsNCj4gPj4g
KwkJcWlfc3VibWl0X3N5bmMoaW9tbXUsICZkZXNjLCAxLCAwKTsNCj4gPj4gKwl9DQo+ID4+ICtv
dXQ6DQo+ID4+ICsJbXV0ZXhfdW5sb2NrKCZwYXNpZF9tdXRleCk7DQo+ID4+ICsJcmV0dXJuIHJl
dDsNCj4gPj4gK30NCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUu
aCBiL2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaA0KPiA+PiBpbmRleCBmYzJjZmMzZGI2ZTEu
LmJmNjAwOWEzNDRmNSAxMDA2NDQNCj4gPj4gLS0tIGEvaW5jbHVkZS9saW51eC9pbnRlbC1pb21t
dS5oDQo+ID4+ICsrKyBiL2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaA0KPiA+PiBAQCAtNzQx
LDYgKzc0MSw5IEBAIHN0cnVjdCBpb21tdV9zdmEgKmludGVsX3N2bV9iaW5kKHN0cnVjdCBkZXZp
Y2UNCj4gPj4gKmRldiwgc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+ID4+ICAgCQkJCSB2b2lkICpk
cnZkYXRhKTsNCj4gPj4gICB2b2lkIGludGVsX3N2bV91bmJpbmQoc3RydWN0IGlvbW11X3N2YSAq
aGFuZGxlKTsNCj4gPj4gICBpbnQgaW50ZWxfc3ZtX2dldF9wYXNpZChzdHJ1Y3QgaW9tbXVfc3Zh
ICpoYW5kbGUpOw0KPiA+PiAraW50IGludGVsX3N2bV9wYWdlX3Jlc3BvbnNlKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0DQo+IGlvbW11X2ZhdWx0X2V2ZW50DQo+ID4+ICpldnQsDQo+ID4+ICsJ
CQkgICAgc3RydWN0IGlvbW11X3BhZ2VfcmVzcG9uc2UgKm1zZyk7DQo+ID4+ICsNCj4gPj4gICBz
dHJ1Y3Qgc3ZtX2Rldl9vcHM7DQo+ID4+DQo+ID4+ICAgc3RydWN0IGludGVsX3N2bV9kZXYgew0K
PiA+PiAtLQ0KPiA+PiAyLjE3LjENCj4gPg0K
