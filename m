Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612BEC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D58F20787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585846277;
	bh=OWoWofA5/lIsAhLWpLfJf9L99GPd7+sOKnFrWNGUgf4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Yn4uH8/8yZWUjLeIBRHDALaI7bUyheWQOBHQm8M5KO2S3dVwrpdAg1M9U9m1cKj8i
	 0kaqGzE5/RaT7ao9ItIbgWdpLsGap5KlQrzQzVmiUgNMiVKTP8opg4PNdWiYlyfW2A
	 3cqQAIAwvNilSxNSrYDj6zBpL49hkI97b/t3bkWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbgDBQvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgDBQvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:51:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D553F20737;
        Thu,  2 Apr 2020 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585846275;
        bh=OWoWofA5/lIsAhLWpLfJf9L99GPd7+sOKnFrWNGUgf4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aGV2qaGXe0XQ7hFCmEpdhRMZgc9etUQM5MLi6Cjv6BoFazdvHnt6gqt6H0idTEBzr
         j04OUfR59Qml010D8WdYOTwYJ1GwhbukmDoIskcWGmTlaP39QpnZdSoK99RgACNRlA
         DT9wWTJHC90gn2gGWvjbS0iyINuej+70gxzY24HA=
Subject: Re: [PATCH 5.4 00/27] 5.4.30-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200401161414.352722470@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9c52baad-0be9-aa74-8f30-25201d15db2b@kernel.org>
Date:   Thu, 2 Apr 2020 10:51:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401161414.352722470@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 10:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.30 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Apr 2020 16:09:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.30-rc1.gz
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
