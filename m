Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD9C2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R+XLxWUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgEEIhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:37:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14604 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgEEIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:37:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb125a80000>; Tue, 05 May 2020 01:36:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 May 2020 01:37:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 May 2020 01:37:08 -0700
Received: from [10.26.73.45] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 May
 2020 08:37:06 +0000
Subject: Re: [PATCH 4.9 00/18] 4.9.222-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200504165442.028485341@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <09f0c94b-67bd-4fc2-4388-dd14e67261d9@nvidia.com>
Date:   Tue, 5 May 2020 09:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504165442.028485341@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588667816; bh=i56RFVZ0zKHevqLmdDERxi0rJzsJV1lfVnkfUqWHcBM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=R+XLxWUCilf38xggKXllMiFTyw0u1lld1Od4e6GRQhG3ea4QMgmOYyR1QDFOPtx6Y
         aG4fRumNW0WMepYyC4HYjM/GQrh6Gn0Zdy00gEbG2412ZVGy8wcmMtfzT5imSJ5tCd
         DOP9Ztd0HVpgvEIhb17Ix9C39j/uLqFX2keqfml8EsVOmNVbOeM0T2jMYeleex0KT0
         V+MOPMSg0tIJGclnu5RBsvPQigPu8ug95JjsKeKkz+X+o7wv5erTp+d+ztgGyQBbJE
         Vb2QtPuUonzCTXMz36R3ksFZqEuy668AgrLLwCqLyzzU6hcNQ6Yq9USJfVbKI3jOvz
         4l9Hk88cuX/7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/05/2020 18:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.222 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2020 16:52:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.222-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    24 tests:	24 pass, 0 fail

Linux version:	4.9.222-rc1-gf8abf65f20c5
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
