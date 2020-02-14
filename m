Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26D5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D866222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgBNMCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:02:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:21801 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgBNMCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:02:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 04:02:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="434772638"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.193.108]) ([10.249.193.108])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2020 04:02:01 -0800
Subject: Re: [perf/x86/amd] 471af006a7: will-it-scale.per_process_ops -7.6%
 regression
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20200212113514.GT12867@shao2-debian>
 <20200212121830.GR14897@hirez.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <ca326232-d084-3562-af78-1d9c6bdacd56@intel.com>
Date:   Fri, 14 Feb 2020 20:02:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212121830.GR14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/2020 8:18 PM, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 07:35:14PM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -7.6% regression of will-it-scale.per_process_ops due to commit:
>>
>>
>> commit: 471af006a747f1c535c8a8c6c0973c320fe01b22 ("perf/x86/amd: Constrain Large Increment per Cycle events")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: will-it-scale
>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
> That commit only changes code relevant to AMD machines; give you have
> this result on an Intel machine makes me think the bisect is flawed.

Hi,

Sorry for the inconvenience, the regression is stable on our platform, 
we're investigating it.

Best Regards,
Rong Chen
