Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38CBC35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 23:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1C220704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 23:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgAYXKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:10:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:23337 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgAYXKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 18:10:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 15:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,363,1574150400"; 
   d="scan'208";a="246059569"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2020 15:10:00 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.4]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.15]) with mapi id 14.03.0439.000;
 Sat, 25 Jan 2020 15:10:00 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mark D Rustad <mrustad@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v16] x86/split_lock: Enable split lock detection by
 kernel
Thread-Topic: [PATCH v16] x86/split_lock: Enable split lock detection by
 kernel
Thread-Index: AQHV08vIoo9+H20Xn0+pX8CBaZEvcaf8gEOAgAAHYoA=
Date:   Sat, 25 Jan 2020 23:10:00 +0000
Message-ID: <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com>
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
In-Reply-To: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <44124E5DD95A474BBBAE06EC979C7132@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBNYXliZSAiaXNuJ3Qgc3VwcG9ydGVkIiBpcyBub3QgcmVhbGx5IHRoZSByaWdodCB3
b3JkaW5nLiBJIHdvdWxkIHRoaW5rIHRoYXQgaWYgaXQgdHJ1bHkgd2VyZW4ndCBzdXBwb3J0ZWQg
dGhhdCB5b3UgcmVhbGx5IHNob3VsZG4ndCBiZSBjaGFuZ2luZyB0aGUgbW9kZSBhdCBhbGwgYXQg
cnVudGltZS4gRG8geW91IHJlYWxseSBqdXN0IG1lYW4gImlzbid0IGF0b21pYyI/IE9yIGlzIHRo
ZXJlIHNvbWV0aGluZyBkZWVwZXIgYWJvdXQgaXQ/IElmIHNvLCBhcmUgdGhlcmUgb3RoZXIgcG9z
c2libGUgcmlza3MgYXNzb2NpYXRlZCB3aXRoIGNoYW5naW5nIHRoZSBtb2RlIGF0IHJ1bnRpbWU/
DQo+IA0KPiBTb3JyeSwgdGhlIHdvcmRpbmcganVzdCBoYXBwZW5lZCB0byBjYXRjaCBteSBleWUg
DQoNClRoZSDigJxtb2Rlc+KAnSBoZXJlIG1lYW5zIHRoZSB0aHJlZSBvcHRpb24gc2VsZWN0YWJs
ZSBieSBjb21tYW5kIGxpbmUgb3B0aW9uLiBPZmYvd2Fybi9mYXRhbC4gU29tZSBlYXJsaWVyIHZl
cnNpb25zIG9mIHRoaXMgcGF0Y2ggaGFkIGEgc3lzZnMgaW50ZXJmYWNlIHRvIHN3aXRjaCB0aGlu
Z3MgYXJvdW5kLg0KDQpOb3Qgd2hldGhlciB3ZSBoYXZlIHRoZSBNU1IgZW5hYmxlZC9kaXNhYmxl
ZC4NCg0KSWYgVGhvbWFzIG9yIEJvcmlzIGZpbmRzIG1vcmUgdGhpbmdzIHRvIGZpeCB0aGVuIEni
gJlsbCB0YWtlIGEgbG9vayBhdCBjbGFyaWZ5aW5nIHRoaXMgY29tbWVudCB0b28uDQoNCi1Ub255
