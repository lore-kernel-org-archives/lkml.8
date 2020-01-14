Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55823C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3344E20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgANCT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:19:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:14862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgANCT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 21:19:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 18:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="305015113"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2020 18:19:25 -0800
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jan 2020 18:19:26 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jan 2020 18:19:25 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.30]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0439.000;
 Tue, 14 Jan 2020 10:19:24 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH v2] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Topic: [PATCH v2] x86/mce/therm_throt: Fix the access of
 uninitialized therm_work
Thread-Index: AQHVxPN/UsqyHJFgv0iRY5Xjg1sttKfjt8aAgAQZUoCAAaaV0A==
Date:   Tue, 14 Jan 2020 02:19:22 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A61602CA4@SHSMSX101.ccr.corp.intel.com>
References: <20200107004116.59353-1-chuansheng.liu@intel.com>
 <20200110182929.GA20511@agluck-desk2.amr.corp.intel.com>
 <20200113090509.GC13310@zn.tnic>
In-Reply-To: <20200113090509.GC13310@zn.tnic>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxMywgMjAyMCA1OjA1IFBN
DQo+IFRvOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogTGl1LCBDaHVh
bnNoZW5nIDxjaHVhbnNoZW5nLmxpdUBpbnRlbC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOw0KPiBocGFA
enl0b3IuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHg4Ni9tY2UvdGhlcm1fdGhyb3Q6
IEZpeCB0aGUgYWNjZXNzIG9mIHVuaW5pdGlhbGl6ZWQNCj4gdGhlcm1fd29yaw0KPiANCj4gT24g
RnJpLCBKYW4gMTAsIDIwMjAgYXQgMTA6Mjk6MjlBTSAtMDgwMCwgTHVjaywgVG9ueSB3cm90ZToN
Cj4gPiBPbiBUdWUsIEphbiAwNywgMjAyMCBhdCAxMjo0MToxNkFNICswMDAwLCBDaHVhbnNoZW5n
IExpdSB3cm90ZToNCj4gPiA+IEluIG15IElDTCBwbGF0Zm9ybSwgaXQgY2FuIGJlIHJlcHJvZHVj
ZWQgaW4gc2V2ZXJhbCB0aW1lcw0KPiA+ID4gb2YgcmVib290IHN0cmVzcy4gV2l0aCB0aGlzIGZp
eCwgdGhlIHN5c3RlbSBrZWVwcyBhbGl2ZQ0KPiA+ID4gZm9yIG1vcmUgdGhhbiAyMDAgdGltZXMg
b2YgcmVib290IHN0cmVzcy4NCj4gPiA+DQo+ID4gPiBWMjogQm9yaXMgc2hhcmVzIGEgZ29vZCBz
dWdnZXN0aW9uIHRoYXQgd2UgY2FuIG1vdmluZyB0aGUNCj4gPiA+IGludGVycnVwdCB1bm1hc2tp
bmcgYXQgdGhlIGVuZCBvZiB0aGVybV93b3JrIGluaXRpYWxpemF0aW9uLg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IENodWFuc2hlbmcgTGl1IDxjaHVhbnNoZW5nLmxpdUBpbnRlbC5jb20+
DQo+ID4NCj4gPiBMb29rcyBnb29kIHRvIG1lOg0KPiA+DQo+ID4gQWNrZWQtYnk6IFRvbnkgTHVj
ayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gDQo+IFRoeC4NCj4gDQo+IFRoaXMgIklDTCBwbGF0
Zm9ybSIgLSB3aGF0ZXZlciB0aGF0IGlzIC0gaXMgdGhpcyBzaGlwcGluZyBhbHJlYWR5IHNvDQpJ
IGp1c3QgY2FuIHNheSBJQ0woaWNlbGFrZSkgaXMgc2hpcHBlZCBwbGF0Zm9ybSwgSSByZXByb2R1
Y2VkIHRoaXMgaXNzdWUNCmluIG9uZSBsYXB0b3AuDQoNCg0K
