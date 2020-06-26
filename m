Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB76C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2868C20836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgFZSKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:10:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:18651 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFZSKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:10:02 -0400
IronPort-SDR: Ijur+aRIceM0U2f1Kif6my+doZMB+ZdLkfVN5bBUPYgj5zq1OEcIseTVBFecnojQEpJTIBlj1t
 9TgmwBXxms6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="144513100"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="144513100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:10:01 -0700
IronPort-SDR: g2OBDAD4vVXNapwoCfCslq8K5czLXdJb63lCtfHN+z8y3tjb0E6UQHVMO50vSKUtUJeHklLtUf
 e0+2TA6XdnTQ==
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="302408152"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:10:01 -0700
Date:   Fri, 26 Jun 2020 11:10:00 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <20200626181000.GA22833@agluck-desk2.amr.corp.intel.com>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
 <1593116242-31507-13-git-send-email-fenghua.yu@intel.com>
 <20200626094450.GJ4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626094450.GJ4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Do we have a standard way of coding for a feature that depends on multiple
other features?  For this case the system needs to both suport the ENQCMD
instruction, and also have kernel code that programs the IOMMU.

And/or guidance on when to use each of the very somewhat simlar looking
	boot_cpu_has()
	static_cpu_has()
	IS_ENABLED()
	cpu_feature_enabled()
options?

-Tony
