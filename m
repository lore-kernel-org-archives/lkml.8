Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95549C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B16820714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCYFuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:50:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:65262 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgCYFuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:50:12 -0400
IronPort-SDR: +mCIFifJJG7HD+DzpfuRxGyDiCbpI5zvN7Ddo+w77n0hs8bpodKNmXWbQkGc9Y4+mRGr8T3TA5
 l/OyySCE8kVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 22:50:11 -0700
IronPort-SDR: 0VosqJrdoBsE2H7KRynW52/btwD78KKSC5cMCm427w2v8i/D//7WMDd+LIDjsQtF6R6Fo4v8AO
 uBYEbk3wky7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="357716875"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.5.64]) ([10.238.5.64])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2020 22:50:09 -0700
Subject: Re: [LKP] Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2%
 regression
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
To:     Rong Chen <rong.a.chen@intel.com>, Jan Kara <jack@suse.cz>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20191224005915.GW2760@shao2-debian>
 <20200107134106.GD25547@quack2.suse.cz> <20200107165708.GA3619@mit.edu>
 <20200107172824.GK25547@quack2.suse.cz>
 <fde1ad11-c9b0-4393-a123-3f7625c819fa@intel.com>
 <7ec6b078-7b09-fb87-8ad2-a328e96c5bf9@linux.intel.com>
Message-ID: <49a59199-53af-206f-d07c-5c8c45f498b3@linux.intel.com>
Date:   Wed, 25 Mar 2020 13:50:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7ec6b078-7b09-fb87-8ad2-a328e96c5bf9@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
The issue still exists in v5.6-rc7.

On 3/4/2020 4:15 PM, Xing Zhengjun wrote:
> Hi Matthew,
> 
>   We test it in v5.6-rc4, the issue still exist, do you have time to 
> take a look at this? Thanks.
> 
> On 1/8/2020 10:31 AM, Rong Chen wrote:
>>
>>
>> On 1/8/20 1:28 AM, Jan Kara wrote:
>>> On Tue 07-01-20 11:57:08, Theodore Y. Ts'o wrote:
>>>> On Tue, Jan 07, 2020 at 02:41:06PM +0100, Jan Kara wrote:
>>>>> Hello,
>>>>>
>>>>> On Tue 24-12-19 08:59:15, kernel test robot wrote:
>>>>>> FYI, we noticed a -20.2% regression of filebench.sum_bytes_mb/s 
>>>>>> due to commit:
>>>>>>
>>>>>>
>>>>>> commit: b1b4705d54abedfd69dcdf42779c521aa1e0fbd3 ("ext4: introduce 
>>>>>> direct I/O read using iomap infrastructure")
>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 
>>>>>> master
>>>>>>
>>>>>> in testcase: filebench
>>>>>> on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz 
>>>>>> with 8G memory
>>>>>> with following parameters:
>>>>>>
>>>>>>     disk: 1HDD
>>>>>>     fs: ext4
>>>>>>     test: fivestreamreaddirect.f
>>>>>>     cpufreq_governor: performance
>>>>>>     ucode: 0x27
>>>>> I was trying to reproduce this but I failed with my test VM. I had 
>>>>> SATA SSD
>>>>> as a backing store though so maybe that's what makes a difference. 
>>>>> Maybe
>>>>> the new code results in somewhat more seeks because the five 
>>>>> threads which
>>>>> compete in submitting sequential IO end up being more interleaved?
>>>> A "-20.2% regression" should be read as a "20.2% performance
>>>> improvement" is zero-day kernel speak.
>>> Are you sure? I can see:
>>>
>>>       58.30 ±  2%     -20.2%      46.53        filebench.sum_bytes_mb/s
>>>
>>> which implies to me previously the throughput was 58 MB/s and after the
>>> commit it was 46 MB/s?
>>>
>>> Anyway, in my testing that commit made no difference in that benchmark
>>> whasoever (getting around 97 MB/s for each thread before and after the
>>> commit).
>>>                                 Honza
>>
>> We're sorry for the misunderstanding, "-20.2%" means the change of 
>> filebench.sum_bytes_mb/s,
>> "regression" means the explanation of this change from LKP.
>>
>> Best Regards,
>> Rong Chen
>> _______________________________________________
>> LKP mailing list -- lkp@lists.01.org
>> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
