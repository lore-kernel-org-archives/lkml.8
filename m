Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343C1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAB620679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgFOVZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:25:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:13608 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOVZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:25:01 -0400
IronPort-SDR: lP4cxVejspE5QZq7h2ZgrPICGrM3xiQhVaS2mMKEwNPuu81tYYxAQaZDQi0zJrIQMqg6nVXryp
 95bFB818LBcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 14:25:01 -0700
IronPort-SDR: DPbSSKkl15RGLXjpYQfnrBQzsDrL2NKVfrTHzComI5JPwOJAfj8xqnwP2YPVXomnmdcjFehp/x
 VNCrnqd1nQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="262830374"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2020 14:25:00 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 14:25:00 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.6]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 14:24:59 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        "Andrew Donnellan" <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Topic: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Index: AQHWQRt0fMmHYsE9aUKb3rSjyAIL46jZyC2AgACD5gCAAAQ1gIAAJA2AgAAFHACAAAbEgIAAA+gAgAATCICAAAmFgP//iy/ggAB8XID//4sJsA==
Date:   Mon, 15 Jun 2020 21:24:59 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F66C93C@ORSMSX115.amr.corp.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
 <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
In-Reply-To: <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTbyB3aGF04oCZcyB0aGUgUkRNU1IgZm9yPyAgU3VyZWx5IHlvdQ0KPiBoYXZlIHNvbWUgc3Rh
dGUgc29tZXdoZXJlIHRoYXQgc2F5cyDigJx0aGlzIHRhc2sgaGFzIGEgUEFTSUQu4oCdDQo+IENh
buKAmXQgeW91IGp1c3QgbWFrZSBzdXJlIHRoYXQgc3RheXMgaW4gc3luYyB3aXRoIHRoZSBNU1I/
ICBUaGVuLCBvbiAjR1AsIGlmIHRoZSB0YXNrIGFscmVhZHkgaGFzIGEgUEFTSUQsIHlvdSBrbm93
IHRoZSBNU1IgaXMgc2V0Lg0KDQpXZSBoYXZlIHN0YXRlIHRoYXQgc2F5cyB0aGUgcHJvY2VzcyAo
Im1tIikgaGFzIGJlZW4gYWxsb2NhdGVkIGEgUEFTSUQuIEJ1dCBub3QgZm9yIGVhY2ggdGFzay4N
Cg0KRS5nLiBhIHByb2Nlc3MgbWF5IGNsb25lIGEgYnVuY2ggb2YgdGFza3MsIHRoZW4gb25lIG9m
IHRoZW0gb3BlbnMgYSBkZXZpY2UgdGhhdCBuZWVkcw0KYSBQQVNJRC4gICBXZSBkaWQgaW50ZXJu
YWxseSBoYXZlIHBhdGNoZXMgdG8gZ28gaHVudCBkb3duIGFsbCB0aG9zZSBvdGhlciB0YXNrcyBh
bmQNCmZvcmNlIGEgUEFTSUQgb250byBlYWNoLiBCdXQgdGhlIGNvZGUgd2FzIGJpZyBhbmQgdWds
eS4gQWxzbyBtYXliZSB0aGUgd3JvbmcgdGhpbmcNCnRvIGRvIGlmIHRob3NlIHRocmVhZHMgZGlk
bid0IGV2ZXIgbmVlZCB0byBhY2Nlc3MgdGhlIGRldmljZS4NCg0KUGV0ZXJaIHN1Z2dlc3RlZCB0
aGF0IHdlIGNhbiBhZGQgYSBiaXQgdG8gdGhlIHRhc2sgc3RydWN0dXJlIGZvciB0aGlzIHB1cnBv
c2UuDQoNCkZlbmdodWEgaXMgaGVzaXRhbnQgYWJvdXQgYWRkaW5nIGFuIHg4NiBvbmx5IGJpdCB0
aGVyZS4NCg0KLVRvbnkNCg==
