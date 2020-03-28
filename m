Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D04C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BA2206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgC1Qe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:34:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:12234 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgC1Qe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:34:27 -0400
IronPort-SDR: orbZV7QBgR7WzE5YPzsUd7z9koO0JahDhJSPUNc+3O5zMqW+FgDHkVDQPHuy6IZCeFALXfXh73
 RGHmLz94GFXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 09:34:27 -0700
IronPort-SDR: NOomLfMqmv3XJpR5yYFp666TQj4HYJ8dXhBa4qBDgWpZDHdxT+x04ZKQzK6P35WMYDo6QjPvJn
 EWkljLlEOJ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447769875"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 09:34:12 -0700
Date:   Sat, 28 Mar 2020 09:34:12 -0700
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
Message-ID: <20200328163412.GJ8104@linux.intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200325030924.132881-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325030924.132881-3-xiaoyao.li@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:09:24AM +0800, Xiaoyao Li wrote:
> In a context switch from a task that is detecting split locks
> to one that is not (or vice versa) we need to update the TEST_CTRL
> MSR. Currently this is done with the common sequence:
> 	read the MSR
> 	flip the bit
> 	write the MSR
> in order to avoid changing the value of any reserved bits in the MSR.
> 
> Cache unused and reserved bits of TEST_CTRL MSR with SPLIT_LOCK_DETECT
> bit cleared during initialization, so we can avoid an expensive RDMSR
> instruction during context switch.
> 
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Originally-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index deb5c42c2089..1f414578899c 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -45,6 +45,7 @@ enum split_lock_detect_state {
>   * split lock detect, unless there is a command line override.
>   */
>  static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
> +static u64 msr_test_ctrl_cache __ro_after_init;

What about using "msr_test_ctrl_base_value", or something along those lines?
"cache" doesn't make it clear that SPLIT_LOCK_DETECT is guaranteed to be
zero in this variable.

>  
>  /*
>   * Processors which have self-snooping capability can handle conflicting
> @@ -1037,6 +1038,8 @@ static void __init split_lock_setup(void)
>  		break;
>  	}
>  
> +	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);

If we're going to bother skipping the RDMSR if state=sld_off on the command
line then it also makes sense to skip it if enabling fails, i.e. move this
below split_lock_verify_msr(true).

> +
>  	if (!split_lock_verify_msr(true)) {
>  		pr_info("MSR access failed: Disabled\n");
>  		return;
> @@ -1053,14 +1056,10 @@ static void __init split_lock_setup(void)
>   */
>  static void sld_update_msr(bool on)
>  {
> -	u64 test_ctrl_val;
> -
> -	rdmsrl(MSR_TEST_CTRL, test_ctrl_val);
> +	u64 test_ctrl_val = msr_test_ctrl_cache;
>  
>  	if (on)
>  		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> -	else
> -		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>  
>  	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
>  }
> -- 
> 2.20.1
> 
