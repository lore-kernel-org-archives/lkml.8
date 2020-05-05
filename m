Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF1C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243D7206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588693494;
	bh=DltG1TSA0zc4dgQ8qzx6DMt08SbaGrZDKWaHbqNis4k=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Cbxc1OacahD/9R5STUBGZ+H8K9RZJMlfMVWVpULEPemlTlTw5peaRXq0rjLoRdUKf
	 ABYa1sY8nwJIO+CLyO2rLgk523mSMQgaz0Ru/hijAHtNTtTq/MpSJgCLx8V/cyBca6
	 H7pTbjuPRXLmpomjygT4p6khooxfjXPV92JENvbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgEEPox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbgEEPow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:44:52 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86512078D;
        Tue,  5 May 2020 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588693492;
        bh=DltG1TSA0zc4dgQ8qzx6DMt08SbaGrZDKWaHbqNis4k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l2QrwGtM54sPIt7fDgc7y7z2kezW4FNCGg5vybNPZcI4GqEzSqPYhYM6yGDyM+f4I
         EF/aHelDPFuUfqWXntroGqenpqzroT3l0y9oP+QxswVAkbzwaTxkfB0KfOyKpAumqA
         z0WFM9qsocaDYx4HWx9epuyNpiw3yczxZquPo0s0=
Subject: Re: [PATCH 5.4 00/57] 5.4.39-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200504165456.783676004@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <27acec6e-20c3-2d47-6254-7e0a19709b0f@kernel.org>
Date:   Tue, 5 May 2020 09:44:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 11:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.39 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2020 16:52:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.39-rc1.gz
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
