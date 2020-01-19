Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F10DC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 02:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0FC2468C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 02:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgASCK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 21:10:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:6490 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgASCK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 21:10:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 18:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="214896325"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2020 18:10:56 -0800
Date:   Sun, 19 Jan 2020 10:11:07 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] mm/mremap.c: cleanup move_page_tables() a little
Message-ID: <20200119021107.GA9745@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200118160702.9e5cc9f44ef855c070036331@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118160702.9e5cc9f44ef855c070036331@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 04:07:02PM -0800, Andrew Morton wrote:
>On Sat, 18 Jan 2020 07:22:49 +0800 Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> move_page_tables() tries to move page table by PMD or PTE.
>> 
>> The root reason is if it tries to move PMD, both old and new range should
>> be PMD aligned. But current code calculate old range and new range
>> separately.  This leads to some redundant check and calculation.
>> 
>> This cleanup tries to consolidate the range check in one place to reduce
>> some extra range handling.
>
>Thanks, I grabbed these, aimed at 5.7-rc1.

Thanks :)

-- 
Wei Yang
Help you, Help me
