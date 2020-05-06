Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626AEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A036206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgEFIW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:22:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:19981 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbgEFIW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:22:58 -0400
IronPort-SDR: 3Ako+PfXdeFEIKKuckXNebe1S4pUGL0UU9lkAPZrryEyktDLWvkjXJE+WyWDTDalvQbQeVxpda
 f5C2kzuZ16kw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 01:22:57 -0700
IronPort-SDR: zzl/daXJ0Oc7LgXfevtb/pXR40XCMnV3NryHB9opA31ZugUP9uNZBg7KMhVaAbYy82E8S3ZdAx
 7m7bWACakU1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="461682447"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2020 01:22:55 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] mm/swapfile.c: count won't be bigger than SWAP_MAP_MAX
References: <20200501015259.32237-1-richard.weiyang@gmail.com>
        <20200501015259.32237-3-richard.weiyang@gmail.com>
        <20200501154853.bca4cfb7b2558bd43a4942f3@linux-foundation.org>
        <20200502132911.u6y6hkh56ik4ojne@master>
Date:   Wed, 06 May 2020 16:22:54 +0800
In-Reply-To: <20200502132911.u6y6hkh56ik4ojne@master> (Wei Yang's message of
        "Sat, 2 May 2020 13:29:11 +0000")
Message-ID: <87k11pv5ep.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Fri, May 01, 2020 at 03:48:53PM -0700, Andrew Morton wrote:
>>On Fri,  1 May 2020 01:52:59 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>>> When the condition is true, there are two possibilities:
>>
>>I'm struggling with this one.
>>
>>>    1. count == SWAP_MAP_BAD
>>>    2. count == (SWAP_MAP_MAX & COUNT_CONTINUED) == SWAP_MAP_SHMEM
>>
>>I'm not sure what 2. is trying to say.  For a start, (SWAP_MAP_MAX &
>>COUNT_CONTINUED) is zero.  I guess it meant "|"?
>
> Oops, you are right. It should be (SWAP_MAP_MAX | COUNT_CONTINUED).
>
> Sorry for the confusion.
>
>>
>>Also, the return value documentation says we return EINVAL for migration
>>entries.  Where's that happening, or is the comment out of date?
>>
>
> Not paid attention to this.
>
> Take look into the code, I don't find a relationship between the swap count
> and migration. Seems we just make a migration entry but not duplicate it.  
> If my understanding is correct.

Per my understanding, one functionality of the error path is to catch
the behavior that shouldn't happen at all.  For example, if
__swap_duplicate() is called for the migration entry because of some
race condition.

Best Regards,
Huang, Ying
