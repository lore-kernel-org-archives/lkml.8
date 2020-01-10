Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1569BC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DE820678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgAJBzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:55:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:49142 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730359AbgAJBzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:55:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 17:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="246855115"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 17:55:49 -0800
Date:   Fri, 10 Jan 2020 09:55:48 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        richard.weiyang@gmail.com
Subject: Re: [RFC PATCH] mm/rmap.c: finer hwpoison granularity for PTE-mapped
 THP
Message-ID: <20200110015548.GA16823@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200102030421.30799-1-richardw.yang@linux.intel.com>
 <20200109123233.ye2h4dxaubu4ad22@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109123233.ye2h4dxaubu4ad22@box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 03:32:33PM +0300, Kirill A. Shutemov wrote:
>On Thu, Jan 02, 2020 at 11:04:21AM +0800, Wei Yang wrote:
>> Currently we behave differently between PMD-mapped THP and PTE-mapped
>> THP on memory_failure.
>> 
>> User detected difference:
>> 
>>     For PTE-mapped THP, the whole 2M range will trigger MCE after
>>     memory_failure(), while only 4K range for PMD-mapped THP will.
>> 
>> Direct reason:
>> 
>>     All the 512 PTE entry will be marked as hwpoison entry for a PTE-mapped
>>     THP while only one PTE will be marked for a PMD-mapped THP.
>> 
>> Root reason:
>> 
>>     The root cause is PTE-mapped page doesn't need to split pmd which skip
>>     the SPLIT_FREEZE process.
>
>I don't follow how SPLIT_FREEZE is related to pisoning. Cold you
>laraborate?
>

Sure. Let me try to explain this a little.

    split_huge_page_to_list
        unmap_page
	    try_to_unmap_one
                ...
                __split_huge_pmd_locked
        __split_huge_page
            remap_page

There are two dimensions:

   * PMD mapped THP and PTE mapped THP
   * HWPOISON-ed page and non-HWPOISON-ed page

So there are total 4 cases.

1. First let's take a look at the normal case, when HWPOISON is not set.

If the page is PMD-mapped, SPLIT_FREEZE is passed down in flags. And finally
passed to __split_huge_pmd_locked. In this function, when freeze is true, PTE
will be set to migration entry. And because __split_huge_pmd_locked save
migration entry to PTE, try_to_unmap_one will not do real unmap. Then
remap_page restore those migration entry back. 

If the page is PTE-mapped, __split_huge_pmd_locked will be skipped since this
is already done. This means try_to_unmap_one will do the real unmap. Because
SPLIT_FREEZE is passed, PTE will be set to migration entry, which is the same
behavior as PMD-mapped page. Then remap_page restore those migration entry
back.

This shows PMD-mapped and PTE-mapped page share the same result on split.

While difference is who sets PTE as migration entry

  * __split_huge_pmd_locked does this job for PMD-mapped page
  * try_to_unmap_one does this job for PTE-mapped page

2. Now let's take a look at the HWPOISON case.

There are two critical differences 

  * __split_huge_pmd_locked is skipped for PTE-mapped page
  * HWPOISON effects the behavior of try_to_unmap_one

Then for PMD-mapped page, HWPOISON has no effect on split. But for PTE-mapped
page, all PTE will be set to hwpoison entry.

Then in memory_failure, the page split will have two different PTE result.

Not sure I explain it clearly.

-- 
Wei Yang
Help you, Help me
