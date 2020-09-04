Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE891C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EB6208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgIDUrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:47:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:62602 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgIDUrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:47:06 -0400
IronPort-SDR: g20s0NZNfGjlCfoHJgdb6h2OebHcUt9I4jlEWMkjWOUZWZY9UHq9h45N+7dwIgncJlahu8KKnh
 blp2g0ynWhtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="137865025"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="137865025"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 13:47:05 -0700
IronPort-SDR: 8NER1YNk1rEIiCTIDhyqs/wt8RBbGLsTyJpKcsCwbj3ykC4KTFqH9mCIQckmsB2TFSkyQREo0C
 839Q1CE5ZILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="326806381"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2020 13:47:05 -0700
Date:   Fri, 4 Sep 2020 20:47:04 +0000
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
Message-ID: <20200904204704.GA414801@otcwcpicx6.sc.intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-2-git-send-email-fenghua.yu@intel.com>
 <20200904104614.GE21499@zn.tnic>
 <20200904160613.GA412013@otcwcpicx6.sc.intel.com>
 <20200904194519.GA22577@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904194519.GA22577@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris,

On Fri, Sep 04, 2020 at 09:45:19PM +0200, Borislav Petkov wrote:
> On Fri, Sep 04, 2020 at 04:06:13PM +0000, Fenghua Yu wrote:
> > Thank you very much for your review!
> 
> I'm not done with my review yet.
> 
> > Could you please consider to commit the series?
> 
> Fenghua, how long are you doing kernel development? When do patches get
> considered for inclusion? I'm sure you know the answer...
> 
> > I can send out v8 with the subject "drm," change if you want me to do
> > so.
> 
> Pls be patient until I/we are done with the review.

Really appreciate your help here!

Please let me know any comments and I'll address them ASAP. I'm just eager
to see the patches upstreamed:)

-Fenghua
