Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F169C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D06207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFPWdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:33:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:4824 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgFPWdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:33:15 -0400
IronPort-SDR: eBr5v0EAVXTpOAhCJkSoA1H34ljg/no26nM4pT2P0aXukbU3oArgQTSdUSGojXrTZ1qa/6N+gS
 xBAkdMKNiVWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 15:33:11 -0700
IronPort-SDR: PNcBUThGFycdjV+/SWUtekmQ67FLB+yb8hznoVaXuhlfBJvcZJ2RosEQiHAt5Qg9Z5hqr1a5PG
 EsTVkfOvaeIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="261553638"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2020 15:33:11 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.15]) with mapi id 14.03.0439.000;
 Tue, 16 Jun 2020 15:33:09 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Thread-Topic: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Thread-Index: AQHWQ0SCA5kjS+7JBUOWMLjM6bzzzajcF9MA//+7vzA=
Date:   Tue, 16 Jun 2020 22:33:08 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F670974@ORSMSX115.amr.corp.intel.com>
References: <20200615184056.26531-1-tony.luck@intel.com>
 <20200616192952.GO13515@zn.tnic>
In-Reply-To: <20200616192952.GO13515@zn.tnic>
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

PiBUd28gdGhpbmdzOiBjYW4gdGhhdCBlcnJvciB0eXBlIGJlIGRldGVjdGVkIHdoZW4gI01DIGdl
dHMgcmFpc2VkLCBpLmUuLCBpbg0KPiBkb19tYWNoaW5lX2NoZWNrKCkgYXMgcGFydCBvZiBzY2Fu
bmluZyBhbGwgYmFua3M/DQoNCklmIHRoZSBCSU9TIG9wdGlvbiBpcyBsZWZ0IGluIHRoZSBkZWZh
dWx0IHNldHRpbmcsIHVuY29ycmVjdGFibGUgZXJyb3JzIGZvdW5kDQpieSB0aGUgcGF0cm9sIHNj
cnViYmVyIGFyZSByZXBvcnRlZCB3aXRoIGEgbWFjaGluZSBjaGVjay4gVGhvc2UgTVNDT0QNCmFu
ZCBNQ0FDT0Qgc2lnbmF0dXJlcyBhcmUgdGhlIHNhbWUgLi4uIGJ1dCB0aGF0J3Mgbm90IGltcG9y
dGFudCBiZWNhdXNlDQpNQ2lfU1RBVFVTLlVDPT0xLiBTbyBMaW51eCBkb2Vzbid0IG5lZWQgdG8g
anVtcCB0aHJvdWdoIGhvb3BzIHRvDQoidXBncmFkZSIgdGhlIHNldmVyaXR5Lg0KDQo+IElmIHNv
LCB0aGVuIHRoZSBhZGp1c3RpbmcgbmVlZHMgdG8gaGFwcGVuIGluc2lkZSBtY2VfbG9nKCkuDQpT
byBubywgdGhpcyBhZGp1c3Qgb25seSBuZWVkcyB0byBoYXBwZW4gd2hlbiBwb2xsaW5nIHRoZSBi
YW5rcyBmcm9tDQpDTUNJIG9yIHBlcmlvZGljIHRpbWVyLg0KDQo+IEFsc28sIHRoYXQgYXNzaWdu
bWVudCB0byB0aGUgZnVuY3Rpb24gcG9pbnRlciBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZSB0bw0K
PiBtZSBhbmQgSSB0aGluayB5b3Ugc2hvdWxkIGRvIHRoZSB2ZW5kb3IvZmFtaWx5L21vZGVsIGNo
ZWNraW5nIHN0cmFpZ2h0DQo+IGluIGEgZnVuY3Rpb24gYWRqdXN0X21jZV9sb2coKSB3aGljaCBn
ZXRzIGNhbGxlZCBieSB3aG9ldmVyLi4uDQoNClRoZSBwb2ludCB3YXMgdG8gYXZvaWQgdGhlIHJ1
bnRpbWUgdGVzdCBmb3IgQ1BVIG1vZGVsIG9uIGV2ZXJ5IGVycm9yLiBCdXQNCnRoaXMgaXNuJ3Qg
YSBwZXJmb3JtYW5jZSBjcml0aWNhbCBwYXRoLCBzbyB3ZSBjYW4gcmVmYWN0b3IgaWYgeW91IHRo
aW5rIHRoYXQNCmxvb2tzIGNsZWFuZXIuDQoNClRoZXJlIGlzIHNvbWUgbmV3IHNldCBvZiB2YWxp
ZGF0aW9uIHRlc3RzIHJ1bm5pbmcgbm93IHRvIGNoZWNrIHRoZSBlZmZlY3RpdmVuZXNzDQpvZiB0
aGlzIEJJT1MgKyBPUyBjaGFuZ2UuIFNvIGl0IG1heSBiZSBhIHdoaWxlIGJlZm9yZSB1cGRhdGVk
IHZlcnNpb24gaXMNCnBvc3RlZC4NCg0KVGhhbmtzDQoNCi1Ub255DQo=
