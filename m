Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886DBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C60206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgC3SST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:18:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:34687 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3SSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:18:18 -0400
IronPort-SDR: joF6WDlCLRRK9NNzG1tYDp8qMrSmjpLGCUu5W5KoD1INXh4inMqNZMBFcNe04hkUFBDPabmAQ+
 dsY6dtM4Yucg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 11:18:18 -0700
IronPort-SDR: WmN/SopwCkB+jXOVQA/B2L9XXeMO6v9/7PwXugU1SMzx48q8SClGyKBFZH3pFWjHwYN3onQ0z5
 cr7q3nWvJP4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="267005886"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2020 11:18:18 -0700
Date:   Mon, 30 Mar 2020 11:18:17 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v7 2/2] x86/split_lock: Avoid runtime reads of the
 TEST_CTRL MSR
Message-ID: <20200330181817.GH24988@linux.intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200325030924.132881-3-xiaoyao.li@intel.com>
 <20200328163412.GJ8104@linux.intel.com>
 <e641c746-0dde-cfb8-ea23-45c011174b08@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e641c746-0dde-cfb8-ea23-45c011174b08@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 05:13:23PM +0800, Xiaoyao Li wrote:
> On 3/29/2020 12:34 AM, Sean Christopherson wrote:
> >On Wed, Mar 25, 2020 at 11:09:24AM +0800, Xiaoyao Li wrote:
> >>In a context switch from a task that is detecting split locks
> >>to one that is not (or vice versa) we need to update the TEST_CTRL
> >>MSR. Currently this is done with the common sequence:
> >>	read the MSR
> >>	flip the bit
> >>	write the MSR
> >>in order to avoid changing the value of any reserved bits in the MSR.
> >>
> >>Cache unused and reserved bits of TEST_CTRL MSR with SPLIT_LOCK_DETECT
> >>bit cleared during initialization, so we can avoid an expensive RDMSR
> >>instruction during context switch.
> >>
> >>Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >>Originally-by: Tony Luck <tony.luck@intel.com>
> >>Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >>---
> >>  arch/x86/kernel/cpu/intel.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >>diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> >>index deb5c42c2089..1f414578899c 100644
> >>--- a/arch/x86/kernel/cpu/intel.c
> >>+++ b/arch/x86/kernel/cpu/intel.c
> >>@@ -45,6 +45,7 @@ enum split_lock_detect_state {
> >>   * split lock detect, unless there is a command line override.
> >>   */
> >>  static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
> >>+static u64 msr_test_ctrl_cache __ro_after_init;
> >
> >What about using "msr_test_ctrl_base_value", or something along those lines?
> >"cache" doesn't make it clear that SPLIT_LOCK_DETECT is guaranteed to be
> >zero in this variable.
> >
> >>  /*
> >>   * Processors which have self-snooping capability can handle conflicting
> >>@@ -1037,6 +1038,8 @@ static void __init split_lock_setup(void)
> >>  		break;
> >>  	}
> >>+	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
> >
> >If we're going to bother skipping the RDMSR if state=sld_off on the command
> >line then it also makes sense to skip it if enabling fails, i.e. move this
> >below split_lock_verify_msr(true).
> 
> OK.
> 
> Then, the sld bit is 1 for msr_test_ctrl_base_value. Do you think
> "msr_test_ctrl_base_value" still make sense?

Ah, I missed that (obviously).  An alternative (to keeping the rdmsr() where
it is) would be to explicitly clear SLD in the base value after the rdmsr().
That'd double as documentation of what is stored in msr_test_ctrl_base_value.

But, the location of rdmsr() is a nit, it can certainly stay where it is if
someone else has a strong preference.

> or we keep the "else" branch in sld_update_msr() to not rely on the sld bit
> in the base_value?

IMO it's better to have SLD=0 in the base value, regardless of how we make
that happen.

> >>+
> >>  	if (!split_lock_verify_msr(true)) {
> >>  		pr_info("MSR access failed: Disabled\n");
> >>  		return;
> >>@@ -1053,14 +1056,10 @@ static void __init split_lock_setup(void)
> >>   */
> >>  static void sld_update_msr(bool on)
> >>  {
> >>-	u64 test_ctrl_val;
> >>-
> >>-	rdmsrl(MSR_TEST_CTRL, test_ctrl_val);
> >>+	u64 test_ctrl_val = msr_test_ctrl_cache;
> >>  	if (on)
> >>  		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> >>-	else
> >>-		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> >>  	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
> >>  }
> >>-- 
> >>2.20.1
> >>
> 
