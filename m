Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBD1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8476E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgENQ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:56:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:49929 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgENQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:56:36 -0400
IronPort-SDR: L/aSbEo+KoRPGrFPnzzbk9CSUYbIKQ0vl0TBTxNt+TE4T6fU0Gbm45lCAh9BBAdo/um25vzHP9
 W4b3I9mqHyNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 09:56:36 -0700
IronPort-SDR: jHoPhh0H1yXReoPmZeCYgQAMVQkVODStMAUco2qf75a82JwNeVGlyf5xeipSQtBexSLY4QXGaZ
 rPECBZ1bMhKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="280919313"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 14 May 2020 09:56:35 -0700
Date:   Thu, 14 May 2020 09:55:13 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/split_lock: Add Icelake microserver CPU model
Message-ID: <20200514165510.GH242333@romley-ivt3.sc.intel.com>
References: <1588290395-2677-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588290395-2677-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:46:35PM -0700, Fenghua Yu wrote:
> Icelake microserver CPU supports split lock detection while it doesn't
> have the split lock enumeration bit in IA32_CORE_CAPABILITIES.
> 
> Enumerate the feature by model number.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index a19a680542ce..b59bc4ab2425 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1135,6 +1135,7 @@ void switch_to_sld(unsigned long tifn)
>  static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		0),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		0),
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),

Hi, Thomas,

Any comment on this patch? Will you accept this patch?

Thanks.

-Fenghua
