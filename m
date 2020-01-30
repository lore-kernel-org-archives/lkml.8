Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06579C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D511C2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgA3XEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:04:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:56248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgA3XEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:04:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 15:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,383,1574150400"; 
   d="scan'208";a="218436177"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2020 15:04:52 -0800
Date:   Fri, 31 Jan 2020 07:05:07 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        kirill@shutemov.name, dan.j.williams@intel.com,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Patch v2 0/4] mm/mremap: cleanup move_page_tables() a little
Message-ID: <20200130230507.GA15192@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200129002642.13508-1-richardw.yang@linux.intel.com>
 <50f408bd-502e-bd02-53d4-719300736ce2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50f408bd-502e-bd02-53d4-719300736ce2@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 01:18:00AM +0300, Dmitry Osipenko wrote:
>29.01.2020 03:26, Wei Yang пишет:
>> move_page_tables() tries to move page table by PMD or PTE.
>> 
>> The root reason is if it tries to move PMD, both old and new range should
>> be PMD aligned. But current code calculate old range and new range
>> separately.  This leads to some redundant check and calculation.
>> 
>> This cleanup tries to consolidate the range check in one place to reduce
>> some extra range handling.
>> 
>> v2:
>>   * remove 3rd patch which doesn't work on ARM platform. Thanks report from
>>     Dmitry Osipenko
>> 
>> Wei Yang (4):
>>   mm/mremap: format the check in move_normal_pmd() same as
>>     move_huge_pmd()
>>   mm/mremap: it is sure to have enough space when extent meets
>>     requirement
>>   mm/mremap: calculate extent in one place
>>   mm/mremap: start addresses are properly aligned
>> 
>>  include/linux/huge_mm.h |  2 +-
>>  mm/huge_memory.c        |  8 +-------
>>  mm/mremap.c             | 17 ++++++-----------
>>  3 files changed, 8 insertions(+), 19 deletions(-)
>> 
>
>Hello Wei,
>
>I haven't noticed any problems using the v2. Thank you very much for
>addressing the problem!
>

Glad to hear this.

Actually, really thanks for your patience on testing and reporting the
problem.

Have a nice day :-)

>Tested-by: Dmitry Osipenko <digetx@gmail.com>

-- 
Wei Yang
Help you, Help me
