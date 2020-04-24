Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B690C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E7220774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587747089;
	bh=v47mgOKAClzASxcV2Mt75OgxIokGkWQHNoCwnSJqPWA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LADTOTERhhDtCXM0HxDi9zhLw+60EiIr4GJ0kzQO2JIJ8byTa9/ElwyX2gxLe5u7J
	 H99qEQyvGkjkhgmptOMm2rlOkd5RK4cc0MmZRegUEvuJBrvPL3ua0Xy83NC+66+RWN
	 Mz65yr5FQfkhPwaM/FY7FIw22miIqjExl60Op7pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgDXQv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgDXQv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:51:28 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D6F20728;
        Fri, 24 Apr 2020 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587747087;
        bh=v47mgOKAClzASxcV2Mt75OgxIokGkWQHNoCwnSJqPWA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QJSZlg2jczNQ0oqxMs1FnlaRM5IhqNa1apITy8fV4t+qOxnXQKjTliYnLGpV+QR5D
         LZ3FJYfxSmpbVmy7ZDCbuOGp3Jc+dM2GQ74RzOfpRRZvKTTytdsJOxcvtYEaBB+GGF
         tTzcN1AhWiuFbKYfyxokAWz2OEDKKM5uRmeMkTUg=
Subject: Re: [PATCH 4.4 00/99] 4.4.220-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200423103313.886224224@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <499f3bd9-b8cb-1858-0f5e-e19b4340faeb@kernel.org>
Date:   Fri, 24 Apr 2020 10:51:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423103313.886224224@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/20 4:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.220 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 Apr 2020 10:31:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.220-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
