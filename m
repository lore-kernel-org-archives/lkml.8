Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE2C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106EA215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q4/xxTRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgCJUHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:07:43 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4895 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCJUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:07:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e67f3330000>; Tue, 10 Mar 2020 13:06:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 10 Mar 2020 13:07:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 10 Mar 2020 13:07:42 -0700
Received: from [10.26.11.187] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Mar
 2020 20:07:39 +0000
Subject: Re: [PATCH 4.9 00/88] 4.9.216-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200310123606.543939933@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e7ede51a-fd6f-c617-bbb6-1a34b705a73c@nvidia.com>
Date:   Tue, 10 Mar 2020 20:07:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583870771; bh=fvZJegh58L6I/tANVyCvojto1nE43W6ZAqXmm1u28Gc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=q4/xxTRnXlUz7SgrILxUBgwLZYfGEJnDaWu+4LD7TiWIQRDlvuidgtBiA0LvQWTDm
         HOOUItSWiUaLctMTww6PQQPs4752lVMhVAoFTZw3joh4VcWLi2I4z1NghvLDmpKbsN
         tNM4xfA0NpY0gTbUbqWgUzsQmUB2VF3g5cuqlu9RL6oThD/9AefZbH+Oh6J/ATZ5o+
         OnECjaNqBrARl/YHp952XckuhEzdeypw2+HmfbazJNrkZFrmNbra5I755b63fcuHjO
         +uOiZmIJrWnNCtPq4sx2eIvwWV4CttuXN/DIHMk0EjuA9zhJZHMEpfMwvdFpIEbD7u
         QNjOVTuJquBQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2020 12:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.216 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Mar 2020 12:34:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.216-rc1.gz
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

Linux version:	4.9.216-rc1-g823586b24f36
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
