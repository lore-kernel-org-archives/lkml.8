Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1F2C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E56822C9F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgIHPME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:12:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:58732 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgIHPKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:00 -0400
IronPort-SDR: WQH9BmJzFhS9qW0rnAl/oPAPWZAZ/7L+eurf4onopKeBD3S5Yjc7a7XTPq1fx7wdX0l7zMG5k6
 Zqd1dgLIb/pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="158171222"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="158171222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 08:07:06 -0700
IronPort-SDR: AfqRmojd3nb36t5hFsXIz7KBVGkKhWqlZaMS5OkoroCrTyLhrwgsOAy0BAWDB81S4P6lejvlSl
 2fEGD38B2nDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="304121518"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2020 08:07:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Sep 2020 08:07:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Sep 2020 08:07:05 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Tue, 8 Sep 2020 08:07:05 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Thread-Topic: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Thread-Index: AQHWhJO//P+iwgKS2UiBIpgzPJKyq6ldm5KAgAFakgCAAAYWgP//3EBA
Date:   Tue, 8 Sep 2020 15:07:05 +0000
Message-ID: <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic> <20200908100837.GC25236@zn.tnic>
In-Reply-To: <20200908100837.GC25236@zn.tnic>
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

PiBPaywgc28gSSB0aGluayB0aGlzIGlzIHdoYXQgQW5keSBtZWFudCBsYXN0IG5pZ2h0IGFuZCBQ
ZXRlcloganVzdA0KPiBzdWdnZXN0ZWQgaXQgdG9vOg0KPg0KPiBXZSBkbyBhOg0KPg0KPgkgX0FT
TV9FWFRBQkxFX0hBTkRMRSgxYiwgMmIsIGV4X2hhbmRsZXJfcGFuaWMpDQo+DQo+IHdoaWNoIHBh
bmljcyBzdHJhaWdodCBpbiB0aGUgI0dQIGhhbmRsZXIgYW5kIGF2b2lkcyB0aGUgSVJFVC4NCg0K
V2UgY2FuIGV2ZW4gZ2V0IGEgbmljZSBkaWFnbm9zdGljIG1lc3NhZ2Ugc2luY2UgdGhlIGhhbmRs
ZXINCmhhcyBhY2Nlc3MgdG8gInJlZ3MiLiBJdCBjYW4gcHJpbnQgd2hpY2ggTVNSIChyZWdzLT5j
eCkgYW5kDQp3aGVyZSBpdCBoYXBwZW5lZCAocmVncy0+aXApLg0KDQpXaGljaCBzb3VuZHMgbGlr
ZSB5b3UgbWlnaHQgd2FudCBhIHNwZWNpZmljIGV4X2hhbmRsZXJfcmRtc3INCmZ1bmN0aW9uIHJh
dGhlciB0aGFuIGEgZ2VuZXJpYyBleF9oYW5kbGVyX3BhbmljLg0KDQpNYXliZSBzYW1lIGRlYWwg
Zm9yIHdybXNyKCkgdG9vPyBUaGF0IHdvdWxkIGFsc28gcHJpbnQgZWR4OmVheA0Kc28geW91IGNv
dWxkIHNlZSB3aGF0IHdhcyBiZWluZyB3cml0dGVuLg0KDQotVG9ueQ0K
