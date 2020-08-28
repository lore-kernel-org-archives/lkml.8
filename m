Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94772C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E7F2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgH1Ux4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:53:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:11098 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgH1Uxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:53:54 -0400
IronPort-SDR: wSvcNr0FwoSG2zCc7unEEvrJ3qZGByctjsLP3yQR96fc4QjW+nV4axF25hW8gT+hpp2idiBiCq
 Es3z1Q02n43A==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="144423368"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="144423368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 13:53:54 -0700
IronPort-SDR: /OCPrcZkRiHahOLjQ8MnMDVN9cT2EI/iOS5XT0iMuitLHFQIcMIfg4Ju0VrihGCnZq0S65Jl+S
 pW8RKe4vlt2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="330060605"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2020 13:53:54 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 096E3301C54; Fri, 28 Aug 2020 13:30:34 -0700 (PDT)
Date:   Fri, 28 Aug 2020 13:30:33 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: Fix a race between hugetlb sysctl handlers
Message-ID: <20200828203033.GT1509399@tassilo.jf.intel.com>
References: <20200828031146.43035-1-songmuchun@bytedance.com>
 <20200828145950.GS1509399@tassilo.jf.intel.com>
 <fee0c3a6-af68-5971-1959-a66d41ea16a3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee0c3a6-af68-5971-1959-a66d41ea16a3@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:14:16AM -0700, Mike Kravetz wrote:
> On 8/28/20 7:59 AM, Andi Kleen wrote:
> >> Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")
> > 
> > I believe the Fixes line is still not correct. The original patch
> > didn't have that problem. Please identify which patch added
> > the problematic code.
> 
> Hi Andi,
> 
> I agree with Muchun's assessment that the issue was caused by e5ff215941d5.
> Why?

Yes when checking the code again I agree. It was introduced with that
patch. Patches look ok to me now.

-Andi
