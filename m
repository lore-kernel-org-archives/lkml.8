Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED0C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF852071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587746177;
	bh=4l+HVHfLvsrCelx0Ha8/2UsHmy0khwI49AmQ14Qf0Ck=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=KMqp0tLUpQ3wVjfSTSH7vfXNGtptA4qJX66MHoptCs6rLWBQOQjt7fHmuLgnYu62E
	 ZlWX0ZtDPrbq0c4FUBM6NA6b1PKEarsKmgd3+Li5Q7EWdBMwYVfiroLQJhBOW0sL3S
	 z0iiRMyL5rrwcQfUCJq3kMdUXYXS2bSch93TjhW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgDXQgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgDXQgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:36:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CAA7206D7;
        Fri, 24 Apr 2020 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587746176;
        bh=4l+HVHfLvsrCelx0Ha8/2UsHmy0khwI49AmQ14Qf0Ck=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1Plyq2MmbY5dVeITi9gBhktKgD/2UrieoJMY8ma1k02oaPkn8uEP/iMtlDMtpU2GY
         gg1N8CVupAuEEA6yypTfcLTYV2DJ7qYtRtGAy3Qb3KutQ4iCRZSFvYbZh4iEJkJaM5
         EAZ+g8Tv20IZlf8ubW8+aztXFIUgjIrTgagprgj0=
Subject: Re: [PATCH 5.4 000/118] 5.4.35-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200422095031.522502705@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <e5338785-d238-077e-e563-b2e2328ddbfa@kernel.org>
Date:   Fri, 24 Apr 2020 10:36:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 3:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.35 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Apr 2020 09:48:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.35-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

