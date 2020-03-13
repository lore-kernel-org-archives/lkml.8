Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3EEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88965206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584121285;
	bh=Q9eKxBHSZ2zwJDDmxdgSBw1Sc0XC5s0XCrjoJgqtRq8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qMsEB4gBd05nB5HeJP5eDHhw9GF+V/88GNrNsiY+gylyqsknMO7v6hoBPwffljEyr
	 U5v7WEvqoJfoTYUTE/epWCy3H6Vr6fI6cvRn9N9HuciVroow7CetWZ6N7VwS5HloO1
	 +iXuFssWz83j9OibCFpYyc6fJdjHpyrFiw6LY+8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCMRlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:41:24 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9133F206CD;
        Fri, 13 Mar 2020 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584121283;
        bh=Q9eKxBHSZ2zwJDDmxdgSBw1Sc0XC5s0XCrjoJgqtRq8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UwuRGWj+4E1iD45piEECswLWVR1VvJHVJD5K+XG7Aby326NN1YVyiNMHIDdC0lGTb
         gvWCd5PbZRvg2YF4P/+g6VwGbU0XfPsYa85ZiuIt3q5HJl2nATId/Y68Ua50RcQuov
         xKXyYRSlX37nmztpfZOj9xZGpuGlSGYM6+vvEh4w=
Subject: Re: [PATCHv2] selftests/timers: Turn off timeout setting
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     sboyd@kernel.org, tglx@linutronix.de, john.stultz@linaro.org,
        joe.lawrence@redhat.com, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200225165749.6399-1-po-hsu.lin@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <6e13759d-370f-6cd3-34a7-08f2a9b6c0f0@kernel.org>
Date:   Fri, 13 Mar 2020 11:41:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225165749.6399-1-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 9:57 AM, Po-Hsu Lin wrote:
> The following 4 tests in timers can take longer than the default 45
> seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
> Add 45 second timeout per test) to run:

Please use the commit format:

commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second 
timeout per test")

>    * nsleep-lat - 2m7.350s
>    * set-timer-lat - 2m0.66s
>    * inconsistency-check - 1m45.074s
>    * raw_skew - 2m0.013s
> 
> Thus they will be marked as failed with the current 45s setting:
>    not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>    not ok 4 selftests: timers: set-timer-lat # TIMEOUT
>    not ok 6 selftests: timers: inconsistency-check # TIMEOUT
>    not ok 7 selftests: timers: raw_skew # TIMEOUT
> 
> Disable the timeout setting for timers can make these tests finish
> properly:
>    ok 3 selftests: timers: nsleep-lat
>    ok 4 selftests: timers: set-timer-lat
>    ok 6 selftests: timers: inconsistency-check
>    ok 7 selftests: timers: raw_skew
> 
> https://bugs.launchpad.net/bugs/1864626
Please add Fixes tag with commit 852c8cbf34d3 
("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>   tools/testing/selftests/timers/Makefile | 1 +
>   tools/testing/selftests/timers/settings | 1 +
>   2 files changed, 2 insertions(+)
>   create mode 100644 tools/testing/selftests/timers/settings
> 
> diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
> index 7656c7c..0e73a16 100644
> --- a/tools/testing/selftests/timers/Makefile
> +++ b/tools/testing/selftests/timers/Makefile
> @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
>   
>   TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
>   
> +TEST_FILES := settings
>   
>   include ../lib.mk
>   
> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/timers/settings
> @@ -0,0 +1 @@
> +timeout=0
> 

thanks,
-- Shuah
