Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D0EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1939E207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593614515;
	bh=4LNZ3JwkKSBCuuNrdNYfG2FYIH5mf86jE5HKHcXSJUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=opfeQQq9R6jrE59+IUswjaxnnfA7f5/ZEIWJQ47qj2vM4IiKXsQQEkiOgb7ne19MG
	 WcwlZSmdqoMv04IBPrM7Y6d4Z23MX3jUQDxgNwxV9oY4yBAbqCs3oPjtj+vbFL8Cr4
	 TJ6LZADDrEr1k23So1X+aJ5k1Ja9QyuR+MUA62mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgGAOlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbgGAOlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:41:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62A6206BE;
        Wed,  1 Jul 2020 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593614512;
        bh=4LNZ3JwkKSBCuuNrdNYfG2FYIH5mf86jE5HKHcXSJUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ej9bONA9NmH8UvL1bVmfXP8MlIEvLEdTw6WbsG631zA2v/5gxOzQD9RUsrqIeMSwk
         Mrr/9PK+c6wMspbm2guEAAKFjS+rjZB+DEGX3WDb7Ziv5K1KPwWCAlNmYXcVeRGeLI
         rNwhdnM7Mzhd7TxkicDplde3bBTFeg8HjhwbRzEQ=
Date:   Wed, 1 Jul 2020 10:41:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.7 000/265] 5.7.7-rc1 review
Message-ID: <20200701144150.GE2687961@sasha-vm>
References: <20200629151818.2493727-1-sashal@kernel.org>
 <58ac88f8-bb04-2aa0-58da-5eb43c8fc175@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <58ac88f8-bb04-2aa0-58da-5eb43c8fc175@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 10:15:31AM +0100, Jon Hunter wrote:
>
>On 29/06/2020 16:13, Sasha Levin wrote:
>>
>> This is the start of the stable review cycle for the 5.7.7 release.
>> There are 265 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed 01 Jul 2020 03:14:48 PM UTC.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.7.y&id2=v5.7.6
>>
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
>> and the diffstat can be found below.
>>
>> --
>> Thanks,
>> Sasha
>
>All tests are passing for Tegra ...
>
>Test results for stable-v5.7:
>    11 builds:	11 pass, 0 fail
>    26 boots:	26 pass, 0 fail
>    56 tests:	56 pass, 0 fail
>
>Linux version:	5.7.7-rc1-g97943c6d41ef
>Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                tegra194-p2972-0000, tegra20-ventana,
>                tegra210-p2371-2180, tegra210-p3450-0000,
>                tegra30-cardhu-a04

Thanks for the testing Jon!

-- 
Thanks,
Sasha
