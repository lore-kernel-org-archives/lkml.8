Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C30CC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2DF20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBCUl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:41:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:58355 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgBCUl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:41:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 12:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="310831201"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2020 12:41:55 -0800
Date:   Mon, 3 Feb 2020 12:41:55 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v17] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200203204155.GE19638@linux.intel.com>
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
 <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com>
 <8CC9FBA7-D464-4E58-8912-3E14A751D243@gmail.com>
 <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 12:05:35PM -0800, Luck, Tony wrote:
> +/*
> + * Locking is not required at the moment because only bit 29 of this
> + * MSR is implemented and locking would not prevent that the operation
> + * of one thread is immediately undone by the sibling thread.
> + * Use the "safe" versions of rdmsr/wrmsr here because although code
> + * checks CPUID and MSR bits to make sure the TEST_CTRL MSR should
> + * exist, there may be glitches in virtualization that leave a guest
> + * with an incorrect view of real h/w capabilities.
> + */
> +static bool __sld_msr_set(bool on)
> +{
> +	u64 test_ctrl_val;
> +
> +	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
> +		return false;

How about caching the MSR value on a per-{cpu/core} basis at boot to avoid
the RDMSR when switching to/from from a misbehaving tasks?  E.g. to avoid
penalizing well-behaved tasks any more than necessary.

We've likely got bigger issues if MSR_TEST_CTL is being written by BIOS
at runtime, even if the writes were limited to synchronous calls from the
kernel.

Probably makes sense to split the MSR's init sequence and runtime sequence,
e.g. to also use an unsafe wrmsrl() at runtime so that an unexpected #GP
generates a WARN.

> +
> +	if (on)
> +		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +	else
> +		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +
> +	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);
> +}
