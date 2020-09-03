Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346ADC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0523B2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgICRJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:09:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:60075 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgICRJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:09:46 -0400
IronPort-SDR: tGFYoe82qhsEbivYwuYO0T/NHCIJyHd+Uxf/FLrbZspc9PaLb/0eS9H0qcSPhuJisgpNHUxfZT
 th5RiSnZMlpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="155022006"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="155022006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 10:09:45 -0700
IronPort-SDR: gGuYiwrrQRmaO3d7/Ceq4OpaSGoGnDTPuNebiCLdG1ImUGl2bR29GayxVIW0+7tTomhUQNt8Se
 HywpdQoMhw/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="315542999"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2020 10:09:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 10:09:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 10:09:44 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 3 Sep 2020 10:09:44 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Song, Youquan" <youquan.song@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFD PATCH] x86/mce: Make sure to send SIGBUS even after losing
 the race to poison a page
Thread-Topic: [RFD PATCH] x86/mce: Make sure to send SIGBUS even after losing
 the race to poison a page
Thread-Index: AQHWfI+eQkmv7NwjjUqJC+ckWny3zalXokkA//+MysA=
Date:   Thu, 3 Sep 2020 17:09:43 +0000
Message-ID: <38de4f009d3248f7bc7c99f29d34ac8a@intel.com>
References: <20200827163205.23096-1-tony.luck@intel.com>
 <20200903165530.GE5462@zn.tnic>
In-Reply-To: <20200903165530.GE5462@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMZXQncyBzZWUgaWYgdGhhdCBsb2dpYyBtYWtlcyBzZW5zZTogaWYgI01DIG9mZmxpbmVzIHRo
ZSBwYWdlIGFuZCBzZW5kcw0KPiBTSUdCVVMgYnV0IENNQ0kgb25seSBvZmZsaW5lcyB0aGUgcGFn
ZSwgaXNuJ3QgaXQgb25seSBsb2dpY2FsIGZvciB0aGUNCj4gQ01DSSB0byAqYWxzbyogc2VuZCB0
aGUgU0lHQlVTIHRvbywgYWZ0ZXIgaGF2aW5nIG9mZmxpbmVkIHRoZSBwYWdlPw0KPg0KPiBJLmUu
LCBib3RoIHNob3VsZCBkbyB0aGUgcHJvcGVyIGFuZCBmdWxsIHJlY292ZXJ5IGFjdGlvbi4gSnVz
dCBzYXlpbi4uLg0KDQpJdCBtYWRlIHNlbnNlLCBhbmQgc2VlbWVkIHRvIGV4cGxhaW4gYW4gaXNz
dWUgSSB3YXMgc2VlaW5nLCB3aGVuIEkgd3JvdGUgaXQuDQpCdXQgc29tZSBzdHJlc3MgdGVzdGlu
ZyBvZiB0aGF0IHBhdGNoIHNob3dlZCB0aGF0IGl0IGludHJvZHVjZXMgc29tZSBwcm9ibGVtcw0K
YW5kIGluc3RhYmlsaXR5Lg0KDQpXaXRob3V0IHRoZSBwYXRjaCBJIGNhbiBpbmplY3QgMTAsMDAw
IGVycm9ycyBhbmQgaGF2ZSBldmVyeSBvbmUgb2YgdGhlbSBjb21wbGV0ZQ0KY29ycmVjdGx5IChw
cm9jZXNzIGdldHMgYSBTSUdCVVMgd2l0aCB0aGUgYWRkcmVzcyBvZiB0aGUgZXJyb3IpLiBXaXRo
IG15IHBhdGNoDQphcm91bmQgMC40JSBvZiBpbmplY3Rpb25zIGZhaWwgdG8gcHJvdmlkZSB0aGUg
YWRkcmVzcyB0byB0aGUgU0lHQlVTIGhhbmRsZXIsIHdvcnNlDQp0aGUgdGVzdCBnZXRzIGEgZmF0
YWwgZXJyb3IgZXZlcnkgNjAwLTcwMCBpbmplY3Rpb25zLg0KDQpTbywgSSdtIGFiYW5kb25pbmcg
dGhhdCBwYXRjaC4NCg0KLVRvbnkNCg==
