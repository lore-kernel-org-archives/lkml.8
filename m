Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6847C8300B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C8E206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgD1IKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:10:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:37237 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgD1IKQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:10:16 -0400
IronPort-SDR: Q6LhvMGYuY7Ers9L2++s6RQcz5NPn6HU7FxwwWOcj1ep8TA0x8/RQuGCd5ElsxetCBYUNh6c47
 otnM5ZtHaF4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 01:10:15 -0700
IronPort-SDR: CjZd/6KZIipPq+ntLgxh4XThTLyklQPN42fzO/WLWtPI9Zw6lVJBP7mN9EdZty+1839WmEfDvU
 31o1CsWjqlVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,327,1583222400"; 
   d="scan'208";a="367427144"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2020 01:10:13 -0700
Subject: Re: [PATCH v3 0/7] perf: Stream comparison
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
 <20200427101044.GA1457790@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d2fc66e5-d33a-0ed2-e46b-6cfbc4a941a6@linux.intel.com>
Date:   Tue, 28 Apr 2020 16:10:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427101044.GA1457790@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/27/2020 6:10 PM, Jiri Olsa wrote:
> On Mon, Apr 20, 2020 at 09:04:44AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>                compute_flag div.c:25                   compute_flag div.c:25
>>                compute_flag div.c:22                   compute_flag div.c:22
>>                        main div.c:40                           main div.c:40
>>                        main div.c:40                           main div.c:40
>>                        main div.c:39                           main div.c:39*
>>
>> [ Hot chains in old perf data only ]
>>
>> hot chain 1:
>>               cycles: 2, hits: 4.08%
>>           --------------------------
>>                        main div.c:42
>>                compute_flag div.c:28
>>
>> [ Hot chains in new perf data only ]
>>
>> hot chain 1:
>>                                                      cycles: 36, hits: 3.36%
>>                                                   --------------------------
>>                                                    __random_r random_r.c:357
>>                                                        __random random.c:293
>>                                                        __random random.c:293
>>                                                        __random random.c:291
>>                                                        __random random.c:291
>>                                                        __random random.c:291
>>                                                        __random random.c:288
>>                                                               rand rand.c:27
>>                                                               rand rand.c:26
>>                                                                     rand@plt
>>                                                                     rand@plt
>>                                                        compute_flag div.c:25
>>                                                        compute_flag div.c:22
>>                                                                main div.c:40
>>                                                                main div.c:40
>>
>> Now we can see, following streams pair is moved to another section
>> "[ Hot chains in old perf data but source line changed (*) in new perf data ]"
>>
>>              cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
>>          ---------------------------              --------------------------
>>                        main div.c:39                           main div.c:39*
>>                        main div.c:44                           main div.c:44
>>
> 
> 
> so I tried following:
> 
>    # ./perf record -e cycles:u -b ./perf bench sched pipe
>    # ./perf record -e cycles:u -b ./perf bench sched pipe
>    # ./perf diff -f --stream --before $PWD --after $PWD >out 2>&1
> 
> and the out file looks like this:
> 
>    [ Matched hot chains between old perf data and new perf data ]
> 
>    [ Hot chains in old perf data but source line changed (*) in new perf data ]
> 
>    [ Hot chains in old perf data only ]
> 
>    hot chain 1:
>                 cycles: 0, hits: 4.20%
>             --------------------------
>                     0xffffffff89c00163
> 
>    hot chain 2:
>                 cycles: 0, hits: 4.11%
>             --------------------------
>                     0xffffffff89c00163
> 
>    hot chain 3:
>                 cycles: 0, hits: 8.22%
>             --------------------------
>                     0xffffffff89c00163
> 
>    hot chain 4:
>                 cycles: 0, hits: 5.54%
>             --------------------------
>                     0xffffffff89c00163
> 
>    hot chain 5:
>                 cycles: 0, hits: 6.10%
>             --------------------------
>                     0xffffffff89c00163
> 
>    [ Hot chains in new perf data only ]
> 
>    hot chain 1:
>                                                         cycles: 0, hits: 5.21%
>                                                     --------------------------
>                                                             0xffffffff89c00163
> 
>    hot chain 2:
>                                                         cycles: 0, hits: 4.79%
>                                                     --------------------------
>                                                             0xffffffff89c00163
> 
>    hot chain 3:
>                                                         cycles: 0, hits: 5.44%
>                                                     --------------------------
>                                                             0xffffffff89c00163
> 
>    hot chain 4:
>                                                         cycles: 0, hits: 5.50%
>                                                     --------------------------
>                                                             0xffffffff89c00163
> 
>    hot chain 5:
>                                                         cycles: 0, hits: 7.14%
>                                                     --------------------------
>                                                             0xffffffff89c00163
> 
> 
> I'd expected more common paths, from what I can see from 'perf report --branch-history'
> on bpth perf.data and perf.data.old
> 
> jirka
> 

