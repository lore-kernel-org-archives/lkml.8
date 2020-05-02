Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C0C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4863C208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588461265;
	bh=z2xDfe2nsqG9FjHrPXPh77KoVrvObAsI7+pJsQc+kYQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hnqLxim2tZx/pErPyXGeQzKESr2ipE2zIpd1IxRiA3t8or5+E1gICYFQT1sAYVYVB
	 M5cOLcpBAQandu1TUstegNX/rZXT/JAZEDp9M4834I9zAjnONxWAW2xRSjfCjgKUI4
	 v7ttNynNLwukF6zmX421cSdNfnWM4mOKw07b6Wpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEBXOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 19:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgEBXOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:14:24 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805FF20787;
        Sat,  2 May 2020 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588461264;
        bh=z2xDfe2nsqG9FjHrPXPh77KoVrvObAsI7+pJsQc+kYQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=yQ0Vfx7Jtu0Gk813MejPruFybBd3dCe40JQcTh62HnPnMtDxNks+hGJzd6sCUcQRF
         JG047ydmaUlP1+rNusw8eSRlhGaAsxwGJZUe1SqlvKuhALwfAiVntKJnKxoBn5U+M2
         huubcwiWeKC7wz8IcH/DQECBCzn7jn8UfX9LjlKk=
Subject: Re: [PATCH 5.6 000/106] 5.6.9-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200501131543.421333643@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <769045a8-0e13-4af8-7bfb-de13a9d3038f@kernel.org>
Date:   Sat, 2 May 2020 17:14:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 7:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.6.9 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 03 May 2020 13:12:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
