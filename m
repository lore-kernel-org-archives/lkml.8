Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA0FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D2A2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHYRgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:36:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:49398 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHYRgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:36:00 -0400
IronPort-SDR: 2TTSuPl76RP6A8avMTfGnfq1e21BsS70aNQEU1lxzNh3VC9N2J5EAQh1LNiw8Jlf8Mkk0V8SWc
 P09B0Gh5PBgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156156000"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="156156000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:35:59 -0700
IronPort-SDR: i++aEhxC93hp5FRAZKq2sE51+wKkC4DoHR88XqEw37wTGCMIQbNkw82h/F1iyW67sMrfk/oib1
 UsxXhbQr1FFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="280045164"
Received: from unknown (HELO fmsmsx606.amr.corp.intel.com) ([10.18.84.216])
  by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2020 10:35:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Aug 2020 10:35:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Aug 2020 10:35:30 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Tue, 25 Aug 2020 10:35:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tom Lendacky" <thomas.lendacky@amd.com>, Pu Wen <puwen@hygon.cn>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Dirk Hohndel <dirkhh@vmware.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Gordon Tetlow <gordon@tetlows.org>,
        David Kaplan <David.Kaplan@amd.com>
Subject: RE: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
Thread-Topic: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
Thread-Index: AQHWepnN5CwxwmBahk+tjye5jNDIMqlJf26A//+V8lKAAADkcA==
Date:   Tue, 25 Aug 2020 17:35:29 +0000
Message-ID: <dfce335fefe043868301bacf57120759@intel.com>
References: <875z98jkof.fsf@nanos.tec.linutronix.de>
 <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice>
 <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
 <20200825171903.GA20660@sjchrist-ice>
 <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
In-Reply-To: <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
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

PiA+IE9yIG1hbGljaW91cyBoeXBlcnZpc29yIGFjdGlvbiwgYW5kIHRoYXQncyBhIHByb2JsZW0u
DQo+ID4NCj4gPiBTdXBwb3NlIHRoZSBoeXBlcnZpc29yIHJlbWFwcyBhIEdQQSB1c2VkIGluIHRo
ZSBTWVNDQUxMIGdhcCAoZS5nLiB0aGUNCj4gPiBhY3R1YWwgU1lTQ0FMTCB0ZXh0IG9yIHRoZSBm
aXJzdCBtZW1vcnkgaXQgYWNjZXNzZXMgLS0gSSBkb24ndCBoYXZlIGENCj4gPiBURFggc3BlYyBz
byBJIGRvbid0IGtub3cgdGhlIGRldGFpbHMpLg0KDQpJcyBpdCBmZWFzaWJsZSB0byBkZWZlbmQg
YWdhaW5zdCBhIG1hbGljaW91cyAob3IgYnVnZ3kpIGh5cGVydmlzb3I/DQoNCk9idmlvdXNseSwg
d2UgY2FuJ3QgbGVhdmUgaG9sZXMgdGhhdCBndWVzdHMgY2FuIGV4cGxvaXQuIEJ1dCB0aGUgaHlw
ZXJ2aXNvcg0KY2FuIGNyYXNoIHRoZSBzeXN0ZW0gbm8gbWF0dGVyIGhvdyBjbGV2ZXIgVERYIGlz
Lg0KDQotVG9ueQ0K
