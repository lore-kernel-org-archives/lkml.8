Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D512B2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbgFOU4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:56:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:57014 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOU42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:56:28 -0400
IronPort-SDR: WUYzY+y/SL++S37t6+QsApg97i+0JtMYtwmcfdgdKS8aFGLtsP+NpI3RL9TuHSfcRPBXUqkMgc
 aw7xP7g6uHQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 13:56:27 -0700
IronPort-SDR: muuOGndW6l2twqgKRUp5gHj+I6DHwdVVXjshaVMnzZ31gcVkdJsq7yUI+1XuAIXfF8xffWXCmG
 4mfjL2O9CNyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="261210056"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2020 13:56:26 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 13:56:15 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
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
Thread-Index: AQHWQRt0fMmHYsE9aUKb3rSjyAIL46jZyC2AgACD5gCAAAQ1gIAAJA2AgAAFHACAAAbEgIAAA+gAgAATCICAAAmFgP//iy/g
Date:   Mon, 15 Jun 2020 20:56:15 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
References: <20200615201735.GE13792@romley-ivt3.sc.intel.com>
 <C41D099B-BE2E-4D0E-A7B5-7CE587E11930@amacapital.net>
In-Reply-To: <C41D099B-BE2E-4D0E-A7B5-7CE587E11930@amacapital.net>
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

PiBBcmUgd2UgcGxhbm5pbmcgdG8ga2VlcCBQQVNJRCBsaXZlIG9uY2UgYSB0YXNrIGhhcyB1c2Vk
IGl0IG9uY2Ugb3IgYXJlIHdlIGdvaW5nIHRvIHN3YXAgaXQgbGF6aWx5PyAgSWYgdGhlIGxhdHRl
ciwgYSBwZXJjcHUgdmFyaWFibGUgbWlnaHQgYmUgYmV0dGVyLg0KDQpDdXJyZW50IHBsYW4gaXMg
InRvdWNoIGl0IG9uY2UgYW5kIHRoZSB0YXNrIG93bnMgaXQgdW50aWwgZXhpdCgyKSINCg0KTWF5
YmUgc29tZWRheSBpbiB0aGUgZnV0dXJlIHdoZW4gd2UgaGF2ZSBkYXRhIG9uIGhvdyBhcHBsaWNh
dGlvbnMNCmFjdHVhbGx5IHVzZSBhY2NlbGVyYXRvcnMgd2UgY291bGQgbG9vayBhdCBzb21ldGhp
bmcgbW9yZSBjb21wbGV4DQppZiB1c2FnZSBwYXR0ZXJucyBsb29rIGxpa2UgaXQgd291bGQgYmUg
YmVuZWZpY2lhbC4NCg0KLVRvbnkNCg==
