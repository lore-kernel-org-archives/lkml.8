Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F212071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgIAHEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:04:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:31873 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIAHEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:04:11 -0400
IronPort-SDR: ZMtPtc26BJ17MpnKYf/1RKl5SyDtCW7td/N0GiokmpGeugIH+tkfknZ12NYQH0KwceYhh5F1jY
 uc2kbXMt+Kig==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175163124"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="175163124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 00:04:09 -0700
IronPort-SDR: efF1CteDSvGUjeuCqyhMEUNm9cFV4TnP7lq8jUVXOjIXznGnws6g1EdUdV4PMWcoPSQL7jVqCX
 5ZCmFbREJVsw==
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="502140536"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 00:04:06 -0700
Subject: Re: [LKP] Re: [rcuperf] 4e88ec4a9e:
 UBSAN:division-overflow_in_arch/x86/include/asm/div64.h
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200831120122.GH4299@shao2-debian>
 <20200831155037.GZ2855@paulmck-ThinkPad-P72>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <649fd850-602f-7f0d-d286-73a8dd88ad6d@intel.com>
Date:   Tue, 1 Sep 2020 15:03:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200831155037.GZ2855@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/20 11:50 PM, Paul E. McKenney wrote:
> On Mon, Aug 31, 2020 at 08:01:22PM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: 4e88ec4a9eb17527e640b063f79e5b875733eb53 ("rcuperf: Change rcuperf to rcuscale")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>>
>> in testcase: trinity
>> with following parameters:
>>
>> 	runtime: 300s
>>
>> test-description: Trinity is a linux system call fuzz tester.
>> test-url: http://codemonkey.org.uk/projects/trinity/
>>
>>
>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> +---------------------------------------------------------+------------+------------+
>> |                                                         | 65bd77f554 | 4e88ec4a9e |
>> +---------------------------------------------------------+------------+------------+
>> | boot_successes                                          | 13         | 0          |
>> | boot_failures                                           | 0          | 14         |
>> | UBSAN:division-overflow_in_arch/x86/include/asm/div64.h | 0          | 14         |
>> | error:#[##]                                             | 0          | 14         |
>> | EIP:main_func.cold                                      | 0          | 14         |
>> | Kernel_panic-not_syncing:Fatal_exception                | 0          | 14         |
>> +---------------------------------------------------------+------------+------------+
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <lkp@intel.com>
> Does the patch below fix this for you?

Yes, this patch can fix the issue, and nreaders was adjusted to 1:

[    5.953645] The force parameter has not been set to 1. The Iris 
poweroff handler will not be installed.
[   12.546587] rcu-ref-scale: --- Start of test:  verbose=0 shutdown=1 
holdoff=10 loops=10000 nreaders=-1 nruns=30 readdelay=0
[   12.561495] ------------[ cut here ]------------
[   12.562016] ref_scale_init: nreaders = 0, adjusted to 1
[   12.562601] WARNING: CPU: 0 PID: 1 at kernel/rcu/refscale.c:684 
ref_scale_init+0x653/0x80

Best Regards,
Rong Chen

>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit d301e320e952e2e604d83d9540e52510b0eb3d94
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Aug 27 09:58:19 2020 -0700
>
>      refscale: Bounds-check module parameters
>      
>      The default value for refscale.nreaders is -1, which results in the code
>      setting the value to three-quarters of the number of CPUs.  On single-CPU
>      systems, this results in three-quarters of the value one, which the C
>      language's integer arithmetic rounds to zero.  This in turn results in
>      a divide-by-zero error.
>      
>      This commit therefore adds bounds checking to the refscale module
>      parameters, so that if they are less than one, they are set to the
>      value one.
>      
>      Reported-by: kernel test robot <lkp@intel.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 952595c..fb5f20d 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -681,6 +681,12 @@ ref_scale_init(void)
>   	// Reader tasks (default to ~75% of online CPUs).
>   	if (nreaders < 0)
>   		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
> +	if (WARN_ONCE(loops <= 0, "%s: loops = %ld, adjusted to 1\n", __func__, loops))
> +		loops = 1;
> +	if (WARN_ONCE(nreaders <= 0, "%s: nreaders = %d, adjusted to 1\n", __func__, nreaders))
> +		nreaders = 1;
> +	if (WARN_ONCE(nruns <= 0, "%s: nruns = %d, adjusted to 1\n", __func__, nruns))
> +		nruns = 1;
>   	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
>   			       GFP_KERNEL);
>   	if (!reader_tasks) {
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

