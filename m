Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF06C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E612B22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgH0JRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:17:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:14585 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0JR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:17:28 -0400
IronPort-SDR: sjrbu/lqPu7v3BCkJxkze/Z4ycI6GbnaveubbOrYLU4EC5FqTZrMGhdPxYjl5smBrh7E0U9OC5
 aVY7a42lklZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="144126653"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="144126653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 02:17:27 -0700
IronPort-SDR: HdQxFMr4zj2enzdTrdXmT80q/wsDt4eE7fyTrad+oevMENTV2ftTvQfynT7O87FaDZnxXq2+fx
 +0n5m6xLojHA==
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="475133419"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 02:17:25 -0700
Subject: Re: [mm] c566586818:
 BUG:kernel_hang_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
To:     Catalin Marinas <catalin.marinas@arm.com>, Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <34a960a0-ec0b-3c26-ec73-e415a8197757@intel.com>
 <9D9FBD8D-DF19-4DA9-B0B1-260BA72D3712@lca.pw> <20200826173010.GD24545@gaia>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <120c99ce-6439-2945-e990-588c42a9e582@intel.com>
Date:   Thu, 27 Aug 2020 17:16:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200826173010.GD24545@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/20 1:30 AM, Catalin Marinas wrote:
> On Tue, Aug 25, 2020 at 11:02:40PM -0400, Qian Cai wrote:
>> On Aug 25, 2020, at 8:44 PM, Rong Chen <rong.a.chen@intel.com> wrote:
>>> I rebuilt the kernel on commit c566586818 but the error changed to
>>> "RIP: 0010:clear_page_orig+0x12/0x40", and the error can be
>>> reproduced on parent commit:
>> Catalin, any thought? Sounds like those early kmemleak allocations
>> cause some sort of memory corruption?
> I can't immediately see how but Rong implies that the error also happens
> on the parent commit. Does it mean the bisection isn't entirely right?
>

Hi Catalin,

The original bisection is for "BUG:kernel_hang_in_early-boot_stage" 
which locate to commit c566586818,
and the boot will go on and meet the error "RIP: 
0010:clear_page_orig+0x12/0x40" if we set
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=400, but the error shouldn't cause 
by commit c566586818
because we can reproduce the error on parent commit.

Best Regards,
Rong Chen
