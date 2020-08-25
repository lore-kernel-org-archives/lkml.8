Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3E2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0869520825
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHYPfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:35:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:36602 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgHYPfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:35:05 -0400
IronPort-SDR: UYvACQJR4YXO4G3L1Cu+3K3ilyJKCSJYHajPEiKpgM3up9xzgTPqTm+NYlx3eFzHDN/YNQDNUr
 s/yqmPZL08pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="153559431"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="153559431"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:34:49 -0700
IronPort-SDR: vzkXNWqHEhv+u8xJUKhBznoFEov86BCFyq+MANnIg2WkjyXzZyoTaqIIBur1AYG6N2rzf5JWKf
 OayyfXViTUbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="328898092"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 08:34:49 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2C1D1301C53; Tue, 25 Aug 2020 08:25:09 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:25:09 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        npiggin@suse.de, agl@us.ibm.com, nacc@us.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Fix a race between hugetlb sysctl handlers
Message-ID: <20200825152509.GO1509399@tassilo.jf.intel.com>
References: <20200822095328.61306-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822095328.61306-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")

I don't think the Fixes line is correct. The original patch
just used a global variable and didn't have this race.
It must have been added later in some other patch that added
hugetlb_sysctl_handler_common.

-Andi
