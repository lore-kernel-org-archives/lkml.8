Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BE7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140F02072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgCCTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:22:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:14655 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbgCCTWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:22:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 11:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="274348369"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2020 11:22:42 -0800
Date:   Tue, 3 Mar 2020 11:22:42 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH] x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR
Message-ID: <20200303192242.GU1439@linux.intel.com>
References: <20200206164614.GA20622@agluck-desk2.amr.corp.intel.com>
 <6735A646-3817-4030-B9B9-11492BB1B8F0@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6735A646-3817-4030-B9B9-11492BB1B8F0@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:37:04AM -0800, Andy Lutomirski wrote:
> 
> > On Feb 6, 2020, at 8:46 AM, Luck, Tony <tony.luck@intel.com> wrote:
> > 
> > ﻿On Wed, Feb 05, 2020 at 05:18:23PM -0800, Andy Lutomirski wrote:
> >>> On Wed, Feb 5, 2020 at 4:49 PM Luck, Tony <tony.luck@intel.com> wrote:
> >>> 
> >>> In a context switch from a task that is detecting split locks
> >>> to one that is not (or vice versa) we need to update the TEST_CTRL
> >>> MSR. Currently this is done with the common sequence:
> >>>        read the MSR
> >>>        flip the bit
> >>>        write the MSR
> >>> in order to avoid changing the value of any reserved bits in the MSR.
> >>> 
> >>> Cache the value of the TEST_CTRL MSR when we read it during initialization
> >>> so we can avoid an expensive RDMSR instruction during context switch.
> >> 
> >> If something else that is per-cpu-ish gets added to the MSR in the
> >> future, I will personally make fun of you for not making this percpu.
> > 
> > Xiaoyao Li has posted a version using a percpu cache value:
> > 
> > https://lore.kernel.org/r/20200206070412.17400-4-xiaoyao.li@intel.com
> > 
> > So take that if it makes you happier.  My patch only used the
> > cached value to store the state of the reserved bits in the MSR
> > and assumed those are the same for all cores.
> > 
> > Xiaoyao Li's version updates with what was most recently written
> > on each thread (but doesn't, and can't, make use of that because we
> > know that the other thread on the core may have changed the actual
> > value in the MSR).
> > 
> > If more bits are implemented that need to be set at run time, we
> > are likely up the proverbial creek. I'll see if I can find out if
> > there are plans for that.
> > 
> 
> I suppose that this whole thing is a giant mess, especially since at least
> one bit there is per-physical-core. Sigh.
> 
> So I don’t have a strong preference.

I'd prefer to go with this patch, i.e. not percpu, to remove the temptation
of incorrectly optimizing away toggling SPLIT_LOCK_DETECT.
