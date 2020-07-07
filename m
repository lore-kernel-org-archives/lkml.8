Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7464BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50947206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgGGVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:30:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:18917 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgGGVas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:30:48 -0400
IronPort-SDR: Pjc0Rwb/IUNtckjnpH8ohIK/036ZXoK9hmZ4/4ijV23Gxoc095K1pAXPEPDXJAxYBlJC4axvnA
 RkYB08tgctew==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="212645205"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="212645205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 14:30:46 -0700
IronPort-SDR: rwm7lj+DnvL/a1nGsfKY1/7jBpW0zpUQ2Umk8tCEBzRExI+Yqm+0qUJZpUU7FPxDpBzDyT16+x
 cJ0EuuDG1dxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="297521531"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 07 Jul 2020 14:30:44 -0700
Date:   Tue, 7 Jul 2020 14:30:44 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v5 00/12] x86: tag application address space for devices
Message-ID: <20200707213043.GG32961@romley-ivt3.sc.intel.com>
References: <1593560682-40814-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593560682-40814-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas, Joerg, Boris, Ingo, Baolu, and x86/iommu maintainers,

On Tue, Jun 30, 2020 at 04:44:30PM -0700, Fenghua Yu wrote:
> Typical hardware devices require a driver stack to translate application
> buffers to hardware addresses, and a kernel-user transition to notify the
> hardware of new work. What if both the translation and transition overhead
> could be eliminated? This is what Shared Virtual Address (SVA) and ENQCMD
> enabled hardware like Data Streaming Accelerator (DSA) aims to achieve.
> Applications map portals in their local-address-space and directly submit
> work to them using a new instruction.
> 

Any comment on this series? Updated patch 1 with minor changes was sent out
on the same patch 1 thread and was Acked-by Felix Kuehling. If you want me
to send the whole series with the minor changes or any other changes, please
let me know.

Any plan to push the patches into your tree and upstream?

Thanks.

-Fenghua
