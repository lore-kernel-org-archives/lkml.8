Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDAE2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJDap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:30:45 -0400
Received: from foss.arm.com ([217.140.110.172]:44876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgGJDan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:30:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4103831B;
        Thu,  9 Jul 2020 20:30:43 -0700 (PDT)
Received: from [10.163.87.77] (unknown [10.163.87.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BA903F9AB;
        Thu,  9 Jul 2020 20:30:38 -0700 (PDT)
Subject: Re: [PATCH V4] mm/vmstat: Add events for THP migration without split
To:     Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
 <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <50cc0a0d-e04e-9e5d-26a6-73a91944ba8c@arm.com>
Date:   Fri, 10 Jul 2020 09:00:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/09/2020 09:04 PM, Randy Dunlap wrote:
> Hi,
> 
> I have a few comments on this.
> 
> a. I reported it very early and should have been Cc-ed.

I should have Cc-ed you on this V4 patch, sorry about that.

> 
> b. A patch that applies to mmotm or linux-next would have been better
> than a full replacement patch.
I have followed that (i.e patch on mmotm/next as fix) only when the
required change is smaller as compared to the series on mmotm/next.
But for others a new patch should be better which can be replaced
on mmotm and next. At least that is my understanding and would like
to be corrected otherwise.

> 
> c. I tried replacing what I believe is the correct/same patch file in mmotm
> and still have build errors.

That should not have happened, all new THP migration events are with
CONFIG_MIGRATION rather than CONFIG_TRANSPARENT_HUGEPAGE previously.
