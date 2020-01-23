Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81C5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA58020704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAWRPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:15:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:44225 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgAWRPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:15:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 09:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="220730221"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2020 09:15:33 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.4]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.111]) with mapi id 14.03.0439.000;
 Thu, 23 Jan 2020 09:15:32 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v12] x86/split_lock: Enable split lock detection by
 kernel
Thread-Topic: [PATCH v12] x86/split_lock: Enable split lock detection by
 kernel
Thread-Index: AQHV0VV7/XPb/EW8oEGwDJr5iFh+Caf3zf+A//+EAFCAAJ4qAP//hI4AgAC36oCAAFEyoA==
Date:   Thu, 23 Jan 2020 17:15:32 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F54960E@ORSMSX114.amr.corp.intel.com>
References: <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123012317.GA21843@agluck-desk2.amr.corp.intel.com>
 <20200123042132.GA2448175@rani.riverdale.lan>
In-Reply-To: <20200123042132.GA2448175@rani.riverdale.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gIHN0YXRpYyB2b2lkIF9faW5pdCBzcGxpdF9sb2NrX3NldHVwKHZvaWQpDQo+PiAgew0KPj4g
LQllbnVtIHNwbGl0X2xvY2tfZGV0ZWN0X3N0YXRlIHNsZCA9IHNsZF9zdGF0ZTsNCj4+ICsJZW51
bSBzcGxpdF9sb2NrX2RldGVjdF9zdGF0ZSBzbGQ7DQo+DQo+IFRoaXMgaXMgYmlrZS1zaGVkZGlu
ZywgYnV0IGluaXRpYWxpemluZyBzbGQgPSBzbGRfd2FybiBoZXJlIHdvdWxkIGhhdmUNCj4gYmVl
biBlbm91Z2ggd2l0aCBubyBvdGhlciBjaGFuZ2VzIHRvIHRoZSBwYXRjaCBJIHRoaW5rPw0KDQpO
b3QgcXVpdGUuIElmIHRoZXJlIGlzbid0IGEgY29tbWFuZCBsaW5lIG9wdGlvbiwgd2UgZ2V0IGhl
cmU6DQoNCglpZiAocmV0IDwgMCkNCgkJZ290byBwcmludDsNCg0Kd2hpY2ggc2tpcHMgY29weWlu
ZyB0aGUgbG9jYWwgInNsZCIgdG8gdGhlIGdsb2JhbCAic2xkX3N0YXRlIi4NCg0KLVRvbnkNCg==
