Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42AF206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgFHRPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:15:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:48861 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbgFHRPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:15:54 -0400
IronPort-SDR: gAWpLZ+I4q30Dsls0kB+1m3LzFXASCITW2b/7PqijOm+ApWv89s3rZBRmazD13KMx72sHnhxw2
 P34cDpKZaibw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 10:15:53 -0700
IronPort-SDR: Z91BEZn8DNHF2So1W//NF7BVGaXUboKhiOB0zOH9S8UympcfdNTpKT1fc9e+CYetBwb428DVGy
 eOxpYbQfqgJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="472670632"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2020 10:15:52 -0700
Date:   Mon, 8 Jun 2020 10:15:52 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/split_lock: Sanitize userspace and guest error
 output
Message-ID: <20200608171552.GB8223@linux.intel.com>
References: <20200608122114.13043-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608122114.13043-1-prarit@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 08:21:14AM -0400, Prarit Bhargava wrote:
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 166d7c355896..e02ec81fe1eb 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1074,10 +1074,17 @@ static void split_lock_init(void)
>  	split_lock_verify_msr(sld_state != sld_off);
>  }
>  
> -static void split_lock_warn(unsigned long ip)
> +static bool split_lock_warn(unsigned long ip, int fatal_no_warn)
>  {
> -	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
> -			    current->comm, current->pid, ip);
> +	if (fatal_no_warn)
> +		return false;

This misses the point Xiaoyao was making.  If EFLAGS.AC=1 then the #AC is a
legacy alignment check fault and should not be treated as a split-lock #AC.
The basic premise of the patch makes sense, but the end result is confusing
because incorporating "fatal" and the EFLAGS.AC state into split_lock_warn()
bastardizes both the "split_lock" and "warn" aspects of the function.

E.g. something like this yields the same net effect, it's just organized
differently.  If so desired, the "bogus" message could be dropped via
Xiaoyao's prep patch[*] so that this change would only affect the sld_fatal
messages.

[*] https://lkml.kernel.org/r/20200509110542.8159-3-xiaoyao.li@intel.com


diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 23fd5f319908..1aad0b8e394c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1071,11 +1071,14 @@ static void split_lock_init(void)
        split_lock_verify_msr(sld_state != sld_off);
 }

-static void split_lock_warn(unsigned long ip)
+static bool handle_split_lock(unsigned long ip)
 {
        pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
                            current->comm, current->pid, ip);

+       if (sld_state != sld_warn)
+               return false;
+
        /*
         * Disable the split lock detection for this task so it can make
         * progress and set TIF_SLD so the detection is re-enabled via
@@ -1083,18 +1086,13 @@ static void split_lock_warn(unsigned long ip)
         */
        sld_update_msr(false);
        set_tsk_thread_flag(current, TIF_SLD);
+       return true;
 }

 bool handle_guest_split_lock(unsigned long ip)
 {
-       if (sld_state == sld_warn) {
-               split_lock_warn(ip);
+       if (handle_split_lock(ip))
                return true;
-       }
-
-       pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
-                    current->comm, current->pid,
-                    sld_state == sld_fatal ? "fatal" : "bogus", ip);

        current->thread.error_code = 0;
        current->thread.trap_nr = X86_TRAP_AC;
@@ -1105,10 +1103,10 @@ EXPORT_SYMBOL_GPL(handle_guest_split_lock);

 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
-       if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+       if (regs->flags & X86_EFLAGS_AC)
                return false;
-       split_lock_warn(regs->ip);
-       return true;
+
+       return handle_split_lock(regs->ip);
 }

 /*


> +
> +	pr_warn_ratelimited("#AC: %s/%d %ssplit_lock trap at address: 0x%lx\n",
> +			    current->comm, current->pid,
> +			    sld_state == sld_fatal ? "fatal " : "", ip);
> +
> +	if (sld_state == sld_fatal)
> +		return false;
>  
>  	/*
>  	 * Disable the split lock detection for this task so it can make
> @@ -1086,18 +1093,13 @@ static void split_lock_warn(unsigned long ip)
>  	 */
>  	sld_update_msr(false);
>  	set_tsk_thread_flag(current, TIF_SLD);
> +	return true;
>  }
>  
>  bool handle_guest_split_lock(unsigned long ip)
>  {
> -	if (sld_state == sld_warn) {
> -		split_lock_warn(ip);
> +	if (split_lock_warn(ip, 0))
>  		return true;
> -	}
> -
> -	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
> -		     current->comm, current->pid,
> -		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
>  
>  	current->thread.error_code = 0;
>  	current->thread.trap_nr = X86_TRAP_AC;
> @@ -1108,10 +1110,7 @@ EXPORT_SYMBOL_GPL(handle_guest_split_lock);
>  
>  bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>  {
> -	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> -		return false;
> -	split_lock_warn(regs->ip);
> -	return true;
> +	return split_lock_warn(regs->ip, regs->flags & X86_EFLAGS_AC);
>  }
>  
>  /*
> -- 
> 2.21.3
> 
