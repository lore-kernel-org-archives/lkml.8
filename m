Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C39C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4AC207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390326AbgDCAFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:05:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:16264 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390294AbgDCAFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:05:45 -0400
IronPort-SDR: hYSD8JtMOMCN3hYdg1ElcR55zAqDeSHR/hv13HX8k6I0hmcsiH14s5rsnfeLDAsqqGz5Frht7C
 eb78SdWKr/Jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 17:05:44 -0700
IronPort-SDR: GWn4OjVy3o8Dsgvo+tif0vznlxkC+i7g0zdLzzJQDEOoJ3namMfgV143OgLItGWAlNUP+H014w
 vA2lXs9pE5Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,337,1580803200"; 
   d="scan'208";a="423336550"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 02 Apr 2020 17:05:44 -0700
Date:   Thu, 2 Apr 2020 17:05:27 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, bp@alien8.de, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM
 counter width
Message-ID: <20200403000527.GI188393@romley-ivt3.sc.intel.com>
References: <cover.1585763047.git.reinette.chatre@intel.com>
 <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:51:02AM -0700, Reinette Chatre wrote:
> The original Memory Bandwidth Monitoring (MBM) architectural
> definition defines counters of up to 62 bits in the
> IA32_QM_CTR MSR while the first-generation MBM implementation
> uses statically defined 24 bit counters.
> 
> @@ -856,6 +856,8 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>  
>  static void init_cqm(struct cpuinfo_x86 *c)
>  {
> +	c->x86_cache_mbm_width_offset = -1;
> +
>  	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
>  		c->x86_cache_max_rmid  = -1;
>  		c->x86_cache_occ_scale = -1;
> @@ -875,6 +877,9 @@ static void init_cqm(struct cpuinfo_x86 *c)
>  
>  		c->x86_cache_max_rmid  = ecx;
>  		c->x86_cache_occ_scale = ebx;
> +		/* EAX contents is only defined for Intel CPUs */
> +		if (c->x86_vendor == X86_VENDOR_INTEL)
> +			c->x86_cache_mbm_width_offset = eax & 0xff;

Is it reliable to read eax which is reserved on older platforms that
don't support the feature?

Seems the code assumes the reserved eax is 0 on those platforms. Is it
reliable?

>  int rdt_get_mon_l3_config(struct rdt_resource *r)
>  {
> +	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>  	unsigned int cl_size = boot_cpu_data.x86_cache_size;
>  	int ret;
>  
>  	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
>  	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
> -	r->mbm_width = MBM_CNTR_WIDTH;
> +	r->mbm_width = MBM_CNTR_WIDTH_BASE;
> +
> +	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
> +		r->mbm_width += mbm_offset;
> +	else if (mbm_offset > MBM_CNTR_WIDTH_OFFSET_MAX)
> +		pr_warn("Ignoring impossible MBM counter offset\n");
>  

Thanks.

-Fenghua
