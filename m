Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1FEC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A3E20795
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgIDQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:06:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:34938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgIDQGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:06:17 -0400
IronPort-SDR: yjr+BW74s7btEI0SpCxXonE6s+atR+eZft/3Pgc4to2nhOaO8tBhhPtE9BzZczpXXO9wLOb0PQ
 3Np+cjUOBvOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="157036546"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="157036546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:06:14 -0700
IronPort-SDR: 3+uboW1eJZdPEC8GQz+ib5rViBy7IyYNUzc36nW2gBgKz2vs8ICx9HH6/cqH+iw9yA+XcV/QQT
 4dHWONkUUyIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="326722628"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2020 09:06:14 -0700
Date:   Fri, 4 Sep 2020 16:06:13 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
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
Subject: Re: [PATCH v7 1/9] iommu: Change type of pasid to u32
Message-ID: <20200904160613.GA412013@otcwcpicx6.sc.intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-2-git-send-email-fenghua.yu@intel.com>
 <20200904104614.GE21499@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904104614.GE21499@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris,

On Fri, Sep 04, 2020 at 12:46:14PM +0200, Borislav Petkov wrote:
> Just a nitpick in case you have to send a new version or the committer
> of this one can fixup the prefix here:
> 
> > Subject: Re: [PATCH v7 1/9] iommu: Change type of pasid to u32
> 
> 		drm, iommu: Change type ...
> 
> 
> On Thu, Aug 27, 2020 at 08:06:26AM -0700, Fenghua Yu wrote:
> > PASID is defined as a few different types in iommu including "int",
> > "u32", and "unsigned int". To be consistent and to match with uapi
> > definitions, define PASID and its variations (e.g. max PASID) as "u32".
> > "u32" is also shorter and a little more explicit than "unsigned int".
> > 
> > No PASID type change in uapi although it defines PASID as __u64 in
> > some places.

Thank you very much for your review!

Could you please consider to commit the series? I can send out v8 with
the subject "drm," change if you want me to do so.

Thanks.

-Fenghua
