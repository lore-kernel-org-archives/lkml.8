Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A23C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049E9222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgBNNb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:31:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:22084 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNNb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:31:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 05:31:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="381442955"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2020 05:31:54 -0800
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 05:31:54 -0800
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 05:31:53 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.126]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.138]) with mapi id 14.03.0439.000;
 Fri, 14 Feb 2020 21:31:51 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Tyler Sanderson <tysand@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
Subject: RE: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Thread-Topic: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Thread-Index: AQHV3EIpfQc0Q8o+LUGdBo475Vlup6gZ+hiAgADBtnA=
Date:   Fri, 14 Feb 2020 13:31:51 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E4392AF@shsmsx102.ccr.corp.intel.com>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
In-Reply-To: <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
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

T24gRnJpZGF5LCBGZWJydWFyeSAxNCwgMjAyMCA1OjUyIFBNLCBEYXZpZCBIaWxkZW5icmFuZCB3
cm90ZToNCj4gPiBDb21taXQgNzE5OTQ2MjBiYjI1ICgidmlydGlvX2JhbGxvb246IHJlcGxhY2Ug
b29tIG5vdGlmaWVyIHdpdGgNCj4gPiBzaHJpbmtlciIpIGNoYW5nZWQgdGhlIGJlaGF2aW9yIHdo
ZW4gZGVmbGF0aW9uIGhhcHBlbnMgYXV0b21hdGljYWxseS4NCj4gPiBJbnN0ZWFkIG9mIGRlZmxh
dGluZyB3aGVuIGNhbGxlZCBieSB0aGUgT09NIGhhbmRsZXIsIHRoZSBzaHJpbmtlciBpcyB1c2Vk
Lg0KPiA+DQo+ID4gSG93ZXZlciwgdGhlIGJhbGxvb24gaXMgbm90IHNpbXBseSBzb21lIHNsYWIg
Y2FjaGUgdGhhdCBzaG91bGQgYmUNCj4gPiBzaHJ1bmsgd2hlbiB1bmRlciBtZW1vcnkgcHJlc3N1
cmUuIFRoZSBzaHJpbmtlciBkb2VzIG5vdCBoYXZlIGENCj4gPiBjb25jZXB0IG9mIHByaW9yaXRp
ZXMsIHNvIHRoaXMgYmVoYXZpb3IgY2Fubm90IGJlIGNvbmZpZ3VyZWQuDQo+ID4NCj4gPiBUaGVy
ZSB3YXMgYSByZXBvcnQgdGhhdCB0aGlzIHJlc3VsdHMgaW4gdW5kZXNpcmVkIHNpZGUgZWZmZWN0
cyB3aGVuDQo+ID4gaW5mbGF0aW5nIHRoZSBiYWxsb29uIHRvIHNocmluayB0aGUgcGFnZSBjYWNo
ZS4gWzFdDQo+ID4gCSJXaGVuIGluZmxhdGluZyB0aGUgYmFsbG9vbiBhZ2FpbnN0IHBhZ2UgY2Fj
aGUgKGkuZS4gbm8gZnJlZSBtZW1vcnkNCj4gPiAJIHJlbWFpbnMpIHZtc2Nhbi5jIHdpbGwgYm90
aCBzaHJpbmsgcGFnZSBjYWNoZSwgYnV0IGFsc28gaW52b2tlIHRoZQ0KPiA+IAkgc2hyaW5rZXJz
IC0tIGluY2x1ZGluZyB0aGUgYmFsbG9vbidzIHNocmlua2VyLiBTbyB0aGUgYmFsbG9vbg0KPiA+
IAkgZHJpdmVyIGFsbG9jYXRlcyBtZW1vcnkgd2hpY2ggcmVxdWlyZXMgcmVjbGFpbSwgdm1zY2Fu
IGdldHMgdGhpcw0KPiA+IAkgbWVtb3J5IGJ5IHNocmlua2luZyB0aGUgYmFsbG9vbiwgYW5kIHRo
ZW4gdGhlIGRyaXZlciBhZGRzIHRoZQ0KPiA+IAkgbWVtb3J5IGJhY2sgdG8gdGhlIGJhbGxvb24u
IEJhc2ljYWxseSBhIGJ1c3kgbm8tb3AuIg0KPiA+DQo+ID4gVGhlIG5hbWUgImRlZmxhdGUgb24g
T09NIiBtYWtlcyBpdCBwcmV0dHkgY2xlYXIgd2hlbiBkZWZsYXRpb24gc2hvdWxkDQo+ID4gaGFw
cGVuIC0gYWZ0ZXIgb3RoZXIgYXBwcm9hY2hlcyB0byByZWNsYWltIG1lbW9yeSBmYWlsZWQsIG5v
dCB3aGlsZQ0KPiA+IHJlY2xhaW1pbmcuIFRoaXMgYWxsb3dzIHRvIG1pbmltaXplIHRoZSBmb290
cHJpbnQgb2YgYSBndWVzdCAtIG1lbW9yeQ0KPiA+IHdpbGwgb25seSBiZSB0YWtlbiBvdXQgb2Yg
dGhlIGJhbGxvb24gd2hlbiByZWFsbHkgbmVlZGVkLg0KPiA+DQo+ID4gRXNwZWNpYWxseSwgYSBk
cm9wX3NsYWIoKSB3aWxsIHJlc3VsdCBpbiB0aGUgd2hvbGUgYmFsbG9vbiBnZXR0aW5nDQo+ID4g
ZGVmbGF0ZWQgLSB1bmRlc2lyZWQuIFdoaWxlIGhhbmRsaW5nIGl0IHZpYSB0aGUgT09NIGhhbmRs
ZXIgbWlnaHQgbm90DQo+ID4gYmUgcGVyZmVjdCwgaXQga2VlcHMgZXhpc3RpbmcgYmVoYXZpb3Iu
IElmIHdlIHdhbnQgYSBkaWZmZXJlbnQNCj4gPiBiZWhhdmlvciwgdGhlbiB3ZSBuZWVkIGEgbmV3
IGZlYXR1cmUgYml0IGFuZCBkb2N1bWVudCBpdCBwcm9wZXJseQ0KPiA+IChhbHRob3VnaCwgdGhl
cmUgc2hvdWxkIGJlIGEgY2xlYXIgdXNlIGNhc2UgYW5kIHRoZSBpbnRlbmRlZCBlZmZlY3RzIHNo
b3VsZA0KPiBiZSB3ZWxsIGRlc2NyaWJlZCkuDQo+ID4NCj4gPiBLZWVwIHVzaW5nIHRoZSBzaHJp
bmtlciBmb3IgVklSVElPX0JBTExPT05fRl9GUkVFX1BBR0VfSElOVCwNCj4gYmVjYXVzZQ0KPiA+
IHRoaXMgaGFzIG5vIHN1Y2ggc2lkZSBlZmZlY3RzLiBBbHdheXMgcmVnaXN0ZXIgdGhlIHNocmlu
a2VyIHdpdGgNCj4gPiBWSVJUSU9fQkFMTE9PTl9GX0ZSRUVfUEFHRV9ISU5UIG5vdy4gV2UgYXJl
IGFsd2F5cyBhbGxvd2VkIHRvDQo+IHJldXNlDQo+ID4gZnJlZSBwYWdlcyB0aGF0IGFyZSBzdGls
bCB0byBiZSBwcm9jZXNzZWQgYnkgdGhlIGd1ZXN0LiBUaGUgaHlwZXJ2aXNvcg0KPiA+IHRha2Vz
IGNhcmUgb2YgaWRlbnRpZnlpbmcgYW5kIHJlc29sdmluZyBwb3NzaWJsZSByYWNlcyBiZXR3ZWVu
DQo+ID4gcHJvY2Vzc2luZyBhIGhpbnRpbmcgcmVxdWVzdCBhbmQgdGhlIGd1ZXN0IHJldXNpbmcg
YSBwYWdlLg0KPiA+DQo+ID4gSW4gY29udHJhc3QgdG8gcHJlIGNvbW1pdCA3MTk5NDYyMGJiMjUg
KCJ2aXJ0aW9fYmFsbG9vbjogcmVwbGFjZSBvb20NCj4gPiBub3RpZmllciB3aXRoIHNocmlua2Vy
IiksIGRvbid0IGFkZCBhIG1vb2R1bGUgcGFyYW1ldGVyIHRvIGNvbmZpZ3VyZQ0KPiA+IHRoZSBu
dW1iZXIgb2YgcGFnZXMgdG8gZGVmbGF0ZSBvbiBPT00uIENhbiBiZSByZS1hZGRlZCBpZiByZWFs
bHkgbmVlZGVkLg0KPiA+IEFsc28sIHBheSBhdHRlbnRpb24gdGhhdCBsZWFrX2JhbGxvb24oKSBy
ZXR1cm5zIHRoZSBudW1iZXIgb2YgNGsgcGFnZXMNCj4gPiAtIGNvbnZlcnQgaXQgcHJvcGVybHkg
aW4gdmlydGlvX2JhbGxvb25fb29tX25vdGlmeSgpLg0KPiA+DQo+ID4gTm90ZTE6IHVzaW5nIHRo
ZSBPT00gaGFuZGxlciBpcyBmcm93bmVkIHVwb24sIGJ1dCBpdCByZWFsbHkgaXMgd2hhdCB3ZQ0K
PiA+ICAgICAgICBuZWVkIGZvciB0aGlzIGZlYXR1cmUuDQo+ID4NCj4gPiBOb3RlMjogd2l0aG91
dCBWSVJUSU9fQkFMTE9PTl9GX01VU1RfVEVMTF9IT1NUIChpb3csIGFsd2F5cyB3aXRoDQo+IFFF
TVUpIHdlDQo+ID4gICAgICAgIGNvdWxkIGFjdHVhbGx5IHNraXAgc2VuZGluZyBkZWZsYXRpb24g
cmVxdWVzdHMgdG8gb3VyIGh5cGVydmlzb3IsDQo+ID4gICAgICAgIG1ha2luZyB0aGUgT09NIHBh
dGggKnZlcnkqIHNpbXBsZS4gQmVzaWNhbGx5IGZyZWVpbmcgcGFnZXMgYW5kDQo+ID4gICAgICAg
IHVwZGF0aW5nIHRoZSBiYWxsb29uLiBJZiB0aGUgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSBob3N0
IGV2ZXINCj4gPiAgICAgICAgYmVjb21lcyBhIHByb2JsZW0gb24gdGhpcyBjYWxsIHBhdGguDQo+
ID4NCj4gDQo+IEBNaWNoYWVsLCBob3cgdG8gcHJvY2VlZCB3aXRoIHRoaXM/DQo+IA0KDQpJIHZv
dGUgZm9yIG5vdCBnb2luZyBiYWNrLiBXaGVuIHRoZXJlIGFyZSBzb2xpZCByZXF1ZXN0IGFuZCBz
dHJvbmcgcmVhc29ucyBpbiB0aGUgZnV0dXJlLCB3ZSBjb3VsZCByZW9wZW4gdGhpcyBkaXNjdXNz
aW9uLg0KDQpCZXN0LA0KV2VpDQo=
