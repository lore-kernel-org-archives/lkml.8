Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5206DC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725B1204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HYgfgLrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbgEMNqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:46:36 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17318 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgEMNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:46:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebbfa2f0000>; Wed, 13 May 2020 06:46:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 May 2020 06:46:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 May 2020 06:46:35 -0700
Received: from [10.26.74.82] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 May
 2020 13:46:33 +0000
Subject: Re: [PATCH 5.6 000/118] 5.6.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200513094417.618129545@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <12592104-9a83-5b19-be42-5bbf92198ad7@nvidia.com>
Date:   Wed, 13 May 2020 14:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589377583; bh=MMq244zQ6f/PFo4yEc+mgL5wOdb+hDWjRauLSXWDRvY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HYgfgLrQI1CM43E5OkdMAfri0o2ZQOPpEr7gCzlbNZYAXSVxGGDGsXPZYcRoxr1pV
         /vnQ/cIHxR8RdgeH9BqqEV3icoNrkjCJ4lUOwTi8gWzY4G+T4bjZprKQlKK0+fQjBB
         2dfAFg6cdyTc9q59oeCnrF3PqGxsVnlQZvp6YEkl2v3Gk+1O4j6F8xD8awr0Uzv2tP
         Wbu9nUT9ndXiOf5tvacSx7AoXwILCDB5JXGqOOtQvMScLzlfUBAj6G+M9vnJKmgUSX
         6jtKtQvpvyjZnwKWw4xvwOMl3eiyA1Y45S3nl5izlLC1lFTrO+D5SaC1B6ux2qD9ZM
         Wh0lOWzyGwJfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/05/2020 10:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.6.13 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 15 May 2020 09:41:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v5.6:
    13 builds:	13 pass, 0 fail
    26 boots:	26 pass, 0 fail
    42 tests:	42 pass, 0 fail

Linux version:	5.6.13-rc1-gf1d28d1c7608
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
