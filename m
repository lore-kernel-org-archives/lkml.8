Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAFDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AAC207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgA0Rff convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:35:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:56628 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgA0Rff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 09:35:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,370,1574150400"; 
   d="scan'208";a="401394432"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2020 09:35:34 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Jan 2020 09:35:34 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.4]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.118]) with mapi id 14.03.0439.000;
 Mon, 27 Jan 2020 09:35:34 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v15] x86/split_lock: Enable split lock detection by
 kernel
Thread-Topic: [PATCH v15] x86/split_lock: Enable split lock detection by
 kernel
Thread-Index: AQHV0ynJ1/MagQqLD0a5ZArbKBEXmKf8a7KA//+AyICAAsQPgIAAGKGg
Date:   Mon, 27 Jan 2020 17:35:33 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F54F399@ORSMSX114.amr.corp.intel.com>
References: <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125212524.GA538225@rani.riverdale.lan>
 <20200125215003.GB17914@agluck-desk2.amr.corp.intel.com>
 <20200127080419.GG14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200127080419.GG14914@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you found any actual bad software ? The only way I could trigger
> was by explicitly writing a program to tickle it.

No application or library issues found so far (though I'm not running the kind of multi-threaded
applications that might be using atomic operations for synchronization).

Only Linux kernel seems to have APIs that make it easy for programmers to accidently split
an atomic operation between cache lines.

-Tony
