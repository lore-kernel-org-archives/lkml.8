Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DBFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C027212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFQTjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:39:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:52522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgFQTjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:39:45 -0400
IronPort-SDR: wS7tIFarexy0u+Xai9N0UFpJqNPYfGSUT0f/mB8oJikfhiaWgUXBn9qQn6cGa7+5gqdDfWNFJM
 EW18WHN9QlVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 12:39:45 -0700
IronPort-SDR: XlOkZWuUqUJIMX3YBJ641L9Zny0vHQ3jjFJ0lLYzgPZoGdYYh0V+M5UafI1dtz9Eglt47VJwI7
 0sv5dlw7OpgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="476968932"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2020 12:39:44 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Wed, 17 Jun 2020 12:39:43 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradeed.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v3 01/13] iommu: Change type of pasid to unsigned int
Thread-Topic: [PATCH v3 01/13] iommu: Change type of pasid to unsigned int
Thread-Index: AQHWRNSCgq6s3Eb3TUCTrKgNEKKtfajdqISA//+LkWA=
Date:   Wed, 17 Jun 2020 19:39:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F67216A@ORSMSX115.amr.corp.intel.com>
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
 <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
 <CALCETrXFHa_05-sGAy5M9YGJWUfTn9MfM-ZYk+hp12tqHNJA0Q@mail.gmail.com>
In-Reply-To: <CALCETrXFHa_05-sGAy5M9YGJWUfTn9MfM-ZYk+hp12tqHNJA0Q@mail.gmail.com>
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

PiBJcyBQQVNJRCBpbiB0aGUgdWFwaSBhdCBhbGw/DQoNCg0KJCBncmVwIHBhc2lkIGluY2x1ZGUv
dWFwaS9saW51eC9pb21tdS5oDQoqIEBwYXNpZDogUHJvY2VzcyBBZGRyZXNzIFNwYWNlIElEDQog
ICAgICAgIF9fdTMyICAgcGFzaWQ7DQogKiBAcGFzaWQ6IFByb2Nlc3MgQWRkcmVzcyBTcGFjZSBJ
RA0KICAgICAgICBfX3UzMiAgIHBhc2lkOw0KICogQHBhc2lkOiBQcm9jZXNzIEFkZHJlc3MgU3Bh
Y2UgSUQNCiAgICAgICAgX191MzIgICBwYXNpZDsNCiAqIC0gSWYgdGhlIFBBU0lEIGJpdCBpcyBz
ZXQsIHRoZSBAcGFzaWQgZmllbGQgaXMgcG9wdWxhdGVkIGFuZCB0aGUgaW52YWxpZGF0aW9uDQog
KiBAcGFzaWQ6IHByb2Nlc3MgYWRkcmVzcyBzcGFjZSBJRA0KICAgICAgICBfX3U2NCAgIHBhc2lk
Ow0KICogc3RydWN0IGlvbW11X2ludl9wYXNpZF9pbmZvIC0gUEFTSUQgU2VsZWN0aXZlIEludmFs
aWRhdGlvbiBTdHJ1Y3R1cmUNCiAqIC0gSWYgdGhlIFBBU0lEIGJpdCBpcyBzZXQsIHRoZSBAcGFz
aWQgZmllbGQgaXMgcG9wdWxhdGVkIGFuZCB0aGUgaW52YWxpZGF0aW9uDQogKiBAcGFzaWQ6IHBy
b2Nlc3MgYWRkcmVzcyBzcGFjZSBJRA0Kc3RydWN0IGlvbW11X2ludl9wYXNpZF9pbmZvIHsNCiAg
ICAgICAgX191NjQgICBwYXNpZDsNCiAqIEBwYXNpZF9pbmZvOiBpbnZhbGlkYXRpb24gZGF0YSB3
aGVuIEBncmFudWxhcml0eSBpcyAlSU9NTVVfSU5WX0dSQU5VX1BBU0lEDQogICAgICAgICAgICAg
ICAgc3RydWN0IGlvbW11X2ludl9wYXNpZF9pbmZvIHBhc2lkX2luZm87DQogKiBzdHJ1Y3QgaW9t
bXVfZ3Bhc2lkX2JpbmRfZGF0YV92dGQgLSBJbnRlbCBWVC1kIHNwZWNpZmljIGRhdGEgb24gZGV2
aWNlIGFuZCBndWVzdA0Kc3RydWN0IGlvbW11X2dwYXNpZF9iaW5kX2RhdGFfdnRkIHsNCiAqIHN0
cnVjdCBpb21tdV9ncGFzaWRfYmluZF9kYXRhIC0gSW5mb3JtYXRpb24gYWJvdXQgZGV2aWNlIGFu
ZCBndWVzdCBQQVNJRCBiaW5kaW5nDQogKiBAaHBhc2lkOiAgICAgUHJvY2VzcyBhZGRyZXNzIHNw
YWNlIElEIHVzZWQgZm9yIHRoZSBndWVzdCBtbSBpbiBob3N0IElPTU1VDQogKiBAZ3Bhc2lkOiAg
ICAgUHJvY2VzcyBhZGRyZXNzIHNwYWNlIElEIHVzZWQgZm9yIHRoZSBndWVzdCBtbSBpbiBndWVz
dCBJT01NVQ0Kc3RydWN0IGlvbW11X2dwYXNpZF9iaW5kX2RhdGEgew0KICAgICAgICBfX3U2NCBo
cGFzaWQ7DQogICAgICAgIF9fdTY0IGdwYXNpZDsNCiAgICAgICAgICAgICAgICBzdHJ1Y3QgaW9t
bXVfZ3Bhc2lkX2JpbmRfZGF0YV92dGQgdnRkOw0K
