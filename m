Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7503CC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A2B21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581531411;
	bh=IyIY0/EgyNmjqsAdVgjLfhCJXVillaTCbgTouXKUUyw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FTtx8hvi92tSiKH+cpeV6sVXDafDreXfLdIVAbShQIDeJP0hEosadsoVZnNYD5xzU
	 62eyIdJDp3hEo9oibptkmR/lUnfvEChZ404lYwV2HFJvVEXwvO3l9dM630QAMyJ7cO
	 9ZrJfbnI58K/EQCKh6WFHmEYr2tHoJNuM2xQ5JrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgBLSQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:16:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgBLSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:16:50 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819FA2073C;
        Wed, 12 Feb 2020 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581531409;
        bh=IyIY0/EgyNmjqsAdVgjLfhCJXVillaTCbgTouXKUUyw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RSLjw6EVs/cpmR+j9KFYo8fm5nyedNY3nM6ynL6qh3S0lGFEOLpsxgIdFyrFEplxd
         Fz/0LsynMpkoiF+vyV8++XR5YZ0hhP1nzazwbnmI9GMYwGzmWjAwnqmSMMzSkOwnAc
         t0kHPNHG5Ly5F2HS6GScuySGDcze4dRpJuFtHWww=
Subject: Re: Linux 5.6-rc1 kselftest build failures
To:     Dmitry Safonov <dima@arista.com>, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Andrei Vagin <avagin@gmail.com>,
        shuah <shuah@kernel.org>
References: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
 <c31e468a-3afe-f9b6-b006-c3bc3f35f1cc@arista.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c191597b-c12e-9d06-01a3-7a7dda4f124f@kernel.org>
Date:   Wed, 12 Feb 2020 11:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c31e468a-3afe-f9b6-b006-c3bc3f35f1cc@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/20 7:09 AM, Dmitry Safonov wrote:
> Hi Shuah,
> 
> On 2/12/20 12:35 AM, shuah wrote:
>> The following tests fail to build on x86_64
> [..]
>> timerns:
>>
>> tools/testing/selftests/timens'
>> gcc -Wall -Werror -pthread  -lrt -ldl  timens.c  -o
>> tools/testing/selftests/timens/timens
>> /usr/bin/ld: /tmp/ccGy5CST.o: in function `check_config_posix_timers':
>> timens.c:(.text+0x65a): undefined reference to `timer_create'
>> collect2: error: ld returned 1 exit status
> 
> I've just send a patch to fix it:
> https://lkml.kernel.org/r/20200212140040.126747-1-dima@arista.com
> 
> Could you try it?

Yup. Works, responsed to the patch thread.

> 
> Also, it seems that the same thing affects futex/rtc/tcp_mmap/tcp_inq tests?
> 
> While looking into this, I see there are new auto-generated lkmdtm &&
> pidfd tests, is it worth to add them to .gitignore?
> 

Thanks for finding. Yes please send a patch for this.

thanks,
-- Shuah
