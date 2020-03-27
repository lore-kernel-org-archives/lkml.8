Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA186C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB86C20716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgC0Iqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:46:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:2058 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgC0Iqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:46:42 -0400
IronPort-SDR: ajW9eLjF99Q94bOokbHTbdWnOBaSGGUHCprt79fBeGnxIn6QeBWuEh3HGF4nr+Q7Q0G15MoTns
 MjK3YPfgeQcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:46:42 -0700
IronPort-SDR: m9bWDS0smC6fU10zjO7AJfBOg/gNnNGCaVr0F8Otjg4VJbEX2WXZ+lrW0mtLUCYuWtbLiux74X
 oPnqGlHqj3iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="271497408"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2020 01:46:40 -0700
Subject: Re: [mm] fd4d9c7d0c: stress-ng.switch.ops_per_sec -30.5% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
References: <20200326055723.GL11705@shao2-debian>
 <CAHk-=wi2c3UcK4fjUR2nM-7iUOAyQijq9ETfQHaN0WwFh2Bm9A@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <e8ed8717-4cfd-60c8-6c08-2915e5caed6c@intel.com>
Date:   Fri, 27 Mar 2020 16:46:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi2c3UcK4fjUR2nM-7iUOAyQijq9ETfQHaN0WwFh2Bm9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/20 12:57 AM, Linus Torvalds wrote:
> On Wed, Mar 25, 2020 at 10:57 PM kernel test robot
> <rong.a.chen@intel.com> wrote:
>> FYI, we noticed a -30.5% regression of stress-ng.switch.ops_per_sec due to commit:
>>
>> commit: fd4d9c7d0c71866ec0c2825189ebd2ce35bd95b8 ("mm: slub: add missing TID bump in kmem_cache_alloc_bulk()")
> This looks odd.
>
> I would not expect the update of c->tid to have that noticeable an
> impact, even on a big machine that might be close to some scaling
> limit.
>
> It doesn't add any expensive atomic ops, and while it _could_ make a
> percpu cacheline dirty, I think that cacheline should already be dirty
> anyway under any load where this is noticeable. Plus this should be a
> relatively cold path anyway.
>
> So mind humoring me, and double-check that regression?
>
> Of course, it might be another "just magic cache placement" detail
> where code moved enough to make a difference.
>
> Or maybe it really ends up causing new tid mismatches and we end up
> failing the fast path in slub as a result. But looking at the stats
> that changed in your message doesn't make me go "yeah, that looks like
> a slub difference".
>
> So before we look more at this, I'd like to make sure that the
> regression is actually real, and not noise.
>
> Please?
>
>               Linus

Hi Linus,

We rebuilt the kernels and tested more times, but the data is constant,
we are still checking this case.

Best Regards,
Rong Chen
