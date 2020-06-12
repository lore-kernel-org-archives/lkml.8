Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78173207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgFLQeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:34:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:23746 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFLQeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:34:07 -0400
IronPort-SDR: 0ErhRB5FSTBLN11toJmxxYyah6LasDNZUlIrghLfkxA53DOeK0r2ltiBKt4gBjN/dqPBQ4TGiM
 iyJJlcRyLWNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 09:34:06 -0700
IronPort-SDR: bQgeC4VBmyhs2p4OQebZkZzkLy8HM9QNhBMV7DebR+LLkZkC+Gxi6fncD00UZqmM1tl1CwOfUr
 CQAnefalwQ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="307347223"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2020 09:34:06 -0700
Date:   Fri, 12 Jun 2020 09:34:06 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612163406.GA1026@linux.intel.com>
References: <20200612105026.GA22660@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612105026.GA22660@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:50:26PM +0200, Borislav Petkov wrote:
> @@ -95,11 +114,18 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
>  		err = wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
>  		if (err)
>  			break;
> +
>  		tmp += 2;
>  		bytes += 8;
>  	}
>  
> -	return bytes ? bytes : err;
> +	if (bytes) {
> +		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);

The kernel should be tainted if the WRMSR is attempted, regardless of
whether it succeeds, and it should happen before the WRMSR.  E.g. pointing
MSR_IA32_DS_AREA at a bad address will likely cause an OOPS on the #PF
that would occur the next time the CPU attempts to access the area, which
could happen before wrmsr_safe_on_cpu() even returns.  In general, there's
no telling what microcode magic is buried behind WRMSR, i.e. a fault on
WRMSR is not a good indicator that the CPU is still in a sane state.

It might also make sense to do pr_err/warn_ratelimited() before the WRMSR,
e.g. to help triage MSR writes that cause insta-death or lead to known bad
behavior down the line.

> +
> +		return bytes;
> +	}
> +
> +	return err;
>  }
>  
>  static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
> @@ -242,6 +268,8 @@ static void __exit msr_exit(void)
>  }
>  module_exit(msr_exit)
>  
> +module_param(allow_writes, bool, 0400);

This can be 0600, or maybe 0644, i.e. allow the user to enable/disable
writes after the module has been loaded.

> +
>  MODULE_AUTHOR("H. Peter Anvin <hpa@zytor.com>");
>  MODULE_DESCRIPTION("x86 generic MSR driver");
>  MODULE_LICENSE("GPL");
