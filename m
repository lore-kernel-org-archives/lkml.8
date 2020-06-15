Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8575EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A69E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbgFORLF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:11:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:16214 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFORLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:11:04 -0400
IronPort-SDR: 0qn1lHL521TMRPY7Qzi0cyXpzweXZ/rsDFt8UH+tV1tzfiuA6T77evzGkLyRVUOilaX62ewbCE
 LvWSnnenG4Dg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 10:11:04 -0700
IronPort-SDR: RVNXESVvO6FWtMErjyjWNKs0+yP0qEGVpzaS46AsbhzCxBJ4pgFxBRHP0UsFn0BSa/WFZhIvwg
 gS0bY/MY5b0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="449468052"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2020 10:11:03 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 10:11:03 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.61]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 10:11:03 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Topic: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Index: AQHWQRt0fMmHYsE9aUKb3rSjyAIL46jZyC2AgACD5gCAAAQ1gP//m/aA
Date:   Mon, 15 Jun 2020 17:11:02 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F66C290@ORSMSX115.amr.corp.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
In-Reply-To: <20200615160357.GA2531@hirez.programming.kicks-ass.net>
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

>> The heuristic always initializes the MSR with the per mm PASID IIF the
>> mm has a valid PASID but the MSR doesn't have one. This heuristic usually
>> happens only once on the first #GP in a thread.
>
> But it doesn't guarantee the PASID is the right one. Suppose both the mm
> has a PASID and the MSR has a VALID one, but the MSR isn't the mm one.
> Then we NO-OP. So if the exception was due to us having the wrong PASID,
> we stuck.

ENQCMD only checks the 'valid' bit of the IA32_PASID MSR to decide whether
to #GP or not.  H/W has no concept of the "right" pasid value.

If IA32_PASID is valid with the wrong value ... then the system is about to
see some major corruption because the operations in the accelerator are
not going to translate to the physical addresses for pages owned by the process
that issued the ENQCMD.

-Tony
