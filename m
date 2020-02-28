Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CFAC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F53246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582861335;
	bh=4QyGvuh99hk9j2XWEnr00K29Bgk8kv5gF6ccJumYNdY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cZBWhixu2K6FowLl7ww+/j19Ifbd35o34lRWolOWbNU3at4MitjMTNiXFfy5kBwlr
	 w4Mbgf787uL9updafzZS5vXxWLg8eczp4lCvTkZYO0VTw2RQydhGilEhe0BEOFce6C
	 0x6pG6EM/Zc+hMeN91pzTZZD6rc7hCHwzDVG6viI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgB1DmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbgB1DmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:42:14 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0B8246A1;
        Fri, 28 Feb 2020 03:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582861333;
        bh=4QyGvuh99hk9j2XWEnr00K29Bgk8kv5gF6ccJumYNdY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U/+uKp/tsc5feyEY0wIl6FgfpcuAZUQ9d0U7LYjhWsh7Q2cZ1fBq3V9OQi4rzklRb
         8RgFGJzwcZ3Z0ez1mt7TdYfOUHKTfkmeOYVquPrfXxwITKXzmPeqk6xsjlQeOnbN8A
         B0975Bn8X4TatKs1cxYYr6J/fZxI1vM3E5MxXvYc=
Subject: Re: [PATCH 4.14 000/237] 4.14.172-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200227132255.285644406@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <cf242d57-8253-e4be-94ab-8917c9972692@kernel.org>
Date:   Thu, 27 Feb 2020 20:42:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.172 release.
> There are 237 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.172-rc1.gz
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
