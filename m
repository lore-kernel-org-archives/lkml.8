Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3161C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F78208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jsmUsgFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbgFPUUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:20:09 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18888 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFPUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:20:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee929460000>; Tue, 16 Jun 2020 13:19:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Jun 2020 13:20:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Jun 2020 13:20:07 -0700
Received: from [10.26.75.222] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Jun
 2020 20:20:05 +0000
Subject: Re: [PATCH 5.4 000/131] 5.4.47-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200616172616.044174583@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <dcc826f2-a9c9-4870-f1da-76bda0bb767b@nvidia.com>
Date:   Tue, 16 Jun 2020 21:20:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616172616.044174583@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592338758; bh=wn/uQcO0/lI7I/tJ3A3dP8S9I67Ph+r5VwJNVID9FNk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jsmUsgFLnlXsphgNgWVyvUyFpJqyM655AzTRmkKOp2e6qq0uXYnmZyYTS8Edqmltb
         h8ECjsSrp2+n+tsmzOmR4s/1f+4UjgFOBHQr+vR15QZBXr/tARoWH9OQCRbRmUTMTb
         R2E0Ao2ipbTsfB4nZ1GNmTaQHURLhzg5J0D+f7uTL/EhSLP3YaRhUBTjIXytJbkwZU
         mLid0pmh1qi7SZJblRBweD8S3RHqWkMs0cgIL9TOKiuRA2OM79WotN+Fg0DxLTD3VW
         fuHoxvsynv9dIk0REmgrSJAHxxHA6tp1gqZXcxM8PEWL8g2tYleMIYGJiiDJ8xQeJ2
         N4GIT87k51tSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2020 18:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.47 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2020 17:25:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.47-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


All tests are passing for Tegra ...

Test results for stable-v5.4:
    11 builds:	11 pass, 0 fail
    26 boots:	26 pass, 0 fail
    56 tests:	56 pass, 0 fail

Linux version:	5.4.47-rc2-ga7debb64f8b4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
