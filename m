Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0821CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6C321835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAVUDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:03:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:48784 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVUDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:03:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 12:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="229481726"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2020 12:03:30 -0800
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jan 2020 12:03:29 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.4]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.111]) with mapi id 14.03.0439.000;
 Wed, 22 Jan 2020 12:03:29 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v12] x86/split_lock: Enable split lock detection by
 kernel
Thread-Topic: [PATCH v12] x86/split_lock: Enable split lock detection by
 kernel
Thread-Index: AQHV0VV7/XPb/EW8oEGwDJr5iFh+Caf3kN+A//+HzdA=
Date:   Wed, 22 Jan 2020 20:03:28 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5483E9@ORSMSX114.amr.corp.intel.com>
References: <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122190405.GA23947@zn.tnic>
In-Reply-To: <20200122190405.GA23947@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKyNkZWZpbmUgWDg2X0ZFQVRVUkVfU1BMSVRfTE9DS19ERVRFQ1QJKCA3KjMyKzMxKSAvKiAj
QUMgZm9yIHNwbGl0IGxvY2sgKi8NCj4NCj4gVGhhdCB3b3JkIGlzIGFscmVhZHkgZnVsbCBpbiB0
aXA6DQo+IC4uLg0KPiB1c2Ugd29yZCAxMSBpbnN0ZWFkLg0KDQpXaWxsIHJlYmFzZSBhZ2FpbnN0
IHRpcC9tYXN0ZXIgYW5kIG1vdmUgdG8gd29yZCAxMS4NCg0KPj4gKyNkZWZpbmUgTVNSX0lBMzJf
Q09SRV9DQVBBQklMSVRJRVMJCQkgIDB4MDAwMDAwY2YNCj4+ICsjZGVmaW5lIE1TUl9JQTMyX0NP
UkVfQ0FQQUJJTElUSUVTX1NQTElUX0xPQ0tfREVURUNUX0JJVCAgNQ0KPj4gKyNkZWZpbmUgTVNS
X0lBMzJfQ09SRV9DQVBBQklMSVRJRVNfU1BMSVRfTE9DS19ERVRFQ1QJICBCSVQoTVNSX0lBMzJf
Q09SRV9DQVBBQklMSVRJRVNfU1BMSVRfTE9DS19ERVRFQ1RfQklUKQ0KPg0KPiBBbnkgY2hhbmNl
IG1ha2luZyB0aG9zZSBzaG9ydGVyPw0KDQpJIGNvdWxkIGFiYnJldmlhdGUgQ0FQQUJJTElUSUVT
IGFzICJDQVAiLCB0aGF0IHdvdWxkIHNhdmUgOSBjaGFyYWN0ZXJzLiBJcyB0aGF0IGVub3VnaD8N
Cg0KSSdtIG5vdCBmb25kIG9mIHRoZSAicmVtb3ZlIHRoZSB2b3dlbHMiOiBTUExUX0xDS19EVENU
LCBidXQgdGhhdCBpcyBzb3J0IG9mIHJlYWRhYmxlDQphbmQgd291bGQgc2F2ZSA0IG1vcmUuIFdo
YXQgZG8geW91IHRoaW5rPw0KDQotVG9ueQ0K
