Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4265BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2635621473
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgFZSQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:16:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:64784 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFZSQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:16:45 -0400
IronPort-SDR: l2oiloYgDf5NF7a/IY7RALemqzIFlH2c0CaSQ9XbLwxqqbgoghC6m8FTpoRzzQ23H7grnD80FX
 w5lApmuIqT+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="143661750"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="143661750"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:16:44 -0700
IronPort-SDR: LrvGyNnpWX6ik5OFFqZoBMW0OQOmmNpAFfodvXeT2j9bQlZKueLItipolrt/V64t2tcadV1dna
 D9NzoyBXgSJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="385835873"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2020 11:16:44 -0700
Date:   Fri, 26 Jun 2020 11:16:24 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradeed.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200626181624.GA32961@romley-ivt3.sc.intel.com>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
 <1593116242-31507-13-git-send-email-fenghua.yu@intel.com>
 <20200626094450.GJ4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626094450.GJ4800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Fri, Jun 26, 2020 at 11:44:50AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 25, 2020 at 01:17:22PM -0700, Fenghua Yu wrote:
> 
> > +static bool fixup_pasid_exception(void)
> > +{
> > +	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> > +		return false;
> > +	if (!static_cpu_has(X86_FEATURE_ENQCMD))
> > +		return false;
> 
> elsewhere you had another variation:
> 
> +       if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> +               return;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +               return;
> 
> Which is it, and why do we need the CONFIG thing when combined with the
> enabled thing?
> 

I will use the second one with cpu_feature_enabled() for both cases.

The CONFIG thing is for compilation time optimization when
CONFIG_INTEL_IOMMU_SVM is not set.

If CONFIG_INTEL_IOMMU_SVM is not set, IS_ENABLED(CONFIG_INTEL_IOMMU_SVM) 
is "false" during compilation time. Then GCC will optimize 
fixup_pasid_execption() to empty and will not define
__fixup_pasid_exception() at all because no one calls it.

If CONFIG_INTEL_IOMMU_SVM is set, IS_ENABLED(...) is always true.
Depending on cpu_feature_enabled(X86_FEATURE_ENQCMD), __fixup_pasid_execption()
will be called or not during run time.

Does it make sense?

Do you want me to define a helper enqcmd_enabled()?

static inline bool enqcmd_enabled(void)
{
   if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
           return false;
   if (!static_cpu_has(X86_FEATURE_ENQCMD))
           return false;
   return true;
}

Then both fixup_pasid_execption() and free_pasid() can call it.

static bool fixup_pasid_exception(void)
{
	if (!enqcmd_enabled())
		return false;
	
	return __fixup_pasid_exception();
}

statis inline void free_pasid(struct m_struct *mm)
{
	if (!enqcmd_enabled())
		return;

	__free_pasid(mm);
}

Please advice.

-Fenghua
