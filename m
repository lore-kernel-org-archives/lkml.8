Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01530C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB22320733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBIMKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:10:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:52721 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgBIMKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:10:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 04:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,421,1574150400"; 
   d="scan'208";a="250923645"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2020 04:10:17 -0800
Received: from lcsmsx601.ger.corp.intel.com (10.109.210.10) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 9 Feb 2020 04:10:17 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX601.ger.corp.intel.com (10.109.210.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 9 Feb 2020 14:10:15 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sun, 9 Feb 2020 14:10:15 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 V2] mfd: constify properties in mfd_cell
Thread-Topic: [PATCH 1/2 V2] mfd: constify properties in mfd_cell
Thread-Index: AQHV3q/JurhZU4WdAEOnVlgq+8N6CagSnuMAgAAjSMD//+JFAIAAIcoA
Date:   Sun, 9 Feb 2020 12:10:15 +0000
Message-ID: <c4e85375e4204198a05236c2f48157f0@intel.com>
References: <20200208184407.1294-1-tomas.winkler@intel.com>
 <CAHp75Ve0PGO_s-nRk6zwk6QTcFi4Jm3yA-QZ7j7dxqVkYB=svA@mail.gmail.com>
 <29e51a81900f4009ab173058bdf9ebde@intel.com>
 <CAHp75Ve_=edHqb9DMMzFR4NZAhZV1BeLH+EBYLz-+fDsNP_vYQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve_=edHqb9DMMzFR4NZAhZV1BeLH+EBYLz-+fDsNP_vYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiBTdW4sIEZlYiA5LCAyMDIwIGF0IDE6NTggUE0gV2lua2xlciwgVG9tYXMgPHRv
bWFzLndpbmtsZXJAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPiA+IE9uIFNhdCwgRmViIDgsIDIw
MjAgYXQgODo0NCBQTSBUb21hcyBXaW5rbGVyDQo+ID4gPiA8dG9tYXMud2lua2xlckBpbnRlbC5j
b20+DQo+ID4gPiB3cm90ZToNCj4gDQo+ID4gPiA+IFYyOiBkcm9wIHBsYXRmb3JtX2RldmljZSBw
YXJ0DQo+ID4gPg0KPiA+ID4gQnR3LCB3aGVuIHlvdSBwcmVwYXJlIHNlcmllcywgeW91IG1heSB1
c2UgLXZYIGNvbW1hbmQgbGluZQ0KPiA+ID4gcGFyYW1ldGVyLCB3aGVyZSBYIGlzIGEgdmVyc2lv
biBudW1iZXIuIFRoZSBzY3JpcHRzIHdpbGwgcHV0IHYyIGluDQo+ID4gPiBlYWNoIFN1YmplY3Qg
bGluZSB1bmlmb3JtbHkuDQo+ID4gUmlnaHQsIGp1c3QgdGhlIHNlY29uZCBwYXRjaCB3YXMgYSBu
ZXcgb25lLCBzbyBub3Qgc3VyZSBJIHNob3VsZCBtYXJrIGl0IHYyLg0KPiANCj4gWWVzLCBpdCBl
dm9sdmVkIGZyb20gdGhlIHYxIG9mIG9uZSBwYXRjaC4gU28sIGp1c3QgbWFyayBib3RoIG9mIHRo
ZW0gbGlrZQ0KPiAgIHYyOiBwZXIgc3Vic3lzdGVtIHNwbGl0IGZyb20gdjENCj4gb3IgYWxpa2Uu
DQpPa2F5LCB3ZSBjYW4gbG9vayBhdCB0aGF0IGFsc28gdGhpcyB3YXkuDQpUb21hcw0KDQo=
