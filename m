Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C2C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7EE20726
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 11:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgBIL6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 06:58:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:44996 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgBIL6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 06:58:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 03:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,421,1574150400"; 
   d="scan'208";a="225969465"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga007.fm.intel.com with ESMTP; 09 Feb 2020 03:57:59 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 9 Feb 2020 03:57:58 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX602.ger.corp.intel.com (10.184.107.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 9 Feb 2020 13:57:56 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sun, 9 Feb 2020 13:57:56 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 V2] mfd: constify properties in mfd_cell
Thread-Topic: [PATCH 1/2 V2] mfd: constify properties in mfd_cell
Thread-Index: AQHV3q/JurhZU4WdAEOnVlgq+8N6CagSnuMAgAAjSMA=
Date:   Sun, 9 Feb 2020 11:57:56 +0000
Message-ID: <29e51a81900f4009ab173058bdf9ebde@intel.com>
References: <20200208184407.1294-1-tomas.winkler@intel.com>
 <CAHp75Ve0PGO_s-nRk6zwk6QTcFi4Jm3yA-QZ7j7dxqVkYB=svA@mail.gmail.com>
In-Reply-To: <CAHp75Ve0PGO_s-nRk6zwk6QTcFi4Jm3yA-QZ7j7dxqVkYB=svA@mail.gmail.com>
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

DQo+IA0KPiBPbiBTYXQsIEZlYiA4LCAyMDIwIGF0IDg6NDQgUE0gVG9tYXMgV2lua2xlciA8dG9t
YXMud2lua2xlckBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQ29uc3RpZnkgJ3N0cnVj
dCBwcm9wZXJ0eV9lbnRyeSAqcHJvcGVydGllcycgaW4gbWZkX2NlbGwgSXQgaXMgYWx3YXlzDQo+
ID4gcGFzc2VkIGFyb3VuZCBhcyBhIHBvaW50ZXIgY29uc3Qgc3RydWN0Lg0KPiANCj4gSSBndWVz
cyB0aGlzIHNob3VsZCBiZSBzZWNvbmQgcGF0Y2ggaW4gdGhlIHNwbGl0IGFuZCBpdCdzIGFjdHVh
bGx5IGRlcGVuZGVudCB0byB0aGUNCj4gZmlyc3Qgb25lICh3b24ndCB3ZSBnZXQgYSBjb21waWxl
ciB3YXJuaW5nIHdoZW4gd2UgZHJvcCBjb25zdCBxdWFsaWZpZXIgZHVyaW5nDQo+IGFzc2lnbm1l
bnQ/KS4NCj4gDQo+ID4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb21hcyBXaW5rbGVyIDx0b21hcy53
aW5rbGVyQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IFYyOiBkcm9wIHBsYXRmb3JtX2Rl
dmljZSBwYXJ0DQo+IA0KPiBCdHcsIHdoZW4geW91IHByZXBhcmUgc2VyaWVzLCB5b3UgbWF5IHVz
ZSAtdlggY29tbWFuZCBsaW5lIHBhcmFtZXRlciwNCj4gd2hlcmUgWCBpcyBhIHZlcnNpb24gbnVt
YmVyLiBUaGUgc2NyaXB0cyB3aWxsIHB1dCB2MiBpbiBlYWNoIFN1YmplY3QgbGluZQ0KPiB1bmlm
b3JtbHkuDQpSaWdodCwganVzdCB0aGUgc2Vjb25kIHBhdGNoIHdhcyBhIG5ldyBvbmUsIHNvIG5v
dCBzdXJlIEkgc2hvdWxkIG1hcmsgaXQgdjIuIA0KVGhhbmtzDQpUb21hcw0KDQo=
