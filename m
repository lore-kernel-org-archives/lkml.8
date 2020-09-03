Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBE9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E22720786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgICWez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:34:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:22699 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbgICWey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:34:54 -0400
IronPort-SDR: R7rtXpVy0FBnuXVAPccE1BUZSidpYAVnhgnU0pZEZME6U32cx/WnsJj32luJNeT2CjO94p6hTO
 5Gq/5sFcQS5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145366697"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="145366697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 15:34:53 -0700
IronPort-SDR: u790SXF/INpCFqyCHnMzD1KOSwujaEmm1KPJsg8RXI9m0TfIgJbwR0MMq1d1xR66xa6sMsGdRZ
 cZTk+kjb68cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="326396319"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2020 15:34:53 -0700
Date:   Thu, 3 Sep 2020 22:34:53 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v7 9/9] x86/mmu: Allocate/free PASID
Message-ID: <20200903223453.GA410113@otcwcpicx6.sc.intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas, Andy, et al,

On Thu, Aug 27, 2020 at 08:06:34AM -0700, Fenghua Yu wrote:
> A PASID is allocated for an "mm" the first time any thread binds
> to an SVM capable device and is freed from the "mm" when the SVM is
> unbound by the last thread. It's possible for the "mm" to have different
> PASID values in different binding/unbinding SVM cycles.
> 
> The mm's PASID (non-zero for valid PASID or 0 for invalid PASID) is
> propagated to per-thread PASID MSR for all threads within the mm through
> through IPI, context switch, or inherit to ensure a running thread has
> the right PASID MSR matching the mm's PASID.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v7:
> - Don't fix up PASID in #GP. Instead, update the PASID MSR by IPI and
>   context switch after PASID allocation and free. Inherit PASID from
>   parent. (Andy)
> 
> Before v7:
> - Allocate a PASID for the mm and free it until mm exit.

This is a friendly reminder. Any comment on this series?

This patch (9/9) is essentially the only changed patch that implements
updating PASID MSR for a thread by IPI and context switch per Andy's
comment.

Thank you very much in advance!

-Fenghua
