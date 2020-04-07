Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7A1C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232992072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HQAoSsFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgDGTDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:03:19 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10844 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGTDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:03:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8cce100000>; Tue, 07 Apr 2020 12:01:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Apr 2020 12:03:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Apr 2020 12:03:18 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr
 2020 19:03:07 +0000
Received: from [10.26.73.75] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr 2020
 19:02:43 +0000
Subject: Re: [PATCH 5.5 00/48] 5.5.16-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200407154800.629167305@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b14a2a76-157b-3dde-c5f4-a070d2b51b2e@nvidia.com>
Date:   Tue, 7 Apr 2020 20:02:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407154800.629167305@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586286096; bh=V+NoaGOhinNraBE7UQmhXvZOwqP2eTwpqSkpS8uhU2w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HQAoSsFeQ68JHoEJhQCM4yQAzp4kKzKu3kJR+6Taw07CoiJlKpdrASClR+TDgsc6E
         UG3wzr3oP3eIzoWwzAU1d+HzurgzYRhOv61iQIRtRXYQWQH5RqE9v2hGaLiLWsc+Bh
         i9xCvHreVEgwLHf2KHtf04EWd4boAEdNSFtf98Fm8JOZ8AqYWheyKaj9p0IG2tIUFx
         qgwNIpyyYOOaXWCbBQkFqvox4y3+B6OpgSnx4OitAb0GQ9hLwBI69diztHkMYyRWIT
         I6wWuTy/hYziJW/sK7AvMrpdVuHA3aDW1FkScoGrlHNYRXK3J9k1ASxZ1CDfoYbDyD
         ZUwwc7TtRXQCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/04/2020 17:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.16 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Apr 2020 15:46:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.16-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v5.5:
    13 builds:	13 pass, 0 fail
    24 boots:	24 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	5.5.16-rc2-gf921e13beada
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
