Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41DC221EE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mUKqg3UJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGHIk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:40:57 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13036 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgGHIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:40:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f05868b0000>; Wed, 08 Jul 2020 01:40:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 01:40:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Jul 2020 01:40:56 -0700
Received: from [10.26.73.185] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 08:40:53 +0000
Subject: Re: [PATCH 4.14 00/27] 4.14.188-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200707145748.944863698@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c65f11ef-d734-cfe0-963c-e9665508a4f2@nvidia.com>
Date:   Wed, 8 Jul 2020 09:40:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707145748.944863698@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594197643; bh=rfRQR3pLwgy/RKbZMDm/GGiHl/4bWAPGLOv0dFOfP/E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mUKqg3UJg22H62UL2s8JJnR6cGyu+j9rncYJB/6BnBeyANCpL2W+8+1r3YKI+Qmp7
         CqHybQdJGDkRyFnLQnUISGTQC5Qs3E2LzjQxgA9u8BDYAYpxLNBAodHLOUHCXrSFVA
         fRkKue3t2osltOhUrd/NUYdKjAmDWeLZQkEvCB+65bjoBXi/3hJc7azJBiqdboziSa
         JUCcK5nZK+KHF8mYrDbgbxiJssVKliOB8futrEcijlvxVdvgOwjKXugAvow7p49VAK
         sgS4RbDQZMkIPy2y62Lrlrs2Catp1b9N3VhZ1pZPw5fRUekWl65bg3uy+W3evxfuXm
         hB7PhvtoWc32Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/07/2020 16:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.188 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.188-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    30 tests:	30 pass, 0 fail

Linux version:	4.14.188-rc1-gca554d6bb6dd
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
