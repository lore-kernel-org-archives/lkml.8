Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF56C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9112072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCIIhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:37:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:59851 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgCIIhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:37:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 01:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="230853650"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2020 01:37:36 -0700
Subject: Re: [kbuild-all] Re: arch/x86/mm/fault.o: warning: objtool:
 do_page_fault()+0x4fb: unreachable instruction
To:     Frederic Weisbecker <frederic@kernel.org>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
References: <202003061843.YVzsDc3A%lkp@intel.com>
 <20200306142732.GA8590@lenoir>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d242f3cb-e95b-441e-0a32-a0279100eeaf@intel.com>
Date:   Mon, 9 Mar 2020 16:37:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200306142732.GA8590@lenoir>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/20 10:27 PM, Frederic Weisbecker wrote:
> On Fri, Mar 06, 2020 at 06:48:47PM +0800, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   9f65ed5fe41ce08ed1cb1f6a950f9ec694c142ad
>> commit: ee6352b2c47a24234398e06381edd93a8e965976 x86/context-tracking: Remove exception_enter/exit() from do_page_fault()
>> date:   8 weeks ago
>> config: x86_64-randconfig-a002-20200306 (attached as .config)
>> compiler: gcc-4.9 (Debian 4.9.2-10+deb8u1) 4.9.2
>> reproduce:
>>          git checkout ee6352b2c47a24234398e06381edd93a8e965976
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> arch/x86/mm/fault.o: warning: objtool: do_page_fault()+0x4fb: unreachable instruction
> I tried several versions of gcc and I can't reproduce the warning. Also looking
> at the code I fail to find an actual unreachable path. Do you still have the vmlinux around?
>
>

Hi Frederic,

Sorry for the inconvenience, we checked again and only found this issue 
on gcc-4.9.2,
and there's no issue on gcc-4.9.3 or other new versions.

Best Regards,
Rong Chen
