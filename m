Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201DBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFA720723
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k/lNNGBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgFLTxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:53:30 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13675 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:53:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee3dd0b0000>; Fri, 12 Jun 2020 12:52:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Jun 2020 12:53:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Jun 2020 12:53:29 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Jun
 2020 19:53:24 +0000
Subject: Re: [PATCH] mm/hmm: remove redundant check non_swap_entry()
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200612192618.32579-1-rcampbell@nvidia.com>
 <20200612193524.GL8681@bombadil.infradead.org>
 <20200612194204.GM65026@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <266b26e6-5f6f-9178-948a-fcae20c16112@nvidia.com>
Date:   Fri, 12 Jun 2020 12:53:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200612194204.GM65026@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591991563; bh=0OEkAeXHnbstwmHFscadQ/FCSGGM9Wj3sCp54HXFs6I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k/lNNGBhXbpnc/5LBW1zGsU34nc7RmLXWFZejYx0xWvEQF9ZdSHov3/InpXaFzjHK
         Z+oDt/5EzD85bXWjufFCsNzX/ZAgEO0ade0BuIM4lqd2zlJKYWt/AbPROOfej+VGAK
         rzXTgyvseFAbiJ856edQE6+0/Ahe5rsTTpBKHnDmwwDt9k5CeBsE40u/qXPN18IG9s
         JdGJ0Pqb0PXe9cKHu1rNYrsW0KdXSQCCFDnYRoQAa817jvQ0qzQv1FAPWiPI4ZhW/G
         xkgjYmkIBsC8FzCf3vykZwO7EYaczu+wTK4tVXo5CSzwHg9kZVRt0FXJGhYlfWuXyj
         FaT2BTy0rGTyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/20 12:42 PM, Jason Gunthorpe wrote:
> On Fri, Jun 12, 2020 at 12:35:24PM -0700, Matthew Wilcox wrote:
>> On Fri, Jun 12, 2020 at 12:26:18PM -0700, Ralph Campbell wrote:
>>> In zap_pte_range(), the check for non_swap_entry() and
>>> is_device_private_entry() is redundant since the latter is a subset of the
>>> former. Remove the redundant check to simplify the code and for clarity.
>>
>> That is highly configuration dependent.
>>
>> #else /* CONFIG_DEVICE_PRIVATE */
>> ...
>> static inline bool is_device_private_entry(swp_entry_t entry)
>> {
>>          return false;
>> }
> 
> The commit message might be a bit confusing, as it is not a subset, I
> would say that device_private_entry alone is sufficient to tell if the
> entry is private or not.
> 
> For the !CONFIG_DEVICE_PRIVATE case having it wired to false is
> right.
> 
> Jason
> 

How about the following message instead?

In zap_pte_range(), the check for non_swap_entry() and
is_device_private_entry() is unnecessary since the latter is sufficient
to determine if the page is a device private page. Remove the test for
non_swap_entry() to simplify the code and for clarity.
