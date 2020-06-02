Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED679C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE1E2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GrIz+z5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFBDUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 23:20:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18277 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFBDUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 23:20:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed5c5130000>; Mon, 01 Jun 2020 20:18:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 01 Jun 2020 20:20:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 01 Jun 2020 20:20:10 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jun
 2020 03:20:05 +0000
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration without
 split
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
 <20200601165736.qw5kwwknxltk7bv6@ca-dmjordan1.us.oracle.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0a936ec7-f44f-1d72-915f-f5758d25fd72@nvidia.com>
Date:   Mon, 1 Jun 2020 20:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601165736.qw5kwwknxltk7bv6@ca-dmjordan1.us.oracle.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591067923; bh=D8A1hpMTIZ2k2DR5/UwfONmp0VIuvs4qyuES2Sn0xHI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GrIz+z5hstXvn5L/CafsZt24hH1k+QVqhtvYgU/lu9Ljg3nTrKtd77O17KQLDl4vN
         lmAZr7+feh4qJlTL5hsQbTUhjhWAdVEXovxBrznllPwBYYJ43uaLj2rcovQAIf61Zv
         JlMuR/pyceVvBuF3Y6GO+SQRZ0ZsYPc1wd7AWbgHkwoEfh7wXO8K0m3wiw+OscXAr7
         KZRy9shP7jrQkVFCWAtaTR3wi82pXtw2GL4liNVN4JZ3midiN+fNVVydCo0VVq+Fyz
         /8sMNGI674n0h7BrlFtwLenM+HbDOd3k/5CUr7szqoVRehIdhFCrwH+XWz+UMR6jGf
         Ge+G+fFQ7q2Og==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-01 09:57, Daniel Jordan wrote:
> Hi Anshuman,
> 
> On Fri, May 22, 2020 at 09:04:04AM +0530, Anshuman Khandual wrote:
>> This adds the following two new VM events which will help in validating PMD
>> based THP migration without split. Statistics reported through these events
>> will help in performance debugging.
>>
>> 1. THP_PMD_MIGRATION_SUCCESS
>> 2. THP_PMD_MIGRATION_FAILURE
> 
> The names suggest a binary event similar to the existing
> pgmigrate_success/fail, but FAILURE only tracks one kind of migration error,
> and then only when the thp is successfully split, so shouldn't it be called
> SPLIT instead?
> 

So the full description of the situation, which we're trying to compress into
a shorter name, is "THP pmd migration failure, due to successfully splitting
the THP". From that, the beginning part is the real point here, while the last
part is less important. In other words, the users of these events are people
who are trying to quantify THP migrations, and these events are particularly
relevant for that. The "THP migration failed" is more important here than
the reason that it failed. Or so I believe so far.

So I still think that the names are really quite good, but your point is
also important: maybe this patch should also be tracking other causes
of THP PMD migration failure, in order to get a truer accounting of the
situation.

thanks,
-- 
John Hubbard
NVIDIA
