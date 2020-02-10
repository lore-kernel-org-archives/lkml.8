Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A6C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8684020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBJDOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:14:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:47983 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBJDOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 22:14:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 19:13:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="scan'208";a="227061106"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2020 19:13:58 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 9 Feb 2020 19:13:23 -0800
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 9 Feb 2020 19:13:23 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.126]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.138]) with mapi id 14.03.0439.000;
 Mon, 10 Feb 2020 11:13:21 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "tysand@google.com" <tysand@google.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>
Subject: RE: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Thread-Topic: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Thread-Index: AQHV3Mq/N+pHUOUW3kyXc/hsfZBMQqgQuBMAgAL6SVA=
Date:   Mon, 10 Feb 2020 03:13:21 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
In-Reply-To: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
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

T24gU2F0dXJkYXksIEZlYnJ1YXJ5IDgsIDIwMjAgODozMyBQTSwgVGV0c3VvIEhhbmRhIHdyb3Rl
Og0KPiANCj4gSXMgdGhpcyBOVU1BIGF3YXJlPyBDYW4gIm5vZGUtQSdzIE5SX0ZJTEVfUEFHRVMg
aXMgYWxyZWFkeSAwIGFuZA0KPiBub2RlLUIncyBOUl9GSUxFX1BBR0VTIGlzIG5vdCAwLCBidXQg
YWxsb2NhdGlvbiByZXF1ZXN0IHdoaWNoIHRyaWdnZXJlZCB0aGlzDQo+IHNocmlua2VyIHdhbnRz
IHRvIGFsbG9jYXRlIGZyb20gb25seSBub2RlLUIiIGhhcHBlbj8gDQoNCk5vLCBpdCdzIGEgZ2xv
YmFsIGNvdW50ZXIuDQoNCj5DYW4gc29tZSB0aHJlYWQga2VlcA0KPiB0aGlzIHNocmlua2VyIGRl
ZnVuY3Rpb25hbCBieSBrZWVwIGluY3JlYXNpbmcgTlJfRklMRV9QQUdFUz8NCg0KWWVzLiBBY3R1
YWxseSBpdCdzIG91ciBpbnRlbnRpb24gLSBhcyBsb25nIGFzIHRoZXJlIGFyZSBwYWdlY2FjaGUg
cGFnZXMsDQpiYWxsb29uIHBhZ2VzIGFyZSBhdm9pZGVkIHRvIGJlIHJlY2xhaW1lZC4NCg0KDQo+
IA0KPiBJcyB0aGlzIHBhdGNoIGZyb20gIlJlOiBCYWxsb29uIHByZXNzdXJpbmcgcGFnZSBjYWNo
ZSIgdGhyZWFkPyBJIGhvcGUgdGhhdA0KPiB0aGUgZ3Vlc3QgY291bGQgc3RhcnQgcmVjbGFpbWlu
ZyBtZW1vcnkgYmFzZWQgb24gaG9zdCdzIHJlcXVlc3QgKGxpa2UgT09NDQo+IG5vdGlmaWVyIGNo
YWluKSB3aGljaCBpcyBpc3N1ZWQgd2hlbiBob3N0IHRoaW5rcyB0aGF0IGhvc3QgaXMgZ2V0dGlu
ZyBjbG9zZSB0bw0KPiBPT00gYW5kIHRodXMgZ3Vlc3RzIHNob3VsZCBzdGFydCByZXR1cm5pbmcg
dGhlaXIgdW51c2VkIG1lbW9yeSB0byBob3N0Lg0KPiBNYXliZSAicGVyaW9kaWNhbGx5IChlLmcu
IDUgbWludXRlcykiIGluIGFkZGl0aW9uIHRvICJ1cG9uIGNsb3NlIHRvIE9PTQ0KPiBjb25kaXRp
b24iIGlzIGFsc28gcG9zc2libGUuDQoNClRoYXQncyBhYm91dCB0aGUgaG9zdCB1c2FnZXMuIFRo
ZSBob3N0IHNpZGUgbWFuYWdlbWVudCBzb2Z0d2FyZSBkZWNpZGVzIHdoZW4gdG8gaXNzdWUgYSBy
ZXF1ZXN0IHRvIGJhbGxvb24gKGVpdGhlciBwZXJpb2RpY2FsbHkgb3IgZXZlbnQgZHJpdmVuKSwg
SSB0aGluayB0aGVyZSBpc24ndCBhbnl0aGluZyB3ZSBuZWVkIHRvIGRvIGluIHRoZSBiYWxsb29u
IGRyaXZlciBoZXJlLg0KDQpCZXN0LA0KV2VpDQo=
