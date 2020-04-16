Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51433C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB0A221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgDPWdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:33:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:23491 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgDPWdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:33:39 -0400
IronPort-SDR: ZOYBONn5ScUjb8K/D8bnnJOsmL+E+51p0BI80HddWUf7qZBWaROup830+diCVVwqA+ZC8rK1T2
 PUy34mlwYoBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 15:33:37 -0700
IronPort-SDR: cMCGQzNBMi3msDP+2Z8eBi4EStoF0XaNSdJ11cJbV9O3PDaxyOnUYd2jVYPj21vAfT7AShKTbd
 8sdI9vdqvdfA==
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="428011991"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 15:33:36 -0700
Date:   Thu, 16 Apr 2020 15:33:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are
 not architectural
Message-ID: <20200416223335.GA23759@agluck-desk2.amr.corp.intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com>
 <20200416205754.21177-3-tony.luck@intel.com>
 <87eesnm6fc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eesnm6fc.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:06:47AM +0200, Thomas Gleixner wrote:
> Tony Luck <tony.luck@intel.com> writes:
> > Features enumerated by IA32_CORE_CAPABILITIES are model specific and
> > implementation details may vary in different cpu models. Thus it is only
> > safe to trust features after checking the CPU model.
> 
> What's the point of the IA32_CORE_CAPABILITIES check if we need a model
> match to figure out whether IA32_CORE_CAPABILITIES bit 5 is valid to
> enumerate split lock detection?
> 
> IOW, are we going to see CPUs which end up in the match list and have
> bit 5 cleared in IA32_CORE_CAPABILITIES?

There may be low-end SKUs of a model that don't have all the features of
the high-end SKUs. So yes, you may find that a specific SKU of a model
on the list for a feature doesn't have the feature.

A model specific feature may also have implementation differences
on different models.  E.g. if Intel were to produce a model that
did split lock "right" (with thread-scoped control). That would
still use the same bit in IA32_CORE_CAPABILITIES, but the OS would
need model specific knowledge to know that this split lock detect
worked differently from another model that has split lock detect.

-Tony
