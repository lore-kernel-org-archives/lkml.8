Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF56C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9422086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cB+8v2XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBCVjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:39:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19510 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgBCVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:39:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3892d00000>; Mon, 03 Feb 2020 13:38:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 13:39:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 13:39:20 -0800
Received: from [10.26.11.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 21:39:17 +0000
Subject: Re: [PATCH 4.4 00/53] 4.4.213-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200203161902.714326084@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2a8a9c20-f222-b3f2-13bd-789c936129c5@nvidia.com>
Date:   Mon, 3 Feb 2020 21:39:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580765904; bh=myr+oSzYd1ifTU8N8WRHBs+t42/gYp+DIJmUHuEGpBc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cB+8v2XLAfilJuwT9qwICZxM4Aw6MhW2sRxh775vp3540nCHGd5mYQerE52H0VNQf
         5+k2iUmj+AF5OdvXYozA8JVGPyD5GqumTvCbgG304KZpyuI6ieh5LPifbQr/Vz2l0s
         wUF8oKc/6dxcio7eYv8D/GmljI9l4roUnbxqsAB47ef2eLk8Sc71fCVAAGJEOKB3Sd
         RPuXIbxI1qqd/tOZiZhOA9dxAioHvo1EuCZg1+ejGK9fmsiLuxXdfwERC4E5RRAb/Q
         mOj3S2PJJ8ZcE85B4KolbfuSZstiuZqYSVIPQv/pO2WJ7DrWClrFPm8jknkICM+W5Y
         7u0rVHAL0evAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/02/2020 16:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.213 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.213-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v4.4:
    6 builds:	6 pass, 0 fail
    12 boots:	12 pass, 0 fail
    19 tests:	19 pass, 0 fail

Linux version:	4.4.213-rc1-g0d16ce6b7f9f
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
