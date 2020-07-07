Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90179C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674ED2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135812;
	bh=2YOrN/eXCeYZZ+Hvhn0y30XY5LNsyOcDuqV7G/KEYhs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LywcxxQC8rfOPerXm808Ft0BnZCFznh5QTyFS3Y0fByeWkaq0jCwrVohlSrQFpdrL
	 wKGxFW9x79i6oE8PqLJnF8jXqPaCdckIAmCRPWHuzYthTD7J0Z7wp7Q9uU8LwvbuYh
	 efDYDPGAR0q2B+MQsgqKXnBK6w5RxiYxPTqojoAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgGGPaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbgGGPYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:24:16 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC2C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:24:16 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r8so35163643oij.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQlH+5Rxv1TZTmNUKokYf1gRnidmklj65FW3ajui8n8=;
        b=gtkvz8FGNaNJgUQOYZxrh8RQ//6B5EnuDkuA0CI343tqSUwxmVFPrUj22a9A5eJ0d8
         PeRYJ7/r2g4Kb8/uLNJPEoQbqvXD4iPm2Z9HvDz4VKCy0kRM+h+dhgWKuhgTucsBKEob
         mQC+mhd+P5O+UaZRgc8Myl3wXAx5Vygcp/Uq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQlH+5Rxv1TZTmNUKokYf1gRnidmklj65FW3ajui8n8=;
        b=Bq3EwaK7BH7J8v2HfDfG0MjCBU7NhymTiuhvdXMUoeTFAMRUCUUr+uUa718FZLMpHJ
         O7QCeuc02ivg1PqmIWcG3GxfmE4RfWtC/2S0ASIY/9b3XAGEHfzdJ/ISNFFU21pB3PyN
         TAoZMX4Aq3GxMZo0RiAKzo2Fgk6krqS2PXCukq7IqEctLQvUST6AGRt4DvslD9nZcrW+
         NSu3hxtI2vUrj3kk1fR8HERAVEItgf8knzvj4cHxTQxPetNd3z6XBq2YMrOTHcRKgEvF
         Hw0avXsrobHJiakpOMmEcaaYdEJ4G4cbP5z2hrzCHCL+KpB2T+vlJ1JrW/FOcdDyhL9H
         /tMg==
X-Gm-Message-State: AOAM531gC3+2rTXQIniEdL85UAB8VodNMz1gIhqSsMwKxMLUxOs568MD
        5ftY2g3aiGDfrn9y3F4DratC3w==
X-Google-Smtp-Source: ABdhPJwTBVZClUaOBGBLJNT1lD+iIbNdX7fMrPQfh1eSqtSETAt6r/3QI8NT+64KTOzF8Wxb/CGV8w==
X-Received: by 2002:aca:5158:: with SMTP id f85mr3774047oib.6.1594135455807;
        Tue, 07 Jul 2020 08:24:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t16sm188781oou.28.2020.07.07.08.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:24:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] selftests: pidfd: do not use ksft_exit_skip after
 ksft_set_plan
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, shuah@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200707101936.12052-1-pbonzini@redhat.com>
 <20200707101936.12052-2-pbonzini@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f10aaf26-39f6-79ae-c3cc-56c31835f57e@linuxfoundation.org>
Date:   Tue, 7 Jul 2020 09:24:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707101936.12052-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 4:19 AM, Paolo Bonzini wrote:
> Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
> than planned.  Use ksft_test_result_skip instead.
> 
> The plan passed to ksft_set_plan was wrong, too, so fix it while at it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20200623001547.22255-5-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tools/testing/selftests/pidfd/pidfd_test.c | 34 +++++++++++++++++++---
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index 7aff2d3b42c0..f65ad4e32353 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -8,6 +8,7 @@
>   #include <sched.h>
>   #include <signal.h>
>   #include <stdio.h>
> +#include <stdbool.h>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <syscall.h>
> @@ -27,6 +28,8 @@
>   
>   #define MAX_EVENTS 5
>   
> +static bool have_pidfd_send_signal = false;

You don't need to initialize this to false. Rest looks good.

> +
>   static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
>   {
>   	size_t stack_size = 1024;
> @@ -56,6 +59,13 @@ static int test_pidfd_send_signal_simple_success(void)
>   	int pidfd, ret;
>   	const char *test_name = "pidfd_send_signal send SIGUSR1";
>   
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>   	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
>   	if (pidfd < 0)
>   		ksft_exit_fail_msg(
> @@ -86,6 +96,13 @@ static int test_pidfd_send_signal_exited_fail(void)
>   	pid_t pid;
>   	const char *test_name = "pidfd_send_signal signal exited process";
>   
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>   	pid = fork();
>   	if (pid < 0)
>   		ksft_exit_fail_msg("%s test: Failed to create new process\n",
> @@ -137,6 +154,13 @@ static int test_pidfd_send_signal_recycled_pid_fail(void)
>   	pid_t pid1;
>   	const char *test_name = "pidfd_send_signal signal recycled pid";
>   
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>   	ret = unshare(CLONE_NEWPID);
>   	if (ret < 0)
>   		ksft_exit_fail_msg("%s test: Failed to unshare pid namespace\n",
> @@ -325,15 +349,17 @@ static int test_pidfd_send_signal_syscall_support(void)
>   
>   	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
>   	if (ret < 0) {
> -		if (errno == ENOSYS)
> -			ksft_exit_skip(
> +		if (errno == ENOSYS) {
> +			ksft_test_result_skip(
>   				"%s test: pidfd_send_signal() syscall not supported\n",
>   				test_name);
> -
> +			return 0;
> +		}
>   		ksft_exit_fail_msg("%s test: Failed to send signal\n",
>   				   test_name);
>   	}
>   
> +	have_pidfd_send_signal = true;
>   	close(pidfd);
>   	ksft_test_result_pass(
>   		"%s test: pidfd_send_signal() syscall is supported. Tests can be executed\n",
> @@ -521,7 +547,7 @@ static void test_pidfd_poll_leader_exit(int use_waitpid)
>   int main(int argc, char **argv)
>   {
>   	ksft_print_header();
> -	ksft_set_plan(4);
> +	ksft_set_plan(8);
>   
>   	test_pidfd_poll_exec(0);
>   	test_pidfd_poll_exec(1);
> 

thanks,
-- Shuah
