Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B91C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC82075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgFRPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:22:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:27485 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgFRPWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:22:42 -0400
IronPort-SDR: bFxr9MpFVoBZcRCdCUMK9W4YnFRCq9CeDYijdHHf/u1cZgfjhc2OkDfX0NrAc/it8+GgutSEQf
 KdelUM4Emclg==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="122842630"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="122842630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:22:42 -0700
IronPort-SDR: XgeIFWNm/rUPs3f8JBvzlSgZi/FudpaujhzTcJqwZYy14jIQfuwr/srpYtcNR3RxtTUZceiA85
 vFX4SaXyTU2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="291802011"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2020 08:22:41 -0700
Date:   Thu, 18 Jun 2020 08:22:41 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
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
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/13] iommu: Change type of pasid to unsigned int
Message-ID: <20200618152240.GD15763@romley-ivt3.sc.intel.com>
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
 <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
 <20200618071206.GA7294@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618071206.GA7294@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:12:06AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 17, 2020 at 11:23:41AM -0700, Fenghua Yu wrote:
> > PASID is defined as a few different types in iommu including "int",
> > "u32", and "unsigned int". To be consistent and to match with ioasid's
> > type, define PASID and its variations (e.g. max PASID) as "unsigned int".
> 
> Wouldn't u32 be a little more explicit (besides being shorter and
> matching the uapi definitions)?

"unsigned int" matches ioasid_t type definition. Very (very) few places
define pasid as "u32". If changing to u32, this patch will be much bigger.

include/uapi/linux/iommu.h defines pasid as either __u32 or __u64. It's
not just __u32.

Thanks.

-Fenghua
