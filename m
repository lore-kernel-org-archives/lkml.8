Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C1EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08354246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582861458;
	bh=FzWk4N9ogTfVMhMkMYcmP33YicN7Tms0aGFqyyxykqo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OtS3+zmIlRyidt/3jeEIuYlJpcu3p1rmPveiIeVt/og/b6tGuG1q9HVySgVchF/wv
	 lMrIinNXyeeNXywd+UoxTUDPPKEosUHyfGjnjMkclcC8qJOa9fG8inYMmP3r3lhgsf
	 Y5N24TpqTj2w6R29Hd8QizxRIAptG/OOQlHtkYWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgB1DoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbgB1DoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:44:16 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F870246A1;
        Fri, 28 Feb 2020 03:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582861456;
        bh=FzWk4N9ogTfVMhMkMYcmP33YicN7Tms0aGFqyyxykqo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=srJRASiVIBQordezfxvVfRNgdpbTaeFWmlSu4YxQnPSG/hWR8biZthigitDG2dEXX
         1Y0acvcwXe7Wa2P1PXMGyb4fOkFObApJSBql9hZs6uYmo0/P113WoB4TbkyYKpP5W/
         G3L8YWTNyPpL5zqPFqkJDyOcaLgfIs28dbpMcT0k=
Subject: Re: [PATCH 4.9 000/165] 4.9.215-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200227132230.840899170@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <18aba4e2-02e2-b9f4-d62a-5be1cd2996b2@kernel.org>
Date:   Thu, 27 Feb 2020 20:44:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 6:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.215 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.215-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
