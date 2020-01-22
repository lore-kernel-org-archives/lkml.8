Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB247C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5F12253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgAVXYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:24:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:23094 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgAVXYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:24:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 15:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,351,1574150400"; 
   d="scan'208";a="375062915"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga004.jf.intel.com with ESMTP; 22 Jan 2020 15:24:35 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jan 2020 15:24:35 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.4]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.76]) with mapi id 14.03.0439.000;
 Wed, 22 Jan 2020 15:24:35 -0800
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
Thread-Index: AQHV0VV7/XPb/EW8oEGwDJr5iFh+Caf3zf+A//+EAFA=
Date:   Wed, 22 Jan 2020 23:24:34 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
References: <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
In-Reply-To: <20200122224245.GA2331824@rani.riverdale.lan>
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

Pj4gK3N0YXRpYyBlbnVtIHNwbGl0X2xvY2tfZGV0ZWN0X3N0YXRlIHNsZF9zdGF0ZSA9IHNsZF93
YXJuOw0KPj4gKw0KPg0KPiBUaGlzIHNldHMgc2xkX3N0YXRlIHRvIHNsZF93YXJuIGV2ZW4gb24g
Q1BVcyB0aGF0IGRvbid0IHN1cHBvcnQNCj4gc3BsaXQtbG9jayBkZXRlY3Rpb24uIHNwbGl0X2xv
Y2tfaW5pdCB3aWxsIHRoZW4gdHJ5IHRvIHJlYWQvd3JpdGUgdGhlDQo+IE1TUiB0byB0dXJuIGl0
IG9uLiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gaW5pdGlhbGl6ZSBpdCB0byBzbGRfb2ZmIGFuZA0K
PiBzZXQgaXQgdG8gc2xkX3dhcm4gaW4gc3BsaXRfbG9ja19zZXR1cCBpbnN0ZWFkLCB3aGljaCBp
cyBvbmx5IGNhbGxlZCBpZg0KPiB0aGUgQ1BVIHN1cHBvcnRzIHRoZSBmZWF0dXJlPw0KDQpJJ3Zl
IGxvc3Qgc29tZSBiaXRzIG9mIHRoaXMgcGF0Y2ggc2VyaWVzIHNvbWV3aGVyZSBhbG9uZyB0aGUg
d2F5IDotKCAgVGhlcmUNCndhcyBvbmNlIGNvZGUgdG8gZGVjaWRlIHdoZXRoZXIgdGhlIGZlYXR1
cmUgd2FzIHN1cHBvcnRlZCAoZWl0aGVyIHdpdGgNCng4Nl9tYXRjaF9jcHUoKSBmb3IgYSBjb3Vw
bGUgb2YgbW9kZWxzLCBvciB1c2luZyB0aGUgYXJjaGl0ZWN0dXJhbCB0ZXN0DQpiYXNlZCBvbiBz
b21lIE1TUiBiaXRzLiAgSSBuZWVkIHRvIGRpZyB0aGF0IG91dCBhbmQgcHV0IGl0IGJhY2sgaW4u
IFRoZW4NCnN0dWZmIGNhbiBjaGVjayBYODZfRkVBVFVSRV9TUExJVF9MT0NLIGJlZm9yZSB3YW5k
ZXJpbmcgaW50byBjb2RlDQp0aGF0IG1lc3NlcyB3aXRoIE1TUnMNCg0KPj4gKwlpZiAoIXNwbGl0
X2xvY2tfZGV0ZWN0X2VuYWJsZWQoKSkNCj4+ICsJCXJldHVybjsNCj4NCj4gVGhpcyBtaXNzZXMg
b25lIGNvbW1lbnQgZnJvbSBTZWFuIFsxXSB0aGF0IHRoaXMgY2hlY2sgc2hvdWxkIGJlIGRyb3Bw
ZWQsDQo+IG90aGVyd2lzZSB1c2VyLXNwYWNlIGFsaWdubWVudCBjaGVjayB2aWEgRUZMQUdTLkFD
IHdpbGwgZ2V0IGlnbm9yZWQgd2hlbg0KPiBzcGxpdCBsb2NrIGRldGVjdGlvbiBpcyBkaXNhYmxl
ZC4NCg0KQWggeWVzLiBHb29kIGNhdGNoLiAgV2lsbCBmaXguDQoNClRoYW5rcyBmb3IgdGhlIHJl
dmlldy4NCg0KLVRvbnkNCg==
