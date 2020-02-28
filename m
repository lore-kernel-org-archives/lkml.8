Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E1BC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8313246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgB1FuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:50:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:30303 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB1FuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:50:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 21:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="437317578"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2020 21:50:21 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 21:50:21 -0800
Received: from bgsmsx109.gar.corp.intel.com (10.223.4.211) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 21:50:21 -0800
Received: from BGSMSX107.gar.corp.intel.com ([169.254.9.58]) by
 BGSMSX109.gar.corp.intel.com ([169.254.10.142]) with mapi id 14.03.0439.000;
 Fri, 28 Feb 2020 11:20:17 +0530
From:   "Laxminarayan Bharadiya, Pankaj" 
        <pankaj.laxminarayan.bharadiya@intel.com>
To:     Daniel Stone <daniel@fooishbar.org>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        "mihail.atanassov@arm.com" <mihail.atanassov@arm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Souza, Jose" <jose.souza@intel.com>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Deak, Imre" <imre.deak@intel.com>,
        "Shankar, Uma" <uma.shankar@intel.com>,
        "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-gfx] [RFC][PATCH 5/5] drm/i915/display: Add
 Nearest-neighbor based integer scaling support
Thread-Topic: [Intel-gfx] [RFC][PATCH 5/5] drm/i915/display: Add
 Nearest-neighbor based integer scaling support
Thread-Index: AQHV66uZeA9shQKOjUiF9Sh/Uqx6m6grJygAgAT3PXA=
Date:   Fri, 28 Feb 2020 05:50:16 +0000
Message-ID: <E92BA18FDE0A5B43B7B3DA7FCA03128605778A4D@BGSMSX107.gar.corp.intel.com>
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
 <20200225070545.4482-6-pankaj.laxminarayan.bharadiya@intel.com>
 <CAPj87rPHFCntSOCx=92HitNxRBkXx3xSft0krkFLzdM2FrDSRw@mail.gmail.com>
