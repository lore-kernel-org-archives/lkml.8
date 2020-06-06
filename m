Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A412C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 03:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6A920723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 03:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgFFDDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 23:03:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:15627 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgFFDDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 23:03:18 -0400
IronPort-SDR: 1PBqU7sDNs4OOz5KaiqMstFDSwrFpOnYZ3UnHHTyPhlFXhFSBeL20t5YfceHktlcF/gT9fCsJ8
 Qlbe5Uzea8pQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 20:03:18 -0700
IronPort-SDR: wEF+1kd51aRzfdSObmlDpRVOambjQk0OeFZRP2myEztEe1jvDy6ZrDWeWy22bg2VV21s7c7u/T
 UwKN/FYnPl2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; 
   d="scan'208";a="294885055"
Received: from wdu1-mobl3.ccr.corp.intel.com (HELO [10.255.30.207]) ([10.255.30.207])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2020 20:03:14 -0700
Subject: Re: [net] a6211caa63:
 dmesg.UBSAN:signed-integer-overflow_in_arch/x86/include/asm/atomic.h
To:     Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Yuqi Jin <jinyuqi@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jiong Wang <jiongwang@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200605080929.GK12456@shao2-debian>
 <CANn89iK1EfAqw-SkXyQR=88fKnBpXCcR_FaiFkVDUNazNgAX1g@mail.gmail.com>
 <20200605140521.GD4117@hirez.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a33f477a-3847-f870-bf3f-845910b90665@intel.com>
Date:   Sat, 6 Jun 2020 11:03:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200605140521.GD4117@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2020 10:05 PM, Peter Zijlstra wrote:
> On Fri, Jun 05, 2020 at 06:17:51AM -0700, Eric Dumazet wrote:
>> On Fri, Jun 5, 2020 at 1:10 AM kernel test robot <rong.a.chen@intel.com> wrote:
>> There you go.
>>
>> We decided this was a bogus report, and that UBSAN requires sane compilers.
>>
>> Please read the fine comment that was added in this commit and update
>> your compiler or do not mess with compiler flags.
>>
>> +       /* If UBSAN reports an error there, please make sure your compiler
>> +        * supports -fno-strict-overflow before reporting it that was a bug
>> +        * in UBSAN, and it has been fixed in GCC-8.
>> +        */
>> +       return atomic_add_return(segs + delta, p_id) - segs;
>>>          make HOSTCC=gcc-4.9 CC=gcc-4.9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> Rong, can you make sure to exclude gcc<8 for UBSAN reports ?

Got it, thank's for your warning.

Best Regards,
Rong Chen


