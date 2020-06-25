Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9690CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5DE20709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389906AbgFYFvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:51:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:64281 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389446AbgFYFvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:51:42 -0400
IronPort-SDR: tOS59YQIKHu1ZXf7kZmh0DaskICZfGa+ztH6iJ6CDn/hrg/aHfiv+YA54jmlnci01mSufC80C6
 ogCMcnaxoeUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133193217"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="133193217"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 22:51:41 -0700
IronPort-SDR: QzPu4addwR0m89RYgPZYOfjXsxqL6Eg0hXaKoAPNKxE6SpIkx8opFaflwYi9NZk9pWrIVzAFNJ
 kERFhtj3LALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="293776524"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga002.jf.intel.com with ESMTP; 24 Jun 2020 22:51:41 -0700
Date:   Wed, 24 Jun 2020 22:51:40 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200625055140.GA2141@linux.intel.com>
References: <20200612105026.GA22660@zn.tnic>
 <20200613154844.GB584@zn.tnic>
 <20200615063837.GA14668@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615063837.GA14668@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:38:37AM +0200, Borislav Petkov wrote:
> Here's an improved v2 with sparse warnings fixed:
> 
> ---
> Disable writing to MSRs from userspace by default. Writes can still be
> allowed by supplying the allow_writes=1 module parameter and the kernel
> will be tainted so that it shows in oopses.
> 
> Having unfettered access to all MSRs on a system is and has always been
> a disaster waiting to happen. Think performance counter MSRs, MSRs with
> sticky or locked bits, MSRs making major system changes like loading
> microcode, MTRRs, PAT configuration, TSC counter, security mitigations
> MSRs, you name it.
> 
> This also destroys all the kernel's caching of MSR values for
> performance, as the recent case with MSR_AMD64_LS_CFG showed.
> 
> Another example is writing MSRs by mistake by simply typing the wrong
> MSR address. System freezes have been experienced that way.
> 
> In general, poking at MSRs under the kernel's feet is a bad bad idea.
> 
> So disable poking directly at the MSRs by default. If userspace still
> wants to do that, then proper interfaces should be defined which
> are under the kernel's control and accesses to those MSRs can be
> synchronized and sanitized properly.
> 
> Changelog:
> - taint before WRMSR, all
> - make param 0600, Sean.
> - do not deny but log writes by default, Linus.
> 
> [ Fix sparse warnings ]
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>

A few non-functional nits below.

Tested-by: Sean Christopherson <sean.j.christopherson@intel.com>

> ---
>  arch/x86/kernel/msr.c | 69 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index 1547be359d7f..576c43e39247 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -42,6 +42,14 @@
>  static struct class *msr_class;
>  static enum cpuhp_state cpuhp_msr_state;
>  
> +enum allow_write_msrs {
> +	MSR_WRITES_ON,
> +	MSR_WRITES_OFF,
> +	MSR_WRITES_DEFAULT,
> +};
> +
> +static enum allow_write_msrs allow_writes = MSR_WRITES_DEFAULT;
> +
>  static ssize_t msr_read(struct file *file, char __user *buf,
>  			size_t count, loff_t *ppos)
>  {
> @@ -70,6 +78,24 @@ static ssize_t msr_read(struct file *file, char __user *buf,
>  	return bytes ? bytes : err;
>  }
>  
> +static int filter_write(u32 reg)
> +{
> +     switch (allow_writes) {
> +     case MSR_WRITES_ON:  return 0;          break;
> +     case MSR_WRITES_OFF: return -EPERM;     break;

The breaks after the returns are unnecessary.

> +     default: break;
> +     }
> +
> +     if (reg == MSR_IA32_ENERGY_PERF_BIAS)
> +             return 0;
> +
> +     pr_err_ratelimited("Write to unrecognized MSR 0x%x by %s\n"
> +                        "Please report to x86@kernel.org\n",
> +                        reg, current->comm);


Maybe s/unrecognized/unauthorized?  Unrecognized implies the kernel doesn't
know anything about the MSR being written, which may not hold true.

> +     return 0;
> +}
> +
>  static ssize_t msr_write(struct file *file, const char __user *buf,
>                        size_t count, loff_t *ppos)
>  {
> @@ -84,6 +110,10 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
>       if (err)
>               return err;
>
> +     err = filter_write(reg);
> +     if (err)
> +             return err;
> +
>       if (count % 8)
>               return -EINVAL; /* Invalid chunk size */
>
> @@ -92,9 +122,13 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
>                       err = -EFAULT;
>                       break;
>               }
> +
> +             add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +
>               err = wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
>               if (err)
>                       break;
> +

Random leftover whitespace change.

>  		tmp += 2;
>  		bytes += 8;
>  	}
