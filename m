Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91586C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5469F21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIJTom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:44:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:61723 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgIJTob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:44:31 -0400
IronPort-SDR: up2Zt1S+KO8/ijMyd710d+XalpTdhxe009YVvNBM+wEOFczNWBihcBFz7RHpRUtcqa7o0flhPz
 rxsz1CQXsC4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="159570521"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="159570521"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 12:43:25 -0700
IronPort-SDR: 1MY6NQYWqDmoajSb/kWucqFNMKgN7RXxaE2wq1XlQJCWzJ2WJDL6Ipu8rNCPYEhhro8msbdifR
 PLKwaq82S+dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="337261307"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 10 Sep 2020 12:43:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Sep 2020 12:43:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Sep 2020 12:43:24 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 10 Sep 2020 12:43:24 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Thread-Topic: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Thread-Index: AQHWhJO//P+iwgKS2UiBIpgzPJKyq6ldm5KAgAFakgCAAAYWgP//3EBAgAB8VICAAVCYAP///VsAgACR+ICAAXgPgP//jjwAAA8aWgAADRoRUA==
Date:   Thu, 10 Sep 2020 19:43:24 +0000
Message-ID: <490a2e08d9024732a94844b420d858a3@intel.com>
References: <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic> <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com> <20200908152539.GE25236@zn.tnic>
 <20200909113022.GA12237@zn.tnic>
 <20200909182051.GA31883@agluck-desk2.amr.corp.intel.com>
 <20200909200321.GG12237@zn.tnic> <20200910182901.GK8357@zn.tnic>
 <20200910184206.GA17305@agluck-desk2.amr.corp.intel.com>
 <20200910185434.GM8357@zn.tnic>
In-Reply-To: <20200910185434.GM8357@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDb25zaWRlcmluZyBob3cgdGhpcyBzaXR1YXRpb24gaXMgc3VwcG9zZWQgdG8gYWxtb3N0IG5l
dmVyIGhhcHBlbiBhbmQNCj4gaG93IHdlJ3JlIGFjdHVhbGx5IGludGVyZXN0ZWQgaW4gdGhlIGZp
cnN0IGxpbmUgb2YgdGhlIHdob2xlIHNwbGF0IEkNCj4gcGFzdGVkLCBob3cgbXVjaCBvdXRwdXQg
Y29tZXMgYWZ0ZXIgaXQsIGRvZXNuJ3QgcmVhbGx5IG1hdHRlci4gQWxsIGl0DQo+IG1hdHRlcnMg
aXMgdGhhdCB0aGUgbWFjaGluZSBzdG9wcyBhbnkgZnVydGhlciBwcm9ncmVzcyAoYXMgbXVjaCBh
cyB3ZQ0KPiBjYW4gZG8gdGhhdCB3aXRoIGEgcGFuaWMsIG9mYykuDQoNCkl0IHdvdWxkIGJlIGEg
Im5pY2UgdG8gaGF2ZSIgLi4uIGJlY2F1c2UgYWxsIHRoYXQgZXh0cmEgbm9pc2UgcHVzaGVkIHRo
ZQ0KdXNlZnVsIGxpbmUgb2ZmIHRoZSB0b3Agb2YgdGhlIHNjcmVlbi4gRm9yIGFueW9uZSB3aXRo
IGEgc2VyaWFsIGNvbnNvbGUNCml04oCZcyBhIG5vbi1pc3N1ZS4gQnV0IHNpbmNlIHRoaXMgaXMg
YSAic2hvdWxkIG5ldmVyIGhhcHBlbiIgY2FzZSBpdCBpc24ndA0Kd29ydGggY3JlYXRpbmcgYSBj
b21wbGV4IGJ1bmNoIG9mIGluZnJhc3RydWN0dXJlLg0KDQpZb3UgY2FuIHNsYXAgYToNCg0KUmV2
aWV3ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCg0Kb24gaXQgd2hlbiB5
b3UgcHVzaCBpbnRvIEdJVC4NCg0KLVRvbnkNCg==
