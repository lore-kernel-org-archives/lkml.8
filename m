Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D106C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444962082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HD2IbLFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390496AbgFXKce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:32:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17361 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388705AbgFXKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:32:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef32b7b0000>; Wed, 24 Jun 2020 03:31:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Jun 2020 03:32:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Jun 2020 03:32:09 -0700
Received: from [10.26.73.205] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jun
 2020 10:32:07 +0000
Subject: Re: [PATCH 5.4 000/311] 5.4.49-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200624055926.651441497@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <46d8162d-a75f-add9-11a2-75d058c8ee15@nvidia.com>
Date:   Wed, 24 Jun 2020 11:32:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624055926.651441497@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592994684; bh=fbO8UkOrpZmd/+todMA8Poq0/jk1iXgO4dMWtNvm8Uk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HD2IbLFBMdsQjHZbmnEYeHTk6AD+1UuWAI2zv2ODNRb/Sly1bnuPYYGdBThyFryp/
         JOp+6AaB98n7lcE9A1i/Y2MW4hGozUY2MmVQzmYAdgC7ocFlTyiH7dmcsHrDaUeJxk
         pUJartvkwFRk2S8L4k+PAxai6NSkcPikpDK+0e8bPzBE1Box7/lgOzXFocBOnGgIE8
         MIHTxKGm3c5ynqooDSTzm4jBErf6ZSoirm55jwCBy/ky9jLZeM2Ufe+99L2CPYk4Fu
         ssCKziNSt7GnNFKymbLvkPrWlPypa1sGPjBNLJeubjA0oyAX2NKpT4JYASz8Qq9KQ1
         8yAJzLPv6PiCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/2020 07:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.49 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 26 Jun 2020 05:58:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.49-rc2.gz
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

Linux version:	5.4.49-rc2-gf7f032930408
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
