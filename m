Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5AEC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 23:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7536207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 23:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbgAOXsR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 18:48:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:29451 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbgAOXsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 18:48:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 15:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="225768893"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2020 15:48:16 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.94]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.58]) with mapi id 14.03.0439.000;
 Wed, 15 Jan 2020 15:48:16 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v11] x86/split_lock: Enable split lock detection by
 kernel
Thread-Topic: [PATCH v11] x86/split_lock: Enable split lock detection by
 kernel
Thread-Index: AQHVx+uK8yhbkFdMCUil9IyDWo661KfqNK6AgAIhjACAAI5YAP//h3yQ
Date:   Wed, 15 Jan 2020 23:48:15 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F52799E@ORSMSX115.amr.corp.intel.com>
References: <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
In-Reply-To: <20200115225724.GA18268@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> All comments accepted and code changed ... except for these three:
>
> Sounds like you're also writing code, in which case you should give
> yourself credit with your own Co-developed-by: tag.

I just fixed some typos in PeterZ's untested example patch. Now changed
a few names as per your suggestions. I don't' really think of that as "writing code".

-Tony
