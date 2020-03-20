Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A80BC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6095D2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584715621;
	bh=EkWxp6DOsISjV04sDISIAHdyAJaajF7MydZzKwlbcuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tjeBKKQwtyto/ekB2THHjJDzeiL2oGro9KcpkoIuxJU/HtbB1JWvU0NvuO+nDyj8A
	 moKr26pwhl87tA70ctgV6OHy6CRPF13MLjVnAqNE6pahYHxspFCgFTc1dIWYms7Vfv
	 fVybKum/Ddq0TsNg1nQYx9oNVY6Czx9JRoKhMSPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgCTOrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgCTOrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:47:00 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 326BD20714;
        Fri, 20 Mar 2020 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584715619;
        bh=EkWxp6DOsISjV04sDISIAHdyAJaajF7MydZzKwlbcuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7LjqDAg8NykX6zsT1JTH+tARE5M4KboA4UGxmkUj0wIpzzJEBJwfL/9AWnVgJTD1
         /2hMIzIvD/GmLKIN3xvUnbQ7kuxao9s+6dP0ZcWvT8jQw2wq+/X/YtBFBOXRdoLvuf
         mlbqM3Kb+yHUAaRpq6K7R0hWTiAlKy87UBvitK6M=
Date:   Fri, 20 Mar 2020 10:46:58 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 5.5 00/65] 5.5.11-rc1 review
Message-ID: <20200320144658.GK4189@sasha-vm>
References: <20200319123926.466988514@linuxfoundation.org>
 <fcf6db4c-cebe-9ad3-9f19-00d49a7b1043@roeck-us.net>
 <20200319145900.GC92193@kroah.com>
 <32c627bf-0e6b-8bc4-88d3-032a69484aa6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <32c627bf-0e6b-8bc4-88d3-032a69484aa6@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:15:40AM -0700, Guenter Roeck wrote:
>On 3/19/20 7:59 AM, Greg Kroah-Hartman wrote:
>> On Thu, Mar 19, 2020 at 07:44:33AM -0700, Guenter Roeck wrote:
>>> On 3/19/20 6:03 AM, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 5.5.11 release.
>>>> There are 65 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Sat, 21 Mar 2020 12:37:04 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>
>>> arm:davinci_all_defconfig fails to build.
>>>
>>> include/linux/gpio/driver.h: In function 'gpiochip_populate_parent_fwspec_twocell':
>>> include/linux/gpio/driver.h:552:1: error: no return statement in function returning non-void [-Werror=return-type]
>>>   552 | }
>>>
>>> The problem is caused by commit 8db6a5905e98 ("gpiolib: Add support for the
>>> irqdomain which doesn't use irq_fwspec as arg") which is missing its fix,
>>> commit 9c6722d85e922 ("gpio: Fix the no return statement warning"). That one
>>> is missing a Fixes: tag, providing a good example why such tags are desirable.
>>
>> Thanks for letting me know, I've now dropped that patch (others
>> complained about it for other reasons) and will push out a -rc2 with
>> that fix.
>>
>
>I did wonder why the offending patch was included, but then I figured that
>I lost the "we apply too many patches to stable releases" battle, and I didn't
>want to re-litigate it.

I usually much rather take prerequisite patches rather than do
backports, which is why that patch was selected.

-- 
Thanks,
Sasha
