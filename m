Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B63EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B1F207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgFAXZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:25:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:60977 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgFAXZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:25:12 -0400
IronPort-SDR: 3xItpr+yAsDDlCp+6j33lYmqY55Pe4aFNLDWIaDz9/gPzvRzJQ9gnEUWgYdAZTJBIfDNcwtjym
 Tv/K9+m5rW5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 16:25:11 -0700
IronPort-SDR: VamPsjCpFFkrqjHUmhX3KjPWOOetI/yRceOB11zrSgP2AvYcJa42wWl/t0tiOFW0jJdusMZqrV
 KJ0wYao8uarg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="415968967"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2020 16:25:10 -0700
Date:   Mon, 1 Jun 2020 16:23:18 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
Message-ID: <20200601232318.GA57376@romley-ivt3.sc.intel.com>
References: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 06:00:29PM -0500, Babu Moger wrote:
> Memory bandwidth is calculated reading the monitoring counter
> at two intervals and calculating the delta. It is the software’s
> responsibility to read the count often enough to avoid having
> the count roll over _twice_ between reads.
> 
> The current code hardcodes the bandwidth monitoring counter's width
> to 24 bits for AMD. This is due to default base counter width which
> is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
> to adjust the counter width. But, the AMD hardware supports much
> wider bandwidth counter with the default width of 44 bits.
> 
> Kernel reads these monitoring counters every 1 second and adjusts the
> counter value for overflow. With 24 bits and scale value of 64 for AMD,
> it can only measure up to 1GB/s without overflowing. For the rates
> above 1GB/s this will fail to measure the bandwidth.
> 
> Fix the issue setting the default width to 44 bits by adjusting the
> offset.
> 
> AMD future products will implement the CPUID 0xF.[ECX=1]:EAX.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> - Sending it second time. Email client had some issues first time.
> - Generated the patch on top of 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (x86/cache).
> 
>  arch/x86/kernel/cpu/resctrl/core.c     |    8 +++++++-
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 12f967c6b603..6040e9ae541b 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -983,7 +983,13 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>  		c->x86_cache_occ_scale = ebx;
>  		if (c->x86_vendor == X86_VENDOR_INTEL)
>  			c->x86_cache_mbm_width_offset = eax & 0xff;
> -		else
> +		else if (c->x86_vendor == X86_VENDOR_AMD) {
> +			if (eax)
> +				c->x86_cache_mbm_width_offset = eax & 0xff;

When AMD implements CPUID.0x1f.1:eax, will the offset be based on 24 or 44?
Seems it makes senses to be based on 44 because default counter width is 44.

> +			else
> +				c->x86_cache_mbm_width_offset =
> +					MBM_CNTR_WIDTH_OFFSET_AMD;

If that's the case, you don't need this "else" because the CPUID reports
offset as 0 for default width 44.

This will match the Intel code above.

Otherwise, the code is awkward.

Thanks.

-Fenghua
