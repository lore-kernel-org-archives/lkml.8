Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4936C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0912073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585867643;
	bh=XvBGSTZIz8tQ3dcznCOh3NDhQl0Z07A4ntvcJgby23o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1W5zwCzw/HmAbAZii14sKYm5MdHBo5jzSdNVN0TTjckn276Euwg8maHyqpWQ5Hhn2
	 u6SPrkPxKhQT4vr2SlWJ1iIfdU9hqnr8DVnL7oT6MkzQ4MDtorn1m8tCrjK4UZF2GN
	 ouPp7GOrZICrxXXceqO8+A3B3JP1vlPLgkBCUW18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbgDBWrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389402AbgDBWrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:47:22 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F6492072E;
        Thu,  2 Apr 2020 22:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585867641;
        bh=XvBGSTZIz8tQ3dcznCOh3NDhQl0Z07A4ntvcJgby23o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B/AETOtwWiRZ+WH+0cLHbEB3QC4v9O0DdK6YTeQ4AinegbWOUz4wAsZ2c9IqCKhu0
         DGX200/omt39fJJ54EpKQqY93fxKu2E4BcWnhVypLKkjidKf+WiPwAT/IFDsCs6GfA
         tJ7OSZSQ3TWXQnIm3jWfZ9Qru9SihFsF9dhuBCqo=
Subject: Re: [PATCH 4.14 000/148] 4.14.175-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200401161552.245876366@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <595bd91a-3be3-acfc-0784-d81a9076b60a@kernel.org>
Date:   Thu, 2 Apr 2020 16:47:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 10:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.175 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Apr 2020 16:09:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.175-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
