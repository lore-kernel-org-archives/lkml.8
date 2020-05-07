Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43DFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E362495B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgEGSuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:50:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:46055 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEGSuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:50:54 -0400
IronPort-SDR: m3NdPX7ZhuJowXKNRc2tFiGhVMKd3WIAz8+kGtFVW02AU+/oaLnHYPLjfMr87tqB8rxrqyAdSU
 3KH1MpmcHZeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 11:50:53 -0700
IronPort-SDR: UACRTPXn+b0AiDXLKLxCAcGmJZLWvGDpLJk/+lzMBmtQOodi3YbLbiEBDE4gY5kGbYwTIVgn6n
 UGnv/1ucefmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="251590916"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 07 May 2020 11:50:53 -0700
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 11:50:52 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 21:50:50 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 7 May 2020 21:50:50 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     =?utf-8?B?5Lq/5LiA?= <teroincn@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG]is there a refcount leak in function mei_me_cl_rm_by_uuid?
Thread-Topic: [BUG]is there a refcount leak in function mei_me_cl_rm_by_uuid?
Thread-Index: AQHWI7UxQx9KZrk2hEaieKucEHXx86ic9l4g
Date:   Thu, 7 May 2020 18:50:50 +0000
Message-ID: <06ef12d05af446e8bc8cc674c68cecf7@intel.com>
References: <CANTwqXAwbiGwd3-6ShQw-kvnwNPk6Ev2Sc1yMTVH4+1=mxRQsA@mail.gmail.com>
In-Reply-To: <CANTwqXAwbiGwd3-6ShQw-kvnwNPk6Ev2Sc1yMTVH4+1=mxRQsA@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog5Lq/5LiAIDx0ZXJvaW5j
bkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDA2LCAyMDIwIDE3OjQ3DQo+IFRv
OiBXaW5rbGVyLCBUb21hcyA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtCVUddaXMgdGhlcmUgYSByZWZjb3Vu
dCBsZWFrIGluIGZ1bmN0aW9uIG1laV9tZV9jbF9ybV9ieV91dWlkPw0KDQpVbmZvcnR1bmF0ZWx5
IHlvdSBhcmUgY29ycmVjdCwgIGJ1dCBjdXJyZW50bHkgaXQgaXMgdmVyeSBoYXJkIHRvIGhpdCB0
aGUgaXNzdWUgaW4gcmVhbCBsaWZlLg0KVGhlIHBhdGNoIGlzIGNvbWluZy4gDQpUaGFua3MNClRv
bWFzDQoNCg0KPiANCj4gSEksIGFsbA0KPiBXaGVuIHJldmlld2luZyBmdW5jdGlvbiBtZWlfbWVf
Y2xfcm1fYnlfdXVpZO+8jCBJIG5vdGljZSB0aGF0IGZ1bmN0aW9uDQo+IF9fbWVpX21lX2NsX2J5
X3V1aWQgaW5jcmVhc2VzIG1lX2NsIHJlZmNvdW50IGFuZCBmdW5jdGlvbiBfbWVpX21lX2NsX2Rl
bA0KPiBkZWxldGUgYSBsaXN0IG5vZGUgd2l0aCBkZWNyZW1lbnQgbWVfY2wgcmVmY291bnQgLCBh
Y3R1YWxseSBoZXJlIGNhdXNlIGENCj4gcmVmY291bnQgbGVhayBhcyB3ZSBoYXZlbid0IHJlbGVh
c2UgdGhlIHJlZmNvdW50IGJ5IF9fbWVpX21lX2NsX2J5X3V1aWQgID8NCj4gc2ltaWxhciBpc3N1
ZSBoYXBwZW5zIGluIG1laV9tZV9jbF9ybV9ieV91dWlkX2lkIHRvby4NCj4gDQo+IHZvaWQgbWVp
X21lX2NsX3JtX2J5X3V1aWQoc3RydWN0IG1laV9kZXZpY2UgKmRldiwgY29uc3QgdXVpZF9sZSAq
dXVpZCkgew0KPiAgICAgc3RydWN0IG1laV9tZV9jbGllbnQgKm1lX2NsOw0KPiANCj4gICAgIGRl
dl9kYmcoZGV2LT5kZXYsICJyZW1vdmUgJXBVbFxuIiwgdXVpZCk7DQo+IA0KPiAgICAgZG93bl93
cml0ZSgmZGV2LT5tZV9jbGllbnRzX3J3c2VtKTsNCj4gICAgIG1lX2NsID0gX19tZWlfbWVfY2xf
YnlfdXVpZChkZXYsIHV1aWQpOyAvKiBpbmNyZWFzZSBhIHJlZmNvdW50ICovDQo+ICAgICBfX21l
aV9tZV9jbF9kZWwoZGV2LCBtZV9jbCk7IC8qIHJlbGVhc2UgdGhlIHJlZmNvdW50IHdpdGggYSBs
aXN0IG5vZGUgZGV0ZWxlZA0KPiAqLw0KPiAgICAgdXBfd3JpdGUoJmRldi0+bWVfY2xpZW50c19y
d3NlbSk7DQo+IH0NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gDQo+IExpbiBZaS4NCg==
