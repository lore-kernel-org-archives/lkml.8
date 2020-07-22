Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38286C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14268207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgGVRVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:63218 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgGVRVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:22 -0400
IronPort-SDR: WNw6q0DtBPk5ZKtpzA7k8fAc1GELZY3kHKkAb87S53EQsbIwmAieSOcp92ovEstTyDkDsKsXqm
 IRc9cwnvQTtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151704344"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="151704344"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 10:21:22 -0700
IronPort-SDR: kb3GPD/NL04hNIlvuFoMEq6vktJwtVn5I98YLypdhtdocLwHYlHIfAQpsnNi7Nsj6nL9eefSeM
 GSIytoBMR73g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="270809306"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jul 2020 10:21:21 -0700
Date:   Wed, 22 Jul 2020 10:21:21 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v6 01/12] iommu: Change type of pasid to u32
Message-ID: <20200722172120.GA75908@romley-ivt3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-2-git-send-email-fenghua.yu@intel.com>
 <20200722140340.GJ27672@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722140340.GJ27672@8bytes.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joerg,

On Wed, Jul 22, 2020 at 04:03:40PM +0200, Joerg Roedel wrote:
> On Mon, Jul 13, 2020 at 04:47:56PM -0700, Fenghua Yu wrote:
> > PASID is defined as a few different types in iommu including "int",
> > "u32", and "unsigned int". To be consistent and to match with uapi
> > definitions, define PASID and its variations (e.g. max PASID) as "u32".
> > "u32" is also shorter and a little more explicit than "unsigned int".
> > 
> > No PASID type change in uapi although it defines PASID as __u64 in
> > some places.
> > 
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> For the IOMMU parts:
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>

Thank you!

-Fenghua 
