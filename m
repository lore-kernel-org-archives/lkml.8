Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9636C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDB820738
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgH1Qxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:53:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:42190 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1Qxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:53:52 -0400
IronPort-SDR: Fhj32nmgp7eltoj/q5yOkyoahPTFINM06xPzY4JXZv/YG2ruRTGLJ4dmPbViVENl6aresifVBs
 dICjXV+HjIjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="136243215"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="136243215"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 09:53:51 -0700
IronPort-SDR: m37eGOiRVDtLjlEXWPDtSflNmlPbKTZq9zmm5qG3nXhxfb4GLupEcVhRzAT94U3qGkHGwFexVn
 x8va+e5MHItg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="330006494"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2020 09:53:51 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DD0ED301C54; Fri, 28 Aug 2020 07:59:50 -0700 (PDT)
Date:   Fri, 28 Aug 2020 07:59:50 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: Fix a race between hugetlb sysctl handlers
Message-ID: <20200828145950.GS1509399@tassilo.jf.intel.com>
References: <20200828031146.43035-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828031146.43035-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")

I believe the Fixes line is still not correct. The original patch
didn't have that problem. Please identify which patch added
the problematic code.

-Andi
