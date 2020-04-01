Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCEC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B420787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585772503;
	bh=CvBMEziJK6QTVlRs8WBNAwTidyoTQln1TJB/ijH5s8M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=O6YTOJZjDhvuFfXcipuvQsACiX1uWb/te2HRBMqWkj0AWEkMIOydI3TEUWpda4Xsa
	 rAE0f4MFs6YabBKwGzxk1z8Yau8LWaZKs/M+sOmrf/i5fkBgLohXaQh99UR/sEKuwt
	 vkIM5QFzQwWg12UgP+5VU8sbAmNpdYX0QzfZ3e+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbgDAUVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732385AbgDAUVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:21:40 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BECC920784;
        Wed,  1 Apr 2020 20:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585772500;
        bh=CvBMEziJK6QTVlRs8WBNAwTidyoTQln1TJB/ijH5s8M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ClLciJ4wwJ2Bi9vwk8jX59vF6SEUrkYu/yLIiIegCQVjYryjiMv7fXJhloDT5ngah
         cphVBEf+77zGu3G0k8acW0GKXB1EOWMOBG2YT2Qt7kVCoW4WdEf7d/AtQ788wn9/GI
         2i+SohRFRH3bs9NCYu2mID0Ds7WpuMF0B0EfAyDw=
Subject: Re: [PATCH 5.6 00/10] 5.6.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20200401161413.974936041@linuxfoundation.org>
 <CAHk-=wiVBvO1b5UzfcHm6y4KLHOp3huFfGMdW21F6g25oUePLw@mail.gmail.com>
 <20200401172242.GA2582092@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <e335c0cf-640a-31a9-54fe-45493e006f3e@kernel.org>
Date:   Wed, 1 Apr 2020 14:21:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401172242.GA2582092@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 11:22 AM, Greg Kroah-Hartman wrote:
> On Wed, Apr 01, 2020 at 10:06:47AM -0700, Linus Torvalds wrote:
>> On Wed, Apr 1, 2020 at 9:19 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> This is the start of the stable review cycle for the 5.6.2 release.
>>
>> Good. You made 5.6.1 so quickly that I didn't have time to react and
>> say that it makes little sense without the 802.11 fix, but you're
>> obviously making 5.6.2 quickly, so..
> 

wifi issue I was seeing on my laptop with 5.6.0 is now resolved.
Thanks for pulling this in quickly.

thanks,
-- Shuah
