Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB19C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D6620656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404577AbgBNRFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:05:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:48904 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404913AbgBNRFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:05:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 09:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227428982"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2020 09:05:08 -0800
Date:   Fri, 14 Feb 2020 09:05:08 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: x86: Print "disabled by bios" only once per host
Message-ID: <20200214170508.GB20690@linux.intel.com>
References: <20200214143035.607115-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214143035.607115-1-e.velu@criteo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 03:30:35PM +0100, Erwan Velu wrote:
> The current behavior is to print a "disabled by bios" message per CPU thread.
> As modern CPUs can have up to 64 cores, 128 on a dual socket, and turns this
> printk to be a pretty noisy by showing up to 256 times the same line in a row.
> 
> This patch offer to only print the message once per host considering the BIOS will
> disabled the feature for all sockets/cores at once and not on a per core basis.

This has come up before[*].  Using _once() doesn't fully solve the issue
when KVM is built as a module.  The spam is more than likely a userspace
bug, i.e. userspace is probing KVM on every CPU.

[*] https://lkml.kernel.org/r/20190826182320.9089-1-tony.luck@intel.com

> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fbabb2f06273..8f0d7a09d453 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7300,7 +7300,7 @@ int kvm_arch_init(void *opaque)
>  		goto out;
>  	}
>  	if (ops->disabled_by_bios()) {
> -		printk(KERN_ERR "kvm: disabled by bios\n");
> +		printk_once(KERN_ERR "kvm: disabled by bios\n");
>  		r = -EOPNOTSUPP;
>  		goto out;
>  	}
> -- 
> 2.24.1
> 
