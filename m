Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1FC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8FC20708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589216096;
	bh=5jw+X8a/R6vFcGmFXw7JIS0WUsW0JoyIYxX+t4OB5Ag=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=y1pcBLCvRWk98qdGiS6OvVT/4+w6C71XPKosszOtWOUHk6u+PPr+DSk3ISEciv3qi
	 xkFrh9cthYniwmuZvcCsL3wCw2C2qrvDFb3yk49C/AwY43qzxP2FMqEI5MI/AM6eWW
	 3i0UlPvNjJzcGoIe46YjSPFRwht/Eb3IsFbr1JYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgEKQyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbgEKQyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:54:54 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5FA2206D7;
        Mon, 11 May 2020 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589216094;
        bh=5jw+X8a/R6vFcGmFXw7JIS0WUsW0JoyIYxX+t4OB5Ag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gFXE0Qtoo8LjfV8B+CWnmXDMyguZ2dwzxEH9iagTP1mMTZsy9Qb5Xu3/rH8nZAMWQ
         l7ZDOv2br2MsgYpwYEFWeZCe2mY/NEcAst+rZZldejkuCBToTCYWdbp4+4mm/zSJVI
         zozb+LfsiOb6/qgXi7EJq1TN+IL8uJQxGHsq08NU=
Subject: Re: [PATCH 4.14 00/22] 4.14.180-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200508123033.915895060@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d420c85d-5584-13c7-b3f7-45e58329f9a5@kernel.org>
Date:   Mon, 11 May 2020 10:54:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508123033.915895060@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 6:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.180 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 10 May 2020 12:29:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.180-rc1.gz
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
