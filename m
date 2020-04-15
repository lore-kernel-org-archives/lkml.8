Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B8520768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635401AbgDOHza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:55:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:59506 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635370AbgDOHzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:55:14 -0400
IronPort-SDR: 8VFGD9xYiKGW1cGyItq3/+6B70LoH2DeNbsh91+QyD3moo8yvD0QQ+g0uKSTHkhWLKYavoAI+X
 ZjHQuc4P823g==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 00:55:13 -0700
IronPort-SDR: JiBWpD4OT+aq9OHuUR2nj62YWIW+mr2j0NQVFFQxawcLI1svK9apYS16Eeiu+lml+F7/JMev68
 USYQV7fanHAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="363605489"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.5.222]) ([10.238.5.222])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2020 00:55:10 -0700
Subject: Re: [LKP] Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2%
 regression
To:     Jan Kara <jack@suse.cz>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20191224005915.GW2760@shao2-debian>
 <20200107134106.GD25547@quack2.suse.cz> <20200107165708.GA3619@mit.edu>
 <20200107172824.GK25547@quack2.suse.cz>
 <fde1ad11-c9b0-4393-a123-3f7625c819fa@intel.com>
 <7ec6b078-7b09-fb87-8ad2-a328e96c5bf9@linux.intel.com>
 <49a59199-53af-206f-d07c-5c8c45f498b3@linux.intel.com>
 <20200325143102.GJ28951@quack2.suse.cz>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <309baa89-9f69-0545-946e-4b3624f83e60@linux.intel.com>
Date:   Wed, 15 Apr 2020 15:55:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200325143102.GJ28951@quack2.suse.cz>
Content-Type: multipart/mixed;
 boundary="------------D732FA19680423D3AE941DF7"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D732FA19680423D3AE941DF7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/25/2020 10:31 PM, Jan Kara wrote:
> On Wed 25-03-20 13:50:09, Xing Zhengjun wrote:
>> ping...
>> The issue still exists in v5.6-rc7.
> 
> So I have tried again to reproduce this so that I can look into the
> regression. When observing what is actually happening in the system I have
> to say that this workfile (or actually its implementation in filebench) is
> pretty dubious. The problem is that filebench first creates the files by
> writing them through ordinary write(2). Then it immediately starts reading
> the files with direct IO read. So what happens is that by the time direct
> IO read is running, the system is still writing back the create files and
> depending on how read vs writes get scheduled, you get different results.
> Also direct IO read will first flush the range it is going to read from the
> page cache so to some extent this is actually parallel small ranged
> fsync(2) benchmark. Finally differences in how we achieve integrity of
> direct IO reads with dirty page cache are going to impact this benchmark.
> 

Sounds reasonable!  Thanks for the clarification!

> So overall can now see why this commit makes a difference but the workload
> is IMHO largely irrelevant. What would make sense is to run filebench once,
> then unmount & mount the fs to force files to disk and clear page cache and
> then run it again. Filebench will reuse the files in this case and then
> parallel direct IO readers without page cache are a sensible workload. But
> I didn't see any difference in that (even with rotating disk) on my
> machines.
> 
We do a test per your suggestion, run "filebench" once during setup 
stage, then do a "sync",  after that run "filebench" again, from the 
attached test result "compare", "filebench.sum_bytes_mb/s" regression is 
disappeared.