I used the same command line but I can see more callchain entries.

  perf record -e cycles:u -b perf bench sched pipe
  perf record -e cycles:u -b perf bench sched pipe
  perf diff --stream

[ Matched hot chains between old perf data and new perf data ]

hot chain pair 1:
              cycles: 0, hits: 7.95%                  cycles: 0, hits: 6.61%
         ---------------------------              --------------------------
               __libc_read read.c:27                   __libc_read read.c:27
                  0xffffffffa9800163                      0xffffffffa9800163

[ Hot chains in old perf data but source line changed (*) in new perf data ]

[ Hot chains in old perf data only ]

hot chain 1:
             cycles: 49, hits: 4.98%
          --------------------------
       worker_thread sched-pipe.c:64
       worker_thread sched-pipe.c:63
               __libc_read read.c:28
               __libc_read read.c:27
                  0xffffffffa9800163

hot chain 2:
              cycles: 0, hits: 6.68%
          --------------------------
                  0xffffffffa9800163

hot chain 3:
              cycles: 0, hits: 6.57%
          --------------------------
                  0xffffffffa9800163

hot chain 4:
             cycles: 60, hits: 5.20%
          --------------------------
       worker_thread sched-pipe.c:67
       worker_thread sched-pipe.c:60
       worker_thread sched-pipe.c:70
       worker_thread sched-pipe.c:70
               __libc_read read.c:28
               __libc_read read.c:27
                  0xffffffffa9800163

[ Hot chains in new perf data only ]

hot chain 1:
                                                     cycles: 68, hits: 7.83%
                                                  --------------------------
                                               worker_thread sched-pipe.c:68
                                                     __libc_write write.c:28
                                                     __libc_write write.c:27
                                                          0xffffffffa9800163
                                                     __libc_write write.c:27
                                                                   write@plt
                                                                   write@plt
                                               worker_thread sched-pipe.c:67
                                               worker_thread sched-pipe.c:60
                                               worker_thread sched-pipe.c:70
                                               worker_thread sched-pipe.c:70
                                                       __libc_read read.c:28

hot chain 2:
                                                     cycles: 70, hits: 4.34%
                                                  --------------------------
                                                   worker_thread unistd.h:44
                                               worker_thread sched-pipe.c:61
                                               worker_thread sched-pipe.c:65
                                                     __libc_write write.c:28
                                                     __libc_write write.c:27
                                                          0xffffffffa9800163
                                                     __libc_write write.c:27
                                                                   write@plt
                                                                   write@plt
                                               worker_thread sched-pipe.c:64
                                               worker_thread sched-pipe.c:63
                                                       __libc_read read.c:28

hot chain 3:
                                                      cycles: 0, hits: 5.67%
                                                  --------------------------
                                                          0xffffffffa9800163

hot chain 4:
                                                      cycles: 0, hits: 5.47%
                                                  --------------------------
                                                          0xffffffffa9800163

It's interesting that some leaked kernel address are displayed in callchains 
even we use the -e cycles:u. Should be the skid issue. I have a patch for 
processing the kernel leaked samples but have not posted it.

But I'm no idea why only the leaked kernel address displayed in your example. :(

Thanks
Jin Yao
