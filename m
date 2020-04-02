Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0772AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE81C208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbgDBBti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:49:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:21352 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgDBBti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:49:38 -0400
IronPort-SDR: LZq+Kp3R49xZucv2z5MWCd5kksSGRxed3wEjC9pSxYzh6INBtVF2zlq89gGe9vKyRN7VE/LSKW
 uGETbs4Jr+pQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 18:49:37 -0700
IronPort-SDR: i/S/kqoV2XLfBcwuoAcph+w+D88RFxrkZjVZtRZv5s53U84lBAZQQw30Fzqo4O9Ng7LQH46v71
 4FzN8VKLfKzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="396191444"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 18:49:34 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
References: <20200331085604.1260162-1-ying.huang@intel.com>
        <965DC015-7D6F-430D-8FB7-A24A814C13BE@nvidia.com>
Date:   Thu, 02 Apr 2020 09:49:33 +0800
In-Reply-To: <965DC015-7D6F-430D-8FB7-A24A814C13BE@nvidia.com> (Zi Yan's
        message of "Tue, 31 Mar 2020 08:24:07 -0400")
Message-ID: <87d08qhd1u.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 31 Mar 2020, at 4:56, Huang, Ying wrote:
>>
>> From: Huang Ying <ying.huang@intel.com>
>> -       /* FOLL_DUMP will return -EFAULT on huge zero page */
>> -       page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>> +       if (pmd_present(*pmd)) {
>> +               /* FOLL_DUMP will return -EFAULT on huge zero page */
>> +               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>> +       } else if (unlikely(is_swap_pmd(*pmd))) {
>
> Should be:
>           } else if (unlikely(thp_migration_support() && is_swap_pmd(*pmd))) {

Thought this again.  This can reduce the code size if
thp_migration_support() isn't enabled.  I will do this in the next
version.

Best Regards,
Huang, Ying
