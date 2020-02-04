Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB8C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7862166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgBDVdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:33:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:2969 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgBDVdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:33:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 13:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="279181613"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2020 13:33:08 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 4 Feb 2020 13:33:08 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Feb 2020 23:33:06 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Tue, 4 Feb 2020 23:33:05 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: constify properties in mfd_cell
Thread-Topic: [PATCH] mfd: constify properties in mfd_cell
Thread-Index: AQHV25gUXwM891ST2ke6LBWkpxKqbqgLaZUAgAAjYdA=
Date:   Tue, 4 Feb 2020 21:33:05 +0000
Message-ID: <073e882795124d8c86b36bea33e1d964@intel.com>
References: <20200204201651.15778-1-tomas.winkler@intel.com>
 <CAHp75VeC4R2XG3rfx3+G6po-JS6U0RPoXg2y+JMhd-s+E_sirA@mail.gmail.com>
In-Reply-To: <CAHp75VeC4R2XG3rfx3+G6po-JS6U0RPoXg2y+JMhd-s+E_sirA@mail.gmail.com>
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

DQo+IA0KPiBPbiBUdWUsIEZlYiA0LCAyMDIwIGF0IDEwOjE4IFBNIFRvbWFzIFdpbmtsZXIgPHRv
bWFzLndpbmtsZXJAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IENvbnN0aWZ5ICdzdHJ1
Y3QgcHJvcGVydHlfZW50cnkgKnByb3BlcnRpZXMnIGluIG1mZF9jZWxsIGFuZA0KPiA+IHBsYXRm
b3JtX2RldmljZS4gSXQgaXMgYWx3YXlzIHBhc3NlZCBhcm91bmQgYXMgYSBwb2ludGVyIGNvbnN0
IHN0cnVjdC4NCj4gPg0KPiANCj4gQWZ0ZXINCj4gDQo+IGNvbW1pdCAyNzcwMzZmMDViZTI0MjU0
MGI3YmZlNzVmMjI2MTA3ZDA0ZjUxYjA2DQo+IEF1dGhvcjogSmFuIEtpc3prYSA8amFuLmtpc3pr
YUBzaWVtZW5zLmNvbT4NCj4gRGF0ZTogICBGcmkgSnVuIDIgMDc6NDM6MjcgMjAxNyArMDIwMA0K
PiANCj4gICAgIHBsYXRmb3JtOiBBY2NlcHQgY29uc3QgcHJvcGVydGllcw0KPiANCj4gdGhpcyBv
bmUgbWFrZXMgc2Vuc2UuDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiANCj4gRG9lcyBpbnRlbC1scHNzKiBjb21waWxlIHdp
dGggdGhpcyBjaGFuZ2U/DQoNCg0KWWVzLCBJdCBkb2VzLg0KDQoNCg==
