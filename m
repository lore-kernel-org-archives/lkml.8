Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3869BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBC720776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgDQC14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:27:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:24612 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728969AbgDQC1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:27:55 -0400
IronPort-SDR: akVDUuNrUHwmhFapak8u7ylFTccawbIgZGl3YyM24j2rhOQLkJz5R1QVY7ocUm68cT2y43vzHS
 KgQGfmbGJ3Fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 19:27:55 -0700
IronPort-SDR: o9hkvLAaiO9Rb19BdwJ3FoHao5MY1QDR6RB4lAjMFbD5RyuhafnYlDuWMDlgKtfhXe28uxz0AZ
 JCgxPSKKjYdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="299480898"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Apr 2020 19:27:54 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 19:27:52 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Fri, 17 Apr 2020 10:27:49 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/7] iommu/vt-d: Add page request draining support
Thread-Topic: [PATCH v2 6/7] iommu/vt-d: Add page request draining support
Thread-Index: AQHWEubS8xobodm1XE6sOT1OPN2bNqh579XggAD5A4CAAa9E8A==
Date:   Fri, 17 Apr 2020 02:27:49 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D824051@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-7-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8209CE@SHSMSX104.ccr.corp.intel.com>
 <acf26559-49d2-653c-156d-3ef383b43879@linux.intel.com>
In-Reply-To: <acf26559-49d2-653c-156d-3ef383b43879@linux.intel.com>
Accept-Language: en-US
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

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMTYsIDIwMjAgNDozOCBQTQ0KPiANCj4gSGkgS2V2aW4sDQo+IA0KPiBPbiAy
MDIwLzQvMTUgMTk6MTAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+IHRoZSBjb21wbGV0aW9uIG9m
IGFib3ZlIHNlcXVlbmNlIGVuc3VyZXMgdGhhdCBwcmV2aW91cyBxdWV1ZWQNCj4gPiBwYWdlIGdy
b3VwIHJlc3BvbnNlcyBhcmUgc2VudCBvdXQgYW5kIHJlY2VpdmVkIGJ5IHRoZSBlbmRwb2ludA0K
PiA+IGFuZCB2aWNlIHZlcnNhIGFsbCBpbi1mbHkgcGFnZSByZXF1ZXN0cyBmcm9tIHRoZSBlbmRw
b2ludCBhcmUgcXVldWVkDQo+ID4gaW4gaW9tbXUgcGFnZSByZXF1ZXN0IHF1ZXVlLiBUaGVuIGNv
bWVzIGEgcHJvYmxlbSAtIHlvdSBkaWRuJ3QNCj4gPiB3YWl0IGZvciBjb21wbGV0aW9uIG9mIHRo
b3NlIG5ld2x5LXF1ZXVlZCByZXF1ZXN0cyBhbmQgdGhlaXINCj4gPiByZXNwb25zZXMuDQo+IA0K
PiBJIHRob3VnaHQgYWJvdXQgdGhpcyBhZ2Fpbi4NCj4gDQo+IFdlIGRvIHBhZ2UgcmVxdWVzdCBk
cmFpbmluZyBhZnRlciBQQVNJRCB0YWJsZSBlbnRyeSBnZXRzIHRvcm4gZG93biBhbmQNCj4gdGhl
IGRldlRMQiBnZXRzIGludmFsaWRhdGVkLiBBdCB0aGlzIHBvaW50LCBpZiBhbnkgbmV3IHBhZ2Ug
cmVxdWVzdCBmb3INCj4gdGhpcyBwYXNpZCBjb21lcyBpbiwgSU9NTVUgd2lsbCBnZW5lcmF0ZSBh
biB1bnJlY292ZXJhYmxlIGZhdWx0IGFuZA0KPiByZXNwb25zZSB0aGUgZGV2aWNlIHdpdGggSVIg
KEludmFsaWQgUmVxdWVzdCkuIElPTU1VIHdvbid0IHB1dCB0aGlzIHBhZ2UNCj4gcmVxdWVzdCBp
bnRvIHRoZSBxdWV1ZS4gW1ZULWQgc3BlYyA3LjQuMV0NCg0KTm9uLWNvdmVyYWJsZSBmYXVsdCBp
bXBsaWVzIHNldmVyZSBlcnJvcnMsIHNvIEkgZG9uJ3Qgc2VlIHdoeSB3ZSBzaG91bGQNCmFsbG93
IHN1Y2ggdGhpbmcgaGFwcGVuIHdoZW4gaGFuZGxpbmcgYSBub3JtYWwgc2l0dWF0aW9uLiBpZiB5
b3UgbG9vayBhdA0KdGhlIHN0YXJ0IG9mIGNoYXB0ZXIgNzoNCi0tDQpOb24tcmVjb3ZlcmFibGUg
RmF1bHRzOiBSZXF1ZXN0cyB0aGF0IGVuY291bnRlciBub24tcmVjb3ZlcmFibGUgDQphZGRyZXNz
IHRyYW5zbGF0aW9uIGZhdWx0cyBhcmUgYWJvcnRlZCBieSB0aGUgcmVtYXBwaW5nIGhhcmR3YXJl
LCANCmFuZCB0eXBpY2FsbHkgcmVxdWlyZSBhIHJlc2V0IG9mIHRoZSBkZXZpY2UgKHN1Y2ggYXMg
dGhyb3VnaCBhIGZ1bmN0aW9uLQ0KbGV2ZWwtcmVzZXQpIHRvIHJlY292ZXIgYW5kIHJlLWluaXRp
YWxpemUgdGhlIGRldmljZSB0byBwdXQgaXQgYmFjayBpbnRvIA0Kc2VydmljZS4NCi0tDQoNCj4g
DQo+IEhlbmNlLCB3ZSBkb24ndCBuZWVkIHRvIHdvcnJ5IGFib3V0IHRoZSBuZXdseS1xdWV1ZWQg
cmVxdWVzdHMgaGVyZS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gQmFvbHUNCg0KVGhhbmtzDQpL
ZXZpbg0K
