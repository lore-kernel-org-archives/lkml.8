Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D3C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5EC20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437887AbgDOULg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:11:36 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:57029 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406385AbgDOULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:11:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvdzQpm_1586981488;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TvdzQpm_1586981488)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Apr 2020 04:11:30 +0800
Subject: Re: [PATCHv3, RESEND 1/8] khugepaged: Add self test
To:     Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-2-kirill.shutemov@linux.intel.com>
 <3DDA6828-36E9-4D1E-8F8A-4FA1D913DE89@nvidia.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <faf2dddb-d87f-c630-742f-cfdffe216411@linux.alibaba.com>
Date:   Wed, 15 Apr 2020 13:11:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3DDA6828-36E9-4D1E-8F8A-4FA1D913DE89@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/20 8:39 AM, Zi Yan wrote:
> On 13 Apr 2020, at 8:52, Kirill A. Shutemov wrote:
>
>> External email: Use caution opening links or attachments
>>
>>
>> The test checks if khugepaged is able to recover huge page where we
>> expect to do so. It only covers anon-THP for now.
>>
>> Currently the test shows few failures. They are going to be addressed by
>> the following patches.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Zi Yan <ziy@nvidia.com>
>
> All tests passed with the whole series applied on v5.6 and Linus’ tree (commit: 8632e9b5).

I didn't run the tests by myself, I choose to trust the result from Zi Yan.

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> Thanks.
>
> —
> Best Regards,
> Yan Zi

