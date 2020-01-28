Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFA0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7172214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgA1UlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:41:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:31542 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgA1UlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:41:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 12:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,375,1574150400"; 
   d="scan'208";a="223638691"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2020 12:41:10 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jan 2020 12:41:10 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.4]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.118]) with mapi id 14.03.0439.000;
 Tue, 28 Jan 2020 12:41:10 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [GIT PULL] x86/asm changes for v5.6
Thread-Topic: [GIT PULL] x86/asm changes for v5.6
Thread-Index: AQHV1hR24Va6gTcx002JOO6KwFcGqagBBuqA//+C0/A=
Date:   Tue, 28 Jan 2020 20:41:10 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5517F9@ORSMSX114.amr.corp.intel.com>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJbiBwYXJ0aWN1bGFyLCBJIGRpZG4ndCBjaGVjayB3aGF0IHRoZSBwcmlvcml0eSBmb3IgdGhl
IGFsdGVybmF0aXZlcw0KPiBpcy4gU2luY2UgRlNSTSBiZWluZyBzZXQgYWx3YXlzIGltcGxpZXMg
RVJNUyBiZWluZyBzZXQgdG9vLCBpdCBtYXkgYmUNCj4gdGhhdCB0aGUgRVJNUyBjYXNlIGlzIGFs
d2F5cyBwaWNrZWQgd2l0aCB0aGUgYWJvdmUgY29kZS4NCg0KSXMgdGhlcmUgc3RpbGwgc29tZSBl
YXN5IHdheSB0byBnZXQgZ2RiIHRvIGRpc2Fzc2VtYmxlIGZyb20gL2Rldi9rbWVtDQp0byBzZWUg
d2hhdCB3ZSBlbmRlZCB1cCB3aXRoIGFmdGVyIGFsbCB0aGUgcGF0Y2hpbmc/ICBXaXRoIGFkZHJl
c3Mgc3BhY2UNCnJhbmRvbWl6YXRpb24gYW5kIG90aGVyIHNlY3VyaXR5IGJpdHMgSSdtIG5vdCBj
ZXJ0YWluIHdoYXQgc3RpbGwgd29ya3MuDQoNCi1Ub255DQo=
