Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F2DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C517120409
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584120360;
	bh=wRoH0XObPna2Ps/42yGFV8BP9Pdctkf2Cj7NvYvE8Uw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AGUxG+967YsWnc661Lu8wt4DVcU+g5Xgp3egbW8Xb9o5OxXnASVzwANkz8TzIbxg1
	 SYPZ7nHir3b9I92RzeMc3FGmz3ygHAQgpD4zRSvphtv1Y82NlTLOP5GJELIFvtc4Sg
	 O3MNE87Gv3YaHpl9r+hIG9sDfV4jeeMrIyYZWjvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCMRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCMRZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:25:59 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE1A20409;
        Fri, 13 Mar 2020 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584120359;
        bh=wRoH0XObPna2Ps/42yGFV8BP9Pdctkf2Cj7NvYvE8Uw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qtqSJgrBrrDGyQlyq2ifUcznWqDoUIo7C4TVMfmxSk9BAXs5WpMEGiazJAvb9t2Eb
         rXdjTHfUDe6rOZ5eXpdp5Db14tg9RflsWpE1xeGQ3gNiNgkB6vFV7wh62oeOBBiYTU
         O+qQS9TqWKGHJSAUumgz19ynDQezJ7/Q+5zybJh8=
Subject: Re: [PATCH 0/2] selftests/harness: Handle timeouts cleanly
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200311211733.21211-1-keescook@chromium.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5da3bc61-6e43-f6d4-9623-0f4f1cb8e76a@kernel.org>
Date:   Fri, 13 Mar 2020 11:25:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311211733.21211-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On 3/11/20 3:17 PM, Kees Cook wrote:
> When a selftest would timeout before, the program would just fall over
> and no accounting of failures would be reported (i.e. it would result in
> an incomplete TAP report). Instead, add an explicit SIGALRM handler to
> cleanly catch and report the timeout.
> 
> Before:
> 
>          [==========] Running 2 tests from 2 test cases.
>          [ RUN      ] timeout.finish
>          [       OK ] timeout.finish
>          [ RUN      ] timeout.too_long
>          Alarm clock
> 
> After:
> 
>          [==========] Running 2 tests from 2 test cases.
>          [ RUN      ] timeout.finish
>          [       OK ] timeout.finish
>          [ RUN      ] timeout.too_long
>          timeout.too_long: Test terminated by timeout
>          [     FAIL ] timeout.too_long
>          [==========] 1 / 2 tests passed.
>          [  FAILED  ]
> 

This is good info. to capturein the commit logs for the patches.
Please add them and send v2. You can also fix the subject prefix
at the same time :)

thanks,
-- Shuah