In-Reply-To: <CAPj87rPHFCntSOCx=92HitNxRBkXx3xSft0krkFLzdM2FrDSRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFN0b25lIDxk
YW5pZWxAZm9vaXNoYmFyLm9yZz4NCj4gU2VudDogMjUgRmVicnVhcnkgMjAyMCAxMzowMA0KPiBU
bzogTGF4bWluYXJheWFuIEJoYXJhZGl5YSwgUGFua2FqDQo+IDxwYW5rYWoubGF4bWluYXJheWFu
LmJoYXJhZGl5YUBpbnRlbC5jb20+DQo+IENjOiBKYW5pIE5pa3VsYSA8amFuaS5uaWt1bGFAbGlu
dXguaW50ZWwuY29tPjsgRGFuaWVsIFZldHRlcg0KPiA8ZGFuaWVsQGZmd2xsLmNoPjsgaW50ZWwt
Z2Z4IDxpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgZHJpLWRldmVsDQo+IDxkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgVmlsbGUgU3lyasOkbMOkDQo+IDx2aWxsZS5z
eXJqYWxhQGxpbnV4LmludGVsLmNvbT47IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT47
IE1hYXJ0ZW4NCj4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+
OyB0emltbWVybWFubkBzdXNlLmRlOw0KPiBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5v
cmc+OyBtaWhhaWwuYXRhbmFzc292QGFybS5jb207IEpvb25hcw0KPiBMYWh0aW5lbiA8am9vbmFz
LmxhaHRpbmVuQGxpbnV4LmludGVsLmNvbT47IFZpdmksIFJvZHJpZ28NCj4gPHJvZHJpZ28udml2
aUBpbnRlbC5jb20+OyBDaHJpcyBXaWxzb24gPGNocmlzQGNocmlzLXdpbHNvbi5jby51az47IFNv
dXphLA0KPiBKb3NlIDxqb3NlLnNvdXphQGludGVsLmNvbT47IERlIE1hcmNoaSwgTHVjYXMNCj4g
PGx1Y2FzLmRlbWFyY2hpQGludGVsLmNvbT47IFJvcGVyLCBNYXR0aGV3IEQNCj4gPG1hdHRoZXcu
ZC5yb3BlckBpbnRlbC5jb20+OyBEZWFrLCBJbXJlIDxpbXJlLmRlYWtAaW50ZWwuY29tPjsNCj4g
U2hhbmthciwgVW1hIDx1bWEuc2hhbmthckBpbnRlbC5jb20+OyBOYXV0aXlhbCwgQW5raXQgSw0K
PiA8YW5raXQuay5uYXV0aXlhbEBpbnRlbC5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0
IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtJbnRl
bC1nZnhdIFtSRkNdW1BBVENIIDUvNV0gZHJtL2k5MTUvZGlzcGxheTogQWRkIE5lYXJlc3QtDQo+
IG5laWdoYm9yIGJhc2VkIGludGVnZXIgc2NhbGluZyBzdXBwb3J0DQo+IA0KPiBIaSwNCj4gDQo+
IE9uIFR1ZSwgMjUgRmViIDIwMjAgYXQgMDc6MTcsIFBhbmthaiBCaGFyYWRpeWENCj4gPHBhbmth
ai5sYXhtaW5hcmF5YW4uYmhhcmFkaXlhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gQEAgLTQxNSwx
OCArNDE1LDI2IEBAIHNrbF9wcm9ncmFtX3NjYWxlcihzdHJ1Y3QgaW50ZWxfcGxhbmUgKnBsYW5l
LA0KPiA+ICAgICAgICAgdTE2IHlfdnBoYXNlLCB1dl9yZ2JfdnBoYXNlOw0KPiA+ICAgICAgICAg
aW50IGhzY2FsZSwgdnNjYWxlOw0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IGRybV9wbGFuZV9z
dGF0ZSAqc3RhdGUgPSAmcGxhbmVfc3RhdGUtPnVhcGk7DQo+ID4gKyAgICAgICB1MzIgc3JjX3cg
PSBkcm1fcmVjdF93aWR0aCgmcGxhbmVfc3RhdGUtPnVhcGkuc3JjKSA+PiAxNjsNCj4gPiArICAg
ICAgIHUzMiBzcmNfaCA9IGRybV9yZWN0X2hlaWdodCgmcGxhbmVfc3RhdGUtPnVhcGkuc3JjKSA+
PiAxNjsNCj4gPiAgICAgICAgIHUzMiBzY2FsaW5nX2ZpbHRlciA9IFBTX0ZJTFRFUl9NRURJVU07
DQo+ID4gKyAgICAgICBzdHJ1Y3QgZHJtX3JlY3QgZHN0Ow0KPiA+DQo+ID4gICAgICAgICBpZiAo
c3RhdGUtPnNjYWxpbmdfZmlsdGVyID09DQo+IERSTV9TQ0FMSU5HX0ZJTFRFUl9ORUFSRVNUX05F
SUdIQk9SKSB7DQo+ID4gICAgICAgICAgICAgICAgIHNjYWxpbmdfZmlsdGVyID0gUFNfRklMVEVS
X1BST0dSQU1NRUQ7DQo+ID4gKyAgICAgICAgICAgICAgIHNrbF9zZXR1cF9uZWFyZXN0X25laWdo
Ym9yX2ZpbHRlcihkZXZfcHJpdiwgcGlwZSwNCj4gPiArIHNjYWxlcl9pZCk7DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgICAvKiBNYWtlIHRoZSBzY2FsaW5nIHdpbmRvdyBzaXplIHRvIGludGVn
ZXIgbXVsdGlwbGUgb2Ygc291cmNlDQo+ID4gKyAgICAgICAgICAgICAgICAqIFRPRE86IFNob3Vs
ZCB1c2Vyc3BhY2UgdGFrZSBkZXNpc2lvbiB0byByb3VuZCBzY2FsaW5nIHdpbmRvdw0KPiA+ICsg
ICAgICAgICAgICAgICAgKiB0byBpbnRlZ2VyIG11bHRpcGxlPw0KPiA+ICsgICAgICAgICAgICAg
ICAgKi8NCj4gPiArICAgICAgICAgICAgICAgY3J0Y193ID0gcm91bmRkb3duKGNydGNfdywgc3Jj
X3cpOw0KPiA+ICsgICAgICAgICAgICAgICBjcnRjX2ggPSByb3VuZGRvd24oY3J0Y19oLCBzcmNf
aCk7DQo+IA0KPiBUaGUga2VybmVsIHNob3VsZCBhYnNvbHV0ZWx5IG5vdCBiZSBjaGFuZ2luZyB0
aGUgY28tb3JkaW5hdGVzIHRoYXQNCj4gdXNlcnNwYWNlIHJlcXVlc3RlZC4NCg0KVGhhbmtzLCBX
aWxsIGdldCByaWQgb2YgdGhpcyBpbiBWMi4NCg0KVGhhbmtzLA0KUGFua2FqDQo+IA0KPiBDaGVl
cnMsDQo+IERhbmllbA0K
