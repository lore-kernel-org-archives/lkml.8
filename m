Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE80C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15BC20731
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgD1VAb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:52856 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgD1U7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:59:48 -0400
IronPort-SDR: +oi8F2jbF+Rn0XZkvLUX/fhZtGUKUmPLgSCP0jAITkSNzpG90qKXS2mdyFI2+k49efZWjcd8fD
 sniB3Gn6i83Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 13:59:45 -0700
IronPort-SDR: +Q8PjyVutkue3EcjsUEaFZlOavwMvvK+V+3ei0OrSYFlhTsGbOvqnexFpbIZZpuVkMvs1zSr4N
 AbzGg5ky6H6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="246628978"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga007.jf.intel.com with ESMTP; 28 Apr 2020 13:59:44 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Apr 2020 13:59:44 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.34]) with mapi id 14.03.0439.000;
 Tue, 28 Apr 2020 13:59:44 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 5/7] x86/mmu: Allocate/free PASID
Thread-Topic: [PATCH 5/7] x86/mmu: Allocate/free PASID
Thread-Index: AQHWBtMgRqn1rM/ldEi9589O6eqhDKiMHSGAgANeKoCAAAkqgP//jPrQgACRMQD//44esA==
Date:   Tue, 28 Apr 2020 20:59:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F608EE2@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
        <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
        <87pnbus3du.fsf@nanos.tec.linutronix.de>        <20200428112113.000033bd@intel.com>
        <87tv13o306.fsf@nanos.tec.linutronix.de>
        <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
 <20200428134200.000010f7@intel.com>
In-Reply-To: <20200428134200.000010f7@intel.com>
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

>> So the driver needs to use flush/drain operations to make sure all
>> the in-flight work has completed before releasing/re-using the PASID.
>> 
> Are you suggesting we should let driver also hold a reference of the
> PASID?

The sequence for bare metal is:

	process is queuing requests to DSA
	process exits (either deliberately, or crashes, or is killed)
	kernel does exit processing
	DSA driver is called as part of tear down of "mm"
		issues drain/flush commands to ensure that all
		queued operations on the PASID for this mm have
		completed
	PASID can be freed

There's a 1:1 map from "mm" to PASID ... so reference counting seems
like overkill. Once the kernel is in the "exit" path, we know that no more
work can be queued using this PASID.

-Tony
