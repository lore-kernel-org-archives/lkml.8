Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25B42078A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407749AbgDPGQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:16:41 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:34439 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2407264AbgDPGQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:16:26 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 16 Apr
 2020 14:16:15 +0800
Received: from [10.28.64.103] (10.28.64.103) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 16 Apr
 2020 14:16:13 +0800
Subject: Re: [PATCH] x86/perf: Add hardware performance events support for
 Zhaoxin CPU.
To:     Borislav Petkov <bp@alien8.de>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <cooperyan@zhaoxin.com>, <codyyao@zhaoxin.com>
References: <1586747669-4827-1-git-send-email-CodyYao-oc@zhaoxin.com>
 <20200415093635.GD31016@zn.tnic>
From:   CodyYao-oc <CodyYao-oc@zhaoxin.com>
Message-ID: <a4e4ee8a-bce8-64da-891e-c2705181f7da@zhaoxin.com>
Date:   Thu, 16 Apr 2020 14:16:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415093635.GD31016@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.64.103]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/15 下午5:36, Borislav Petkov wrote:
> On Mon, Apr 13, 2020 at 11:14:29AM +0800, CodyYao-oc wrote:
>> Zhaoxin CPU has provided facilities for monitoring performance
>> via PMU(Performance Monitor Unit), but the functionality is unused so far.
>> Therefore, add support for zhaoxin pmu to make performance related
>> hardware events available.
>>
>> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> What exactly did the 0day bot report?
> 
> Put that in []
> 
> above the Reported-by line pls.
> 

Dear Boris,

It's a warning message about uninitialized variable, paste the log 
below, sorry for missing it.

Furthermore, it will disappear on next version patch because of the code 
changes, anyway I'll paste it when resend next version patch.

[All warnings (new ones prefixed by >>):

 >> arch/x86/events/zhaoxin/core.c:362:6: warning: variable 'is_zxc' is 
used uninitialized whenever 'if' condition is false 
[-Wsometimes-uninitialized]
            if (boot_cpu_data.x86 == 0x06 &&
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    arch/x86/events/zhaoxin/core.c:369:6: note: uninitialized use occurs 
here
            if (is_zxc)
                ^~~~~~
    arch/x86/events/zhaoxin/core.c:362:2: note: remove the 'if' if its 
condition is always true
            if (boot_cpu_data.x86 == 0x06 &&
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 >> arch/x86/events/zhaoxin/core.c:362:6: warning: variable 'is_zxc' is 
used uninitialized whenever '&&' condition is false 
[-Wsometimes-uninitialized]
            if (boot_cpu_data.x86 == 0x06 &&
                ^~~~~~~~~~~~~~~~~~~~~~~~~
    arch/x86/events/zhaoxin/core.c:369:6: note: uninitialized use occurs 
here
            if (is_zxc)
                ^~~~~~
    arch/x86/events/zhaoxin/core.c:362:6: note: remove the '&&' if its 
condition is always true
            if (boot_cpu_data.x86 == 0x06 &&
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    arch/x86/events/zhaoxin/core.c:352:13: note: initialize the variable 
'is_zxc' to silence this warning
            bool is_zxc;
                       ^
                        = 0
    2 warnings generated.]

Reported-by:kbuild test robot<lkp@intel.com>

Thanks
Cody