> 								Honza
>>
>> On 3/4/2020 4:15 PM, Xing Zhengjun wrote:
>>> Hi Matthew,
>>>
>>>    We test it in v5.6-rc4, the issue still exist, do you have time to
>>> take a look at this? Thanks.
>>>
>>> On 1/8/2020 10:31 AM, Rong Chen wrote:
>>>>
>>>>
>>>> On 1/8/20 1:28 AM, Jan Kara wrote:
>>>>> On Tue 07-01-20 11:57:08, Theodore Y. Ts'o wrote:
>>>>>> On Tue, Jan 07, 2020 at 02:41:06PM +0100, Jan Kara wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> On Tue 24-12-19 08:59:15, kernel test robot wrote:
>>>>>>>> FYI, we noticed a -20.2% regression of
>>>>>>>> filebench.sum_bytes_mb/s due to commit:
>>>>>>>>
>>>>>>>>
>>>>>>>> commit: b1b4705d54abedfd69dcdf42779c521aa1e0fbd3
>>>>>>>> ("ext4: introduce direct I/O read using iomap
>>>>>>>> infrastructure")
>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
>>>>>>>> master
>>>>>>>>
>>>>>>>> in testcase: filebench
>>>>>>>> on test machine: 8 threads Intel(R) Core(TM) i7-4770
>>>>>>>> CPU @ 3.40GHz with 8G memory
>>>>>>>> with following parameters:
>>>>>>>>
>>>>>>>>      disk: 1HDD
>>>>>>>>      fs: ext4
>>>>>>>>      test: fivestreamreaddirect.f
>>>>>>>>      cpufreq_governor: performance
>>>>>>>>      ucode: 0x27
>>>>>>> I was trying to reproduce this but I failed with my test
>>>>>>> VM. I had SATA SSD
>>>>>>> as a backing store though so maybe that's what makes a
>>>>>>> difference. Maybe
>>>>>>> the new code results in somewhat more seeks because the
>>>>>>> five threads which
>>>>>>> compete in submitting sequential IO end up being more interleaved?
>>>>>> A "-20.2% regression" should be read as a "20.2% performance
>>>>>> improvement" is zero-day kernel speak.
>>>>> Are you sure? I can see:
>>>>>
>>>>>        58.30 ±  2%     -20.2%      46.53        filebench.sum_bytes_mb/s
>>>>>
>>>>> which implies to me previously the throughput was 58 MB/s and after the
>>>>> commit it was 46 MB/s?
>>>>>
>>>>> Anyway, in my testing that commit made no difference in that benchmark
>>>>> whasoever (getting around 97 MB/s for each thread before and after the
>>>>> commit).
>>>>>                                  Honza
>>>>
>>>> We're sorry for the misunderstanding, "-20.2%" means the change of
>>>> filebench.sum_bytes_mb/s,
>>>> "regression" means the explanation of this change from LKP.
>>>>
>>>> Best Regards,
>>>> Rong Chen
>>>> _______________________________________________
>>>> LKP mailing list -- lkp@lists.01.org
>>>> To unsubscribe send an email to lkp-leave@lists.01.org
>>>
>>
>> -- 
>> Zhengjun Xing

-- 
Zhengjun Xing

--------------D732FA19680423D3AE941DF7
Content-Type: text/plain; charset=UTF-8;
 name="compare"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="compare"

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KdGJveF9ncm91cC90ZXN0Y2Fz
ZS9yb290ZnMva2NvbmZpZy9jb21waWxlci9kZWJ1Zy1zZXR1cC9kaXNrL2ZzL3Rlc3QvY3B1
ZnJlcV9nb3Zlcm5vci91Y29kZToKICBsa3AtaHN3LWQwMS9maWxlYmVuY2gvZGViaWFuLXg4
Nl82NC0yMDE5MTExNC5jZ3oveDg2XzY0LXJoZWwtNy42L2djYy03L3Rlc3QyLzFIREQvZXh0
NC9maXZlc3RyZWFtcmVhZGRpcmVjdC5mL3BlcmZvcm1hbmNlLzB4MjcKCmNvbW1pdDogCiAg
YjFiNDcwNWQ1NGFiZWRmZDY5ZGNkZjQyNzc5YzUyMWFhMWUwZmJkMwogIDA5ZWRmNGQzODE5
NTdiMTQ0NDQwYmFjMThhNDc2OWM1MzA2M2I5NDMKICB2NS41CiAgdjUuNy1yYzEKCmIxYjQ3
MDVkNTRhYmVkZmQgMDllZGY0ZDM4MTk1N2IxNDQ0NDBiYWMxOGE0ICAgICAgICAgICAgICAg
ICAgICAgICAgdjUuNSAgICAgICAgICAgICAgICAgICAgdjUuNy1yYzEgCi0tLS0tLS0tLS0t
LS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gCiAgICAgICAgICVzdGRkZXYg
ICAgICVjaGFuZ2UgICAgICAgICAlc3RkZGV2ICAgICAlY2hhbmdlICAgICAgICAgJXN0ZGRl
diAgICAgJWNoYW5nZSAgICAgICAgICVzdGRkZXYKICAgICAgICAgICAgIFwgICAgICAgICAg
fCAgICAgICAgICAgICAgICBcICAgICAgICAgIHwgICAgICAgICAgICAgICAgXCAgICAgICAg
ICB8ICAgICAgICAgICAgICAgIFwgIAogICAgIDU5LjQwICAgICAgICAgICAgKzAuMCUgICAg
ICA1OS40MCAgICAgICAgICAgIC0wLjglICAgICAgNTguOTMgICAgICAgICAgICAtMS4wJSAg
ICAgIDU4LjgwICAgICAgICBmaWxlYmVuY2guc3VtX2J5dGVzX21iL3MKICAgICAgMzU3MCAg
ICAgICAgICAgICswLjAlICAgICAgIDM1NzAgICAgICAgICAgICAtMC44JSAgICAgICAzNTQx
ICAgICAgICAgICAgLTEuMCUgICAgICAgMzUzMyAgICAgICAgZmlsZWJlbmNoLnN1bV9vcGVy
YXRpb25zCiAgICAgNTkuNTAgICAgICAgICAgICArMC4wJSAgICAgIDU5LjUwICAgICAgICAg
ICAgLTAuOCUgICAgICA1OS4wMiAgICAgICAgICAgIC0xLjAlICAgICAgNTguODkgICAgICAg
IGZpbGViZW5jaC5zdW1fb3BlcmF0aW9ucy9zCiAgICAgNTkuMzMgICAgICAgICAgICArMC4w
JSAgICAgIDU5LjMzICAgICAgICAgICAgKzAuMCUgICAgICA1OS4zMyAgICAgICAgICAgIC0w
LjYlICAgICAgNTkuMDAgICAgICAgIGZpbGViZW5jaC5zdW1fcmVhZHMvcwogICAgIDgzLjk4
ICAgICAgICAgICAgLTEuNSUgICAgICA4Mi43NSAgICAgICAgICAgICswLjglICAgICAgODQu
NjIgICAgICAgICAgICArMS4wJSAgICAgIDg0Ljg0ICAgICAgICBmaWxlYmVuY2guc3VtX3Rp
bWVfbXMvb3AK
--------------D732FA19680423D3AE941DF7--
