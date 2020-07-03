Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F33C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F5520771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGCFzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:55:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:18291 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCFzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:55:03 -0400
IronPort-SDR: cyE/XyKNTNP02QGL9eZ++jUH7tQLOlY6uI8mJeKM04XHvpGhF1LIBNsRINWF3TZvVhyamJSLyJ
 +67QT3iWbIuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="208614433"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="208614433"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 22:55:02 -0700
IronPort-SDR: 1/dfEGOro3OAp3tG2MJqrkY5IghHqv7u5uY+3ngl3gAohzd5F0aeqOqnBbBiejAoHWeqVvuGwh
 8P6CBD5tp6tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="321718978"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2020 22:55:00 -0700
Subject: Re: [bpf] af7ec13833: will-it-scale.per_process_ops -2.5% regression
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200628085032.GT5535@shao2-debian>
 <cb4cab43-8f13-dd2a-5c58-855d93c6e790@fb.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <1d98d1f0-fe84-6df7-f5bd-f4cb2cdb7f45@intel.com>
Date:   Fri, 3 Jul 2020 13:54:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cb4cab43-8f13-dd2a-5c58-855d93c6e790@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/20 11:10 PM, Yonghong Song wrote:
>
>
> On 6/28/20 1:50 AM, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -2.5% regression of will-it-scale.per_process_ops 
>> due to commit:
>>
>>
>> commit: af7ec13833619e17f03aa73a785a2f871da6d66b ("bpf: Add 
>> bpf_skc_to_tcp6_sock() helper")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> One of previous emails claims that
>     commit: 492e639f0c222784e2e0f121966375f641c61b15 ("bpf: Add 
> bpf_seq_printf and bpf_seq_write helpers")
> is reponsible for 2.5% improvement for will-it-scale.per_process_ops, 
> which I believe is false.
>
> This commit should not cause regression.
>
> Probably the variation of performance is caused by test environment 
> which you may want to investigate further to reduce false alarming.
> Thanks!

Hi Yonghong,

It's a function align issue, the commit effects the align of functions 
which causes a little regression,
we force to set -falign-functions=32 in KBUILD_CFLAGS and the regression 
is gone:

diff --git a/Makefile b/Makefile
index 70def4907036c..9746afa4edc21 100644
--- a/Makefile
+++ b/Makefile
@@ -476,7 +476,7 @@ LINUXINCLUDE    := \
                 $(USERINCLUDE)

  KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
+KBUILD_CFLAGS   := -Wall -Wundef -falign-functions=32 
-Werror=strict-prototypes -Wno-trigraphs \
                    -fno-strict-aliasing -fno-common -fshort-wchar 
-fno-PIE \
                    -Werror=implicit-function-declaration 
-Werror=implicit-int \
                    -Wno-format-security \


Best Regards,
Rong Chen

>
>>
>> in testcase: will-it-scale
>> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 
>> 2.30GHz with 192G memory
>> with following parameters:
>>
>>     nr_task: 16
>>     mode: process
>>     test: mmap1
>>     cpufreq_governor: performance
>>     ucode: 0x5002f01
>>
>> test-description: Will It Scale takes a testcase and runs it from 1 
>> through to n parallel copies to see if the testcase will scale. It 
>> builds both a process and threads based test in order to see any 
>> differences between the two.
>> test-url: https://github.com/antonblanchard/will-it-scale
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> Details are as below:
> [...]

