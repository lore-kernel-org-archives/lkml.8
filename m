Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE7C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A573020826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIBHx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:53:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:6168 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIBHxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:53:24 -0400
IronPort-SDR: UY2ILCo1TO2A+D3cUmLKMhcIoyyFB7JvCkhmO245T/1LcZqaB5XFUhZPebdVfxGNT5b7nxd741
 MW4Y1VjlgI+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="158338536"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="158338536"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 00:53:22 -0700
IronPort-SDR: 85agHi/zZwdSU7fkFbZoQx29XPaqbBiirB+Fo+FsB6N69zyl/N1FTJ2LUwSGqslJhs+OnjLv/C
 XvZbmzxC8nBQ==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="477536794"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.175.78]) ([10.249.175.78])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 00:53:16 -0700
Subject: Re: [kthread] 2e7d8748eb: last_state.is_incomplete_run
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, axboe@kernel.dk,
        akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
References: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com>
 <20200820062533.GK18179@shao2-debian>
 <CAPx_LQGBY-QzXnYMB4zZ=Q5yyRGFF9W68NgB8gqqXchRjUD2WQ@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <dbe28d52-1879-66b7-a490-29fe5e14a703@intel.com>
Date:   Wed, 2 Sep 2020 15:53:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPx_LQGBY-QzXnYMB4zZ=Q5yyRGFF9W68NgB8gqqXchRjUD2WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the input, we do detect this on this commit but not its parent.
It may be merged into a wrong base branch or something else that
we are not aware of. And it's kind difficulty now for us to provide a
reproduction step for kexec issue, we will consider this further.

Best Regards,
Rong Chen


On 8/27/2020 11:49 AM, qianli zhao wrote:
> I did not see any exceptions related to my changes,the corresponding
> macro CONFIG_DEBUG_OBJECTS_KTHREAD is not enabled,so i think the issue
> has nothing to do with my changes
>
> Thanks
>
> On Thu, 20 Aug 2020 at 14:26, kernel test robot <rong.a.chen@intel.com> wrote:
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: 2e7d8748eba7e32150cbd4f57129ea77d1255892 ("[RFC V2] kthread: add object debug support")
>> url: https://github.com/0day-ci/linux/commits/Qianli-Zhao/kthread-add-object-debug-support/20200812-131719
>> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git fb893de323e2d39f7a1f6df425703a2edbdf56ea
>>
>> in testcase: boot
>>
>> on test machine: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>>
>> kernel boot failed by kexec:
>>
>> user  :notice:  [32m[  +0.371313]  [0m [33mLKP [0m: kexec loading...
>> user  :notice:  [32m[  +0.007118]  [0mkexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/2e7d8748eba7e32150cbd4f57129ea77d1255892/vmlinuz-5.8.0-12610-g2e7d8748eba7e --initrd=/opt/rootfs/tmp/initrd-concatenated
>>
>>
>>
>>
>> Thanks,
>> Rong Chen
>>

