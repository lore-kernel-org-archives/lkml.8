Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C363C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4732924959
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347545;
	bh=XipnPd5rd2M5w8iTqFjOmWhstavs032S5pyhbIG9/UM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=I3kxvi9qfeli4xOTptmJ1Hg23RbPAaewbODpxhG0r/jdq8fzxwh/Q4j5K54thPOtM
	 bMyGM11WKDlmmGUXTQ5T8UpFYuePFxA3r9nZtsrNS6sZBguEsKiKLWiCBogNFZXxTd
	 qSnpqtDO0EU0QybaDOCmNSW9o+dq9fD0QDevVtdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgEAPjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbgEAPjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:39:03 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE0724958;
        Fri,  1 May 2020 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347543;
        bh=XipnPd5rd2M5w8iTqFjOmWhstavs032S5pyhbIG9/UM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wbdP/MH9AxBlALdz6uIDyNQCScm1mDXLUX94+vwX4Ws/3t29JSUBUesuuqO0E90Zq
         pZR+1LICO8k27qfVnpJu4OPDJKnzKEIdMiJHcE2dOB//YZs4NyiPKRmXKa5VWbeuB1
         /AJyzP0YHu0kG/y6Qt++Ijb3Y1T/RVfs9NN3kfdw=
Subject: Re: [PATCH 2/3] selftests/ftrace: Pick only the first kprobe event to
 test
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>, skhan@linuxfoundation.org,
        shuah <shuah@kernel.org>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
 <158834027133.28357.11196486193798517250.stgit@devnote2>
 <20200501101718.5a15e557@gandalf.local.home>
From:   shuah <shuah@kernel.org>
Message-ID: <7751734b-83f1-bf14-9d8e-9092b0b7be3e@kernel.org>
Date:   Fri, 1 May 2020 09:38:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501101718.5a15e557@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 8:17 AM, Steven Rostedt wrote:
> On Fri,  1 May 2020 22:37:51 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Since the kprobe/kprobe_args_type.tc reads out all event logs
>> from the trace buffer, the test can fail if there is another
>> fork event happens.
>> Use head command to pick only the first kprobe event from
>> the trace buffer to test the argument types.
>>
>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> ---
>>   .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>> index 1bcb67dcae26..81490ecaaa92 100644
>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>> @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
>>     echo 0 > events/kprobes/testprobe/enable
>>   
>>     : "Confirm the arguments is recorded in given types correctly"
>> -  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>> +  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>>     check_types $ARGS $width
>>   
>>     : "Clear event for next loop"
> 
> I think I've manually added this exact change to my tests to keep it from
> failing.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 

Does this conflict with:

Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date:   Tue Apr 7 14:34:19 2020 +0800

     selftests/ftrace: Check the first record for kprobe_args_type.tc

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=f0c0d0cf590f71b2213b29a7ded2cde3d0a1a0ba

I went into mainline yesterday in my rc4 pull request.

Exact change it appears.

diff --git 
a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc 
b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 1bcb67dcae26..81490ecaaa92 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -38,7 +38,7 @@ for width in 64 32 16 8; do
    echo 0 > events/kprobes/testprobe/enable

    : "Confirm the arguments is recorded in given types correctly"
-  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) 
arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
+  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) 
arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
    check_types $ARGS $width

    : "Clear event for next loop"

thanks,
-- Shuah
