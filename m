Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86216C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B6220874
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgGPThB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:37:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:25433 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgGPThB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:37:01 -0400
IronPort-SDR: mmYM6DBlrqvgHzgZAzdSAGmdTSfJuQQ5k7YnMEhAH/o4Vc+YuttIX6mJDdHo/XA+kffaXx8Mg8
 rLSBdYV3JHLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147472120"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="147472120"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 12:37:01 -0700
IronPort-SDR: rgeq5PWWOvapHXHEl2k+ns8B4LrbmEfXbA/av211FVXohb1QHNca5F582yThEbVc3FbmVZf8G8
 Hh2tbjW64qDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="308751536"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2020 12:37:00 -0700
Date:   Thu, 16 Jul 2020 12:37:00 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/split_lock: Enumerate split lock feature on Sapphire
 Rapids
Message-ID: <20200716193659.GA66451@romley-ivt3.sc.intel.com>
References: <1593208534-33721-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593208534-33721-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas, Boris, Ingo,

On Fri, Jun 26, 2020 at 02:55:34PM -0700, Fenghua Yu wrote:
> Add Sapphire Rapids processor to CPU list to enumerate split lock
> feature.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index c25a67a34bd3..dca069ad6671 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1148,6 +1148,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
>  	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
>  	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
>  	{}
>  };

Any comment on this patch?

Thanks.

-Fenghua
