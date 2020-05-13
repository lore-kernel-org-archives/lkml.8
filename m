Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EAF20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589410889;
	bh=HFB2CGVGSIWhoZvJMSjlv4YeL+A57y7In5icMGNlvJI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FVjYB1nGT1X9U8z5lFrs3agMFbxd0SjdFcwf0fGofQwOCouLcjpBm2ULZDBY22HoD
	 RThD6flL4qk+bNhPF1eCThCfBBd88+jyxElKTv4A+yJebvNwOgc6w1dWnNqjFHKMhD
	 SNvHZl3/Vjs4lvh7K0xwr4CQ3NQxZ/MUMS4+QJZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbgEMXB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbgEMXB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:01:26 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE5120675;
        Wed, 13 May 2020 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589410886;
        bh=HFB2CGVGSIWhoZvJMSjlv4YeL+A57y7In5icMGNlvJI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NYFBS4gNDIYXpiCuzUm3eAzsF1qT+OFoCV78iqye/pSw3RxsY02Lzxe2TfMQHDtoF
         vQJIzO9jgBRBSbi6vcZAMllO3kjS2G7fNRcB0/U6SCsvq/10/WzYiO2wKZtgDcD7aQ
         n/gRSDrS8z+2oln1E1ttbJnvDFdoB/U0dgtf/fh0=
Subject: Re: [PATCH 5.4 00/90] 5.4.41-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200513094408.810028856@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <926e46a4-6473-9f47-3c9c-da5bbc55fe7f@kernel.org>
Date:   Wed, 13 May 2020 17:01:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/20 3:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.41 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 15 May 2020 09:41:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.41-rc1.gz
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
